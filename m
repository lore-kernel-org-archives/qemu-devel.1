Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cVx6B-00028B-Lg
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cVx67-0000Iv-Hp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:09:07 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:35644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cVx67-0000IN-9Q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:09:03 -0500
Date: Tue, 24 Jan 2017 04:09:00 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1628141119.618244.1485248940241.JavaMail.zimbra@redhat.com>
In-Reply-To: <1485248428-575-1-git-send-email-kraxel@redhat.com>
References: <1485248428-575-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: fix overflow in vnc_update_stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Hi

----- Original Message -----
> Commit "bea60dd ui/vnc: fix potential memory corruption issues" is
> incomplete.  vnc_update_stats must calculate width and height the same
> way vnc_refresh_server_surface does it, to make sure we don't use width
> and height values larger than the qemu vnc server can handle.
>=20
> Commit "e22492d ui/vnc: disable adaptive update calculations if not
> needed" masks the issue in the default configuration.  It triggers only
> in case the "lossy" option is set to "on" (default is "off").
>=20
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 29aa9c4..e7c029d 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2756,8 +2756,10 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, =
int
> x, int y)
> =20
>  static int vnc_update_stats(VncDisplay *vd,  struct timeval * tv)
>  {
> -    int width =3D pixman_image_get_width(vd->guest.fb);
> -    int height =3D pixman_image_get_height(vd->guest.fb);
> +    int width =3D MIN(pixman_image_get_width(vd->guest.fb),
> +                    pixman_image_get_width(vd->server));
> +    int height =3D MIN(pixman_image_get_height(vd->guest.fb),
> +                     pixman_image_get_height(vd->server));
>      int x, y;
>      struct timeval res;
>      int has_dirty =3D 0;
> --
> 1.8.3.1
>=20
>=20
