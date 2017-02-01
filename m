Received: from eggs.gnu.org ([2001:4830:134:3::10]:46643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdG-0004RI-8N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdE-0006y0-9C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:34:58 -0500
Date: Wed, 1 Feb 2017 15:28:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201042819.GQ30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-12-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eLe8FOcWSbbyMVJD"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-12-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 11/17] target/ppc/POWER9: Update to new
 pte format for POWER9 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--eLe8FOcWSbbyMVJD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:17PM +1100, Suraj Jitindar Singh wrote:
> The page table entry format was updated for the POWER9 processor.
>=20
> It was decided that kernels would used the old format irrespective
> with the translation occuring at the hypervisor level. Thus we convert
> between the old and new format when accessing the ptes. Since we need the
> whole pte to perform this conversion, we remove the old functions which
> accessed either the first or second doubleword and introduce a new
> functions which access the entire pte, returning the entry converted
> back to the old format (if required). Update call sites accordingly.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c    | 51 ++++++++++++++++++-----------------
>  target/ppc/mmu-hash64.c | 13 +++++----
>  target/ppc/mmu-hash64.h | 71 ++++++++++++++++++++++++++++++++++++-------=
------
>  3 files changed, 86 insertions(+), 49 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 9a9bedf..9f0c20d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -125,7 +125,8 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>          pte_index &=3D ~7ULL;
>          token =3D ppc_hash64_start_access(cpu, pte_index);
>          for (; index < 8; index++) {
> -            if (!(ppc_hash64_load_hpte0(cpu, token, index) & HPTE64_V_VA=
LID)) {
> +            ppc_hash_pte64_t pte =3D ppc_hash64_load_hpte(cpu, token, in=
dex);
> +            if (!(pte.pte0 & HPTE64_V_VALID)) {
>                  break;
>              }
>          }
> @@ -134,8 +135,10 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
>              return H_PTEG_FULL;
>          }
>      } else {
> +        ppc_hash_pte64_t pte;
>          token =3D ppc_hash64_start_access(cpu, pte_index);

IIRC the only reason for the clumsy start_access / stop_access stuff
was because we wanted to do the two loads separately (to avoid loading
word1 in cases we don't need it).  Since you're combining both loads
into a single helper, I think you can put the start_access /
stop_access into the same helper.

Or have I missed something.

> -        if (ppc_hash64_load_hpte0(cpu, token, 0) & HPTE64_V_VALID) {
> +        pte =3D ppc_hash64_load_hpte(cpu, token, 0);
> +        if (pte.pte0 & HPTE64_V_VALID) {
>              ppc_hash64_stop_access(cpu, token);
>              return H_PTEG_FULL;
>          }
> @@ -163,26 +166,25 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu, ta=
rget_ulong ptex,
>  {
>      CPUPPCState *env =3D &cpu->env;
>      uint64_t token;
> -    target_ulong v, r;
> +    ppc_hash_pte64_t pte;
> =20
>      if (!valid_pte_index(env, ptex)) {
>          return REMOVE_PARM;
>      }
> =20
>      token =3D ppc_hash64_start_access(cpu, ptex);
> -    v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> -    r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> +    pte =3D ppc_hash64_load_hpte(cpu, token, 0);
>      ppc_hash64_stop_access(cpu, token);
> =20
> -    if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> -        ((flags & H_AVPN) && (v & ~0x7fULL) !=3D avpn) ||
> -        ((flags & H_ANDCOND) && (v & avpn) !=3D 0)) {
> +    if ((pte.pte0 & HPTE64_V_VALID) =3D=3D 0 ||
> +        ((flags & H_AVPN) && (pte.pte0 & ~0x7fULL) !=3D avpn) ||
> +        ((flags & H_ANDCOND) && (pte.pte0 & avpn) !=3D 0)) {
>          return REMOVE_NOT_FOUND;
>      }
> -    *vp =3D v;
> -    *rp =3D r;
> +    *vp =3D pte.pte0;
> +    *rp =3D pte.pte1;
>      ppc_hash64_store_hpte(cpu, ptex, HPTE64_V_HPTE_DIRTY, 0);
> -    ppc_hash64_tlb_flush_hpte(cpu, ptex, v, r);
> +    ppc_hash64_tlb_flush_hpte(cpu, ptex, pte.pte0, pte.pte1);
>      return REMOVE_SUCCESS;
>  }
> =20
> @@ -293,35 +295,36 @@ static target_ulong h_protect(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>      target_ulong flags =3D args[0];
>      target_ulong pte_index =3D args[1];
>      target_ulong avpn =3D args[2];
> +    ppc_hash_pte64_t pte;
>      uint64_t token;
> -    target_ulong v, r;
> =20
>      if (!valid_pte_index(env, pte_index)) {
>          return H_PARAMETER;
>      }
> =20
>      token =3D ppc_hash64_start_access(cpu, pte_index);
> -    v =3D ppc_hash64_load_hpte0(cpu, token, 0);
> -    r =3D ppc_hash64_load_hpte1(cpu, token, 0);
> +    pte =3D ppc_hash64_load_hpte(cpu, token, 0);
>      ppc_hash64_stop_access(cpu, token);
> =20
> -    if ((v & HPTE64_V_VALID) =3D=3D 0 ||
> -        ((flags & H_AVPN) && (v & ~0x7fULL) !=3D avpn)) {
> +    if ((pte.pte0 & HPTE64_V_VALID) =3D=3D 0 ||
> +        ((flags & H_AVPN) && (pte.pte0 & ~0x7fULL) !=3D avpn)) {
>          return H_NOT_FOUND;
>      }
> =20
> -    r &=3D ~(HPTE64_R_PP0 | HPTE64_R_PP | HPTE64_R_N |
> -           HPTE64_R_KEY_HI | HPTE64_R_KEY_LO);
> -    r |=3D (flags << 55) & HPTE64_R_PP0;
> -    r |=3D (flags << 48) & HPTE64_R_KEY_HI;
> -    r |=3D flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KEY_LO);
> +    pte.pte1 &=3D ~(HPTE64_R_PP0 | HPTE64_R_PP | HPTE64_R_N |
> +                  HPTE64_R_KEY_HI | HPTE64_R_KEY_LO);
> +    pte.pte1 |=3D (flags << 55) & HPTE64_R_PP0;
> +    pte.pte1 |=3D (flags << 48) & HPTE64_R_KEY_HI;
> +    pte.pte1 |=3D flags & (HPTE64_R_PP | HPTE64_R_N | HPTE64_R_KEY_LO);
>      ppc_hash64_store_hpte(cpu, pte_index,
> -                          (v & ~HPTE64_V_VALID) | HPTE64_V_HPTE_DIRTY, 0=
);
> -    ppc_hash64_tlb_flush_hpte(cpu, pte_index, v, r);
> +                          (pte.pte0 & ~HPTE64_V_VALID) | HPTE64_V_HPTE_D=
IRTY,
> +                          0);
> +    ppc_hash64_tlb_flush_hpte(cpu, pte_index, pte.pte0, pte.pte1);
>      /* Flush the tlb */
>      check_tlb_flush(env, true);
>      /* Don't need a memory barrier, due to qemu's global lock */
> -    ppc_hash64_store_hpte(cpu, pte_index, v | HPTE64_V_HPTE_DIRTY, r);
> +    ppc_hash64_store_hpte(cpu, pte_index, pte.pte0 | HPTE64_V_HPTE_DIRTY,
> +                          pte.pte1);
>      return H_SUCCESS;
>  }
> =20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index b476b3f..03607d5 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -515,7 +515,6 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu,=
 hwaddr hash,
>      CPUPPCState *env =3D &cpu->env;
>      int i;
>      uint64_t token;
> -    target_ulong pte0, pte1;
>      target_ulong pte_index;
> =20
>      pte_index =3D (hash & env->htab_mask) * HPTES_PER_GROUP;
> @@ -524,12 +523,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cp=
u, hwaddr hash,
>          return -1;
>      }
>      for (i =3D 0; i < HPTES_PER_GROUP; i++) {
> -        pte0 =3D ppc_hash64_load_hpte0(cpu, token, i);
> -        pte1 =3D ppc_hash64_load_hpte1(cpu, token, i);
> +        ppc_hash_pte64_t entry =3D ppc_hash64_load_hpte(cpu, token, i);

Hm.  So the hypercalls using the access helpers which include format
conversion makes sense to me - the hypercalls are defined to use the
old format, even on POWER9 AIUI.

It doesn't really make sense to me here, in what is essentially the
physical implementation of the HPT lookup.  Shouldn't that be using
the new format natively?

Basically it seems odd that you store things in the new format in
memory, but convert to the old format on *all* accesses, not just the
hypercall ones which are defined that way.

>          /* This compares V, B, H (secondary) and the AVPN */
> -        if (HPTE64_V_COMPARE(pte0, ptem)) {
> -            *pshift =3D hpte_page_shift(sps, pte0, pte1);
> +        if (HPTE64_V_COMPARE(entry.pte0, ptem)) {
> +            *pshift =3D hpte_page_shift(sps, entry.pte0, entry.pte1);
>              /*
>               * If there is no match, ignore the PTE, it could simply
>               * be for a different segment size encoding and the
> @@ -543,8 +541,7 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu,=
 hwaddr hash,
>              /* We don't do anything with pshift yet as qemu TLB only dea=
ls
>               * with 4K pages anyway
>               */
> -            pte->pte0 =3D pte0;
> -            pte->pte1 =3D pte1;
> +            *pte =3D entry;
>              ppc_hash64_stop_access(cpu, token);
>              return (pte_index + i) * HASH_PTE_SIZE_64;
>          }
> @@ -924,6 +921,8 @@ void ppc_hash64_store_hpte(PowerPCCPU *cpu,
>  {
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    ppc_hash64_hpte_old_to_new(env, &pte0, &pte1);
> +
>      if (env->external_htab =3D=3D MMU_HASH64_KVM_MANAGED_HPT) {
>          kvmppc_hash64_write_pte(env, pte_index, pte0, pte1);
>          return;
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index ab5d347..73d7ce4 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -60,6 +60,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>  #define HASH_PTE_SIZE_64        16
>  #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
> =20
> +#define HPTE64_V_3_00_COMMON    0x000fffffffffffffULL
>  #define HPTE64_V_SSIZE_SHIFT    62
>  #define HPTE64_V_AVPN_SHIFT     7
>  #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
> @@ -69,9 +70,12 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>  #define HPTE64_V_SECONDARY      0x0000000000000002ULL
>  #define HPTE64_V_VALID          0x0000000000000001ULL
> =20
> +#define HPTE64_R_3_00_COMMON    0xf1ffffffffffffffULL
>  #define HPTE64_R_PP0            0x8000000000000000ULL
>  #define HPTE64_R_TS             0x4000000000000000ULL
>  #define HPTE64_R_KEY_HI         0x3000000000000000ULL
> +#define HPTE64_R_SSIZE_SHIFT    58
> +#define HPTE64_R_SSIZE_MASK     (3ULL << HPTE64_R_SSIZE_SHIFT)
>  #define HPTE64_R_RPN_SHIFT      12
>  #define HPTE64_R_RPN            0x0ffffffffffff000ULL
>  #define HPTE64_R_FLAGS          0x00000000000003ffULL
> @@ -91,6 +95,10 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
>  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
> =20
> +typedef struct {
> +    uint64_t pte0, pte1;
> +} ppc_hash_pte64_t;
> +
>  void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
>                           Error **errp);
>  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
> @@ -99,37 +107,64 @@ void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, vo=
id *hpt, int shift,
>  uint64_t ppc_hash64_start_access(PowerPCCPU *cpu, target_ulong pte_index=
);
>  void ppc_hash64_stop_access(PowerPCCPU *cpu, uint64_t token);
> =20
> -static inline target_ulong ppc_hash64_load_hpte0(PowerPCCPU *cpu,
> -                                                 uint64_t token, int ind=
ex)
> +static inline void ppc_hash64_hpte_old_to_new(CPUPPCState *env,
> +                                              target_ulong *pte0,
> +                                              target_ulong *pte1)
>  {
> -    CPUPPCState *env =3D &cpu->env;
> -    uint64_t addr;
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /*
> +         * v3.00 of the ISA moved the B field to the second doubleword a=
nd
> +         * shortened the abbreviated virtual address and abbreviated rea=
l page
> +         * number fields
> +         */
> +        *pte1 =3D (*pte1 & HPTE64_R_3_00_COMMON) |
> +                ((*pte0 >> HPTE64_V_SSIZE_SHIFT) << HPTE64_R_SSIZE_SHIFT=
);
> +        *pte0 =3D *pte0 & HPTE64_V_3_00_COMMON;
> +    default:
> +        ;
> +    }
> +}
> =20
> -    addr =3D token + (index * HASH_PTE_SIZE_64);
> -    if (env->external_htab) {
> -        return  ldq_p((const void *)(uintptr_t)addr);
> -    } else {
> -        return ldq_phys(CPU(cpu)->as, addr);
> +static inline void ppc_hash64_hpte_new_to_old(CPUPPCState *env,
> +                                              target_ulong *pte0,
> +                                              target_ulong *pte1)
> +{
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /*
> +         * v3.00 of the ISA moved the B field to the second doubleword a=
nd
> +         * shortened the abbreviated virtual address and abbreviated rea=
l page
> +         * number fields
> +         */
> +        *pte0 =3D (*pte0 & HPTE64_V_3_00_COMMON) | ((*pte1 & HPTE64_R_SS=
IZE_MASK)
> +                << (HPTE64_V_SSIZE_SHIFT - HPTE64_R_SSIZE_SHIFT));
> +        *pte1 =3D *pte1 & HPTE64_R_3_00_COMMON;
> +    default:
> +        ;
>      }
>  }
> =20
> -static inline target_ulong ppc_hash64_load_hpte1(PowerPCCPU *cpu,
> -                                                 uint64_t token, int ind=
ex)
> +static inline ppc_hash_pte64_t ppc_hash64_load_hpte(PowerPCCPU *cpu,
> +                                                    uint64_t token,
> +                                                    int index)
>  {
>      CPUPPCState *env =3D &cpu->env;
> +    ppc_hash_pte64_t pte;
>      uint64_t addr;
> =20
> -    addr =3D token + (index * HASH_PTE_SIZE_64) + HASH_PTE_SIZE_64/2;
> +    addr =3D token + (index * HASH_PTE_SIZE_64);
>      if (env->external_htab) {
> -        return  ldq_p((const void *)(uintptr_t)addr);
> +        pte.pte0 =3D ldq_p((const void *)(uintptr_t)addr);
> +        pte.pte1 =3D ldq_p((const void *)(uintptr_t)addr + HASH_PTE_SIZE=
_64/2);
>      } else {
> -        return ldq_phys(CPU(cpu)->as, addr);
> +        pte.pte0 =3D ldq_phys(CPU(cpu)->as, addr);
> +        pte.pte1 =3D ldq_phys(CPU(cpu)->as, addr + HASH_PTE_SIZE_64/2);
>      }
> -}
> =20
> -typedef struct {
> -    uint64_t pte0, pte1;
> -} ppc_hash_pte64_t;
> +    ppc_hash64_hpte_new_to_old(env, &pte.pte0, &pte.pte1);
> +    return pte;
> +}
> =20
>  #endif /* CONFIG_USER_ONLY */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eLe8FOcWSbbyMVJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkWPjAAoJEGw4ysog2bOSGe8QAM7ahWcER8WkDyXFicJlIP+B
oZ9Mp4hBIO+1ZxDPwX9iNkVkp/DmRx35WfvV2C5Tmy7hex/RD2ObipynFf6Onm6p
Z9TVJoE97J3DEkYz+mYkgGiQtugncE3yKCUfsmHC63V+VFzWFrKPW+iQyfXueu7z
reUwMGh3XwXDvkLIegtJs2iwb4fKXgRD7CTEyasj2JLm0oP6KWBHs+pj/0lIJuAU
4tpPUg6/ssq3O283q7ZEve/TT+Wuqus7XRWkq9psSW9OUrMcG/ivevX2oylQ0plL
dxyyCKPRHYj+lEuDkJzP5DpnSruCbSLlyMg4LgiSEQatMx3tsdd6gRX7UEnXVCbI
LJN4EoU6Xy1o6AH3lr0HlUrV0SYlHz1eu69alk4uhOBP90QgjEaE4Kmv5kpgfHrS
f8iNfSWg7UPi2zFStQwcA9g3lLUNN0fsmirDkFVgVSC1dfhl4f0Be9tX7f+iu83g
aTYTfsibZSaXrcM4He4pHlmiNzDph6+JgKmcqM9IMOGyjU0zufR2kM7c8CdLwWqs
tS8FBx80OuqPrYu2pe2Zo1xIBpyMjbHclvKYU0ZKcIK7ctu1jSxEjD+W5T6FxpDs
sZi4B2bibUPU0Lab9dXe3maJq81Gj0o4p8oObqC/Pgh5j+/y4WlRsYbH7rY5P4fe
nBAhNUVRbqtYfZd7l65v
=ThkI
-----END PGP SIGNATURE-----

--eLe8FOcWSbbyMVJD--
