Received: from eggs.gnu.org ([208.118.235.92]:35274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gef1m-00056V-5c
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gef1k-0000d8-4l
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:49:38 -0500
Date: Wed, 2 Jan 2019 11:49:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102114919.GJ24009@stefanha-x1.localdomain>
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-2-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Content-Disposition: inline
In-Reply-To: <20181223025939.15775-2-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2018 at 10:59:37AM +0800, yuchenlin wrote:
> There is a possible hang in original binary search implementation. That is
> if chunk1 =3D 4, chunk2 =3D 5, chunk3 =3D 4, and we go else case.
>=20
> The chunk1 will be still 4, and so on.
>=20
> Signed-off-by: yuchenlin <npes87184@gmail.com>
> ---
>  block/dmg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/dmg.c b/block/dmg.c
> index 50e91aef6d..0e05702f5d 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -572,14 +572,14 @@ static inline uint32_t search_chunk(BDRVDMGState *s=
, uint64_t sector_num)
>  {
>      /* binary search */
>      uint32_t chunk1 =3D 0, chunk2 =3D s->n_chunks, chunk3;
> -    while (chunk1 !=3D chunk2) {
> +    while (chunk1 <=3D chunk2) {
>          chunk3 =3D (chunk1 + chunk2) / 2;
>          if (s->sectors[chunk3] > sector_num) {
> -            chunk2 =3D chunk3;
> +            chunk2 =3D chunk3 - 1;

Question from the previous email you sent:

What happens when chunk1 =3D 0, chunk2 =3D 1, and chunk3 =3D 0?  This would
cause out-of-bounds sectors[] accesses.

Stefan

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLKU/AAoJEJykq7OBq3PIbEMIAIfsSEwsDFZatnnXEubhChF0
DcR+tIXxMnW3BnkRClnXfp7d+xuo4hRpKTD/d8x1g4w/JKUe2Drlc4q9fdEzVoXT
pvwcKFh61PatRG0z7kgFFqfiu9NqkwIYeeLWZI8TMPMjaJXNk++ct5ZpIUt24d+N
Pv98Mxae8bjzhKHo92wDrOTFpaVoQAUU7+HJ/ysmK8Uyx5aE2IfSeKAQTFvi1WJ9
NHccHI4LvThKrFQRNVBR2m4GWEghCxugX5Em7stQGbeVtoZ/xzpI5QzcbpHxeQzA
+wwef+aMtnaWZQV4eetgowREUqH1dLaUGBz23Rv2j8zBLgWDcXEEDk65tROdv4M=
=zarY
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--
