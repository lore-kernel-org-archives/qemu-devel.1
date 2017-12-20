Received: from eggs.gnu.org ([2001:4830:134:3::10]:48831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRchs-0005lx-3S
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRcho-0005VS-5Y
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:38:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eRchn-0005V5-Rg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:38:36 -0500
Date: Wed, 20 Dec 2017 11:38:30 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220113830.GS21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
	<20171218191228.31018-12-berrange@redhat.com>
	<CAJ+F1CKdVL6XEuyeS2bM78XJ7N1f64VL3_=GrCp6cKVEivdb9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKdVL6XEuyeS2bM78XJ7N1f64VL3_=GrCp6cKVEivdb9w@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

On Wed, Dec 20, 2017 at 12:32:51PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>  Hi
>=20
> On Mon, Dec 18, 2017 at 8:12 PM, Daniel P. Berrange <berrange@redhat.co=
m> wrote:
> > The previous patches fix problems with throttling of forced framebuff=
er updates
> > and audio data capture that would cause the QEMU output buffer size t=
o grow
> > without bound. Those fixes are graceful in that once the client catch=
es up with
> > reading data from the server, everything continues operating normally=
.
> >
> > There is some data which the server sends to the client that is impra=
ctical to
> > throttle. Specifically there are various pseudo framebuffer update en=
codings to
> > inform the client of things like desktop resizes, pointer changes, au=
dio
> > playback start/stop, LED state and so on. These generally only involv=
e sending
> > a very small amount of data to the client, but a malicious guest migh=
t be able
> > to do things that trigger these changes at a very high rate. Throttli=
ng them is
> > not practical as missed or delayed events would cause broken behaviou=
r for the
> > client.
> >
> > This patch thus takes a more forceful approach of setting an absolute=
 upper
> > bound on the amount of data we permit to be present in the output buf=
fer at
> > any time. The previous patch set a threshold for throttling the outpu=
t buffer
> > by allowing an amount of data equivalent to one complete framebuffer =
update and
> > one seconds worth of audio data. On top of this it allowed for one fu=
rther
> > forced framebuffer update to be queued.
> >
> > To be conservative, we thus take that throttling threshold and multip=
ly it by
> > 5 to form an absolute upper bound. If this bound is hit during vnc_wr=
ite() we
> > forceably disconnect the client, refusing to queue further data. This=
 limit is
> > high enough that it should never be hit unless a malicious client is =
trying to
> > exploit the sever, or the network is completely saturated preventing =
any sending
> > of data on the socket.
> >
> > This completes the fix for CVE-2017-15124 started in the previous pat=
ches.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  ui/vnc.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 4021c0118c..a4f0279cdc 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -1521,8 +1521,37 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_=
UNUSED,
> >  }
> >
> >
> > +/*
> > + * Scale factor to apply to vs->throttle_output_offset when checking=
 for
> > + * hard limit. Worst case normal usage could be x2, if we have a com=
plete
> > + * incremental update and complete forced update in the output buffe=
r.
> > + * So x3 should be good enough, but we pick x5 to be conservative an=
d thus
> > + * (hopefully) never trigger incorrectly.
> > + */
> > +#define VNC_THROTTLE_OUTPUT_LIMIT_SCALE 5
> > +
> >  void vnc_write(VncState *vs, const void *data, size_t len)
> >  {
> > +    if (vs->disconnecting) {
> > +        return;
> > +    }
> > +    /* Protection against malicious client/guest to prevent our outp=
ut
> > +     * buffer growing without bound if client stops reading data. Th=
is
> > +     * should rarely trigger, because we have earlier throttling cod=
e
> > +     * which stops issuing framebuffer updates and drops audio data
> > +     * if the throttle_output_offset value is exceeded. So we only r=
each
> > +     * this higher level if a huge number of pseudo-encodings get
> > +     * triggered while data can't be sent on the socket.
> > +     *
> > +     * NB throttle_output_offset can be zero during early protocol
> > +     * handshake, or from the job thread's VncState clone
> > +     */
> > +    if (vs->throttle_output_offset !=3D 0 &&
> > +        vs->output.offset > (vs->throttle_output_offset *
> > +                             VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
> > +        vnc_disconnect_start(vs);
>=20
> It seems to me that the main source of data, the display, bypass this c=
heck.
>=20
> The vnc_worker_thread_loop() uses a local VncState & buffer. The
> result is moved to the vs->jobs_buffer, which is later moved in
> vnc_jobs_consume_buffer() to the vs->output in bottom-half.
>=20
> So in theory, it seems it would be possible for a client to make
> several update-request (assuming guest display content changed), and
> have several vnc jobs queued. In the unlikely events they would be
> consumed together, they would not respect the hard cap. I am not sure
> how the vnc-job queueing should be improved, just wanted to raise some
> concerns around that code and the fact it doesn't really respect the
> hard limits apparently. Am I wrong?
>=20
> Perhaps the hard limit should also be put in vnc_jobs_consume_buffer()
> ? Then I can imagine synchronization issues if the hard limit changes
> before the job buffer are consumed.
>=20
> May be we should limit the amount of jobs that can be queued? If we
> can estimate the max result buffer size of a job buffer,
> vnc_should_update() could take that into account?

The vnc_should_update() already prevents there being more than 1
queued job for the worker thread. So even if the client reuqests
more updates, we won't start processing them until the worker
thread as copied the job_buffer into output in the vnc_jobs_consume_buffe=
r
bottom half.  So no matter what the client requests, and how frequently
the guest display updates, we're still limiting output buffer size in
the vnc_update_client method.  This vnc_write protection only needs to
cope with non-display updates, for things like psuedo-encoding messages.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
