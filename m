Received: from eggs.gnu.org ([2001:4830:134:3::10]:58252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE2Qq-0000tg-6c
	for qemu-devel@nongnu.org; Wed, 02 May 2018 20:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE2Qm-0000yV-8V
	for qemu-devel@nongnu.org; Wed, 02 May 2018 20:49:12 -0400
Date: Thu, 3 May 2018 10:48:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503004854.GC13229@umbus.fritz.box>
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20180424113045.25687-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] target/ppc: add hash MMU
 definitions for ISA v3.0
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


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 01:30:43PM +0200, C=E9dric Le Goater wrote:
> The HPTE bits definitions are slightly modified in ISA v3.0. Let's add
> some helpers to hide the differences in the hash MMU code.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_hcall.c    |  5 +++--
>  target/ppc/mmu-hash64.c | 30 ++++++++++++++++++++++--------
>  target/ppc/mmu-hash64.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 16bccdd5c012..929f4e05492d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -94,7 +94,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
>          return H_PARAMETER;
>      }
> =20
> -    raddr =3D (ptel & HPTE64_R_RPN) & ~((1ULL << apshift) - 1);
> +    raddr =3D (ptel & ppc_hash64_hpte_r_rpn(cpu)) & ~((1ULL << apshift) =
- 1);

Doesn't H_ENTER always use the old format?  I thought it did that so
PAPR guests never saw the new format, only powernv.

>      if (is_ram_address(spapr, raddr)) {
>          /* Regular RAM - should have WIMG=3D0010 */
> @@ -586,7 +586,8 @@ static int rehash_hpte(PowerPCCPU *cpu,
> =20
>      base_pg_shift =3D ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte1);
>      assert(base_pg_shift); /* H_ENTER shouldn't allow a bad encoding */
> -    avpn =3D HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << base_pg_shift) - 1) >=
> 23);
> +    avpn =3D ppc_hash64_hpte_v_avpn_val(cpu, pte0) &
> +        ~(((1ULL << base_pg_shift) - 1) >> 23);

Likwise rehash_hpte is only used for PAPR guests, so I don't think it
needs to handle the new format.

>      if (pte0 & HPTE64_V_SECONDARY) {
>          pteg =3D ~pteg;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index a1db20e3a8ed..ecea2ae04dd3 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -452,7 +452,8 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const pp=
c_hash_pte64_t *hptes,
>                          false, n * HASH_PTE_SIZE_64);
>  }
> =20
> -static unsigned hpte_page_shift(const PPCHash64SegmentPageSizes *sps,
> +static unsigned hpte_page_shift(PowerPCCPU *cpu,
> +                                const PPCHash64SegmentPageSizes *sps,
>                                  uint64_t pte0, uint64_t pte1)
>  {
>      int i;
> @@ -479,7 +480,7 @@ static unsigned hpte_page_shift(const PPCHash64Segmen=
tPageSizes *sps,
>              continue;
>          }
> =20
> -        mask =3D ((1ULL << ps->page_shift) - 1) & HPTE64_R_RPN;
> +        mask =3D ((1ULL << ps->page_shift) - 1) & ppc_hash64_hpte_r_rpn(=
cpu);
> =20
>          if ((pte1 & mask) =3D=3D ((uint64_t)ps->pte_enc << HPTE64_R_RPN_=
SHIFT)) {
>              return ps->page_shift;
> @@ -489,6 +490,18 @@ static unsigned hpte_page_shift(const PPCHash64Segme=
ntPageSizes *sps,
>      return 0; /* Bad page size encoding */
>  }
> =20
> +static bool ppc_hash64_hpte_v_compare(PowerPCCPU *cpu, target_ulong pte0,
> +                                      target_ulong ptem)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (env->mmu_model & POWERPC_MMU_3_00) {
> +        return HPTE64_V_COMPARE_3_0(pte0, ptem);
> +    } else {
> +        return HPTE64_V_COMPARE(pte0, ptem);
> +    }
> +}

Ugh, and here we get more complications, because I guess we need to
check for (mmu_model =3D=3D 3.00) && (!vhyp) to exclude PAPR guests.  And
a bunch of similar places.

> +
>  static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
>                                       const PPCHash64SegmentPageSizes *sp=
s,
>                                       target_ulong ptem,
> @@ -509,8 +522,8 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu,=
 hwaddr hash,
>          pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
> =20
>          /* This compares V, B, H (secondary) and the AVPN */
> -        if (HPTE64_V_COMPARE(pte0, ptem)) {
> -            *pshift =3D hpte_page_shift(sps, pte0, pte1);
> +        if (ppc_hash64_hpte_v_compare(cpu, pte0, ptem)) {
> +            *pshift =3D hpte_page_shift(cpu, sps, pte0, pte1);
>              /*
>               * If there is no match, ignore the PTE, it could simply
>               * be for a different segment size encoding and the
> @@ -570,7 +583,8 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cpu,
>          epn =3D (eaddr & ~SEGMENT_MASK_256M) & epnmask;
>          hash =3D vsid ^ (epn >> sps->page_shift);
>      }
> -    ptem =3D (slb->vsid & SLB_VSID_PTEM) | ((epn >> 16) & HPTE64_V_AVPN);
> +    ptem =3D (slb->vsid & SLB_VSID_PTEM) | ((epn >> 16) &
> +                                          ppc_hash64_hpte_v_avpn(cpu));
>      ptem |=3D HPTE64_V_VALID;
> =20
>      /* Page address translation */
> @@ -624,7 +638,7 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU =
*cpu,
>              break;
>          }
> =20
> -        shift =3D hpte_page_shift(sps, pte0, pte1);
> +        shift =3D hpte_page_shift(cpu, sps, pte0, pte1);
>          if (shift) {
>              return shift;
>          }
> @@ -860,7 +874,7 @@ skip_slb_search:
> =20
>      /* 7. Determine the real address from the PTE */
> =20
> -    raddr =3D deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, eaddr);
> +    raddr =3D deposit64(pte.pte1 & ppc_hash64_hpte_r_rpn(cpu), 0, apshif=
t, eaddr);
> =20
>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
>                   prot, mmu_idx, 1ULL << apshift);
> @@ -910,7 +924,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
>          return -1;
>      }
> =20
> -    return deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, addr)
> +    return deposit64(pte.pte1 & ppc_hash64_hpte_r_rpn(cpu), 0, apshift, =
addr)
>          & TARGET_PAGE_MASK;
>  }
> =20
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 53dcec5b9316..a3a0de452b94 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -70,8 +70,12 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
>  #define HPTE64_V_SSIZE_SHIFT    62
>  #define HPTE64_V_AVPN_SHIFT     7
>  #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
> +#define HPTE64_V_AVPN_3_0       0x000fffffffffff80ULL
>  #define HPTE64_V_AVPN_VAL(x)    (((x) & HPTE64_V_AVPN) >> HPTE64_V_AVPN_=
SHIFT)
> +#define HPTE64_V_AVPN_VAL_3_0(x)                        \
> +    (((x) & HPTE64_V_AVPN_3_0) >> HPTE64_V_AVPN_SHIFT)
>  #define HPTE64_V_COMPARE(x, y)  (!(((x) ^ (y)) & 0xffffffffffffff83ULL))
> +#define HPTE64_V_COMPARE_3_0(x, y)  (!(((x) ^ (y)) & 0x3fffffffffffff83U=
LL))
>  #define HPTE64_V_BOLTED         0x0000000000000010ULL
>  #define HPTE64_V_LARGE          0x0000000000000004ULL
>  #define HPTE64_V_SECONDARY      0x0000000000000002ULL
> @@ -82,6 +86,7 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
>  #define HPTE64_R_KEY_HI         0x3000000000000000ULL
>  #define HPTE64_R_RPN_SHIFT      12
>  #define HPTE64_R_RPN            0x0ffffffffffff000ULL
> +#define HPTE64_R_RPN_3_0        0x01fffffffffff000ULL
>  #define HPTE64_R_FLAGS          0x00000000000003ffULL
>  #define HPTE64_R_PP             0x0000000000000003ULL
>  #define HPTE64_R_N              0x0000000000000004ULL
> @@ -99,6 +104,31 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
>  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
>  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
> =20
> +static inline target_ulong ppc_hash64_hpte_r_rpn(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    return env->mmu_model & POWERPC_MMU_3_00 ?
> +        HPTE64_R_RPN_3_0 : HPTE64_R_RPN;
> +}
> +
> +static inline target_ulong ppc_hash64_hpte_v_avpn(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    return env->mmu_model & POWERPC_MMU_3_00 ?
> +        HPTE64_V_AVPN_3_0 : HPTE64_V_AVPN;
> +}
> +
> +static inline target_ulong ppc_hash64_hpte_v_avpn_val(PowerPCCPU *cpu,
> +                                                      target_ulong pte0)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    return env->mmu_model & POWERPC_MMU_3_00 ?
> +        HPTE64_V_AVPN_VAL_3_0(pte0) : HPTE64_V_AVPN_VAL(pte0);
> +}
> +
>  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
>  {
>      if (cpu->vhyp) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqXHAACgkQbDjKyiDZ
s5KiVQ/8DrL2HdJr0N9TajW0xzu/lP3czu1/wV0UuHOEflbj46vRusZ5ynIGN344
+5MBDDbYh2z2w0YX7b5UNU7mJOqPJvo9MlVVHQq8Z/Paua2dpYGYL8F3LWW5WW6o
VN0ZoYAcpzu5y3ez+JJDWJJd4hmMYVuJlR/wmvAAmSS9s4M2ItBQ7Ccz9OuNM+Uc
0EZ750dDgP0U2pOvLgMwLxv7ICmiBozA368ZsykmvnboxxF7TpwPCUK/7qZM9Mu2
pgi4JKsFp5azhJW9YyBwu3EwOWADLXwiUyyEGmmyzYaL7T3yWlF+XyrsJi1ryo8U
xKnlFGki+MPh0SWfpSPJa5l/dPrM38AU2R0JpfvxJT2w0S5qsHsnExRF57AMKwE8
T325PZYt7LPO4eeuo/MRjspVXoOVxqorjmMqN8SYnBJTy1ngPJM31YJkIZYNcnNK
amjSTImtRUGpmj1NEuktNNqbsvjaP7XmJV3gnGL4giMyWlI3mjDrJ3MVxb32sBMJ
d7RVae0m42UvltbfWT84jNf4/Do5Imm7CrnybU/d28O68B+GZYsBOzN+xF2hYaI1
oNFHTv3s+8MwJl2TOn7lnBuZyEwUm4waDN6Gk0qvxY//B6UgiXY4yqlQIVVbvo1Y
KGEWtu9eHKXIkr01i0p/JDxHnrrlSNeNdv8ej5eDo3VbpDjbKg8=
=sxid
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
