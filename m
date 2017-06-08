Received: from eggs.gnu.org ([2001:4830:134:3::10]:54754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIwTM-0006aA-Ss
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIwTI-0004XC-Mx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:23:32 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIwTI-0004X4-AA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:23:28 -0400
Received: by mail-lf0-x241.google.com with SMTP id u62so2962028lfg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 05:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20170606110618.10393-1-kraxel@redhat.com>
In-Reply-To: <20170606110618.10393-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 08 Jun 2017 12:23:16 +0000
Message-ID: <CAJ+F1CKCn1k=vGsbgKTXmHrfCZ=Ftgzg8=FON0-XRjDYR59+6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice: don't enter opengl mode in case
 another UI provides opengl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi

On Tue, Jun 6, 2017 at 3:11 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  include/ui/spice-display.h | 2 ++
>  ui/spice-core.c            | 1 +
>  ui/spice-display.c         | 3 ++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
> index 184d4c373a..4ba9444dba 100644
> --- a/include/ui/spice-display.h
> +++ b/include/ui/spice-display.h
> @@ -140,6 +140,8 @@ struct SimpleSpiceCursor {
>      QXLCursor cursor;
>  };
>
> +extern bool spice_opengl;
> +
>  int qemu_spice_rect_is_empty(const QXLRect* r);
>  void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 804abc5c0f..7c9ec0f0dd 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -847,6 +847,7 @@ void qemu_spice_init(void)
>              exit(1);
>          }
>          display_opengl =3D 1;
> +        spice_opengl =3D 1;
>      }
>  #endif
>  }
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index b353445f58..042292cc90 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -27,6 +27,7 @@
>  #include "ui/spice-display.h"
>
>  static int debug =3D 0;
> +bool spice_opengl;
>
>  static void GCC_FMT_ATTR(2, 3) dprint(int level, const char *fmt, ...)
>  {
> @@ -1013,7 +1014,7 @@ static void qemu_spice_display_init_one(QemuConsole
> *con)
>
>      ssd->dcl.ops =3D &display_listener_ops;
>  #ifdef HAVE_SPICE_GL
> -    if (display_opengl) {
> +    if (spice_opengl) {
>          ssd->dcl.ops =3D &display_listener_gl_ops;
>          ssd->gl_unblock_bh =3D qemu_bh_new(qemu_spice_gl_unblock_bh, ssd=
);
>          ssd->gl_unblock_timer =3D timer_new_ms(QEMU_CLOCK_REALTIME,
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
