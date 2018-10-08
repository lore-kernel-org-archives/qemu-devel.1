Received: from eggs.gnu.org ([2001:4830:134:3::10]:48710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9asZ-00070X-Pc
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9aff-0004Pf-C9
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:54:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1g9afc-0004O6-5K
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:54:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C520661463
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 18:54:16 +0000 (UTC)
References: <20181008185013.19371-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d3a7d12c-162a-8ba2-cfbe-767e0f261c29@redhat.com>
Date: Mon, 8 Oct 2018 20:54:11 +0200
MIME-Version: 1.0
In-Reply-To: <20181008185013.19371-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VK9jglZvIZrebWAwLoXByX2fhQ6K0iXUz"
Subject: Re: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VK9jglZvIZrebWAwLoXByX2fhQ6K0iXUz
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <d3a7d12c-162a-8ba2-cfbe-767e0f261c29@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
References: <20181008185013.19371-1-mreitz@redhat.com>
In-Reply-To: <20181008185013.19371-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.10.18 20:50, Max Reitz wrote:
> There are some 2D resource formats that can be used through virtio-gpu,=

> but which are not supported by SDL2 when used for a scanout; these are
> all alpha-channel formats and also XBGR (RGBX in non-BE pixman).

Oops, it's the other way round.  The virtio-gpu format is RGBX, and the
non-BE pixman (and SDL) constant is XBGR.

Max

> Add these formats in the switch converting pixman to SDL format
> constants so a guest cannot crash the VM by triggering the
> g_assert_not_reached() with an unsupported format.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  ui/sdl2-2d.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
> index 85484407be..c9df72636a 100644
> --- a/ui/sdl2-2d.c
> +++ b/ui/sdl2-2d.c
> @@ -101,15 +101,24 @@ void sdl2_2d_switch(DisplayChangeListener *dcl,
>      case PIXMAN_r5g6b5:
>          format =3D SDL_PIXELFORMAT_RGB565;
>          break;
> +    case PIXMAN_a8r8g8b8:
>      case PIXMAN_x8r8g8b8:
>          format =3D SDL_PIXELFORMAT_ARGB8888;
>          break;
> +    case PIXMAN_a8b8g8r8:
> +    case PIXMAN_x8b8g8r8:
> +        format =3D SDL_PIXELFORMAT_ABGR8888;
> +        break;
> +    case PIXMAN_r8g8b8a8:
>      case PIXMAN_r8g8b8x8:
>          format =3D SDL_PIXELFORMAT_RGBA8888;
>          break;
>      case PIXMAN_b8g8r8x8:
>          format =3D SDL_PIXELFORMAT_BGRX8888;
>          break;
> +    case PIXMAN_b8g8r8a8:
> +        format =3D SDL_PIXELFORMAT_BGRA8888;
> +        break;
>      default:
>          g_assert_not_reached();
>      }
>=20



--VK9jglZvIZrebWAwLoXByX2fhQ6K0iXUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7p9MACgkQ9AfbAGHV
z0Bd7wf/Z4EythMOK6oP/yAkTU12cDQdx0stKCku0TekZI7NxfutNAPgXa4vBwH4
eQJ1a9yPWtE7uY2AMRwdq9NypCcFZEsF0hIochgcJVx6SRcsNfU4nVNUOJo1Klg1
emYQDUGAn/Ui7+Zz9iLj3yUnG5j3RwONAIu/kvhhu2VoSD940c9zgkUb9z4TtW6u
rblaPlMKsZiOXZ98poRFUOva4P8O1BiD4CDT4CRjOevabmgLnsuCcDagJ2m+QWTN
Mlwupara/zwR6xxQlAE0B6FTPfz7vjyyD0m1eTt0eRMWpCvtaEy1hMfGekduzA/8
urCRDlnjLOxFLN2OidSByADG0XPz+g==
=fd8D
-----END PGP SIGNATURE-----

--VK9jglZvIZrebWAwLoXByX2fhQ6K0iXUz--
