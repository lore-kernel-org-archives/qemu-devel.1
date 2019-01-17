Received: from eggs.gnu.org ([209.51.188.92]:48410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gk0nB-00058P-IC
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 01:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gk0co-00013S-86
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 00:53:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gk0co-0000wI-2k
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 00:53:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so10125384qtf.7
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 21:53:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<0b2e43a405816f04fd3e603a263fdf901a42e900.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <0b2e43a405816f04fd3e603a263fdf901a42e900.1547681517.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 09:53:44 +0400
Message-ID: <CAMxuvawV3eZO7+p_0jfGpoPU=P7r7w8Ob2uxykf4J3eFnX2N3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 20/50] paaudio: properly disconnect
 streams in fini_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Thu, Jan 17, 2019 at 3:37 AM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> Currently this needs a workaround due to bug #74624 in pulseaudio.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> ---
>  audio/paaudio.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 108d3158a6..428c848863 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -680,6 +680,27 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
>      return -1;
>  }
>
> +static void qpa_simple_disconnect(PAConnection *c, pa_stream *stream)
> +{
> +    int err;
> +
> +    pa_threaded_mainloop_lock(c->mainloop);
> +    /*
> +     * wait until actually connects. workaround pa bug #74624
> +     * https://bugs.freedesktop.org/show_bug.cgi?id=3D74624

Now that they moved to gitlab, you could update the link & # in commit mess=
age
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/247

> +     */
> +    while (pa_stream_get_state(stream) =3D=3D PA_STREAM_CREATING) {
> +        pa_threaded_mainloop_wait(c->mainloop);
> +    }
> +
> +    err =3D pa_stream_disconnect(stream);
> +    if (err !=3D 0) {
> +        dolog("Failed to dissconnect! err=3D%d\n", err);
> +    }
> +    pa_stream_unref(stream);
> +    pa_threaded_mainloop_unlock(c->mainloop);
> +}
> +
>  static void qpa_fini_out (HWVoiceOut *hw)
>  {
>      void *ret;
> @@ -691,7 +712,7 @@ static void qpa_fini_out (HWVoiceOut *hw)
>      audio_pt_join(&pa->pt, &ret, __func__);
>
>      if (pa->stream) {
> -        pa_stream_unref (pa->stream);
> +        qpa_simple_disconnect(pa->g->conn, pa->stream);
>          pa->stream =3D NULL;
>      }
>
> @@ -711,7 +732,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
>      audio_pt_join(&pa->pt, &ret, __func__);
>
>      if (pa->stream) {
> -        pa_stream_unref (pa->stream);
> +        qpa_simple_disconnect(pa->g->conn, pa->stream);
>          pa->stream =3D NULL;
>      }
>
> --
> 2.20.1
>
