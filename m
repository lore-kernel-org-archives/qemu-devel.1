Received: from eggs.gnu.org ([2001:4830:134:3::10]:60770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fvaVX-0005g6-Sv
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 23:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fvaMV-0001Ei-7U
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 23:44:47 -0400
Date: Fri, 31 Aug 2018 13:35:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180831033540.GA29201@umbus.fritz.box>
References: <20180814165954.9892-1-rka@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20180814165954.9892-1-rka@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: add external PID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 06:59:54PM +0200, Roman Kapl wrote:
> External PID is a mechanism present on BookE 2.06 that enables applicatio=
n to
> store/load data from different address spaces. There are special version =
of some
> instructions, which operate on alternate address space, which is describe=
d in
> the EPLC/EPSC regiser.
>=20
> This implementation uses two additional MMU modes (mmu_idx) to provide the
> address space for the load and store instructions. The QEMU TLB fill code=
 was
> modified to recognize these MMU modes and use the values in EPLC/EPSC to =
find
> the proper entry in he PPC TLB. These two QEMU TLBs are also flushed on e=
ach
> write to EPLC/EPSC.
>=20
> Following instructions are implemented: dcbfep dcbstep dcbtep dcbtstep dc=
bzep
> dcbzlep icbiep lbepx ldepx lfdepx lhepx lwepx stbepx stdepx stfdepx sthepx
> stwepx.
>=20
> Following vector instructions are not: evlddepx evstddepx lvepx lvepxl st=
vepx
> stvepxl.
>=20
> Signed-off-by: Roman Kapl <rka@sysgo.com>

Looks like a good first draft.  I have a few comments dispersed below.

On a more general level, I'm not totally clear on how the new mmu
indices work.  AIUI these essentially index different qemu TLBs (as
opposed to modelled hardware TLBs).  If the EP was set to the same PID
as the current process you'd have two indices essentially aliased to
each other - in that case do we have all the necessary flushes in
place?

> ---
>  target/ppc/cpu.h                   |  24 +++++-
>  target/ppc/helper.h                |   4 +
>  target/ppc/mem_helper.c            |  24 +++++-
>  target/ppc/mmu_helper.c            | 170 ++++++++++++++++++++++++++++---=
------
>  target/ppc/translate.c             | 145 ++++++++++++++++++++++++++++++-
>  target/ppc/translate/fp-impl.inc.c |  34 ++++++++
>  target/ppc/translate/fp-ops.inc.c  |   2 +
>  target/ppc/translate_init.inc.c    |  21 ++++-
>  8 files changed, 379 insertions(+), 45 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4edcf62cf7..04babfbafe 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -929,6 +929,19 @@ enum {
>  /* number of possible TLBs */
>  #define BOOKE206_MAX_TLBN      4
> =20
> +#define EPID_EPID_SHIFT 0x0
> +#define EPID_EPID 0xFF
> +#define EPID_ELPID_SHIFT 0x10
> +#define EPID_ELPID 0x3F0000
> +#define EPID_EGS 0x20000000
> +#define EPID_EGS_SHIFT 29
> +#define EPID_EAS 0x40000000
> +#define EPID_EAS_SHIFT 30
> +#define EPID_EPR 0x80000000
> +#define EPID_EPR_SHIFT 31
> +/* We don't support EGS and ELPID */
> +#define EPID_MASK (EPID_EPID | EPID_EAS | EPID_EPR)
> +
>  /***********************************************************************=
******/
>  /* Server and Embedded Processor Control */
> =20
> @@ -958,7 +971,16 @@ struct ppc_radix_page_info {
> =20
>  /***********************************************************************=
******/
>  /* The whole PowerPC CPU context */
> -#define NB_MMU_MODES    8
> +
> +/* PowerPC needs eight modes for different hypervisor/supervisor/guest +
> + * real/paged mode combinations. The other two modes are for external PID
> + * load/store.
> + */
> +#define NB_MMU_MODES    10
> +#define MMU_MODE8_SUFFIX _epl
> +#define MMU_MODE9_SUFFIX _eps
> +#define PPC_TLB_EPID_LOAD 8
> +#define PPC_TLB_EPID_STORE 9
> =20
>  #define PPC_CPU_OPCODES_LEN          0x40
>  #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 5706c2497f..7c8b419d2d 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -29,7 +29,9 @@ DEF_HELPER_4(lsw, void, env, tl, i32, i32)
>  DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
>  DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
>  DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
> +DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
>  DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
>  DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
> =20
>  #if defined(TARGET_PPC64)
> @@ -658,6 +660,8 @@ DEF_HELPER_2(booke206_tlbilx1, void, env, tl)
>  DEF_HELPER_2(booke206_tlbilx3, void, env, tl)
>  DEF_HELPER_2(booke206_tlbflush, void, env, tl)
>  DEF_HELPER_3(booke_setpid, void, env, i32, tl)
> +DEF_HELPER_2(booke_set_eplc, void, env, tl)
> +DEF_HELPER_2(booke_set_epsc, void, env, tl)
>  DEF_HELPER_2(6xx_tlbd, void, env, tl)
>  DEF_HELPER_2(6xx_tlbi, void, env, tl)
>  DEF_HELPER_2(74xx_tlbd, void, env, tl)
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 8f0d86d104..a5d6d06b16 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -141,10 +141,12 @@ void helper_stsw(CPUPPCState *env, target_ulong add=
r, uint32_t nb,
>      }
>  }
> =20
> -void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> +static void helper_dcbz_common(CPUPPCState *env, target_ulong addr,
> +                               uint32_t opcode, bool ep)
>  {
>      target_ulong mask, dcbz_size =3D env->dcache_line_size;
>      uint32_t i;
> +    int mmu_idx;
>      void *haddr;
> =20
>  #if defined(TARGET_PPC64)
> @@ -164,8 +166,9 @@ void helper_dcbz(CPUPPCState *env, target_ulong addr,=
 uint32_t opcode)
>          env->reserve_addr =3D (target_ulong)-1ULL;
>      }
> =20
> +    mmu_idx =3D ep ? PPC_TLB_EPID_STORE : env->dmmu_idx;

Why not just pass in the mmu_idx directly, rather than having to have
another conditional in here?

>      /* Try fast path translate */
> -    haddr =3D tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, env->dmmu_idx=
);
> +    haddr =3D tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
>      if (haddr) {
>          memset(haddr, 0, dcbz_size);
>      } else {
> @@ -176,6 +179,16 @@ void helper_dcbz(CPUPPCState *env, target_ulong addr=
, uint32_t opcode)
>      }
>  }
> =20
> +void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> +{
> +    helper_dcbz_common(env, addr, opcode, false);
> +}
> +
> +void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> +{
> +    helper_dcbz_common(env, addr, opcode, true);
> +}
> +
>  void helper_icbi(CPUPPCState *env, target_ulong addr)
>  {
>      addr &=3D ~(env->dcache_line_size - 1);
> @@ -187,6 +200,13 @@ void helper_icbi(CPUPPCState *env, target_ulong addr)
>      cpu_ldl_data_ra(env, addr, GETPC());
>  }
> =20
> +void helper_icbiep(CPUPPCState *env, target_ulong addr)
> +{
> +    /* See comments above */
> +    addr &=3D ~(env->dcache_line_size - 1);
> +    cpu_ldl_epl_ra(env, addr, GETPC());
> +}
> +
>  /* XXX: to be tested */
>  target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t =
reg,
>                            uint32_t ra, uint32_t rb)
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index e6739e6c24..ccb4bf7b6b 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -924,29 +924,80 @@ static int ppcmas_tlb_check(CPUPPCState *env, ppcma=
s_tlb_t *tlb,
>      return 0;
>  }
> =20
> +static bool is_epid_mmu(int mmu_idx)
> +{
> +    return mmu_idx =3D=3D PPC_TLB_EPID_STORE || mmu_idx =3D=3D PPC_TLB_E=
PID_LOAD;
> +}
> +
> +static uint32_t mmubooke206_esr(int mmu_idx, bool rw)
> +{
> +    uint32_t esr =3D 0;
> +    if (rw) {
> +        esr |=3D ESR_ST;
> +    }
> +    if (is_epid_mmu(mmu_idx)) {
> +        esr |=3D ESR_EPID;
> +    }
> +    return esr;
> +}
> +
> +/* Get EPID register given the mmu_idx. If this is regular load,
> + * construct the EPID access bits from current processor state  */
> +static bool mmubooke206_get_epid(CPUPPCState *env,
> +                                 int mmu_idx, uint32_t *epid_dst)
> +{
> +    if (mmu_idx =3D=3D PPC_TLB_EPID_STORE) {
> +        *epid_dst =3D env->spr[SPR_BOOKE_EPSC];
> +        return true;
> +    } else if (mmu_idx =3D=3D PPC_TLB_EPID_LOAD) {
> +        *epid_dst =3D env->spr[SPR_BOOKE_EPLC];
> +        return true;
> +    } else {
> +        uint32_t info =3D 0;
> +        if (msr_ds) {
> +            info |=3D EPID_EAS;
> +        }
> +        if (msr_pr) {
> +            info |=3D EPID_EPR;
> +        }
> +        *epid_dst =3D info;
> +        return false;
> +    }
> +}
> +
> +/* Check if the tlb found by hashing really matches */
>  static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
>                                   hwaddr *raddr, int *prot,
>                                   target_ulong address, int rw,
> -                                 int access_type)
> +                                 int access_type, int mmu_idx)
>  {
>      int ret;
>      int prot2 =3D 0;
> +    uint32_t epid;
> +    bool use_epid =3D mmubooke206_get_epid(env, mmu_idx, &epid);
> =20
> -    if (ppcmas_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID]) >=3D 0) {
> -        goto found_tlb;
> -    }
> +    if (!use_epid) {
> +        if (ppcmas_tlb_check(env, tlb, raddr, address,
> +                             env->spr[SPR_BOOKE_PID]) >=3D 0) {
> +            goto found_tlb;
> +        }
> =20
> -    if (env->spr[SPR_BOOKE_PID1] &&
> -        ppcmas_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID1]) >=3D 0) {
> -        goto found_tlb;
> -    }
> +        if (env->spr[SPR_BOOKE_PID1] &&
> +            ppcmas_tlb_check(env, tlb, raddr, address,
> +                             env->spr[SPR_BOOKE_PID1]) >=3D 0) {
> +            goto found_tlb;
> +        }
> =20
> -    if (env->spr[SPR_BOOKE_PID2] &&
> -        ppcmas_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID2]) >=3D 0) {
> -        goto found_tlb;
> +        if (env->spr[SPR_BOOKE_PID2] &&
> +            ppcmas_tlb_check(env, tlb, raddr, address,
> +                             env->spr[SPR_BOOKE_PID2]) >=3D 0) {
> +            goto found_tlb;
> +        }
> +    } else {
> +        if (ppcmas_tlb_check(env, tlb, raddr, address,
> +                             (epid & EPID_EPID) >> EPID_EPID_SHIFT) >=3D=
 0) {
> +            goto found_tlb;
> +        }
>      }
> =20
>      LOG_SWTLB("%s: TLB entry not found\n", __func__);
> @@ -954,7 +1005,7 @@ static int mmubooke206_check_tlb(CPUPPCState *env, p=
pcmas_tlb_t *tlb,
> =20
>  found_tlb:
> =20
> -    if (msr_pr !=3D 0) {
> +    if ((epid & EPID_EPR) !=3D 0) {

So, I get that you've set up get_epid() to work in this case, but I
think accessing the epid variable on something that might not be an
epid accesss could be pretty confusing to future readers of this.

>          if (tlb->mas7_3 & MAS3_UR) {
>              prot2 |=3D PAGE_READ;
>          }
> @@ -978,6 +1029,7 @@ found_tlb:
> =20
>      /* Check the address space and permissions */
>      if (access_type =3D=3D ACCESS_CODE) {
> +        assert(!use_epid);
>          if (msr_ir !=3D ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
>              LOG_SWTLB("%s: AS doesn't match\n", __func__);
>              return -1;
> @@ -992,7 +1044,8 @@ found_tlb:
>          LOG_SWTLB("%s: no PAGE_EXEC: %x\n", __func__, prot2);
>          ret =3D -3;
>      } else {
> -        if (msr_dr !=3D ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
> +        if (((epid & EPID_EAS) >> EPID_EAS_SHIFT)

Likewise here.  I think you'd be better off working out the "effective
PR" and "effective AS" modes near the top based on whether this is an
epid access or not, then using those in the remainder of the code.

> +             !=3D ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
>              LOG_SWTLB("%s: AS doesn't match\n", __func__);
>              return -1;
>          }
> @@ -1012,7 +1065,7 @@ found_tlb:
> =20
>  static int mmubooke206_get_physical_address(CPUPPCState *env, mmu_ctx_t =
*ctx,
>                                              target_ulong address, int rw,
> -                                            int access_type)
> +                                            int access_type, int mmu_idx)
>  {
>      ppcmas_tlb_t *tlb;
>      hwaddr raddr;
> @@ -1030,7 +1083,7 @@ static int mmubooke206_get_physical_address(CPUPPCS=
tate *env, mmu_ctx_t *ctx,
>                  continue;
>              }
>              ret =3D mmubooke206_check_tlb(env, tlb, &raddr, &ctx->prot, =
address,
> -                                        rw, access_type);
> +                                        rw, access_type, mmu_idx);
>              if (ret !=3D -1) {
>                  goto found_tlb;
>              }
> @@ -1348,8 +1401,10 @@ static inline int check_physical(CPUPPCState *env,=
 mmu_ctx_t *ctx,
>      return ret;
>  }
> =20
> -static int get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                target_ulong eaddr, int rw, int access_t=
ype)
> +static int get_physical_address_wtlb(
> +    CPUPPCState *env, mmu_ctx_t *ctx,
> +    target_ulong eaddr, int rw, int access_type,
> +    int mmu_idx)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>      int ret =3D -1;
> @@ -1392,7 +1447,7 @@ static int get_physical_address(CPUPPCState *env, m=
mu_ctx_t *ctx,
>          break;
>      case POWERPC_MMU_BOOKE206:
>          ret =3D mmubooke206_get_physical_address(env, ctx, eaddr, rw,
> -                                               access_type);
> +                                               access_type, mmu_idx);
>          break;
>      case POWERPC_MMU_MPC8xx:
>          /* XXX: TODO */
> @@ -1417,6 +1472,13 @@ static int get_physical_address(CPUPPCState *env, =
mmu_ctx_t *ctx,
>      return ret;
>  }
> =20
> +static int get_physical_address(
> +    CPUPPCState *env, mmu_ctx_t *ctx,
> +    target_ulong eaddr, int rw, int access_type)
> +{
> +    return get_physical_address_wtlb(env, ctx, eaddr, rw, access_type, 0=
);
> +}
> +
>  hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> @@ -1463,8 +1525,17 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, v=
addr addr)
>  }
> =20
>  static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong =
address,
> -                                     int rw)
> +                                     int rw, int mmu_idx)
>  {
> +    uint32_t epid;
> +    uint32_t missed_tid =3D 0;
> +    bool use_pid =3D mmubooke206_get_epid(env, mmu_idx, &epid);
> +    bool as;
> +    if (rw =3D=3D 2) {
> +        as =3D msr_ir;
> +    } else {
> +        as =3D (epid & EPID_EAS) >> EPID_EAS_SHIFT;
> +    }
>      env->spr[SPR_BOOKE_MAS0] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TLBSELD=
_MASK;
>      env->spr[SPR_BOOKE_MAS1] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_TSIZED_=
MASK;
>      env->spr[SPR_BOOKE_MAS2] =3D env->spr[SPR_BOOKE_MAS4] & MAS4_WIMGED_=
MASK;
> @@ -1473,7 +1544,7 @@ static void booke206_update_mas_tlb_miss(CPUPPCStat=
e *env, target_ulong address,
>      env->spr[SPR_BOOKE_MAS7] =3D 0;
> =20
>      /* AS */
> -    if (((rw =3D=3D 2) && msr_ir) || ((rw !=3D 2) && msr_dr)) {
> +    if (as) {
>          env->spr[SPR_BOOKE_MAS1] |=3D MAS1_TS;
>          env->spr[SPR_BOOKE_MAS6] |=3D MAS6_SAS;
>      }
> @@ -1481,19 +1552,25 @@ static void booke206_update_mas_tlb_miss(CPUPPCSt=
ate *env, target_ulong address,
>      env->spr[SPR_BOOKE_MAS1] |=3D MAS1_VALID;
>      env->spr[SPR_BOOKE_MAS2] |=3D address & MAS2_EPN_MASK;
> =20
> -    switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> -    case MAS4_TIDSELD_PID0:
> -        env->spr[SPR_BOOKE_MAS1] |=3D env->spr[SPR_BOOKE_PID] << MAS1_TI=
D_SHIFT;
> -        break;
> -    case MAS4_TIDSELD_PID1:
> -        env->spr[SPR_BOOKE_MAS1] |=3D env->spr[SPR_BOOKE_PID1] << MAS1_T=
ID_SHIFT;
> -        break;
> -    case MAS4_TIDSELD_PID2:
> -        env->spr[SPR_BOOKE_MAS1] |=3D env->spr[SPR_BOOKE_PID2] << MAS1_T=
ID_SHIFT;
> -        break;
> +    if (!use_pid) {
> +        switch (env->spr[SPR_BOOKE_MAS4] & MAS4_TIDSELD_PIDZ) {
> +        case MAS4_TIDSELD_PID0:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID]
> +            break;
> +        case MAS4_TIDSELD_PID1:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID1];
> +            break;
> +        case MAS4_TIDSELD_PID2:
> +            missed_tid =3D env->spr[SPR_BOOKE_PID2];
> +            break;
> +        }
> +        env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> +    } else {
> +        missed_tid =3D (epid & EPID_EPID) >> EPID_EPID_SHIFT;
> +        env->spr[SPR_BOOKE_MAS6] |=3D missed_tid << 16;
>      }
> +    env->spr[SPR_BOOKE_MAS1] |=3D (missed_tid << MAS1_TID_SHIFT);
> =20
> -    env->spr[SPR_BOOKE_MAS6] |=3D env->spr[SPR_BOOKE_PID] << 16;
> =20
>      /* next victim logic */
>      env->spr[SPR_BOOKE_MAS0] |=3D env->last_way << MAS0_ESEL_SHIFT;
> @@ -1520,7 +1597,8 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *en=
v, target_ulong address,
>          /* data access */
>          access_type =3D env->access_type;
>      }
> -    ret =3D get_physical_address(env, &ctx, address, rw, access_type);
> +    ret =3D get_physical_address_wtlb(env, &ctx, address, rw,
> +                                    access_type, mmu_idx);
>      if (ret =3D=3D 0) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       ctx.raddr & TARGET_PAGE_MASK, ctx.prot,
> @@ -1550,12 +1628,13 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *=
env, target_ulong address,
>                      env->spr[SPR_40x_ESR] =3D 0x00000000;
>                      break;
>                  case POWERPC_MMU_BOOKE206:
> -                    booke206_update_mas_tlb_miss(env, address, 2);
> +                    booke206_update_mas_tlb_miss(env, address, 2, mmu_id=
x);
>                      /* fall through */
>                  case POWERPC_MMU_BOOKE:
>                      cs->exception_index =3D POWERPC_EXCP_ITLB;
>                      env->error_code =3D 0;
>                      env->spr[SPR_BOOKE_DEAR] =3D address;
> +                    env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 0);
>                      return -1;
>                  case POWERPC_MMU_MPC8xx:
>                      /* XXX: TODO */
> @@ -1642,13 +1721,13 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *=
env, target_ulong address,
>                      cpu_abort(cs, "MPC8xx MMU model is not implemented\n=
");
>                      break;
>                  case POWERPC_MMU_BOOKE206:
> -                    booke206_update_mas_tlb_miss(env, address, rw);
> +                    booke206_update_mas_tlb_miss(env, address, rw, mmu_i=
dx);
>                      /* fall through */
>                  case POWERPC_MMU_BOOKE:
>                      cs->exception_index =3D POWERPC_EXCP_DTLB;
>                      env->error_code =3D 0;
>                      env->spr[SPR_BOOKE_DEAR] =3D address;
> -                    env->spr[SPR_BOOKE_ESR] =3D rw ? ESR_ST : 0;
> +                    env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 rw);
>                      return -1;
>                  case POWERPC_MMU_REAL:
>                      cpu_abort(cs, "PowerPC in real mode should never rai=
se "
> @@ -1672,7 +1751,7 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *en=
v, target_ulong address,
>                  } else if ((env->mmu_model =3D=3D POWERPC_MMU_BOOKE) ||
>                             (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206))=
 {
>                      env->spr[SPR_BOOKE_DEAR] =3D address;
> -                    env->spr[SPR_BOOKE_ESR] =3D rw ? ESR_ST : 0;
> +                    env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 rw);
>                  } else {
>                      env->spr[SPR_DAR] =3D address;
>                      if (rw =3D=3D 1) {
> @@ -2598,6 +2677,19 @@ void helper_booke_setpid(CPUPPCState *env, uint32_=
t pidn, target_ulong pid)
>      tlb_flush(CPU(cpu));
>  }
> =20
> +void helper_booke_set_eplc(CPUPPCState *env, target_ulong val)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    env->spr[SPR_BOOKE_EPLC] =3D val & EPID_MASK;
> +    tlb_flush_by_mmuidx(CPU(cpu), 1 << PPC_TLB_EPID_LOAD);
> +}
> +void helper_booke_set_epsc(CPUPPCState *env, target_ulong val)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    env->spr[SPR_BOOKE_EPSC] =3D val & EPID_MASK;
> +    tlb_flush_by_mmuidx(CPU(cpu), 1 << PPC_TLB_EPID_STORE);
> +}
> +
>  static inline void flush_page(CPUPPCState *env, ppcmas_tlb_t *tlb)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 9eaa10b421..7b04a79191 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2545,6 +2545,26 @@ GEN_LDS(lha, ld16s, 0x0A, PPC_INTEGER);
>  GEN_LDS(lhz, ld16u, 0x08, PPC_INTEGER);
>  /* lwz lwzu lwzux lwzx */
>  GEN_LDS(lwz, ld32u, 0x00, PPC_INTEGER);
> +
> +#define GEN_LDEPX(name, ldop, opc2, opc3)                               =
      \
> +static void glue(gen_, name##epx)(DisasContext *ctx)                    =
      \
> +{                                                                       =
      \
> +    TCGv EA;                                                            =
      \
> +    CHK_SV;                                                             =
      \
> +    gen_set_access_type(ctx, ACCESS_INT);                               =
      \
> +    EA =3D tcg_temp_new();                                              =
        \
> +    gen_addr_reg_index(ctx, EA);                                        =
      \
> +    tcg_gen_qemu_ld_tl(cpu_gpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_LOAD, =
ldop);\
> +    tcg_temp_free(EA);                                                  =
      \
> +}
> +
> +GEN_LDEPX(lb, DEF_MEMOP(MO_UB), 0x1F, 0x02)
> +GEN_LDEPX(lh, DEF_MEMOP(MO_UW), 0x1F, 0x08)
> +GEN_LDEPX(lw, DEF_MEMOP(MO_UL), 0x1F, 0x00)
> +#if defined(TARGET_PPC64)
> +GEN_LDEPX(ld, DEF_MEMOP(MO_Q), 0x1D, 0x00)
> +#endif
> +
>  #if defined(TARGET_PPC64)
>  /* lwaux */
>  GEN_LDUX(lwa, ld32s, 0x15, 0x0B, PPC_64B);
> @@ -2726,6 +2746,27 @@ GEN_STS(stb, st8, 0x06, PPC_INTEGER);
>  GEN_STS(sth, st16, 0x0C, PPC_INTEGER);
>  /* stw stwu stwux stwx */
>  GEN_STS(stw, st32, 0x04, PPC_INTEGER);
> +
> +#define GEN_STEPX(name, stop, opc2, opc3)                               =
      \
> +static void glue(gen_, name##epx)(DisasContext *ctx)                    =
      \
> +{                                                                       =
      \
> +    TCGv EA;                                                            =
      \
> +    CHK_SV;                                                             =
      \
> +    gen_set_access_type(ctx, ACCESS_INT);                               =
      \
> +    EA =3D tcg_temp_new();                                              =
        \
> +    gen_addr_reg_index(ctx, EA);                                        =
      \
> +    tcg_gen_qemu_st_tl(                                                 =
      \
> +        cpu_gpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_STORE, stop);        =
      \
> +    tcg_temp_free(EA);                                                  =
      \
> +}
> +
> +GEN_STEPX(stb, DEF_MEMOP(MO_UB), 0x1F, 0x06)
> +GEN_STEPX(sth, DEF_MEMOP(MO_UW), 0x1F, 0x0C)
> +GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
> +#if defined(TARGET_PPC64)
> +GEN_STEPX(std, DEF_MEMOP(MO_Q), 0x1d, 0x04)
> +#endif
> +
>  #if defined(TARGET_PPC64)
>  GEN_STUX(std, st64_i64, 0x15, 0x05, PPC_64B);
>  GEN_STX(std, st64_i64, 0x15, 0x04, PPC_64B);
> @@ -4348,6 +4389,19 @@ static void gen_dcbf(DisasContext *ctx)
>      tcg_temp_free(t0);
>  }
> =20
> +/* dcbfep (external PID dcbf) */
> +static void gen_dcbfep(DisasContext *ctx)
> +{
> +    /* XXX: specification says this is treated as a load by the MMU */
> +    TCGv t0;
> +    CHK_SV;
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    t0 =3D tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
> +    tcg_temp_free(t0);
> +}
> +
>  /* dcbi (Supervisor only) */
>  static void gen_dcbi(DisasContext *ctx)
>  {
> @@ -4381,6 +4435,18 @@ static void gen_dcbst(DisasContext *ctx)
>      tcg_temp_free(t0);
>  }
> =20
> +/* dcbstep (dcbstep External PID version) */
> +static void gen_dcbstep(DisasContext *ctx)
> +{
> +    /* XXX: specification say this is treated as a load by the MMU */
> +    TCGv t0;
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    t0 =3D tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
> +    tcg_temp_free(t0);
> +}
> +
>  /* dcbt */
>  static void gen_dcbt(DisasContext *ctx)
>  {
> @@ -4390,6 +4456,15 @@ static void gen_dcbt(DisasContext *ctx)
>       */
>  }
> =20
> +/* dcbtep */
> +static void gen_dcbtep(DisasContext *ctx)
> +{
> +    /* interpreted as no-op */
> +    /* XXX: specification say this is treated as a load by the MMU
> +     *      but does not generate any exception
> +     */
> +}
> +
>  /* dcbtst */
>  static void gen_dcbtst(DisasContext *ctx)
>  {
> @@ -4399,6 +4474,15 @@ static void gen_dcbtst(DisasContext *ctx)
>       */
>  }
> =20
> +/* dcbtstep */
> +static void gen_dcbtstep(DisasContext *ctx)
> +{
> +    /* interpreted as no-op */
> +    /* XXX: specification say this is treated as a load by the MMU
> +     *      but does not generate any exception
> +     */
> +}
> +
>  /* dcbtls */
>  static void gen_dcbtls(DisasContext *ctx)
>  {
> @@ -4425,6 +4509,21 @@ static void gen_dcbz(DisasContext *ctx)
>      tcg_temp_free_i32(tcgv_op);
>  }
> =20
> +/* dcbzep */
> +static void gen_dcbzep(DisasContext *ctx)
> +{
> +    TCGv tcgv_addr;
> +    TCGv_i32 tcgv_op;
> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    tcgv_addr =3D tcg_temp_new();
> +    tcgv_op =3D tcg_const_i32(ctx->opcode & 0x03FF000);
> +    gen_addr_reg_index(ctx, tcgv_addr);
> +    gen_helper_dcbzep(cpu_env, tcgv_addr, tcgv_op);
> +    tcg_temp_free(tcgv_addr);
> +    tcg_temp_free_i32(tcgv_op);
> +}
> +
>  /* dst / dstt */
>  static void gen_dst(DisasContext *ctx)
>  {
> @@ -4463,6 +4562,17 @@ static void gen_icbi(DisasContext *ctx)
>      tcg_temp_free(t0);
>  }
> =20
> +/* icbiep */
> +static void gen_icbiep(DisasContext *ctx)
> +{
> +    TCGv t0;
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    t0 =3D tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    gen_helper_icbiep(cpu_env, t0);
> +    tcg_temp_free(t0);
> +}
> +
>  /* Optional: */
>  /* dcba */
>  static void gen_dcba(DisasContext *ctx)
> @@ -6730,16 +6840,24 @@ GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF80=
1, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
>  GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
>  GEN_HANDLER(dcbf, 0x1F, 0x16, 0x02, 0x03C00001, PPC_CACHE),
> +GEN_HANDLER_E(dcbfep, 0x1F, 0x1F, 0x03, 0x03C00001, PPC_CACHE, PPC2_BOOK=
E206),
>  GEN_HANDLER(dcbi, 0x1F, 0x16, 0x0E, 0x03E00001, PPC_CACHE),
>  GEN_HANDLER(dcbst, 0x1F, 0x16, 0x01, 0x03E00001, PPC_CACHE),
> +GEN_HANDLER_E(dcbstep, 0x1F, 0x1F, 0x01, 0x03E00001, PPC_CACHE, PPC2_BOO=
KE206),
>  GEN_HANDLER(dcbt, 0x1F, 0x16, 0x08, 0x00000001, PPC_CACHE),
> -GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, PPC_CACHE),
> +GEN_HANDLER_E(dcbtep, 0x1F, 0x1F, 0x09, 0x00000001, PPC_CACHE, PPC2_BOOK=
E206),
> +GEN_HANDLER(dcbtst, 0x1F, 0x1F, 0x07, 0x00000001, PPC_CACHE),
> +GEN_HANDLER_E(dcbtstep, 0x1F, 0x16, 0x07, 0x00000001, PPC_CACHE, PPC2_BO=
OKE206),
>  GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE, PPC2_BOOK=
E206),
>  GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001, PPC_CACHE_DCBZ),
> +GEN_HANDLER_E(dcbzep, 0x1F, 0x1F, 0x1F, 0x03C00001,
> +              PPC_CACHE_DCBZ, PPC2_BOOKE206),
>  GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
>  GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
>  GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
>  GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001, PPC_CACHE_ICBI),
> +GEN_HANDLER_E(icbiep, 0x1F, 0x1F, 0x1E, 0x03E00001,
> +              PPC_CACHE_ICBI, PPC2_BOOKE206),
>  GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001, PPC_CACHE_DCBA),
>  GEN_HANDLER(mfsr, 0x1F, 0x13, 0x12, 0x0010F801, PPC_SEGMENT),
>  GEN_HANDLER(mfsrin, 0x1F, 0x13, 0x14, 0x001F0001, PPC_SEGMENT),
> @@ -7042,6 +7160,19 @@ GEN_LDX_HVRM(lbzcix, ld8u, 0x15, 0x1a, PPC_CILDST)
>  GEN_LDX(lhbr, ld16ur, 0x16, 0x18, PPC_INTEGER)
>  GEN_LDX(lwbr, ld32ur, 0x16, 0x10, PPC_INTEGER)
> =20
> +/* External PID based load */
> +#undef GEN_LDEPX
> +#define GEN_LDEPX(name, ldop, opc2, opc3)                               =
      \
> +GEN_HANDLER_E(name##epx, 0x1F, opc2, opc3,                              =
      \
> +              0x00000001, PPC_INTEGER, PPC2_BOOKE206),
> +
> +GEN_LDEPX(lb, DEF_MEMOP(MO_UB), 0x1F, 0x02)
> +GEN_LDEPX(lh, DEF_MEMOP(MO_UW), 0x1F, 0x08)
> +GEN_LDEPX(lw, DEF_MEMOP(MO_UL), 0x1F, 0x00)
> +#if defined(TARGET_PPC64)
> +GEN_LDEPX(ld, DEF_MEMOP(MO_Q), 0x1D, 0x00)
> +#endif
> +
>  #undef GEN_ST
>  #undef GEN_STU
>  #undef GEN_STUX
> @@ -7076,6 +7207,18 @@ GEN_STX_HVRM(stbcix, st8, 0x15, 0x1e, PPC_CILDST)
>  GEN_STX(sthbr, st16r, 0x16, 0x1C, PPC_INTEGER)
>  GEN_STX(stwbr, st32r, 0x16, 0x14, PPC_INTEGER)
> =20
> +#undef GEN_STEPX
> +#define GEN_STEPX(name, ldop, opc2, opc3)                               =
      \
> +GEN_HANDLER_E(name##epx, 0x1F, opc2, opc3,                              =
      \
> +              0x00000001, PPC_INTEGER, PPC2_BOOKE206),
> +
> +GEN_STEPX(stb, DEF_MEMOP(MO_UB), 0x1F, 0x06)
> +GEN_STEPX(sth, DEF_MEMOP(MO_UW), 0x1F, 0x0C)
> +GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
> +#if defined(TARGET_PPC64)
> +GEN_STEPX(std, DEF_MEMOP(MO_Q), 0x1D, 0x04)
> +#endif
> +
>  #undef GEN_CRLOGIC
>  #define GEN_CRLOGIC(name, tcg_op, opc)                                  =
      \
>  GEN_HANDLER(name, 0x13, 0x01, opc, 0x00000001, PPC_INTEGER)
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
> index 2fbd4d4f38..d97dd1c7c8 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -676,6 +676,23 @@ GEN_LDFS(lfd, ld64_i64, 0x12, PPC_FLOAT);
>   /* lfs lfsu lfsux lfsx */
>  GEN_LDFS(lfs, ld32fs, 0x10, PPC_FLOAT);
> =20
> +/* lfdepx (external PID lfdx) */
> +static void gen_lfdepx(DisasContext *ctx)
> +{
> +    TCGv EA;
> +    CHK_SV;
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +    gen_set_access_type(ctx, ACCESS_FLOAT);
> +    EA =3D tcg_temp_new();
> +    gen_addr_reg_index(ctx, EA);
> +    tcg_gen_qemu_ld_i64(cpu_fpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_LOAD,
> +        DEF_MEMOP(MO_Q));
> +    tcg_temp_free(EA);
> +}
> +
>  /* lfdp */
>  static void gen_lfdp(DisasContext *ctx)
>  {
> @@ -852,6 +869,23 @@ GEN_STFS(stfd, st64_i64, 0x16, PPC_FLOAT);
>  /* stfs stfsu stfsux stfsx */
>  GEN_STFS(stfs, st32fs, 0x14, PPC_FLOAT);
> =20
> +/* stfdepx (external PID lfdx) */
> +static void gen_stfdepx(DisasContext *ctx)
> +{
> +    TCGv EA;
> +    CHK_SV;
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +    gen_set_access_type(ctx, ACCESS_FLOAT);
> +    EA =3D tcg_temp_new();
> +    gen_addr_reg_index(ctx, EA);
> +    tcg_gen_qemu_st_i64(cpu_fpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_STORE,
> +                       DEF_MEMOP(MO_Q));
> +    tcg_temp_free(EA);
> +}
> +
>  /* stfdp */
>  static void gen_stfdp(DisasContext *ctx)
>  {
> diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-=
ops.inc.c
> index 3c6d05a074..621f6bfe0c 100644
> --- a/target/ppc/translate/fp-ops.inc.c
> +++ b/target/ppc/translate/fp-ops.inc.c
> @@ -66,6 +66,7 @@ GEN_LDXF(name, ldop, 0x17, op | 0x00, type)
> =20
>  GEN_LDFS(lfd, ld64, 0x12, PPC_FLOAT)
>  GEN_LDFS(lfs, ld32fs, 0x10, PPC_FLOAT)
> +GEN_HANDLER_E(lfdepx, 0x1F, 0x1F, 0x12, 0x00000001, PPC_NONE, PPC2_BOOKE=
206),
>  GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001, PPC_NONE, PPC2_ISA20=
5),
>  GEN_HANDLER_E(lfiwzx, 0x1f, 0x17, 0x1b, 0x1, PPC_NONE, PPC2_FP_CVT_ISA20=
6),
>  GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001, PPC_NONE, PPC2_ISA205=
),
> @@ -87,6 +88,7 @@ GEN_STXF(name, stop, 0x17, op | 0x00, type)
>  GEN_STFS(stfd, st64_i64, 0x16, PPC_FLOAT)
>  GEN_STFS(stfs, st32fs, 0x14, PPC_FLOAT)
>  GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
> +GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOK=
E206),
>  GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA20=
5),
> =20
>  GEN_HANDLER(frsqrtes, 0x3B, 0x1A, 0xFF, 0x001F07C0, PPC_FLOAT_FRSQRTES),
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 7813b1b004..9f924b8ff2 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -1652,6 +1652,15 @@ static void spr_write_booke_pid(DisasContext *ctx,=
 int sprn, int gprn)
>      gen_helper_booke_setpid(cpu_env, t0, cpu_gpr[gprn]);
>      tcg_temp_free_i32(t0);
>  }
> +static void spr_write_eplc(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_booke_set_eplc(cpu_env, cpu_gpr[gprn]);
> +}
> +static void spr_write_epsc(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_booke_set_epsc(cpu_env, cpu_gpr[gprn]);
> +}
> +
>  #endif
> =20
>  static void gen_spr_usprg3(CPUPPCState *env)
> @@ -1895,6 +1904,16 @@ static void gen_spr_BookE206(CPUPPCState *env, uin=
t32_t mas_mask,
>                       &spr_read_generic, &spr_write_booke_pid,
>                       0x00000000);
>      }
> +
> +    spr_register(env, SPR_BOOKE_EPLC, "EPLC",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_eplc,
> +                 0x00000000);
> +    spr_register(env, SPR_BOOKE_EPSC, "EPSC",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_epsc,
> +                 0x00000000);
> +
>      /* XXX : not implemented */
>      spr_register(env, SPR_MMUCFG, "MMUCFG",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -2780,8 +2799,6 @@ static void gen_spr_8xx(CPUPPCState *env)
>   * perf    =3D> 768-783 (Power 2.04)
>   * perf    =3D> 784-799 (Power 2.04)
>   * PPR     =3D> SPR 896 (Power 2.04)
> - * EPLC    =3D> SPR 947 (Power 2.04 emb)
> - * EPSC    =3D> SPR 948 (Power 2.04 emb)
>   * DABRX   =3D> 1015    (Power 2.04 hypv)
>   * FPECR   =3D> SPR 1022 (?)
>   * ... and more (thermal management, performance counters, ...)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluIt4oACgkQbDjKyiDZ
s5KlFhAAgT+jsJqqzwUMnCgszfrWlEZF168nduCaEY2jrWIbU1duiTMCwa46Ry8F
o4lfNPE+dQkEqgp6pI1wscg481G8TdFhL0RwFneo2bWo3vM2m26+J1hiJvIY4/tI
OtAhjdVds85ByTva9FI6SzKJBVlnza1a/tHlUd7j7MsbOItMCwwV+A+alT7m4P0z
LqGi/uGTVTfZop0arxkU/u8GsrSCglPzYlkL9P8o4JM/qC5rgfxj4FBuSP5AADTq
r179WYRBe0fce+bCgIf9fLaEe0dCrV75QPfDB8k13jir4z0UIGLHltwQ2JVvX/6e
S2Ab53r3ER3MmQmLE2l5Biq4r+IfAqR34UesJxoIYfw7XxA54Z3sByaEdifYOoBG
cbyJfK3ZH1mvvfpAxV4HtJvBwsXpKG5wLrKxEYrY+4lWXiA4NTTUvNigF0FnFbfo
ViuGQHSVu9SC/Auseb8MobqXO4vzL84E5R8XA0EV0HKUzCrwkW6Mcmrvdbw4GMWo
eQgvAYRs+vs9wFsIIstn/j00UcZo1BjVbqh3RzRMIhMjzgXulPTjrOCqVtDRvEwP
g7hYHi8NsdOE5jYgIjihtcIwzSKnVcFyRiZtpXa6MruwMPQBbJML3oeMtNaB7UDJ
DDj3J164zdJBHO5UrhFqRc8rGCPkZdLss8AbodiwTxNf3LJ+Wqg=
=PIFs
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
