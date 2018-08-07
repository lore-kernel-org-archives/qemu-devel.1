Received: from eggs.gnu.org ([2001:4830:134:3::10]:35258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fn3rr-0006YB-Fw
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fn3rq-00070f-Fz
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:25:51 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:51324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fn3rq-00070I-88
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:25:50 -0400
Received: by mail-wm0-x234.google.com with SMTP id y2-v6so17873022wma.1
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 08:25:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803173614.12358-3-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-3-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Aug 2018 17:25:48 +0200
Message-ID: <CAJ+F1CJjLPo73CsaPKEdE_E8=4ywbEdATFzePRWtzii7jVawbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] char/spice: discard write() if
 backend is disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi

On Fri, Aug 3, 2018 at 7:36 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Most chardev backend handle write() as discarded data if underlying
> system is disconnected. For unknown historical reasons, the Spice
> backend has "reliable" write. It will wait until the client end is
> reconnected to accept further write().
>
> Let's review Spice chardev usage and handling of a disconnected
> client:
>
>  * spice vdagent
>    The agent will reopen the virtio port on disconnect.
>
>  * usb redirection
>    A disconnect creates a device disconnection.
>
>  * smartcard emulation
>    Data is discarded in passthru_apdu_from_guest()

Doing more testing, I realize this creates is a regression on Spice
smartcard. Sadly, the Spice smartcard channel isn't actually based on
spicevmc (as the chardev name may imply), and doesn't set the
connected sif->state(). I am sending a patch to spice-devel to fix
this. I'll update this patch to set the chardev opened at "smartcard"
spicevmc creation time when we have an old spice server.

>
>  * spice webdavd
>    The daemon will restart the service, and reopen the virtio port.
>
>  * spice ports (serial console, qemu monitor..)
>    Depends on the associated device or usage.
>
>    - 16550A serial does nothing special, and may block guest on write
>
>    - QMP/HMP monitor have some CLOSED event handling, but want to
>      flush the write, which will finish when a new client connects.
>
> For all these use cases, it is better to discard pending write when
> the client is disconnected, and expect the device/agent to behave
> correctly on CHR_EVENT_CLOSED (to stop reading and writing from
> chardev).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/spice.c      | 6 ++++++
>  chardev/trace-events | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/chardev/spice.c b/chardev/spice.c
> index fe06034d7f..6ad95ffe62 100644
> --- a/chardev/spice.c
> +++ b/chardev/spice.c
> @@ -212,6 +212,12 @@ static int spice_chr_write(Chardev *chr, const uint8=
_t *buf, int len)
>      int read_bytes;
>
>      assert(s->datalen =3D=3D 0);
> +
> +    if (!chr->be_open) {
> +        trace_spice_chr_discard_write(len);
> +        return len;
> +    }
> +
>      s->datapos =3D buf;
>      s->datalen =3D len;
>      spice_server_char_device_wakeup(&s->sin);
> diff --git a/chardev/trace-events b/chardev/trace-events
> index d0e5f3bbc1..b8a7596344 100644
> --- a/chardev/trace-events
> +++ b/chardev/trace-events
> @@ -10,6 +10,7 @@ wct_cmd_other(const char *cmd) "%s"
>  wct_speed(int speed) "%d"
>
>  # chardev/spice.c
> +spice_chr_discard_write(int len) "spice chr write discarded %d"
>  spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
>  spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
>  spice_vmc_register_interface(void *scd) "spice vmc registered interface =
%p"
> --
> 2.18.0.547.g1d89318c48
>
>



--=20
Marc-Andr=C3=A9 Lureau
