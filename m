Received: from eggs.gnu.org ([2001:4830:134:3::10]:59800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1endhT-0002SG-Sk
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 00:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1endhP-0001zU-O4
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 00:09:15 -0500
Date: Mon, 19 Feb 2018 14:29:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180219032914.GG1109@umbus.fritz.box>
References: <20180216084504.24958-1-clg@kaod.org>
	<20180216084504.24958-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <20180216084504.24958-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/ppc: generalize check on
 radix when in HV mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 09:45:04AM +0100, C=E9dric Le Goater wrote:
> On a POWER9 processor, the first doubleword of the partition table
> entry (as pointed to by the PTCR) indicates whether the host uses HPT
> or Radix Tree translation for that partition. Use that bit to check
> for radix mode on pseries and powernv QEMU machines.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  Changes since v1:
>=20
>  - fixed commit log
>  - introduced ppc64_v3_get_patbe0()
>  - renamed ppc64_radix() in ppc64_v3_radix()
> =20
>  target/ppc/mmu-book3s-v3.c  | 16 +++++++++++++++-
>  target/ppc/mmu-book3s-v3.h  | 11 +++--------
>  target/ppc/mmu_helper.c     |  4 ++--
>  target/ppc/translate_init.c |  2 +-
>  4 files changed, 21 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> index b60df4408f3b..9d05e07ef6bd 100644
> --- a/target/ppc/mmu-book3s-v3.c
> +++ b/target/ppc/mmu-book3s-v3.c
> @@ -23,10 +23,24 @@
>  #include "mmu-book3s-v3.h"
>  #include "mmu-radix64.h"
> =20
> +bool ppc64_v3_radix(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (msr_hv) {
> +        return ppc64_v3_get_patbe0(cpu) & PATBE0_HR;
> +    } else  {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +
> +        return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> +    }

I think this is backwards.  If cpu->vhyp is set, you should always the
get_patbe() hook, before you go looking at anything else.

This is also wrong if you have a powernv platform but msr_hv is not
set - which is what you'll have once you get to the point of trying to
run guests within an emulated powernv machine.

> +}
> +
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx)
>  {
> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> +    if (ppc64_v3_radix(cpu)) { /* radix mode */
>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
>      } else { /* Guest uses hash */
>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index a7ab580c3140..a12bb1e28b45 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -29,7 +29,8 @@
>  #define PTCR_PATS               0x000000000000001FULL /* Partition Table=
 Size */
> =20
>  /* Partition Table Entry Fields */
> -#define PATBE1_GR 0x8000000000000000
> +#define PATBE0_HR               PPC_BIT(0)            /* 1:Host Radix 0:=
HPT   */
> +#define PATBE1_GR               PPC_BIT(0)            /* 1:Guest Radix 0=
:HPT  */
> =20
>  /* Process Table Entry */
>  struct prtb_entry {
> @@ -43,13 +44,7 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
>  }
> =20
> -static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> -{
> -    PPCVirtualHypervisorClass *vhc =3D
> -        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -
> -    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> -}
> +bool ppc64_v3_radix(PowerPCCPU *cpu);
> =20
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx);
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 82e63552f617..81a43982e421 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1285,7 +1285,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf=
, CPUPPCState *env)
>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>          break;
>      case POWERPC_MMU_VER_3_00:
> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
>              /* TODO - Unsupported */
>          } else {
>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> @@ -1431,7 +1431,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, va=
ddr addr)
>      case POWERPC_MMU_VER_2_07:
>          return ppc_hash64_get_phys_page_debug(cpu, addr);
>      case POWERPC_MMU_VER_3_00:
> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
>              return ppc_radix64_get_phys_page_debug(cpu, addr);
>          } else {
>              return ppc_hash64_get_phys_page_debug(cpu, addr);
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index c998ac2ee405..21d5dcd15386 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8967,7 +8967,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
>           * KVM but not under TCG. Update the default LPCR to keep new
>           * CPUs in sync when radix is enabled.
>           */
> -        if (ppc64_radix_guest(cpu)) {
> +        if (ppc64_v3_radix(cpu)) {
>              lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
>          } else {
>              lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqKRIoACgkQbDjKyiDZ
s5IowBAAyWSAJapFelTrPj2aajaJAoOzSHOOwEoedHQQrSdyQ0HNCBB2kKW9NuJi
PsvxVEnrxrDPGAUxA/6J1WCTNqJkVK4oiIVMYtEkQ/0WDRw9z+2D/mX2Z6Xd2nCc
X4E3tk52AsM51Ax903fbHJH1rUD1jOvevS10EGrABGCeFVsusHYIH9JhMf6ua3SH
OLpFec8eR0I8aMO7Yr5PlDhrLch0sEbcHDUmeSHNKpPVhABLiJ4q4oMsjQovWDwp
nu1wvEsVVB/R/ys/viiXPpUVyZ8CikyMa6Z3C4HFDfIsrA9oM2YFWFYLukJvqGih
lo1yj/AXTGSVedyIfDwdmXejIPpmlBmTT3zRiNpSYSm3SRraR+rwjNDaPaQKyLA0
no87D8PVOBArXQ2v8hyJqGpnoAGXF0nsyvCEH1JBMy6Nb8Dv19gmYnnZwUwRLVZl
rBguzkm9i35+lH/AZgPG4cmDFrkLalE8RhpLHaH1eVxm4+TFJ7Pvf/mc7ZQCazN5
8B47XwEoh6Jc9hNBvERXbcMLYUwn0mCA8Lj0f+uTO1MTcIu8xjU1mpoXYVdnpE9L
ZOiFN8Mxoq0mlNoqWt1/ltJyYtf6rkU/TEAQ04Msr0LkDQw/s525m1cHe+g3BGXc
JCpzkFdu+HY0iwDbqed1A+u3AN7vN8XRB2mHk8fnIfFSIM0E/Os=
=EX4W
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
