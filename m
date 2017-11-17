Received: from eggs.gnu.org ([2001:4830:134:3::10]:58810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eFaCE-00049r-QF
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eFaCB-0003cy-Km
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:32:14 -0500
Date: Fri, 17 Nov 2017 16:50:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171117055055.GD26448@umbus.fritz.box>
References: <20171117053900.2536-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <20171117053900.2536-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3] target/ppc: Update setting
 of cpu features to account for compat modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 04:39:00PM +1100, Suraj Jitindar Singh wrote:
> The device tree nodes ibm,arch-vec-5-platform-support and ibm,pa-features
> are used to communicate features of the cpu to the guest operating
> system. The properties of each of these are determined based on the
> selected cpu model and the availability of hypervisor features.
> Currently the compatibility mode of the cpu is not taken into account.
>=20
> The ibm,arch-vec-5-platform-support node is used to communicate the
> level of support for various ISAv3 processor features to the guest
> before CAS to inform the guests' request. The available mmu mode should
> only be hash unless the cpu is a POWER9 which is not in a prePOWER9
> compat mode, in which case the available modes depend on the
> accelerator and the hypervisor capabilities.
>=20
> The ibm,pa-featues node is used to communicate the level of cpu support
> for various features to the guest os. This should only contain features
> relevant to the operating mode of the processor, that is the selected
> cpu model taking into account any compat mode. This means that the
> compat mode should be taken into account when choosing the properties of
> ibm,pa-features and they should match the compat mode selected, or the
> cpu model selected if no compat mode.
>=20
> Update the setting of these cpu features in the device tree as described
> above to properly take into account any compat mode. We use the
> ppc_check_compat function which takes into account the current processor
> model and the cpu compat mode.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to ppc-for-2.11.

>=20
> ---
>=20
> V1 -> V2:
> - Pass cpu pointer to spapr_populate_pa_features to avoid extracting it
>   back out from env
> - Slight reword of spapr_dt_ov5_platform_support logic to avoid
>   duplicate case
> V2 -> V3:
> - Use ppc_check_compat() to avoid having to check both the cpu model
>   and the compat mode separately since it does it for us
> ---
>  hw/ppc/spapr.c | 43 +++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d682f01..6841bd2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -44,6 +44,7 @@
>  #include "migration/register.h"
>  #include "mmu-hash64.h"
>  #include "mmu-book3s-v3.h"
> +#include "cpu-models.h"
>  #include "qom/cpu.h"
> =20
>  #include "hw/boards.h"
> @@ -252,9 +253,10 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int of=
fset, PowerPCCPU *cpu)
>  }
> =20
>  /* Populate the "ibm,pa-features" property */
> -static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int =
offset,
> -                                      bool legacy_guest)
> +static void spapr_populate_pa_features(PowerPCCPU *cpu, void *fdt, int o=
ffset,
> +                                       bool legacy_guest)
>  {
> +    CPUPPCState *env =3D &cpu->env;
>      uint8_t pa_features_206[] =3D { 6, 0,
>          0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
>      uint8_t pa_features_207[] =3D { 24, 0,
> @@ -287,23 +289,22 @@ static void spapr_populate_pa_features(CPUPPCState =
*env, void *fdt, int offset,
>          /* 60: NM atomic, 62: RNG */
>          0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>      };
> -    uint8_t *pa_features;
> +    uint8_t *pa_features =3D NULL;
>      size_t pa_size;
> =20
> -    switch (POWERPC_MMU_VER(env->mmu_model)) {
> -    case POWERPC_MMU_VER_2_06:
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06, 0, cpu->compat_p=
vr)) {
>          pa_features =3D pa_features_206;
>          pa_size =3D sizeof(pa_features_206);
> -        break;
> -    case POWERPC_MMU_VER_2_07:
> +    }
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07, 0, cpu->compat_p=
vr)) {
>          pa_features =3D pa_features_207;
>          pa_size =3D sizeof(pa_features_207);
> -        break;
> -    case POWERPC_MMU_VER_3_00:
> +    }
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0, cpu->compat_p=
vr)) {
>          pa_features =3D pa_features_300;
>          pa_size =3D sizeof(pa_features_300);
> -        break;
> -    default:
> +    }
> +    if (!pa_features) {
>          return;
>      }
> =20
> @@ -340,7 +341,6 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
> =20
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        CPUPPCState *env =3D &cpu->env;
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int index =3D spapr_vcpu_id(cpu);
>          int compat_smt =3D MIN(smp_threads, ppc_compat_max_threads(cpu));
> @@ -384,7 +384,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
>              return ret;
>          }
> =20
> -        spapr_populate_pa_features(env, fdt, offset,
> +        spapr_populate_pa_features(cpu, fdt, offset,
>                                           spapr->cas_legacy_guest_workaro=
und);
>      }
>      return ret;
> @@ -579,7 +579,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>                            page_sizes_prop, page_sizes_prop_size)));
>      }
> =20
> -    spapr_populate_pa_features(env, fdt, offset, false);
> +    spapr_populate_pa_features(cpu, fdt, offset, false);
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
>                             cs->cpu_index / vcpus_per_socket)));
> @@ -949,7 +949,11 @@ static void spapr_dt_ov5_platform_support(void *fdt,=
 int chosen)
>          26, 0x40, /* Radix options: GTSE =3D=3D yes. */
>      };
> =20
> -    if (kvm_enabled()) {
> +    if (!ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                          first_ppc_cpu->compat_pvr)) {
> +        /* If we're in a pre POWER9 compat mode then the guest should do=
 hash */
> +        val[3] =3D 0x00; /* Hash */
> +    } else if (kvm_enabled()) {
>          if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) {
>              val[3] =3D 0x80; /* OV5_MMU_BOTH */
>          } else if (kvmppc_has_cap_mmu_radix()) {
> @@ -958,13 +962,8 @@ static void spapr_dt_ov5_platform_support(void *fdt,=
 int chosen)
>              val[3] =3D 0x00; /* Hash */
>          }
>      } else {
> -        if (first_ppc_cpu->env.mmu_model & POWERPC_MMU_V3) {
> -            /* V3 MMU supports both hash and radix (with dynamic switchi=
ng) */
> -            val[3] =3D 0xC0;
> -        } else {
> -            /* Otherwise we can only do hash */
> -            val[3] =3D 0x00;
> -        }
> +        /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
> +        val[3] =3D 0xC0;
>      }
>      _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
>                       val, sizeof(val)));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloOeLwACgkQbDjKyiDZ
s5KhNhAAqwbU0a5D/jxLszIJguhODytEyyY6jM8bPyaW6Gl0J4oJAd0wccrgBLdb
pw1dcRn0TzJvyzdhcySWMdj/snncywiGBfDFFg/AX69RqVMCZB7h3cjegDcO2pVe
EvWtxdJH0ZiB8LhWRUOJL6HjBSi55NXleMxX16k5IT5bLo92D8bfSuaQ2BT2shbh
KcuyEeSrjz6+xGF6E/51kxvMkpbMwflBg7BgC9TZRVSGY2VxXJ8kiihkZrE4Mh4G
/tEVrC7dkuThoVI9JuG5ALR3toDBTjIIPG55KLfq6UXiSubOZn6UIo+9awmQX4pL
lS4v1SjaqxdALofI5IqfV2d0abnxriPSYLWywpdU3QkRWA2+ntGNmKSO2FMZnsCd
97gIoCZcQNVKZ5gaGdqTdSrFt73qPVRDiTyGbas+YlV4ocv6cvAorcEnGtcKQu/C
mNGU0G4u8F+wb9UhvIljN/ujUSKKjU6++wvWRoUl6TrZIXe1IR4GF5y3WmQWBmld
Izhoo0B5G29EFpIja6fJgRBslxpx9YF1LAH5Wd5cUCvvObd5QvTlnTphBbef6OMU
vPPJtDIC8WNJc3HIcmJJJvyjBwCE73573oJJCawvQB9paxzqc+l4AESLVcB+9Vzr
cUl1VEuOtoXRYqsGBFuTu+BbS9AiZM2moSpWg71U5ASRBTYY49g=
=jV5D
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
