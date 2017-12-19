Received: from eggs.gnu.org ([2001:4830:134:3::10]:55132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRM8t-0001A0-Ix
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRM8s-00059o-8B
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:57:27 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:43605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eRM8r-00058n-Vb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:57:26 -0500
Received: by mail-wm0-x22e.google.com with SMTP id n138so5354998wmg.2
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 09:57:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218191228.31018-11-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
	<20171218191228.31018-11-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Dec 2017 18:57:23 +0100
Message-ID: <CAJ+F1CK+cpUO7J1_WrbQeLZSDApMOamm=j0S4mUGWJM7qRuoVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 10/13] ui: fix VNC client throttling
 when forced update is requested
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
> The VNC server must throttle data sent to the client to prevent the 'outp=
ut'
> buffer size growing without bound, if the client stops reading data off t=
he
> socket (either maliciously or due to stalled/slow network connection).
>
> The current throttling is very crude because it simply checks whether the
> output buffer offset is zero. This check is disabled if the client has re=
quested
> a forced update, because we want to send these as soon as possible.
>
> As a result, the VNC client can cause QEMU to allocate arbitrary amounts =
of RAM.
> They can first start something in the guest that triggers lots of framebu=
ffer
> updates eg play a youtube video. Then repeatedly send full framebuffer up=
date
> requests, but never read data back from the server. This can easily make =
QEMU's
> VNC server send buffer consume 100MB of RAM per second, until the OOM kil=
ler
> starts reaping processes (hopefully the rogue QEMU process, but it might =
pick
> others...).
>
> To address this we make the throttling more intelligent, so we can thrott=
le
> full updates. When we get a forced update request, we keep track of exact=
ly how
> much data we put on the output buffer. We will not process a subsequent f=
orced
> update request until this data has been fully sent on the wire. We always=
 allow
> one forced update request to be in flight, regardless of what data is que=
ued
> for incremental updates or audio data. The slight complication is that we=
 do
> not initially know how much data an update will send, as this is done in =
the
> background by the VNC job thread. So we must track the fact that the job =
thread
> has an update pending, and not process any further updates until this job=
 is
> has been completed & put data on the output buffer.
>
> This unbounded memory growth affects all VNC server configurations suppor=
ted by
> QEMU, with no workaround possible. The mitigating factor is that it can o=
nly be
> triggered by a client that has authenticated with the VNC server, and who=
 is
> able to trigger a large quantity of framebuffer updates or audio samples =
from
> the guest OS. Mostly they'll just succeed in getting the OOM killer to ki=
ll
> their own QEMU process, but its possible other processes can get taken ou=
t as
> collateral damage.
>
> This is a more general variant of the similar unbounded memory usage flaw=
 in
> the websockets server, that was previously assigned CVE-2017-15268, and f=
ixed
> in 2.11 by:
>
>   commit a7b20a8efa28e5f22c26c06cd06c2f12bc863493
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Mon Oct 9 14:43:42 2017 +0100
>
>     io: monitor encoutput buffer size from websocket GSource
>
> This new general memory usage flaw has been assigned CVE-2017-15124, and =
is
> partially fixed by this patch.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc-auth-sasl.c |  5 +++++
>  ui/vnc-jobs.c      |  5 +++++
>  ui/vnc.c           | 28 ++++++++++++++++++++++++----
>  ui/vnc.h           |  7 +++++++
>  4 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
> index 761493b9b2..8c1cdde3db 100644
> --- a/ui/vnc-auth-sasl.c
> +++ b/ui/vnc-auth-sasl.c
> @@ -79,6 +79,11 @@ long vnc_client_write_sasl(VncState *vs)
>
>      vs->sasl.encodedOffset +=3D ret;
>      if (vs->sasl.encodedOffset =3D=3D vs->sasl.encodedLength) {
> +        if (vs->sasl.encodedRawLength >=3D vs->force_update_offset) {
> +            vs->force_update_offset =3D 0;
> +        } else {
> +            vs->force_update_offset -=3D vs->sasl.encodedRawLength;
> +        }
>          vs->output.offset -=3D vs->sasl.encodedRawLength;
>          vs->sasl.encoded =3D NULL;
>          vs->sasl.encodedOffset =3D vs->sasl.encodedLength =3D 0;
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index f7867771ae..e326679dd0 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -152,6 +152,11 @@ void vnc_jobs_consume_buffer(VncState *vs)
>                  vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
>          }
>          buffer_move(&vs->output, &vs->jobs_buffer);
> +
> +        if (vs->job_update =3D=3D VNC_STATE_UPDATE_FORCE) {
> +            vs->force_update_offset =3D vs->output.offset;
> +        }
> +        vs->job_update =3D VNC_STATE_UPDATE_NONE;
>      }
>      flush =3D vs->ioc !=3D NULL && vs->abort !=3D true;
>      vnc_unlock_output(vs);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index a2699f534d..4021c0118c 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1021,14 +1021,28 @@ static bool vnc_should_update(VncState *vs)
>          break;
>      case VNC_STATE_UPDATE_INCREMENTAL:
>          /* Only allow incremental updates if the pending send queue
> -         * is less than the permitted threshold
> +         * is less than the permitted threshold, and the job worker
> +         * is completely idle.
>           */
> -        if (vs->output.offset < vs->throttle_output_offset) {
> +        if (vs->output.offset < vs->throttle_output_offset &&
> +            vs->job_update =3D=3D VNC_STATE_UPDATE_NONE) {
>              return true;
>          }
>          break;
>      case VNC_STATE_UPDATE_FORCE:
> -        return true;
> +        /* Only allow forced updates if the pending send queue
> +         * does not contain a previous forced update, and the
> +         * job worker is completely idle.
> +         *
> +         * Note this means we'll queue a forced update, even if
> +         * the output buffer size is otherwise over the throttle
> +         * output limit.
> +         */
> +        if (vs->force_update_offset =3D=3D 0 &&
> +            vs->job_update =3D=3D VNC_STATE_UPDATE_NONE) {
> +            return true;
> +        }
> +        break;
>      }
>      return false;
>  }
> @@ -1096,8 +1110,9 @@ static int vnc_update_client(VncState *vs, int has_=
dirty)
>          }
>      }
>
> -    vnc_job_push(job);
> +    vs->job_update =3D vs->update;

How is this going to match the buffer job in vnc_jobs_consume_buffer() ?

(isn't this potentially taking the next job to finish as a force-update?)

>      vs->update =3D VNC_STATE_UPDATE_NONE;
> +    vnc_job_push(job);
>      vs->has_dirty =3D 0;
>      return n;
>  }
> @@ -1332,6 +1347,11 @@ static ssize_t vnc_client_write_plain(VncState *vs=
)
>      if (!ret)
>          return 0;
>
> +    if (ret >=3D vs->force_update_offset) {
> +        vs->force_update_offset =3D 0;
> +    } else {
> +        vs->force_update_offset -=3D ret;
> +    }
>      buffer_advance(&vs->output, ret);
>
>      if (vs->output.offset =3D=3D 0) {
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 8fe69595c6..3f4cd4d93d 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -271,6 +271,7 @@ struct VncState
>
>      VncDisplay *vd;
>      VncStateUpdate update; /* Most recent pending request from client */
> +    VncStateUpdate job_update; /* Currently processed by job thread */
>      int has_dirty;
>      uint32_t features;
>      int absolute;
> @@ -298,6 +299,12 @@ struct VncState
>
>      VncClientInfo *info;
>
> +    /* Job thread bottom half has put data for a forced update
> +     * into the output buffer. This offset points to the end of
> +     * the update data in the output buffer. This lets us determine
> +     * when a force update is fully sent to the client, allowing
> +     * us to process further forced updates. */
> +    size_t force_update_offset;
>      /* We allow multiple incremental updates or audio capture
>       * samples to be queued in output buffer, provided the
>       * buffer size doesn't exceed this threshold. The value
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
