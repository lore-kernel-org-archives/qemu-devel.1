Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmZ-00058J-0f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciVmU-00058Q-SP
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:36:47 -0500
Date: Tue, 28 Feb 2017 11:29:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228002914.GE17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<ac9e5c1e3b571f0286a2ebcd955abfd7be5d7ac7.1487829585.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B6Zh/hwRPruM9rlZ"
Content-Disposition: inline
In-Reply-To: <ac9e5c1e3b571f0286a2ebcd955abfd7be5d7ac7.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 10/12] spapr: move
 spapr_populate_pa_features()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com


--B6Zh/hwRPruM9rlZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 05:00:03PM +1100, Sam Bobroff wrote:
> In the next patch, spapr_fixup_cpu_dt() will need to call
> spapr_populate_pa_features() so move it's definition up without making
> any other changes.

s/it's/its/

>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  hw/ppc/spapr.c | 86 +++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 43 insertions(+), 43 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index dfee0f685f..0c0782b558 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -194,6 +194,49 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int of=
fset, CPUState *cs)
>      return ret;
>  }
> =20
> +/* Populate the "ibm,pa-features" property */
> +static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int =
offset)
> +{
> +    uint8_t pa_features_206[] =3D { 6, 0,
> +        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> +    uint8_t pa_features_207[] =3D { 24, 0,
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> +    uint8_t *pa_features;
> +    size_t pa_size;
> +
> +    switch (POWERPC_MMU_VER(env->mmu_model)) {
> +    case POWERPC_MMU_VER_2_06:
> +        pa_features =3D pa_features_206;
> +        pa_size =3D sizeof(pa_features_206);
> +        break;
> +    case POWERPC_MMU_VER_2_07:
> +        pa_features =3D pa_features_207;
> +        pa_size =3D sizeof(pa_features_207);
> +        break;
> +    default:
> +        return;
> +    }
> +
> +    if (env->ci_large_pages) {
> +        /*
> +         * Note: we keep CI large pages off by default because a 64K cap=
able
> +         * guest provisioned with large pages might otherwise try to map=
 a qemu
> +         * framebuffer (or other kind of memory mapped PCI BAR) using 64=
K pages
> +         * even if that qemu runs on a 4k host.
> +         * We dd this bit back here if we are confident this is not an i=
ssue
> +         */
> +        pa_features[3] |=3D 0x20;
> +    }
> +    if (kvmppc_has_cap_htm() && pa_size > 24) {
> +        pa_features[24] |=3D 0x80;    /* Transactional memory support */
> +    }
> +
> +    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
> +}
> +
>  static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
>  {
>      int ret =3D 0, offset, cpus_offset;
> @@ -346,49 +389,6 @@ static int spapr_populate_memory(sPAPRMachineState *=
spapr, void *fdt)
>      return 0;
>  }
> =20
> -/* Populate the "ibm,pa-features" property */
> -static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int =
offset)
> -{
> -    uint8_t pa_features_206[] =3D { 6, 0,
> -        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> -    uint8_t pa_features_207[] =3D { 24, 0,
> -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
> -        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> -        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> -    uint8_t *pa_features;
> -    size_t pa_size;
> -
> -    switch (POWERPC_MMU_VER(env->mmu_model)) {
> -    case POWERPC_MMU_VER_2_06:
> -        pa_features =3D pa_features_206;
> -        pa_size =3D sizeof(pa_features_206);
> -        break;
> -    case POWERPC_MMU_VER_2_07:
> -        pa_features =3D pa_features_207;
> -        pa_size =3D sizeof(pa_features_207);
> -        break;
> -    default:
> -        return;
> -    }
> -
> -    if (env->ci_large_pages) {
> -        /*
> -         * Note: we keep CI large pages off by default because a 64K cap=
able
> -         * guest provisioned with large pages might otherwise try to map=
 a qemu
> -         * framebuffer (or other kind of memory mapped PCI BAR) using 64=
K pages
> -         * even if that qemu runs on a 4k host.
> -         * We dd this bit back here if we are confident this is not an i=
ssue
> -         */
> -        pa_features[3] |=3D 0x20;
> -    }
> -    if (kvmppc_has_cap_htm() && pa_size > 24) {
> -        pa_features[24] |=3D 0x80;    /* Transactional memory support */
> -    }
> -
> -    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
> -}
> -
>  static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>                                    sPAPRMachineState *spapr)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B6Zh/hwRPruM9rlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtMRaAAoJEGw4ysog2bOSYk4P/0IpZggqSoLBHka4t9MwHu+E
wZ93QAVotbZA8wWxoiUmy8z3YwbJNjjwJO7tBn4W5uhIOa9e6cfnrab/GrU3LHPC
XOuauw/dkVHScToBjsrBuyzxVy8CXEkobXRDWwWhm7f9zFoD06oe+HmSCcLcwGkY
RVWWZYU7pQ7OaUDDtFV/TqFFxim1scFETK7sNl0l+LPJ7cQ5EglQucsYRA2/+0ts
e6dhiAlK7rN5vTi8FyIubmBZydX4UIK/W85mHMjVtCM7GGDyHGh+L0FN9mgR+W5q
jF5yGZcoj6xHupdHIKeq6120xCMTvLJogtAZbrW06o96DiSVDFUo+9YjdjM8H132
a1OO0G9FpetlV6SY4mhOO6AsIMoMUMWXs6zQAK20ROB/J476ZF6HEEKOErC0+bLw
Yq7XfGqHfzFpEY1WcEqkTS87HQzBsqEdiX2RXsJTgPbAFYiLwXlPkmo5s2bVN+21
xOQgoO7urza76f3Ke6hAKX35aGuWHMiVxBuqXyCiJMTsnOspvuguGBZP7NNlavck
Z5ZKXAwXxuaQH4Py/wyRVm6WJBH7WNUJZwujAJVzFpM/2Ni2w9v3U9gHUqf/gHMY
4JDh+OmmdlzpZuwHqTYVUk/KsGP/Ewu6Ux1lcNtTo/6DxSl9qR/z0UDE9TD2yuwp
YAOja7lWWuUnztq29BE3
=2VD+
-----END PGP SIGNATURE-----

--B6Zh/hwRPruM9rlZ--
