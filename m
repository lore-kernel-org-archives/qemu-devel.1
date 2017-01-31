Received: from eggs.gnu.org ([2001:4830:134:3::10]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYan6-0001j3-PK
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYan5-0002s1-VC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:56:20 -0500
Date: Tue, 31 Jan 2017 15:56:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131155610.GV18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-17-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oAjj1ZwgLg4oRN9q"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-17-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 16/21] hbitmap: add hbitmap_count_between()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--oAjj1ZwgLg4oRN9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:59PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Add this function only for HBitmap's with greanularity =3D 0.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  include/qemu/hbitmap.h | 2 ++
>  util/hbitmap.c         | 9 +++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index 2873a46..1967e13 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -314,4 +314,6 @@ static inline size_t hbitmap_iter_next_word(HBitmapIt=
er *hbi, unsigned long *p_c
>  }
> =20
> =20
> +uint64_t hbitmap_count_between(HBitmap *hb, uint64_t start, uint64_t end=
);

Missing doc comments.

> +
>  #endif
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 48d8b2d..d06bfa3 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -232,6 +232,15 @@ static uint64_t hb_count_between(HBitmap *hb, uint64=
_t start, uint64_t last)
>      return count;
>  }
> =20
> +/* hbitmap_count_between() is only for HBitmap's with granularity =3D 0 =
*/
> +uint64_t hbitmap_count_between(HBitmap *hb, uint64_t start, uint64_t end)
> +{
> +    assert(hb->granularity =3D=3D 0);
> +    assert(start < end);
> +
> +    return hb_count_between(hb, start, end - 1);
> +}

Please rename hb_count_between() and make it externally visible instead
of adding a similarly-named wrapper.

--oAjj1ZwgLg4oRN9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkLOaAAoJEJykq7OBq3PIAh8H+gJnLk8ULeoYKnGoNsRbrqh6
hEXtsqy1RHgD+dbIFXQOvu54RlMOHlYk703hknVKt+1tMM4NMSxotHC8XbfrzAsp
UzKIZFsi2pkvfSBIced5Ti5V238gguQCEBihaoCMK9UxoPdGguhlJugJbg+aZ1j7
+RYFAf05trqrWgZdNC5231Fsd6V7FmwZyLa+CUvTTiWmkq81fFlFGmvPO5NI7Fu9
GJ9qtgnACRXOk0jJkcvuuzcc8l4j6ZsN4TZZrb2J7SBxmSrEFg8ZTC5+RVyZ5p2v
prZOnCUyfN0hGcrko7yEJwPnMvE6bRcXaHyIqu+yCUUaHE8iSXzraBgiQUJAofU=
=oE2t
-----END PGP SIGNATURE-----

--oAjj1ZwgLg4oRN9q--
