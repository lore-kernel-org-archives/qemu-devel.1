Received: from eggs.gnu.org ([2001:4830:134:3::10]:52020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1ZC-0002HQ-BQ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Z9-0002Pp-5o
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:52:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab516a18-25d3-11b8-7065-ce94c5cce7a7@amsat.org>
Date: Wed, 2 Aug 2017 18:52:27 -0300
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 01/15] target/arm: Use
 MMUAccessType enum rather than int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/02/2017 01:43 PM, Peter Maydell wrote:
> In the ARM get_phys_addr() code, switch to using the MMUAccessType
> enum and its MMU_* values rather than int and literal 0/1/2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/arm/helper.c    | 30 +++++++++++++++---------------
>   target/arm/internals.h |  3 ++-
>   2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index fa60040..b78d277 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -20,13 +20,13 @@
>   
>   #ifndef CONFIG_USER_ONLY
>   static bool get_phys_addr(CPUARMState *env, target_ulong address,
> -                          int access_type, ARMMMUIdx mmu_idx,
> +                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                             hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
>                             target_ulong *page_size, uint32_t *fsr,
>                             ARMMMUFaultInfo *fi);
>   
>   static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
> -                               int access_type, ARMMMUIdx mmu_idx,
> +                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                                  hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
>                                  target_ulong *page_size_ptr, uint32_t *fsr,
>                                  ARMMMUFaultInfo *fi);
> @@ -2135,7 +2135,7 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
>   }
>   
>   static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
> -                             int access_type, ARMMMUIdx mmu_idx)
> +                             MMUAccessType access_type, ARMMMUIdx mmu_idx)
>   {
>       hwaddr phys_addr;
>       target_ulong page_size;
> @@ -2194,7 +2194,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
>   
>   static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>   {
> -    int access_type = ri->opc2 & 1;
> +    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
>       uint64_t par64;
>       ARMMMUIdx mmu_idx;
>       int el = arm_current_el(env);
> @@ -2253,7 +2253,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>   static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>   {
> -    int access_type = ri->opc2 & 1;
> +    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
>       uint64_t par64;
>   
>       par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S2NS);
> @@ -2273,7 +2273,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
>   static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>   {
> -    int access_type = ri->opc2 & 1;
> +    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
>       ARMMMUIdx mmu_idx;
>       int secure = arm_is_secure_below_el3(env);
>   
> @@ -7510,7 +7510,7 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
>   }
>   
>   static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
> -                             int access_type, ARMMMUIdx mmu_idx,
> +                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                                hwaddr *phys_ptr, int *prot,
>                                target_ulong *page_size, uint32_t *fsr,
>                                ARMMMUFaultInfo *fi)
> @@ -7626,7 +7626,7 @@ do_fault:
>   }
>   
>   static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
> -                             int access_type, ARMMMUIdx mmu_idx,
> +                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                                hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
>                                target_ulong *page_size, uint32_t *fsr,
>                                ARMMMUFaultInfo *fi)
> @@ -7733,7 +7733,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
>           if (pxn && !regime_is_user(env, mmu_idx)) {
>               xn = 1;
>           }
> -        if (xn && access_type == 2)
> +        if (xn && access_type == MMU_INST_FETCH)
>               goto do_fault;
>   
>           if (arm_feature(env, ARM_FEATURE_V6K) &&
> @@ -7848,7 +7848,7 @@ static bool check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, int level,
>   }
>   
>   static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
> -                               int access_type, ARMMMUIdx mmu_idx,
> +                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                                  hwaddr *phys_ptr, MemTxAttrs *txattrs, int *prot,
>                                  target_ulong *page_size_ptr, uint32_t *fsr,
>                                  ARMMMUFaultInfo *fi)
> @@ -8256,7 +8256,7 @@ static inline bool m_is_system_region(CPUARMState *env, uint32_t address)
>   }
>   
>   static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
> -                                 int access_type, ARMMMUIdx mmu_idx,
> +                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                                    hwaddr *phys_ptr, int *prot, uint32_t *fsr)
>   {
>       ARMCPU *cpu = arm_env_get_cpu(env);
> @@ -8415,7 +8415,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>   }
>   
>   static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
> -                                 int access_type, ARMMMUIdx mmu_idx,
> +                                 MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                                    hwaddr *phys_ptr, int *prot, uint32_t *fsr)
>   {
>       int n;
> @@ -8442,7 +8442,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
>           return true;
>       }
>   
> -    if (access_type == 2) {
> +    if (access_type == MMU_INST_FETCH) {
>           mask = env->cp15.pmsav5_insn_ap;
>       } else {
>           mask = env->cp15.pmsav5_data_ap;
> @@ -8513,7 +8513,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
>    * @fsr: set to the DFSR/IFSR value on failure
>    */
>   static bool get_phys_addr(CPUARMState *env, target_ulong address,
> -                          int access_type, ARMMMUIdx mmu_idx,
> +                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
>                             hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
>                             target_ulong *page_size, uint32_t *fsr,
>                             ARMMMUFaultInfo *fi)
> @@ -8626,7 +8626,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
>    * fsr with ARM DFSR/IFSR fault register format value on failure.
>    */
>   bool arm_tlb_fill(CPUState *cs, vaddr address,
> -                  int access_type, int mmu_idx, uint32_t *fsr,
> +                  MMUAccessType access_type, int mmu_idx, uint32_t *fsr,
>                     ARMMMUFaultInfo *fi)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1f6efef..bb06946 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -457,7 +457,8 @@ struct ARMMMUFaultInfo {
>   };
>   
>   /* Do a page table walk and add page to TLB if possible */
> -bool arm_tlb_fill(CPUState *cpu, vaddr address, int rw, int mmu_idx,
> +bool arm_tlb_fill(CPUState *cpu, vaddr address,
> +                  MMUAccessType access_type, int mmu_idx,
>                     uint32_t *fsr, ARMMMUFaultInfo *fi);
>   
>   /* Return true if the stage 1 translation regime is using LPAE format page
> 
