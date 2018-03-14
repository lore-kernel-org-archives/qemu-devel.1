Received: from eggs.gnu.org ([2001:4830:134:3::10]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1evyiF-0003HG-V0
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1evyiC-0001WZ-Nx
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:12:31 -0400
Date: Wed, 14 Mar 2018 15:59:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314045900.GH4182@umbus.fritz.box>
References: <20180216084504.24958-1-clg@kaod.org>
	<20180216084504.24958-4-clg@kaod.org>
	<20180219032914.GG1109@umbus.fritz.box>
	<7f1c8d29-f0b9-c2b9-1bdb-221d2cd2b2c3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline
In-Reply-To: <7f1c8d29-f0b9-c2b9-1bdb-221d2cd2b2c3@kaod.org>
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


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 07:36:05PM +0100, C=E9dric Le Goater wrote:
> On 02/19/2018 04:29 AM, David Gibson wrote:
> > On Fri, Feb 16, 2018 at 09:45:04AM +0100, C=E9dric Le Goater wrote:
> >> On a POWER9 processor, the first doubleword of the partition table
> >> entry (as pointed to by the PTCR) indicates whether the host uses HPT
> >> or Radix Tree translation for that partition. Use that bit to check
> >> for radix mode on pseries and powernv QEMU machines.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  Changes since v1:
> >>
> >>  - fixed commit log
> >>  - introduced ppc64_v3_get_patbe0()
> >>  - renamed ppc64_radix() in ppc64_v3_radix()
> >> =20
> >>  target/ppc/mmu-book3s-v3.c  | 16 +++++++++++++++-
> >>  target/ppc/mmu-book3s-v3.h  | 11 +++--------
> >>  target/ppc/mmu_helper.c     |  4 ++--
> >>  target/ppc/translate_init.c |  2 +-
> >>  4 files changed, 21 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> >> index b60df4408f3b..9d05e07ef6bd 100644
> >> --- a/target/ppc/mmu-book3s-v3.c
> >> +++ b/target/ppc/mmu-book3s-v3.c
> >> @@ -23,10 +23,24 @@
> >>  #include "mmu-book3s-v3.h"
> >>  #include "mmu-radix64.h"
> >> =20
> >> +bool ppc64_v3_radix(PowerPCCPU *cpu)
> >> +{
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +
> >> +    if (msr_hv) {
> >> +        return ppc64_v3_get_patbe0(cpu) & PATBE0_HR;
> >> +    } else  {
> >> +        PPCVirtualHypervisorClass *vhc =3D
> >> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >> +
> >> +        return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> >> +    }
> >=20
> > I think this is backwards.  If cpu->vhyp is set, you should always the
> > get_patbe() hook, before you go looking at anything else.
>=20
> OK. So, we should probably change the ppc64_radix_guest() name to=20
> reflect its relation to spapr. How about ppc64_v3_radix_spapr() ?

Um.. why?  The existing name is accurate AFAICT.  It already says
"guest", and even in the unlikely event of a non PAPR guest, the
vhyp->get_patbe method can abstract that correctly.

> > This is also wrong if you have a powernv platform but msr_hv is not
> > set - which is what you'll have once you get to the point of trying to
> > run guests within an emulated powernv machine.
>=20
> That is a good goal to reach ! I will add an error for the !msr_hv
> case.
>=20
> Thanks,
>=20
> C.
>=20
>=20
> >> +}
> >> +
> >>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >>                                int mmu_idx)
> >>  {
> >> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> >> +    if (ppc64_v3_radix(cpu)) { /* radix mode */
> >>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> >>      } else { /* Guest uses hash */
> >>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> >> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> >> index a7ab580c3140..a12bb1e28b45 100644
> >> --- a/target/ppc/mmu-book3s-v3.h
> >> +++ b/target/ppc/mmu-book3s-v3.h
> >> @@ -29,7 +29,8 @@
> >>  #define PTCR_PATS               0x000000000000001FULL /* Partition Ta=
ble Size */
> >> =20
> >>  /* Partition Table Entry Fields */
> >> -#define PATBE1_GR 0x8000000000000000
> >> +#define PATBE0_HR               PPC_BIT(0)            /* 1:Host Radix=
 0:HPT   */
> >> +#define PATBE1_GR               PPC_BIT(0)            /* 1:Guest Radi=
x 0:HPT  */
> >> =20
> >>  /* Process Table Entry */
> >>  struct prtb_entry {
> >> @@ -43,13 +44,7 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *c=
pu)
> >>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
> >>  }
> >> =20
> >> -static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> >> -{
> >> -    PPCVirtualHypervisorClass *vhc =3D
> >> -        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >> -
> >> -    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> >> -}
> >> +bool ppc64_v3_radix(PowerPCCPU *cpu);
> >> =20
> >>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >>                                int mmu_idx);
> >> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> >> index 82e63552f617..81a43982e421 100644
> >> --- a/target/ppc/mmu_helper.c
> >> +++ b/target/ppc/mmu_helper.c
> >> @@ -1285,7 +1285,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fpri=
ntf, CPUPPCState *env)
> >>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> >>          break;
> >>      case POWERPC_MMU_VER_3_00:
> >> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> >> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
> >>              /* TODO - Unsupported */
> >>          } else {
> >>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> >> @@ -1431,7 +1431,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs,=
 vaddr addr)
> >>      case POWERPC_MMU_VER_2_07:
> >>          return ppc_hash64_get_phys_page_debug(cpu, addr);
> >>      case POWERPC_MMU_VER_3_00:
> >> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> >> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
> >>              return ppc_radix64_get_phys_page_debug(cpu, addr);
> >>          } else {
> >>              return ppc_hash64_get_phys_page_debug(cpu, addr);
> >> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> >> index c998ac2ee405..21d5dcd15386 100644
> >> --- a/target/ppc/translate_init.c
> >> +++ b/target/ppc/translate_init.c
> >> @@ -8967,7 +8967,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtua=
lHypervisor *vhyp)
> >>           * KVM but not under TCG. Update the default LPCR to keep new
> >>           * CPUs in sync when radix is enabled.
> >>           */
> >> -        if (ppc64_radix_guest(cpu)) {
> >> +        if (ppc64_v3_radix(cpu)) {
> >>              lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
> >>          } else {
> >>              lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqorBQACgkQbDjKyiDZ
s5JCvxAAtoHwH4Di8nzhrplvTtFfsnAwJPrNJzDTkrOHtvRvdIeV4cwUOuT7NhLf
iAE0FrHIzB9XpFFZyWMlY5HeIz7ZYkXEi8fv2Ph/i4GgTsCDob0Le4W5S9aexEXt
tsRgmTEdctoUJLOtVM3E2W/qCeLQU5p80pQQFxQQ3qha1kILnfH/vIcOLgWwL+v0
yhLMjzH0SMRNsZirK7v64rjqznY0EhorNYFSxdiUSxeFAkweJE1hr6tjYFwS9j0d
oW5eAlK3wHk2VzzMPONiVLWDmKgh1V+TpjH2/sVmsn4QphiucAlBnRWfF/dX5q6v
rVn2teklCAnUlSGFdpNhKrd0hRVUmcsShVW1msrYmtrUtHi+dNq5H9CffA0maSxH
Uox9B6jjiJETqCyPh6wtf0cQ0n6BqgiSA2KuT3WaSOnnWFLShV4VHLRXXmUjth98
qIuMOYHjP5cDDLXKlxf4rOBKGtnjlwPjcRBNQqzTmjmptmFVXTJmCglU3CgH9r4E
JgLtA4Zy2U8uScoIEtLoKI5HmDu43chuy/Q4c/AJ8RmkR12Y5fgBohFYz+LfDSgh
YTta8AMyu7bBKhs9hICXp/I4Wf9RpOLCjJs6/o21dzLcQoJCBLT0FnPeRykJkkpH
kARTk/yXCyKK6IV4gQx7JHdLlIa0IAMNvN7uXQlBGPlNDS8kr6I=
=VWqS
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
