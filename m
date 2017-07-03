Received: from eggs.gnu.org ([2001:4830:134:3::10]:51456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRw8t-0007zy-1A
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRw8o-0006S1-PM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:51:35 -0400
Date: Mon, 3 Jul 2017 17:51:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170703075121.GU13989@umbus.fritz.box>
References: <20170703061948.18220-1-sjitindarsingh@gmail.com>
	<20170703061948.18220-4-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E75mJrUy8lRi9cGN"
Content-Disposition: inline
In-Reply-To: <20170703061948.18220-4-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-PPC] [PATCH 3/3] target/ppc: Add debug
 function to dump radix mmu translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, bsingharora@gmail.com


--E75mJrUy8lRi9cGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 04:19:48PM +1000, Suraj Jitindar Singh wrote:
> In target/ppc/mmu-hash64.c there already exists the function
> dump_slb() to dump the hash translation entries (for effective to
> virtual translation at least).
>=20
> Implement the function ppc_radix64_dump() to allow all the kernel
> effective to real address mappings and corresponding ptes to be dumped.
> This is called when "info tlb" is invoked in the qemu console. Previously
> this command had no output when invoked with a radix guest.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This doesn't really seem equivalent to the other dump_mmu() paths.
For HPT, it just dumps the SLB, which is 32 entries.  The RPT is
likely to have thousands of PTEs.

Similarly the other embedded paths generally just dump a (software
loaded) TLB, which will have a fixed number of entries.  6xx dumps a
TLB and various metadata, but not its whole hash table.

In the other direction the info dumped for other platforms *is*
affected by the process context (or equivalent), whereas here you just
dump the RPT for the kernel (PID 0).

So instead of dumping the RPT itself, what I think you want is to
pretty print:
	PID
	LPID
	partition table entry 0
	partition table entry LPID
	process table entry 0
	process table entry PID

and maybe any other context relevant registers I've forgotten.

Obviously some of that will need to be omitted for the 'pseries' (vhyp
!=3D 0) case.

In fact most of the info above would make sense to always dump for a
v3.00 MMU, regardless of HPT vs RPT mode. Obviously dumping the SLB
only makes sense for HPT mode, though.

> ---
>  target/ppc/mmu-radix64.c | 49 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/mmu-radix64.h |  1 +
>  target/ppc/mmu_helper.c  |  2 +-
>  3 files changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index bbd37e3..f7eeead 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -296,3 +296,52 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong eaddr)
> =20
>      return raddr & TARGET_PAGE_MASK;
>  }
> +
> +static void ppc_radix64_dump_level(FILE *f, fprintf_function cpu_fprintf,
> +                                   PowerPCCPU *cpu, uint64_t eaddr,
> +                                   uint64_t base_addr, uint64_t nls,
> +                                   uint64_t psize, int *num)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    uint64_t i, pte;
> +
> +    for (i =3D 0; i < (1 << nls); i++) {
> +        eaddr &=3D ~((1ULL << psize) - 1); /* Clear the low bits */
> +        eaddr |=3D (i << (psize - nls));
> +
> +        pte =3D ldq_phys(cs->as, base_addr + (i * sizeof(pte)));
> +        if (!(pte & R_PTE_VALID)) { /* Invalid Entry */
> +            continue;
> +        }
> +
> +        if (pte & R_PTE_LEAF) {
> +            uint64_t mask =3D (1ULL << (psize - nls)) - 1;
> +            cpu_fprintf(f, "%d\t0x%.16" PRIx64 " -> 0x%.16" PRIx64
> +                           " pte: 0x%.16" PRIx64 "\n", (*num)++,
> +                           eaddr, pte & R_PTE_RPN & ~mask, pte);
> +        } else {
> +            ppc_radix64_dump_level(f, cpu_fprintf, cpu, eaddr, pte & R_P=
DE_NLB,
> +                                   pte & R_PDE_NLS, psize - nls, num);
> +        }
> +    }
> +}
> +
> +void ppc_radix64_dump(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU =
*cpu)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    PPCVirtualHypervisorClass *vhc =3D
> +        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +    uint64_t patbe, prtbe0;
> +    int num =3D 0;
> +
> +    /* Get Process Table */
> +    patbe =3D vhc->get_patbe(cpu->vhyp);
> +
> +    /* Load the first entry -> Guest kernel mappings (all we dump for no=
w) */
> +    prtbe0 =3D ldq_phys(cs->as, patbe & PATBE1_R_PRTB);
> +
> +    cpu_fprintf(f, "\tEADDR\t\t      RADDR\n");
> +    ppc_radix64_dump_level(f, cpu_fprintf, cpu, 0ULL, prtbe0 & PRTBE_R_R=
PDB,
> +                           prtbe0 & PRTBE_R_RPDS, PRTBE_R_GET_RTS(prtbe0=
),
> +                           &num);
> +}
> diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
> index 0ecf063..c6c22bd 100644
> --- a/target/ppc/mmu-radix64.h
> +++ b/target/ppc/mmu-radix64.h
> @@ -47,6 +47,7 @@
>  int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                   int mmu_idx);
>  hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong add=
r);
> +void ppc_radix64_dump(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU =
*cpu);
> =20
>  static inline int ppc_radix64_get_prot_eaa(uint64_t pte)
>  {
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index b7b9088..9587b07 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1287,7 +1287,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf=
, CPUPPCState *env)
>          break;
>      case POWERPC_MMU_VER_3_00:
>          if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> -            /* TODO - Unsupported */
> +            ppc_radix64_dump(f, cpu_fprintf, ppc_env_get_cpu(env));
>          } else {
>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>              break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E75mJrUy8lRi9cGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWfd2AAoJEGw4ysog2bOSTH0QAKT2q9fumhhlJdK8S/5MN/24
wfLaGZCCGt5MGUrawAdHxlXrUAFe6xdop5ItuJquw9KKe4WXnjlpbbkG41dAOW1N
8cATFMQLcGN/hPitPRSYgszhTqV8x7XVKLdhFqs+eg0lynZ6uXZ8dzhwozy3/UNy
LMaq42f5cHaXDihF8Dji8GztnpCDLy75n6xpJ4tktT+F8YQollykGYWszOaVZ2io
JTYN0TIJpdpJJf8FRXiZx1teqx+Q1D7EsNnbuqUaPoOdz9D9l+mjHjn+KzOzosXV
RnBkCW36FsE4M/9V/7aDSHUOT11OWE5bNyRdyTuH8N99ut/qooCyp43v2nt4yJ96
5G6z+sQYcoRkKANJmK9hbM60H3OHv6pA3KAkAeVwh7mu+vKZDB7P17CNRgpyqPu2
l6Y4Xd6MfdPh61GL8xtwGuiXreZ637crUv2G7aBoa6LvA9sTrM99w0Er7yuEFjpD
c08vja/lQjjn15zdQ4XLSiNDpmLu5L+kAGBPk1q/UBKuCn3TyLKku/s46YU9ftq6
Rng7jbWgofhIB6ehaWvME3wHdmZJCeqyNJnvCnX5XbxMZB+cYcV0jL0Fw7o2SNnA
105UqMpUi5sfHmUdee7gMQ1IAU4889hWrCFN6XuTgCK4s6KGy8KtJFzKFiDDtzCl
m7FQqaj63Sg7pp+a7cX6
=2E9D
-----END PGP SIGNATURE-----

--E75mJrUy8lRi9cGN--
