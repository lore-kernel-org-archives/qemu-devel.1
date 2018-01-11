Received: from eggs.gnu.org ([2001:4830:134:3::10]:59119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZXjE-00054A-OV
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 02:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZXjB-0000oX-KN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 02:56:48 -0500
Date: Thu, 11 Jan 2018 18:52:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180111075200.GG24770@umbus.fritz.box>
References: <20180111040832.28383-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline
In-Reply-To: <20180111040832.28383-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] target/ppc: Yet another fix for
 KVM-HV HPTE accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 03:08:32PM +1100, Alexey Kardashevskiy wrote:
> As stated in the 1ad9f0a464fe commit log, the returned entries are not
> a while PTEG. It was not a problem before 1ad9f0a464fe as it would read
> a single record assuming it contains a whole PTEG but now the code tries
> reading the entire PTEG and "if ((n - i) < invalid)" produces negative
> values which then are converted to size_t for memset() and that throws
> seg fault.
>=20
> This fixes the math.
>=20
> While here, fix the last @i increment as well.
>=20
> Fixes: 1ad9f0a464fe "target/ppc: Fix KVM-HV HPTE accessors"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied, thanks.

> ---
>=20
> Record #0:
> (gdb) p *hdr
> $13 =3D {
>   index =3D <ptr>,
>   n_valid =3D 0x1,
>   n_invalid =3D 0x6
> }
>=20
> Record #1:
> (gdb) p *hdr
> $18 =3D {
>   index =3D <ptr>,
>   n_valid =3D 0x2,
>   n_invalid =3D 0x6
> }
>=20
>=20
> i.e. in the second iteration of the loop right before
> "if ((n - i) < invalid)":
> (gdb) p n
> $16 =3D 0x8
> (gdb) p i
> $17 =3D 0x9
>=20
> and @invalid becomes -1.
>=20
> ---
>  target/ppc/kvm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 0566af7..c2dea81 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2657,21 +2657,24 @@ void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, h=
waddr ptex, int n)
> =20
>          hdr =3D (struct kvm_get_htab_header *)buf;
>          while ((i < n) && ((char *)hdr < (buf + rc))) {
> -            int invalid =3D hdr->n_invalid;
> +            int invalid =3D hdr->n_invalid, valid =3D hdr->n_valid;
> =20
>              if (hdr->index !=3D (ptex + i)) {
>                  hw_error("kvmppc_read_hptes: Unexpected HPTE index %"PRI=
u32
>                           " !=3D (%"HWADDR_PRIu" + %d", hdr->index, ptex,=
 i);
>              }
> =20
> -            memcpy(hptes + i, hdr + 1, HASH_PTE_SIZE_64 * hdr->n_valid);
> -            i +=3D hdr->n_valid;
> +            if (n - i < valid) {
> +                valid =3D n - i;
> +            }
> +            memcpy(hptes + i, hdr + 1, HASH_PTE_SIZE_64 * valid);
> +            i +=3D valid;
> =20
>              if ((n - i) < invalid) {
>                  invalid =3D n - i;
>              }
>              memset(hptes + i, 0, invalid * HASH_PTE_SIZE_64);
> -            i +=3D hdr->n_invalid;
> +            i +=3D invalid;
> =20
>              hdr =3D (struct kvm_get_htab_header *)
>                  ((char *)(hdr + 1) + HASH_PTE_SIZE_64 * hdr->n_valid);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpXF50ACgkQbDjKyiDZ
s5I0pRAA5iLFFRvngOouX1Gbjun65VawV9V1ULtz9Bq+9U84+LK6kRpgTTnYjOJy
CuR0pgCG6wPgHKXH1wGT301mvZFpip8wsnIMn+n7iPi2XD4A+hRwZ2JPhJw0fN33
5IJPCJNsuOGW8P5Ydme8wqKKqbxKi+gcHaWaqtbDG6S8dvgiaEilKVo/D2zbZwL4
6fKiaJ6sgbPEGiZZ0qGywjw5qxJY+/PyLEG9UAI9HBRLTBWX8ic6hFpqO08OkAbJ
V2Cs2Q56wa+C8gPIENtidandngqTAMCw4bspNXOs33RkIyLdhDkEGasMj2zeC6vK
jCiMFkH7KNNEOaTupuoym1UvLdMSb1W3d7cuAR9wFybCGo64DfiGbWdOyaOktxHo
eRxBQZWRRxm1fM8ilH6yEHSHxIc0/bkZdW7xas49VjlmxzQcOc2mvhbJmBc9j6zw
ieBWjYtcW8RZq9I2mX0ovU7SkNkhix6dckbDvnWjAZcQfR6mv2xIRgnasOMJ9bxe
pkB6W/yCKl160YsecN0jAqX3W4Vr+ZJCarEgaHWzoekdFK8wvsz8p6QjeueK0V3l
auPUByWxo9dVMvFnSF9hiWlXKnAni+FszC4KBakjZbNt2lvSsjZBLSDUCzhpQInL
Lbr3BSN8vLqK5DeRGlgs7thQTtDoxon2UmLtT3jnkhjghmDewng=
=/+zU
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
