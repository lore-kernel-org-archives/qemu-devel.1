Received: from eggs.gnu.org ([2001:4830:134:3::10]:35365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3wfE-0002K0-3f
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 00:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3wfA-0001kr-5i
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 00:38:20 -0400
Date: Thu, 5 Apr 2018 14:37:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180405043758.GI20851@umbus.fritz.box>
References: <20180315133402.13470-1-clg@kaod.org>
	<20180315133402.13470-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <20180315133402.13470-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] target/ppc: generalize check on
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


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 01:34:02PM +0000, C=E9dric Le Goater wrote:
> On a POWER9 processor, the first doubleword of the partition table
> entry (as pointed to by the PTCR) indicates whether the host uses HPT
> or Radix Tree translation for that partition. Use that bit to check
> for radix mode on pseries and powernv QEMU machines.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>


> ---
>=20
>  Changes since v2:
>=20
>  - reworked ppc64_v3_radix() to distinguish pseries machine from
>    powernv machines
>  - kept ppc64_radix_guest()
>=20
>  Changes since v1:
>=20
>  - fixed commit log
>  - introduced ppc64_v3_get_patbe0()
>  - renamed ppc64_radix() in ppc64_v3_radix()
>=20
>  target/ppc/mmu-book3s-v3.c | 23 +++++++++++++++++++++--
>  target/ppc/mmu-book3s-v3.h |  4 +++-
>  target/ppc/mmu_helper.c    |  4 ++--
>  3 files changed, 26 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> index b60df4408f3b..89edbb6abc5c 100644
> --- a/target/ppc/mmu-book3s-v3.c
> +++ b/target/ppc/mmu-book3s-v3.c
> @@ -19,16 +19,35 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "qemu/error-report.h"
>  #include "mmu-hash64.h"
>  #include "mmu-book3s-v3.h"
>  #include "mmu-radix64.h"
> =20
> +bool ppc64_v3_radix(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    /* sPAPR machine */
> +    if (cpu->vhyp) {
> +        return ppc64_radix_guest(cpu);
> +    }
> +
> +    /* PowerNV machine - only HV mode is supported */
> +    if (msr_hv) {
> +        return ppc64_v3_get_patbe0(cpu) & PATBE0_HR;
> +    } else {
> +        error_report("PowerNV guest support Unimplemented");
> +        exit(1);
> +    }
> +}
> +
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx)
>  {
> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> +    if (ppc64_v3_radix(cpu)) {
>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> -    } else { /* Guest uses hash */
> +    } else {
>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
>      }
>  }
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index a7ab580c3140..9721791d2dd3 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -29,7 +29,8 @@
>  #define PTCR_PATS               0x000000000000001FULL /* Partition Table=
 Size */
> =20
>  /* Partition Table Entry Fields */
> -#define PATBE1_GR 0x8000000000000000
> +#define PATBE0_HR               PPC_BIT(0)            /* 1:Host Radix  0=
:HPT  */
> +#define PATBE1_GR               PPC_BIT(0)            /* 1:Guest Radix 0=
:HPT  */
> =20
>  /* Process Table Entry */
>  struct prtb_entry {
> @@ -50,6 +51,7 @@ static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> =20
>      return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
>  }
> +bool ppc64_v3_radix(PowerPCCPU *cpu);
> =20
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx);
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 03009eee723a..fba203cdef18 100644
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrFqCMACgkQbDjKyiDZ
s5KgIg//Y+q+CoiWuV1Ce2Cj5pJaBdi0ifK3el4AVScL4a8JXlCa1uTppgU2PAo1
nccTEL6i7ERwaOIKiETV2Qr5s7ecfvkIyd4QwAjM76SOAkQoRT0xuo6OdJzxA4vG
U12iGm1K7jjDmFmOS70p7io2YPBk3wpi2+Ff5sjrJR5KqeYoQgTdGVJjP1z0EN4M
9AWWOFG8zVGyZeQkiAyndzYwsH2GEeb/+gclzL3+v1SDgcqLEbiuko7O//i4oKkM
OGvegpeSrV2gRZ83CU9B3b6O/zhUC/O7g/eK3fu6V1wy+vIw97wlATSfoUrUvhtB
etlu1t8qpm8RwQObUlTZ9DOS5l+HmCFpy2qhIcKp4m+9+2Nb7C+7TcRWNx7f8JR5
WfLmcs/G39INv+Igq2OKgbSWj0BMRFCdr9qxrrMFs933oXngBOR5P+bny6kgWomv
0RZzAJ1XUBpH+WwNN8LFVa70qIsolCl6PXErxFtsoNs9QDRCrBb0P031YE3tqtdm
1otXbcixfoj8PcEjCiu3Lkf5guyT8p3x/MWV8Hyasw4C6q4zpIJ2BzX8da+KScCq
ikI2X30W2u/vrG9gg0u7ur1RRnLlZ8ByY0MM+HaIGiusJ9FKhEK5x4+MWAqccr6N
ffhJvOfx0I4S5Y5omWKEZm3hlT/p2SxoEYfEP1ktZMKxQsa+nDI=
=z2l5
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
