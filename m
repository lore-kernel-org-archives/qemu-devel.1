Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRccJ-0003gL-1t
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRccH-0008LJ-OW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:32:55 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:47018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eRccH-0008Kc-FK
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:32:53 -0500
Received: by mail-wm0-x230.google.com with SMTP id r78so9259350wme.5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 03:32:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218191228.31018-12-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
	<20171218191228.31018-12-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Dec 2017 12:32:51 +0100
Message-ID: <CAJ+F1CKdVL6XEuyeS2bM78XJ7N1f64VL3_=GrCp6cKVEivdb9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 11/13] ui: place a hard cap on VNC
 server output buffer size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

 Hi

On Mon, Dec 18, 2017 at 8:12 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> The previous patches fix problems with throttling of forced framebuffer u=
pdates
> and audio data capture that would cause the QEMU output buffer size to gr=
ow
> without bound. Those fixes are graceful in that once the client catches u=
p with
> reading data from the server, everything continues operating normally.
>
> There is some data which the server sends to the client that is impractic=
al to
> throttle. Specifically there are various pseudo framebuffer update encodi=
ngs to
> inform the client of things like desktop resizes, pointer changes, audio
> playback start/stop, LED state and so on. These generally only involve se=
nding
> a very small amount of data to the client, but a malicious guest might be=
 able
> to do things that trigger these changes at a very high rate. Throttling t=
hem is
> not practical as missed or delayed events would cause broken behaviour fo=
r the
> client.
>
> This patch thus takes a more forceful approach of setting an absolute upp=
er
> bound on the amount of data we permit to be present in the output buffer =
at
> any time. The previous patch set a threshold for throttling the output bu=
ffer
> by allowing an amount of data equivalent to one complete framebuffer upda=
te and
> one seconds worth of audio data. On top of this it allowed for one furthe=
r
> forced framebuffer update to be queued.
>
> To be conservative, we thus take that throttling threshold and multiply i=
t by
> 5 to form an absolute upper bound. If this bound is hit during vnc_write(=
) we
> forceably disconnect the client, refusing to queue further data. This lim=
it is
> high enough that it should never be hit unless a malicious client is tryi=
ng to
> exploit the sever, or the network is completely saturated preventing any =
sending
> of data on the socket.
>
> This completes the fix for CVE-2017-15124 started in the previous patches=
.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 4021c0118c..a4f0279cdc 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1521,8 +1521,37 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUS=
ED,
>  }
>
>
> +/*
> + * Scale factor to apply to vs->throttle_output_offset when checking for
> + * hard limit. Worst case normal usage could be x2, if we have a complet=
e
> + * incremental update and complete forced update in the output buffer.
> + * So x3 should be good enough, but we pick x5 to be conservative and th=
us
> + * (hopefully) never trigger incorrectly.
> + */
> +#define VNC_THROTTLE_OUTPUT_LIMIT_SCALE 5
> +
>  void vnc_write(VncState *vs, const void *data, size_t len)
>  {
> +    if (vs->disconnecting) {
> +        return;
> +    }
> +    /* Protection against malicious client/guest to prevent our output
> +     * buffer growing without bound if client stops reading data. This
> +     * should rarely trigger, because we have earlier throttling code
> +     * which stops issuing framebuffer updates and drops audio data
> +     * if the throttle_output_offset value is exceeded. So we only reach
> +     * this higher level if a huge number of pseudo-encodings get
> +     * triggered while data can't be sent on the socket.
> +     *
> +     * NB throttle_output_offset can be zero during early protocol
> +     * handshake, or from the job thread's VncState clone
> +     */
> +    if (vs->throttle_output_offset !=3D 0 &&
> +        vs->output.offset > (vs->throttle_output_offset *
> +                             VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
> +        vnc_disconnect_start(vs);

It seems to me that the main source of data, the display, bypass this check=
.

The vnc_worker_thread_loop() uses a local VncState & buffer. The
result is moved to the vs->jobs_buffer, which is later moved in
vnc_jobs_consume_buffer() to the vs->output in bottom-half.

So in theory, it seems it would be possible for a client to make
several update-request (assuming guest display content changed), and
have several vnc jobs queued. In the unlikely events they would be
consumed together, they would not respect the hard cap. I am not sure
how the vnc-job queueing should be improved, just wanted to raise some
concerns around that code and the fact it doesn't really respect the
hard limits apparently. Am I wrong?

Perhaps the hard limit should also be put in vnc_jobs_consume_buffer()
? Then I can imagine synchronization issues if the hard limit changes
before the job buffer are consumed.

May be we should limit the amount of jobs that can be queued? If we
can estimate the max result buffer size of a job buffer,
vnc_should_update() could take that into account?

> +        return;
> +    }
>      buffer_reserve(&vs->output, len);
>
>      if (vs->ioc !=3D NULL && buffer_empty(&vs->output)) {
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
