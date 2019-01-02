Received: from eggs.gnu.org ([208.118.235.92]:41246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gee3H-0007nj-2E
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gee3G-0005BB-Et
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:47:07 -0500
Date: Wed, 2 Jan 2019 10:46:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102104659.GG24009@stefanha-x1.localdomain>
References: <20181221135803.9583-1-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline
In-Reply-To: <20181221135803.9583-1-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-trivial@nongnu.org


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 09:58:03PM +0800, yuchenlin wrote:
> There is a possible hang in original binary searsh implemtation. That is
> if chunk1 =3D 4, chunk2 =3D 5, chunk3 =3D 4, and we go else case.
>=20
> The chunk1 will be still 4, and so on.
>=20
> Signed-off-by: yuchenlin <npes87184@gmail.com>
> ---
>  block/dmg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Do you have an example dmg file that triggers this bug?

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

What if chunk1 =3D 0 and chunk2 =3D 1?  chunk3 =3D 0 and the new chunk2 val=
ue
would be 0xffffffff so the loop continues with out-of-bounds sectors[]
accesses!

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLJajAAoJEJykq7OBq3PIJw4H/Rm/gU4yon7+M0pl4VuikjjH
K8DAKBg81jx8k7MJ9ps5YYEBruRUzbW3XszcuF8GW4JsXZdLCm61NuPwGsQeyL8r
CgetPXdolvE5DUvyE7OtGZLhz5jlAn4jIc3AB5arwAdM75jvWmXR1SA9CzYAE1X3
DozqOlxjqc2W0ld/a15tDaTCUpmnRf3DnxuwE8ukNyl7DmnbcHs7WP+Za/swQX6C
r4GhtK0GUGT60X+/Gs8dQjxIfKR7Y8FXT5Yr2A8zlflamLXE2QDkuoXTozgJK8z1
1FebUJaEy47r4N9vNQf1ZGE/GnAdFUkNxrz0hFutEMSSz1cjdQUZlUXtolzoG6c=
=Oskr
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
