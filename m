Received: from eggs.gnu.org ([2001:4830:134:3::10]:34203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCkFR-0004aC-Ms
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCkFQ-0001rX-RA
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:39:49 -0500
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:51767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eCkFQ-0001rC-M7
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:39:48 -0500
Received: by mail-ua0-x241.google.com with SMTP id 65so4050107uaq.8
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 02:39:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109073759.5910-1-kraxel@redhat.com>
References: <20171109073759.5910-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Nov 2017 11:39:47 +0100
Message-ID: <CAJ+F1CJeZQfwCOhm=jR_=7TyXw+NdsHeT8yETg_ky-wwHPV5tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui: fix dcl unregister
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Nov 9, 2017 at 8:37 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> register checks for dcl->ds being NULL, to avoid registering
> the same dcl twice.
>
> Therefore dcl->ds must be cleared on unregister, otherwise
> un-registering and re-registering doesn't work.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1510809
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/console.c | 1 +
>  ui/vnc.c     | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/ui/console.c b/ui/console.c
> index eca854cbd5..c4c95abed7 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1471,6 +1471,7 @@ void unregister_displaychangelistener(DisplayChange=
Listener *dcl)
>          dcl->con->dcls--;
>      }
>      QLIST_REMOVE(dcl, next);
> +    dcl->ds =3D NULL;
>      gui_setup_refresh(ds);
>  }
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9f8d5a1b1f..bd46f11fcc 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3044,6 +3044,7 @@ void vnc_display_init(const char *id)
>  {
>      VncDisplay *vd;
>
> +    fprintf(stderr, "%s: %s\n", __func__, id);
>      if (vnc_display_find(id) !=3D NULL) {
>          return;
>      }
> @@ -3982,6 +3983,7 @@ void vnc_display_open(const char *id, Error **errp)
>      }
>
>      if (con !=3D vd->dcl.con) {
> +        fprintf(stderr, "%s: %s\n", __func__, id);

I suppose the 2 printf are not intentional.

>          unregister_displaychangelistener(&vd->dcl);
>          vd->dcl.con =3D con;
>          register_displaychangelistener(&vd->dcl);
> --
> 2.9.3
>
>

without the printf,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




--=20
Marc-Andr=C3=A9 Lureau
