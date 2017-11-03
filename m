Received: from eggs.gnu.org ([2001:4830:134:3::10]:42955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eAcbg-0005yg-Iw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eAcba-0006JC-Kd
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:06:00 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:46722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eAcba-0006J0-Fx
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:05:54 -0400
Received: by mail-ua0-x242.google.com with SMTP id w45so1999619uac.3
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 07:05:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171103131959.73560-1-kirill.shutemov@linux.intel.com>
References: <20171103131959.73560-1-kirill.shutemov@linux.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 3 Nov 2017 15:05:53 +0100
Message-ID: <CAJ+F1CKEVXzR6nA3V1RUx+BhE-UU7Du9dGmR0mN9KpsAQKOrSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: don't forget to set backend for
 mux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kirill@shutemov.name, QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Nov 3, 2017 at 2:19 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> I noticied that on recent versions on QEMU I was not able to trigger
> SysRq to invoke debug capabilites of Linux Kernel.
>
> I've tracked it down to qemu_chr_be_event() ignoring CHR_EVENT_BREAK due
> s->be being NULL.
>
> Looks like the bug was introduced in a4afa548fc6d ("char: move front end
> handlers in CharBackend"). Since the commit the qemu_chr_be_event()
> failed to deliver CHR_EVENT_BREAK due to qemu_chr_fe_init() forgot to
> get s->be initialized in case of mux.
>
> Let's fix this.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
> ---
>  chardev/char-fe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index ee6d59610031..d4a54947a567 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -209,9 +209,8 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Err=
or **errp)
>          tag =3D d->mux_cnt++;
>      } else if (s->be) {
>          goto unavailable;
> -    } else {
> -        s->be =3D b;
>      }
> +    s->be =3D b;

This will send the event to the last frontend that called
chr_fe_init(). Instead, it should probably send it to the one with
focus. I am sending an alternative patch.

thanks

>
>      b->fe_open =3D false;
>      b->tag =3D tag;
> --
> 2.14.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
