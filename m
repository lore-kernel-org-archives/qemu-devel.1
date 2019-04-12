Received: from eggs.gnu.org ([209.51.188.92]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplb-0005KQ-O1
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplX-0000q0-UU
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:27 -0400
Date: Fri, 12 Apr 2019 16:11:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190412061145.GD8005@umbus.fritz.box>
References: <20190411080004.8690-1-clg@kaod.org>
	<20190411080004.8690-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20190411080004.8690-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/6] ppc/spapr: Use proper HPTE accessors
 for H_READ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:00:00AM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_hcall.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index be8044a92f2f..7761d4a841af 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -304,8 +304,8 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>  {
>      target_ulong flags =3D args[0];
>      target_ulong ptex =3D args[1];
> -    uint8_t *hpte;
>      int i, ridx, n_entries =3D 1;
> +    const ppc_hash_pte64_t *hptes;
> =20
>      if (!valid_ptex(cpu, ptex)) {
>          return H_PARAMETER;
> @@ -317,13 +317,12 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
>          n_entries =3D 4;
>      }
> =20
> -    hpte =3D spapr->htab + (ptex * HASH_PTE_SIZE_64);
> -
> +    hptes =3D ppc_hash64_map_hptes(cpu, ptex, n_entries);
>      for (i =3D 0, ridx =3D 0; i < n_entries; i++) {
> -        args[ridx++] =3D ldq_p(hpte);
> -        args[ridx++] =3D ldq_p(hpte + (HASH_PTE_SIZE_64/2));
> -        hpte +=3D HASH_PTE_SIZE_64;
> +        args[ridx++] =3D ppc_hash64_hpte0(cpu, hptes, i);
> +        args[ridx++] =3D ppc_hash64_hpte1(cpu, hptes, i);
>      }
> +    ppc_hash64_unmap_hptes(cpu, hptes, ptex, n_entries);
> =20
>      return H_SUCCESS;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlywLCEACgkQbDjKyiDZ
s5IwVg/+NH0VEbX+zv+Y3dkdQzeyjhHt1MfnCIFEknboM8PvnjntIhNGPXI8IV4r
jv8HRJUUhQ6cwLa9cXamhiajfU1e1OoOzoZ6JJAJf6wBfWBYFVQgH/n44PBRWhYf
yBBiaTmpaAdL4JPXwe1r0hYF89icBZz4+6809YBiABAkMYlLd7lqo3sVzGgdERtT
sxl9tt0NVNsTCM740LqZbAAppYZ/l58fc/YRZ0+jr/AmMEYEXFfdNqphkVKnlkz2
a++Qrm5FvAdEXUv6l5kKBJ65tDk7iNQEOTrYoAHk6LIWJwI42iJIqW4Bvg94IDs2
2UyWHNYuRVibefeTgfaAGerCNOxd/TZ+y5EhTrLCBx4exsUICTMdslLQIhUA20pj
6NhiMsQ7/A7973oQ9Xlx7ZnwilNNFGj1OjRnyhN6Rk/jJ35NgV9p+t4LO84N9C6k
IxaxUZbZKPUnPG7aBCbQaHcL2+IvMgO4/mqbwq8wp6RtwYw5SS6vVvC/T2cIihpa
1Mbnl3E31rwXBOf7YNM4QcFOOrz5ygdnA0qVQpP9r+Zyomw6ze4x95Zwn9mfmBcv
7szX1Hj5jZ4mS+F3O2FipVRRoLj8ZZgGH1Rz7eKUA46tjzo6eFo64hFfG/KuzKpL
eTMl1ymK2WWTFAUMbCnaspNZHloTFZNMJJngcUDsSWps8Fdxoxg=
=y1e+
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
