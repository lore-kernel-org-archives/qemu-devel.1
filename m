Received: from eggs.gnu.org ([209.51.188.92]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdL-0003rJ-9t
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdF-0002PB-MI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:49 -0500
Date: Tue, 19 Feb 2019 14:09:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219030948.GP9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-3-clg@kaod.org>
	<20190218064709.GD9345@umbus.fritz.box>
	<8dbdf821-503c-1811-c2ed-90efb8b7cc1b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1BKOZKwX7DAU5odC"
Content-Disposition: inline
In-Reply-To: <8dbdf821-503c-1811-c2ed-90efb8b7cc1b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/12] target/ppci/mmu: Use LPCR:HR to
 chose radix vs. hash translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--1BKOZKwX7DAU5odC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 10:20:43PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/18/19 7:47 AM, David Gibson wrote:
> > On Fri, Feb 15, 2019 at 06:00:19PM +0100, C=E9dric Le Goater wrote:
> >> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>
> >> Now that LPCR:HR is set properly for SPAPR, use it for deciding
> >> the translation type, which also works for bare metal
>=20
> "ppci" -> "ppc" in patch title.

Fixed up inline.

>=20
> >>
> >> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> >> ---
> >>  target/ppc/mmu-book3s-v3.h | 14 +++++++++-----
> >>  target/ppc/mmu-book3s-v3.c | 11 ++++++++++-
> >>  target/ppc/mmu_helper.c    |  9 ++-------
> >>  3 files changed, 21 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> >> index fdf80987d7b2..41b77158622a 100644
> >> --- a/target/ppc/mmu-book3s-v3.h
> >> +++ b/target/ppc/mmu-book3s-v3.h
> >> @@ -43,14 +43,18 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *=
cpu)
> >>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
> >>  }
> >> =20
> >> -static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> >> +/*
> >> + * The LPCR:HR bit is a shortcut that avoids having to
> >> + * dig out the partition table in the fast path. This is
> >> + * also how the HW uses it.
> >> + */
> >> +static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
> >>  {
> >> -    PPCVirtualHypervisorClass *vhc =3D
> >> -        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >> -
> >> -    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> >> +    return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
> >>  }
> >> =20
> >> +hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr);
> >> +
> >>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >>                                int mmu_idx);
> >> =20
> >> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> >> index b60df4408f3b..a174e7efc57c 100644
> >> --- a/target/ppc/mmu-book3s-v3.c
> >> +++ b/target/ppc/mmu-book3s-v3.c
> >> @@ -26,9 +26,18 @@
> >>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >>                                int mmu_idx)
> >>  {
> >> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> >> +    if (ppc64_v3_radix(cpu)) { /* Guest uses radix */
> >>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> >>      } else { /* Guest uses hash */
> >>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> >>      }
> >>  }
> >> +
> >> +hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr)
> >> +{
> >> +    if (ppc64_v3_radix(cpu)) {
> >> +        return ppc_radix64_get_phys_page_debug(cpu, eaddr);
> >> +    } else {
> >> +        return ppc_hash64_get_phys_page_debug(cpu, eaddr);
> >> +    }
> >> +}
> >> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> >> index cefed34da4f2..ae81ee18ae95 100644
> >> --- a/target/ppc/mmu_helper.c
> >> +++ b/target/ppc/mmu_helper.c
> >> @@ -1342,7 +1342,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fpri=
ntf, CPUPPCState *env)
> >>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> >>          break;
> >>      case POWERPC_MMU_3_00:
> >> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> >> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
> >>              /* TODO - Unsupported */
> >>          } else {
> >>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> >> @@ -1497,12 +1497,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs=
, vaddr addr)
> >>      case POWERPC_MMU_2_07:
> >>          return ppc_hash64_get_phys_page_debug(cpu, addr);
> >>      case POWERPC_MMU_3_00:
> >> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> >> -            return ppc_radix64_get_phys_page_debug(cpu, addr);
> >> -        } else {
> >> -            return ppc_hash64_get_phys_page_debug(cpu, addr);
> >> -        }
> >> -        break;
> >> +        return ppc64_v3_get_phys_page_debug(cpu, addr);
> >>  #endif
> >> =20
> >>      case POWERPC_MMU_32B:
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1BKOZKwX7DAU5odC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrc3oACgkQbDjKyiDZ
s5L2DA//ZkvZ2M+o8muW6BLpctKKQgvMl8ODooAfzpQs1MifMjr+MFKl7y/ksM/g
oLM+X2sZNd1mHIvl1CfEjSJogjFoZKkqM2TH5QjKI2DcHtRzxGAIudep8T4uH9DW
hup7fcDv03hPx6kCtN8r2F7gSGrBjsaCgqfVywqrOJrdpIkPlIdX4sLnz616eb05
g4xWcOPIRTsHFk4ZZwo+LYtctZshTGUOvWqfIq0G7FJof/kfHh60jW8JojD0tD1P
xHCU/XK4PNsf45DdPjBdMd9vjqInPup9eXKRp0tOWJ9gnZfu/l+nC9jhD4RgRptb
lvZxp9y4IL9D+tlHmF1duX0J2K3GGZbJbxd25osyItHcsu5PXLd0ckxHCT/FMr98
n2M2WQvVsU3JXluRyWcDKgIqP76XJ0GoQxgeemBnDIpko/faRQOIqRxTCWDdfJYh
yfEUuSPGqtWkf8905KPeKJspkWwOd/lj1nj6mbVEIXc5/eiSkqT2EI7Pmh4AcVu0
ekusJuuKTUfVfZpbhcrBvOjd84fvqMV9RRLJp9Euq92wUkoAeLgzgzCMLCPYcNQW
02VQQYX4q4IAvk0/08MF+D6jVSeUBJ7DCN/txX4GpCrPk/B0PcEPO83Zzy0sXwwi
B+RMdN5eqTHetd/01jC2KTDnu7f0/HeBWcJlIe7euK+HQlnS/JM=
=+yIt
-----END PGP SIGNATURE-----

--1BKOZKwX7DAU5odC--
