Received: from eggs.gnu.org ([2001:4830:134:3::10]:51575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d5gCx-00010P-7p
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d5gCu-0007Nv-Kd
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:23:47 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1493122030-32191-3-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-3-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 2 May 2017 15:23:06 -0700
Message-ID: <CAKmqyKPBYyhT5NFRks8Z4VX=mCdQuVk5+cX4s4qPpO9PQvMMZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 02/13] arm: Add support for M profile CPUs
 having different MMU index semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Patch Tracking <patches@linaro.org>

On Tue, Apr 25, 2017 at 5:06 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The M profile CPU's MPU has an awkward corner case which we
> would like to implement with a different MMU index.
>
> We can avoid having to bump the number of MMU modes ARM
> uses, because some of our existing MMU indexes are only
> used by non-M-profile CPUs, so we can borrow one.
> To avoid that getting too confusing, clean up the code
> to try to keep the two meanings of the index separate.
>
> Instead of ARMMMUIdx enum values being identical to core QEMU
> MMU index values, they are now the core index values with some
> high bits set. Any particular CPU always uses the same high
> bits (so eventually A profile cores and M profile cores will
> use different bits). New functions arm_to_core_mmu_idx()
> and core_to_arm_mmu_idx() convert between the two.
>
> In general core index values are stored in 'int' types, and
> ARM values are stored in ARMMMUIdx types.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

This looks ok to me. I'm a little worried it will make SMMU or some
ARMv9 (or whatever the next thing is) work more complicated as we have
this.

Thanks,

Alistair

> ---
>  target/arm/cpu.h           |  71 ++++++++++++++++-----
>  target/arm/translate.h     |   2 +-
>  target/arm/helper.c        | 151 ++++++++++++++++++++++++---------------------
>  target/arm/op_helper.c     |   3 +-
>  target/arm/translate-a64.c |  18 ++++--
>  target/arm/translate.c     |  10 +--
>  6 files changed, 156 insertions(+), 99 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 1055bfe..e1f4856 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2037,6 +2037,16 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>   * for the accesses done as part of a stage 1 page table walk, rather than
>   * having to walk the stage 2 page table over and over.)
>   *
> + * The ARMMMUIdx and the mmu index value used by the core QEMU TLB code
> + * are not quite the same -- different CPU types (most notably M profile
> + * vs A/R profile) would like to use MMU indexes with different semantics,
> + * but since we don't ever need to use all of those in a single CPU we
> + * can avoid setting NB_MMU_MODES to more than 8. The lower bits of
> + * ARMMMUIdx are the core TLB mmu index, and the higher bits are always
> + * the same for any particular CPU.
> + * Variables of type ARMMUIdx are always full values, and the core
> + * index values are in variables of type 'int'.
> + *
>   * Our enumeration includes at the end some entries which are not "true"
>   * mmu_idx values in that they don't have corresponding TLBs and are only
>   * valid for doing slow path page table walks.
> @@ -2045,28 +2055,61 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>   * of the AT/ATS operations.
>   * The values used are carefully arranged to make mmu_idx => EL lookup easy.
>   */
> +#define ARM_MMU_IDX_A 0x10 /* A profile (and M profile, for the moment) */
> +#define ARM_MMU_IDX_NOTLB 0x20 /* does not have a TLB */
> +
> +#define ARM_MMU_IDX_TYPE_MASK (~0x7)
> +#define ARM_MMU_IDX_COREIDX_MASK 0x7
> +
>  typedef enum ARMMMUIdx {
> -    ARMMMUIdx_S12NSE0 = 0,
> -    ARMMMUIdx_S12NSE1 = 1,
> -    ARMMMUIdx_S1E2 = 2,
> -    ARMMMUIdx_S1E3 = 3,
> -    ARMMMUIdx_S1SE0 = 4,
> -    ARMMMUIdx_S1SE1 = 5,
> -    ARMMMUIdx_S2NS = 6,
> +    ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_S12NSE1 = 1 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
> +    ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
>      /* Indexes below here don't have TLBs and are used only for AT system
>       * instructions or for the first stage of an S12 page table walk.
>       */
> -    ARMMMUIdx_S1NSE0 = 7,
> -    ARMMMUIdx_S1NSE1 = 8,
> +    ARMMMUIdx_S1NSE0 = 0 | ARM_MMU_IDX_NOTLB,
> +    ARMMMUIdx_S1NSE1 = 1 | ARM_MMU_IDX_NOTLB,
>  } ARMMMUIdx;
>
> +/* Bit macros for the core-mmu-index values for each index,
> + * for use when calling tlb_flush_by_mmuidx() and friends.
> + */
> +typedef enum ARMMMUIdxBit {
> +    ARMMMUIdxBit_S12NSE0 = 1 << 0,
> +    ARMMMUIdxBit_S12NSE1 = 1 << 1,
> +    ARMMMUIdxBit_S1E2 = 1 << 2,
> +    ARMMMUIdxBit_S1E3 = 1 << 3,
> +    ARMMMUIdxBit_S1SE0 = 1 << 4,
> +    ARMMMUIdxBit_S1SE1 = 1 << 5,
> +    ARMMMUIdxBit_S2NS = 1 << 6,
> +} ARMMMUIdxBit;
> +
>  #define MMU_USER_IDX 0
>
> +static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
> +{
> +    return mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
> +}
> +
> +static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
> +{
> +    return mmu_idx | ARM_MMU_IDX_A;
> +}
> +
>  /* Return the exception level we're running at if this is our mmu_idx */
>  static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
>  {
> -    assert(mmu_idx < ARMMMUIdx_S2NS);
> -    return mmu_idx & 3;
> +    switch (mmu_idx & ARM_MMU_IDX_TYPE_MASK) {
> +    case ARM_MMU_IDX_A:
> +        return mmu_idx & 3;
> +    default:
> +        g_assert_not_reached();
> +    }
>  }
>
>  /* Determine the current mmu_idx to use for normal loads/stores */
> @@ -2075,7 +2118,7 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
>      int el = arm_current_el(env);
>
>      if (el < 2 && arm_is_secure_below_el3(env)) {
> -        return ARMMMUIdx_S1SE0 + el;
> +        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0 + el);
>      }
>      return el;
>  }
> @@ -2471,7 +2514,7 @@ static inline uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
>  static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                                          target_ulong *cs_base, uint32_t *flags)
>  {
> -    ARMMMUIdx mmu_idx = cpu_mmu_index(env, false);
> +    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
>      if (is_a64(env)) {
>          *pc = env->pc;
>          *flags = ARM_TBFLAG_AARCH64_STATE_MASK;
> @@ -2496,7 +2539,7 @@ static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                     << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
>      }
>
> -    *flags |= (mmu_idx << ARM_TBFLAG_MMUIDX_SHIFT);
> +    *flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
>
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
>       * states defined in the ARM ARM for software singlestep:
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 629dab9..6b2cc34 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -88,7 +88,7 @@ static inline int arm_dc_feature(DisasContext *dc, int feature)
>
>  static inline int get_mem_index(DisasContext *s)
>  {
> -    return s->mmu_idx;
> +    return arm_to_core_mmu_idx(s->mmu_idx);
>  }
>
>  /* Function used to determine the target exception EL when otherwise not known
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8a3e448..520adcc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -571,9 +571,9 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      CPUState *cs = ENV_GET_CPU(env);
>
>      tlb_flush_by_mmuidx(cs,
> -                        (1 << ARMMMUIdx_S12NSE1) |
> -                        (1 << ARMMMUIdx_S12NSE0) |
> -                        (1 << ARMMMUIdx_S2NS));
> +                        ARMMMUIdxBit_S12NSE1 |
> +                        ARMMMUIdxBit_S12NSE0 |
> +                        ARMMMUIdxBit_S2NS);
>  }
>
>  static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -582,9 +582,9 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      CPUState *cs = ENV_GET_CPU(env);
>
>      tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                        (1 << ARMMMUIdx_S12NSE1) |
> -                                        (1 << ARMMMUIdx_S12NSE0) |
> -                                        (1 << ARMMMUIdx_S2NS));
> +                                        ARMMMUIdxBit_S12NSE1 |
> +                                        ARMMMUIdxBit_S12NSE0 |
> +                                        ARMMMUIdxBit_S2NS);
>  }
>
>  static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -605,7 +605,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      pageaddr = sextract64(value << 12, 0, 40);
>
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S2NS));
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
>  }
>
>  static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -621,7 +621,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      pageaddr = sextract64(value << 12, 0, 40);
>
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             (1 << ARMMMUIdx_S2NS));
> +                                             ARMMMUIdxBit_S2NS);
>  }
>
>  static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -629,7 +629,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      CPUState *cs = ENV_GET_CPU(env);
>
> -    tlb_flush_by_mmuidx(cs, (1 << ARMMMUIdx_S1E2));
> +    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
>  }
>
>  static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -637,7 +637,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      CPUState *cs = ENV_GET_CPU(env);
>
> -    tlb_flush_by_mmuidx_all_cpus_synced(cs, (1 << ARMMMUIdx_S1E2));
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
>  }
>
>  static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -646,7 +646,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      CPUState *cs = ENV_GET_CPU(env);
>      uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
>
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S1E2));
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
>  }
>
>  static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -656,7 +656,7 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
>
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             (1 << ARMMMUIdx_S1E2));
> +                                             ARMMMUIdxBit_S1E2);
>  }
>
>  static const ARMCPRegInfo cp_reginfo[] = {
> @@ -2596,9 +2596,9 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
>      if (raw_read(env, ri) != value) {
>          tlb_flush_by_mmuidx(cs,
> -                            (1 << ARMMMUIdx_S12NSE1) |
> -                            (1 << ARMMMUIdx_S12NSE0) |
> -                            (1 << ARMMMUIdx_S2NS));
> +                            ARMMMUIdxBit_S12NSE1 |
> +                            ARMMMUIdxBit_S12NSE0 |
> +                            ARMMMUIdxBit_S2NS);
>          raw_write(env, ri, value);
>      }
>  }
> @@ -2957,12 +2957,12 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      if (arm_is_secure_below_el3(env)) {
>          tlb_flush_by_mmuidx(cs,
> -                            (1 << ARMMMUIdx_S1SE1) |
> -                            (1 << ARMMMUIdx_S1SE0));
> +                            ARMMMUIdxBit_S1SE1 |
> +                            ARMMMUIdxBit_S1SE0);
>      } else {
>          tlb_flush_by_mmuidx(cs,
> -                            (1 << ARMMMUIdx_S12NSE1) |
> -                            (1 << ARMMMUIdx_S12NSE0));
> +                            ARMMMUIdxBit_S12NSE1 |
> +                            ARMMMUIdxBit_S12NSE0);
>      }
>  }
>
> @@ -2974,12 +2974,12 @@ static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      if (sec) {
>          tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            (1 << ARMMMUIdx_S1SE1) |
> -                                            (1 << ARMMMUIdx_S1SE0));
> +                                            ARMMMUIdxBit_S1SE1 |
> +                                            ARMMMUIdxBit_S1SE0);
>      } else {
>          tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            (1 << ARMMMUIdx_S12NSE1) |
> -                                            (1 << ARMMMUIdx_S12NSE0));
> +                                            ARMMMUIdxBit_S12NSE1 |
> +                                            ARMMMUIdxBit_S12NSE0);
>      }
>  }
>
> @@ -2995,18 +2995,18 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      if (arm_is_secure_below_el3(env)) {
>          tlb_flush_by_mmuidx(cs,
> -                            (1 << ARMMMUIdx_S1SE1) |
> -                            (1 << ARMMMUIdx_S1SE0));
> +                            ARMMMUIdxBit_S1SE1 |
> +                            ARMMMUIdxBit_S1SE0);
>      } else {
>          if (arm_feature(env, ARM_FEATURE_EL2)) {
>              tlb_flush_by_mmuidx(cs,
> -                                (1 << ARMMMUIdx_S12NSE1) |
> -                                (1 << ARMMMUIdx_S12NSE0) |
> -                                (1 << ARMMMUIdx_S2NS));
> +                                ARMMMUIdxBit_S12NSE1 |
> +                                ARMMMUIdxBit_S12NSE0 |
> +                                ARMMMUIdxBit_S2NS);
>          } else {
>              tlb_flush_by_mmuidx(cs,
> -                                (1 << ARMMMUIdx_S12NSE1) |
> -                                (1 << ARMMMUIdx_S12NSE0));
> +                                ARMMMUIdxBit_S12NSE1 |
> +                                ARMMMUIdxBit_S12NSE0);
>          }
>      }
>  }
> @@ -3017,7 +3017,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      ARMCPU *cpu = arm_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
>
> -    tlb_flush_by_mmuidx(cs, (1 << ARMMMUIdx_S1E2));
> +    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
>  }
>
>  static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3026,7 +3026,7 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      ARMCPU *cpu = arm_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
>
> -    tlb_flush_by_mmuidx(cs, (1 << ARMMMUIdx_S1E3));
> +    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E3);
>  }
>
>  static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3042,17 +3042,17 @@ static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      if (sec) {
>          tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            (1 << ARMMMUIdx_S1SE1) |
> -                                            (1 << ARMMMUIdx_S1SE0));
> +                                            ARMMMUIdxBit_S1SE1 |
> +                                            ARMMMUIdxBit_S1SE0);
>      } else if (has_el2) {
>          tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            (1 << ARMMMUIdx_S12NSE1) |
> -                                            (1 << ARMMMUIdx_S12NSE0) |
> -                                            (1 << ARMMMUIdx_S2NS));
> +                                            ARMMMUIdxBit_S12NSE1 |
> +                                            ARMMMUIdxBit_S12NSE0 |
> +                                            ARMMMUIdxBit_S2NS);
>      } else {
>            tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                              (1 << ARMMMUIdx_S12NSE1) |
> -                                              (1 << ARMMMUIdx_S12NSE0));
> +                                              ARMMMUIdxBit_S12NSE1 |
> +                                              ARMMMUIdxBit_S12NSE0);
>      }
>  }
>
> @@ -3061,7 +3061,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      CPUState *cs = ENV_GET_CPU(env);
>
> -    tlb_flush_by_mmuidx_all_cpus_synced(cs, (1 << ARMMMUIdx_S1E2));
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
>  }
>
>  static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3069,7 +3069,7 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      CPUState *cs = ENV_GET_CPU(env);
>
> -    tlb_flush_by_mmuidx_all_cpus_synced(cs, (1 << ARMMMUIdx_S1E3));
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E3);
>  }
>
>  static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3086,12 +3086,12 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      if (arm_is_secure_below_el3(env)) {
>          tlb_flush_page_by_mmuidx(cs, pageaddr,
> -                                 (1 << ARMMMUIdx_S1SE1) |
> -                                 (1 << ARMMMUIdx_S1SE0));
> +                                 ARMMMUIdxBit_S1SE1 |
> +                                 ARMMMUIdxBit_S1SE0);
>      } else {
>          tlb_flush_page_by_mmuidx(cs, pageaddr,
> -                                 (1 << ARMMMUIdx_S12NSE1) |
> -                                 (1 << ARMMMUIdx_S12NSE0));
> +                                 ARMMMUIdxBit_S12NSE1 |
> +                                 ARMMMUIdxBit_S12NSE0);
>      }
>  }
>
> @@ -3106,7 +3106,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      CPUState *cs = CPU(cpu);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S1E2));
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
>  }
>
>  static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3120,7 +3120,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      CPUState *cs = CPU(cpu);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S1E3));
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E3);
>  }
>
>  static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3133,12 +3133,12 @@ static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      if (sec) {
>          tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                                 (1 << ARMMMUIdx_S1SE1) |
> -                                                 (1 << ARMMMUIdx_S1SE0));
> +                                                 ARMMMUIdxBit_S1SE1 |
> +                                                 ARMMMUIdxBit_S1SE0);
>      } else {
>          tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                                 (1 << ARMMMUIdx_S12NSE1) |
> -                                                 (1 << ARMMMUIdx_S12NSE0));
> +                                                 ARMMMUIdxBit_S12NSE1 |
> +                                                 ARMMMUIdxBit_S12NSE0);
>      }
>  }
>
> @@ -3149,7 +3149,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             (1 << ARMMMUIdx_S1E2));
> +                                             ARMMMUIdxBit_S1E2);
>  }
>
>  static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3159,7 +3159,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             (1 << ARMMMUIdx_S1E3));
> +                                             ARMMMUIdxBit_S1E3);
>  }
>
>  static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3181,7 +3181,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>
>      pageaddr = sextract64(value << 12, 0, 48);
>
> -    tlb_flush_page_by_mmuidx(cs, pageaddr, (1 << ARMMMUIdx_S2NS));
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
>  }
>
>  static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3197,7 +3197,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      pageaddr = sextract64(value << 12, 0, 48);
>
>      tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                             (1 << ARMMMUIdx_S2NS));
> +                                             ARMMMUIdxBit_S2NS);
>  }
>
>  static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -7049,6 +7049,17 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
>      return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
>  }
>
> +/* Convert a possible stage1+2 MMU index into the appropriate
> + * stage 1 MMU index
> + */
> +static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
> +{
> +    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> +        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
> +    }
> +    return mmu_idx;
> +}
> +
>  /* Returns TBI0 value for current regime el */
>  uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
> @@ -7056,11 +7067,9 @@ uint32_t arm_regime_tbi0(CPUARMState *env, ARMMMUIdx mmu_idx)
>      uint32_t el;
>
>      /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
> -       * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> -       */
> -    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> -        mmu_idx += ARMMMUIdx_S1NSE0;
> -    }
> +     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> +     */
> +    mmu_idx = stage_1_mmu_idx(mmu_idx);
>
>      tcr = regime_tcr(env, mmu_idx);
>      el = regime_el(env, mmu_idx);
> @@ -7079,11 +7088,9 @@ uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
>      uint32_t el;
>
>      /* For EL0 and EL1, TBI is controlled by stage 1's TCR, so convert
> -       * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> -       */
> -    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> -        mmu_idx += ARMMMUIdx_S1NSE0;
> -    }
> +     * a stage 1+2 mmu index into the appropriate stage 1 mmu index.
> +     */
> +    mmu_idx = stage_1_mmu_idx(mmu_idx);
>
>      tcr = regime_tcr(env, mmu_idx);
>      el = regime_el(env, mmu_idx);
> @@ -7129,9 +7136,7 @@ static inline bool regime_using_lpae_format(CPUARMState *env,
>   * on whether the long or short descriptor format is in use. */
>  bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
> -    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> -        mmu_idx += ARMMMUIdx_S1NSE0;
> -    }
> +    mmu_idx = stage_1_mmu_idx(mmu_idx);
>
>      return regime_using_lpae_format(env, mmu_idx);
>  }
> @@ -8385,7 +8390,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
>              int ret;
>
>              ret = get_phys_addr(env, address, access_type,
> -                                mmu_idx + ARMMMUIdx_S1NSE0, &ipa, attrs,
> +                                stage_1_mmu_idx(mmu_idx), &ipa, attrs,
>                                  prot, page_size, fsr, fi);
>
>              /* If S1 fails or S2 is disabled, return early.  */
> @@ -8406,7 +8411,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
>              /*
>               * For non-EL2 CPUs a stage1+stage2 translation is just stage 1.
>               */
> -            mmu_idx += ARMMMUIdx_S1NSE0;
> +            mmu_idx = stage_1_mmu_idx(mmu_idx);
>          }
>      }
>
> @@ -8482,7 +8487,8 @@ bool arm_tlb_fill(CPUState *cs, vaddr address,
>      int ret;
>      MemTxAttrs attrs = {};
>
> -    ret = get_phys_addr(env, address, access_type, mmu_idx, &phys_addr,
> +    ret = get_phys_addr(env, address, access_type,
> +                        core_to_arm_mmu_idx(env, mmu_idx), &phys_addr,
>                          &attrs, &prot, &page_size, fsr, fi);
>      if (!ret) {
>          /* Map a single [sub]page.  */
> @@ -8507,10 +8513,11 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
>      bool ret;
>      uint32_t fsr;
>      ARMMMUFaultInfo fi = {};
> +    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
>
>      *attrs = (MemTxAttrs) {};
>
> -    ret = get_phys_addr(env, addr, 0, cpu_mmu_index(env, false), &phys_addr,
> +    ret = get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
>                          attrs, &prot, &page_size, &fsr, &fi);
>
>      if (ret) {
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index de24815..2a85666 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -194,6 +194,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>      int target_el;
>      bool same_el;
>      uint32_t syn;
> +    ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
>
>      if (retaddr) {
>          /* now we have a real cpu fault */
> @@ -208,7 +209,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>      /* the DFSR for an alignment fault depends on whether we're using
>       * the LPAE long descriptor format, or the short descriptor format
>       */
> -    if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
> +    if (arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
>          env->exception.fsr = (1 << 9) | 0x21;
>      } else {
>          env->exception.fsr = 0x1;
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 24de30d..a82ab49 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -101,21 +101,27 @@ void a64_translate_init(void)
>          offsetof(CPUARMState, exclusive_high), "exclusive_high");
>  }
>
> -static inline ARMMMUIdx get_a64_user_mem_index(DisasContext *s)
> +static inline int get_a64_user_mem_index(DisasContext *s)
>  {
> -    /* Return the mmu_idx to use for A64 "unprivileged load/store" insns:
> +    /* Return the core mmu_idx to use for A64 "unprivileged load/store" insns:
>       *  if EL1, access as if EL0; otherwise access at current EL
>       */
> +    ARMMMUIdx useridx;
> +
>      switch (s->mmu_idx) {
>      case ARMMMUIdx_S12NSE1:
> -        return ARMMMUIdx_S12NSE0;
> +        useridx = ARMMMUIdx_S12NSE0;
> +        break;
>      case ARMMMUIdx_S1SE1:
> -        return ARMMMUIdx_S1SE0;
> +        useridx = ARMMMUIdx_S1SE0;
> +        break;
>      case ARMMMUIdx_S2NS:
>          g_assert_not_reached();
>      default:
> -        return s->mmu_idx;
> +        useridx = s->mmu_idx;
> +        break;
>      }
> +    return arm_to_core_mmu_idx(useridx);
>  }
>
>  void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
> @@ -11212,7 +11218,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
>      dc->be_data = ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
>      dc->condexec_mask = 0;
>      dc->condexec_cond = 0;
> -    dc->mmu_idx = ARM_TBFLAG_MMUIDX(tb->flags);
> +    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(tb->flags));
>      dc->tbi0 = ARM_TBFLAG_TBI0(tb->flags);
>      dc->tbi1 = ARM_TBFLAG_TBI1(tb->flags);
>      dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0b5a0bc..8d509a2 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -145,9 +145,9 @@ static void disas_set_da_iss(DisasContext *s, TCGMemOp memop, ISSInfo issinfo)
>      disas_set_insn_syndrome(s, syn);
>  }
>
> -static inline ARMMMUIdx get_a32_user_mem_index(DisasContext *s)
> +static inline int get_a32_user_mem_index(DisasContext *s)
>  {
> -    /* Return the mmu_idx to use for A32/T32 "unprivileged load/store"
> +    /* Return the core mmu_idx to use for A32/T32 "unprivileged load/store"
>       * insns:
>       *  if PL2, UNPREDICTABLE (we choose to implement as if PL0)
>       *  otherwise, access as if at PL0.
> @@ -156,11 +156,11 @@ static inline ARMMMUIdx get_a32_user_mem_index(DisasContext *s)
>      case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
>      case ARMMMUIdx_S12NSE0:
>      case ARMMMUIdx_S12NSE1:
> -        return ARMMMUIdx_S12NSE0;
> +        return arm_to_core_mmu_idx(ARMMMUIdx_S12NSE0);
>      case ARMMMUIdx_S1E3:
>      case ARMMMUIdx_S1SE0:
>      case ARMMMUIdx_S1SE1:
> -        return ARMMMUIdx_S1SE0;
> +        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
>      case ARMMMUIdx_S2NS:
>      default:
>          g_assert_not_reached();
> @@ -11816,7 +11816,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
>      dc->be_data = ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
>      dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(tb->flags) & 0xf) << 1;
>      dc->condexec_cond = ARM_TBFLAG_CONDEXEC(tb->flags) >> 4;
> -    dc->mmu_idx = ARM_TBFLAG_MMUIDX(tb->flags);
> +    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(tb->flags));
>      dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
>  #if !defined(CONFIG_USER_ONLY)
>      dc->user = (dc->current_el == 0);
> --
> 2.7.4
>
>
