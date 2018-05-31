Received: from eggs.gnu.org ([2001:4830:134:3::10]:56981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOKFY-0004nm-AO
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOKFX-000567-J5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:52:04 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fOKFX-00055Y-CO
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:52:03 -0400
Received: by mail-wr0-x243.google.com with SMTP id k16-v6so5116754wro.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 02:52:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531074601.10647-4-slp@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 May 2018 11:52:01 +0200
Message-ID: <CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Thu, May 31, 2018 at 9:46 AM, Sergio Lopez <slp@redhat.com> wrote:
> If writing to the frontend channel failed with EPIPE, don't set up a
> retry. EPIPE is not a recoverable error, so trying again is a waste of CP=
U
> cycles.
>
> If the vCPU writing to the serial device and emulator thread are pinned
> to the same pCPU, it can also compromise the stability of the Guest OS,
> as both threads will be competing for pCPU's time, with the vCPU
> actively polling the serial device and barely giving time to the
> emulator thread to make actual progress.
> ---
>  hw/char/serial.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 2c080c9..f26e86b 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -262,6 +262,7 @@ static void serial_xmit(SerialState *s)
>              /* in loopback mode, say that we just received a char */
>              serial_receive1(s, &s->tsr, 1);
>          } else if (qemu_chr_fe_write(&s->chr, &s->tsr, 1) !=3D 1 &&
> +                   errno !=3D EPIPE &&
>                     s->tsr_retry < MAX_XMIT_RETRY) {

Instead of adding explicit handling of EPIPE, shouldn't the code be
rewritten to treat -1 return && errno !=3D EAGAIN as fatal?

>              assert(s->watch_tag =3D=3D 0);
>              s->watch_tag =3D
> --
> 1.8.3.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
