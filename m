Received: from eggs.gnu.org ([2001:4830:134:3::10]:35520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <digetx@gmail.com>) id 1dtZI2-0002HP-4P
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 09:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <digetx@gmail.com>) id 1dtZHx-0001gs-BA
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 09:07:14 -0400
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-23-alex.bennee@linaro.org>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7468f944-914c-de89-66fb-f8ad49eb59c1@gmail.com>
Date: Sun, 17 Sep 2017 16:07:03 +0300
MIME-Version: 1.0
In-Reply-To: <20170224112109.3147-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 22/24] target-arm: ensure all cross vCPUs
 TLB flushes complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: "open list:ARM" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org

On 24.02.2017 14:21, Alex Bennée wrote:
> Previously flushes on other vCPUs would only get serviced when they
> exited their TranslationBlocks. While this isn't overly problematic it
> violates the semantics of TLB flush from the point of view of source
> vCPU.
> 
> To solve this we call the cputlb *_all_cpus_synced() functions to do
> the flushes which ensures all flushes are completed by the time the
> vCPU next schedules its own work. As the TLB instructions are modelled
> as CP writes the TB ends at this point meaning cpu->exit_request will
> be checked before the next instruction is executed.
> 
> Deferring the work until the architectural sync point is a possible
> future optimisation.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 165 ++++++++++++++++++++++------------------------------
>  1 file changed, 69 insertions(+), 96 deletions(-)
> 

Hello,

I have an issue with Linux kernel stopping to boot on a SMP 32bit ARM (haven't
checked 64bit) in a single-threaded TCG mode. Kernel reaches point where it
should mount rootfs over NFS and vCPUs stop. This issue is reproducible with any
32bit ARM machine type. Kernel boots fine with a MTTCG accel, only
single-threaded TCG is affected. Git bisection lead to this patch, any ideas?

Example:

qemu-system-arm -M vexpress-a9 -smp cpus=2 -accel accel=tcg,thread=single
-kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb -serial
stdio -net nic,model=lan9118 -net user -d in_asm,out_asm -D /tmp/qemulog

Last TB from the log:
----------------
IN:
0xc011a450:  ee080f73      mcr	15, 0, r0, cr8, cr3, {3}

OUT: [size=68]
0x7f32d8b93f80:  mov    -0x18(%r14),%ebp
0x7f32d8b93f84:  test   %ebp,%ebp
0x7f32d8b93f86:  jne    0x7f32d8b93fb8
0x7f32d8b93f8c:  mov    %r14,%rdi
0x7f32d8b93f8f:  mov    $0x5620f2aea5d0,%rsi
0x7f32d8b93f99:  mov    (%r14),%edx
0x7f32d8b93f9c:  mov    $0x5620f18107ca,%r10
0x7f32d8b93fa6:  callq  *%r10
0x7f32d8b93fa9:  movl   $0xc011a454,0x3c(%r14)
0x7f32d8b93fb1:  xor    %eax,%eax
0x7f32d8b93fb3:  jmpq   0x7f32d7a4e016
0x7f32d8b93fb8:  lea    -0x14aa07c(%rip),%rax        # 0x7f32d76e9f43
0x7f32d8b93fbf:  jmpq   0x7f32d7a4e016


> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b41d0494d1..bcedb4a808 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -536,41 +536,33 @@ static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush(other_cs);
> -    }
> +    tlb_flush_all_cpus_synced(cs);
>  }
>  
>  static void tlbiasid_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush(other_cs);
> -    }
> +    tlb_flush_all_cpus_synced(cs);
>  }
>  
>  static void tlbimva_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_page(other_cs, value & TARGET_PAGE_MASK);
> -    }
> +    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
>  }
>  
>  static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_page(other_cs, value & TARGET_PAGE_MASK);
> -    }
> +    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
>  }
>  
>  static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -587,14 +579,12 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                    uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_by_mmuidx(other_cs,
> -                            (1 << ARMMMUIdx_S12NSE1) |
> -                            (1 << ARMMMUIdx_S12NSE0) |
> -                            (1 << ARMMMUIdx_S2NS));
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs,
> +                                        (1 << ARMMMUIdx_S12NSE1) |
> +                                        (1 << ARMMMUIdx_S12NSE0) |
> +                                        (1 << ARMMMUIdx_S2NS));
>  }
>  
>  static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -621,7 +611,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                 uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>      uint64_t pageaddr;
>  
>      if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
> @@ -630,9 +620,8 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  
>      pageaddr = sextract64(value << 12, 0, 40);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S2NS));
> -    }
> +    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> +                                             (1 << ARMMMUIdx_S2NS));
>  }
>  
>  static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -646,11 +635,9 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                   uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_by_mmuidx(other_cs, (1 << ARMMMUIdx_S1E2));
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, (1 << ARMMMUIdx_S1E2));
>  }
>  
>  static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -665,12 +652,11 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                   uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>      uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S1E2));
> -    }
> +    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> +                                             (1 << ARMMMUIdx_S1E2));
>  }
>  
>  static const ARMCPRegInfo cp_reginfo[] = {
> @@ -2904,8 +2890,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
>  static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                      uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = ENV_GET_CPU(env);
>  
>      if (arm_is_secure_below_el3(env)) {
>          tlb_flush_by_mmuidx(cs,
> @@ -2921,19 +2906,17 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                        uint64_t value)
>  {
> +    CPUState *cs = ENV_GET_CPU(env);
>      bool sec = arm_is_secure_below_el3(env);
> -    CPUState *other_cs;
>  
> -    CPU_FOREACH(other_cs) {
> -        if (sec) {
> -            tlb_flush_by_mmuidx(other_cs,
> -                                (1 << ARMMMUIdx_S1SE1) |
> -                                (1 << ARMMMUIdx_S1SE0));
> -        } else {
> -            tlb_flush_by_mmuidx(other_cs,
> -                                (1 << ARMMMUIdx_S12NSE1) |
> -                                (1 << ARMMMUIdx_S12NSE0));
> -        }
> +    if (sec) {
> +        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> +                                            (1 << ARMMMUIdx_S1SE1) |
> +                                            (1 << ARMMMUIdx_S1SE0));
> +    } else {
> +        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> +                                            (1 << ARMMMUIdx_S12NSE1) |
> +                                            (1 << ARMMMUIdx_S12NSE0));
>      }
>  }
>  
> @@ -2990,46 +2973,40 @@ static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       * stage 2 translations, whereas most other scopes only invalidate
>       * stage 1 translations.
>       */
> +    CPUState *cs = ENV_GET_CPU(env);
>      bool sec = arm_is_secure_below_el3(env);
>      bool has_el2 = arm_feature(env, ARM_FEATURE_EL2);
> -    CPUState *other_cs;
> -
> -    CPU_FOREACH(other_cs) {
> -        if (sec) {
> -            tlb_flush_by_mmuidx(other_cs,
> -                                (1 << ARMMMUIdx_S1SE1) |
> -                                (1 << ARMMMUIdx_S1SE0));
> -        } else if (has_el2) {
> -            tlb_flush_by_mmuidx(other_cs,
> -                                (1 << ARMMMUIdx_S12NSE1) |
> -                                (1 << ARMMMUIdx_S12NSE0) |
> -                                (1 << ARMMMUIdx_S2NS));
> -        } else {
> -            tlb_flush_by_mmuidx(other_cs,
> -                                (1 << ARMMMUIdx_S12NSE1) |
> -                                (1 << ARMMMUIdx_S12NSE0));
> -        }
> +
> +    if (sec) {
> +        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> +                                            (1 << ARMMMUIdx_S1SE1) |
> +                                            (1 << ARMMMUIdx_S1SE0));
> +    } else if (has_el2) {
> +        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> +                                            (1 << ARMMMUIdx_S12NSE1) |
> +                                            (1 << ARMMMUIdx_S12NSE0) |
> +                                            (1 << ARMMMUIdx_S2NS));
> +    } else {
> +          tlb_flush_by_mmuidx_all_cpus_synced(cs,
> +                                              (1 << ARMMMUIdx_S12NSE1) |
> +                                              (1 << ARMMMUIdx_S12NSE0));
>      }
>  }
>  
>  static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                      uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_by_mmuidx(other_cs, (1 << ARMMMUIdx_S1E2));
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, (1 << ARMMMUIdx_S1E2));
>  }
>  
>  static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                      uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_by_mmuidx(other_cs, (1 << ARMMMUIdx_S1E3));
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, (1 << ARMMMUIdx_S1E3));
>  }
>  
>  static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3086,43 +3063,40 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                     uint64_t value)
>  {
> +    ARMCPU *cpu = arm_env_get_cpu(env);
> +    CPUState *cs = CPU(cpu);
>      bool sec = arm_is_secure_below_el3(env);
> -    CPUState *other_cs;
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>  
> -    CPU_FOREACH(other_cs) {
> -        if (sec) {
> -            tlb_flush_page_by_mmuidx(other_cs, pageaddr,
> -                                     (1 << ARMMMUIdx_S1SE1) |
> -                                     (1 << ARMMMUIdx_S1SE0));
> -        } else {
> -            tlb_flush_page_by_mmuidx(other_cs, pageaddr,
> -                                     (1 << ARMMMUIdx_S12NSE1) |
> -                                     (1 << ARMMMUIdx_S12NSE0));
> -        }
> +    if (sec) {
> +        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> +                                                 (1 << ARMMMUIdx_S1SE1) |
> +                                                 (1 << ARMMMUIdx_S1SE0));
> +    } else {
> +        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> +                                                 (1 << ARMMMUIdx_S12NSE1) |
> +                                                 (1 << ARMMMUIdx_S12NSE0));
>      }
>  }
>  
>  static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                     uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S1E2));
> -    }
> +    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> +                                             (1 << ARMMMUIdx_S1E2));
>  }
>  
>  static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                     uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S1E3));
> -    }
> +    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> +                                             (1 << ARMMMUIdx_S1E3));
>  }
>  
>  static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3150,7 +3124,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                        uint64_t value)
>  {
> -    CPUState *other_cs;
> +    CPUState *cs = ENV_GET_CPU(env);
>      uint64_t pageaddr;
>  
>      if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
> @@ -3159,9 +3133,8 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  
>      pageaddr = sextract64(value << 12, 0, 48);
>  
> -    CPU_FOREACH(other_cs) {
> -        tlb_flush_page_by_mmuidx(other_cs, pageaddr, (1 << ARMMMUIdx_S2NS));
> -    }
> +    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> +                                             (1 << ARMMMUIdx_S2NS));
>  }
>  
>  static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
> 


-- 
Dmitry
