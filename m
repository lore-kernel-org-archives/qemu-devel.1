Received: from eggs.gnu.org ([209.51.188.92]:39997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjiU0-00074u-KV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjiLW-0001ch-Pu
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:22:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjiLW-0001Zd-Fj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:22:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DBCF87637
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 10:22:53 +0000 (UTC)
Date: Wed, 16 Jan 2019 10:22:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116102244.GJ20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190116101049.8929-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116101049.8929-1-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: detect and optimize pageflips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 16, 2019 at 11:10:49AM +0100, Gerd Hoffmann wrote:
> When size and format of the display surface stays the same we can just
> tag the guest display as dirty and be done with it.
>=20
> There is no need need to resize the vnc server display or to touch the
> vnc client dirty bits.  On the next refresh cycle
> vnc_refresh_server_surface() will check for actual display content
> changes and update the client dirty bits as needed.
>=20
> The desktop resize and framebuffer format notifications to the vnc
> client will be skipped too.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/vnc.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9e4b2beb71..6002d09407 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -742,6 +742,17 @@ static void vnc_update_server_surface(VncDisplay *=
vd)
>                         width, height);
>  }
> =20
> +static bool vnc_check_pageflip(DisplaySurface *s1,
> +                               DisplaySurface *s2)
> +{
> +    return (s1 !=3D NULL &&
> +            s2 !=3D NULL &&
> +            surface_width(s1) =3D=3D surface_width(s2) &&
> +            surface_height(s1) =3D=3D surface_height(s2) &&
> +            surface_format(s1) =3D=3D surface_format(s2));
> +
> +}
> +
>  static void vnc_dpy_switch(DisplayChangeListener *dcl,
>                             DisplaySurface *surface)
>  {
> @@ -749,6 +760,7 @@ static void vnc_dpy_switch(DisplayChangeListener *d=
cl,
>          "Display output is not active.";
>      static DisplaySurface *placeholder;
>      VncDisplay *vd =3D container_of(dcl, VncDisplay, dcl);
> +    bool pageflip =3D vnc_check_pageflip(vd->ds, surface);
>      VncState *vs;
> =20
>      if (surface =3D=3D NULL) {
> @@ -761,14 +773,21 @@ static void vnc_dpy_switch(DisplayChangeListener =
*dcl,
>      vnc_abort_display_jobs(vd);
>      vd->ds =3D surface;
> =20
> -    /* server surface */
> -    vnc_update_server_surface(vd);
> -
>      /* guest surface */
>      qemu_pixman_image_unref(vd->guest.fb);
>      vd->guest.fb =3D pixman_image_ref(surface->image);
>      vd->guest.format =3D surface->format;
> =20
> +    if (pageflip) {
> +        vnc_set_area_dirty(vd->guest.dirty, vd, 0, 0,
> +                           surface_width(surface),
> +                           surface_height(surface));
> +        return;
> +    }
> +
> +    /* server surface */
> +    vnc_update_server_surface(vd);
> +
>      QTAILQ_FOREACH(vs, &vd->clients, next) {
>          vnc_colordepth(vs);
>          vnc_desktop_resize(vs);
> --=20
> 2.9.3
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
