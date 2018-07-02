Received: from eggs.gnu.org ([2001:4830:134:3::10]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZuJO-0008RJ-8l
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZuJL-0000IS-1x
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:35:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZuJK-000079-No
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:35:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id u22-v6so755743wmc.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 01:35:45 -0700 (PDT)
References: <567473a0-6005-5843-4c73-951f476085ca@web.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e627a48-462a-ba5f-9687-5aace6b34cbb@redhat.com>
Date: Mon, 2 Jul 2018 10:35:40 +0200
MIME-Version: 1.0
In-Reply-To: <567473a0-6005-5843-4c73-951f476085ca@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target-i386: Add NPT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

On 30/06/2018 08:08, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This implements NPT suport for SVM by hooking into
> x86_cpu_handle_mmu_fault where it reads the stage-1 page table. Whether
> we need to perform this 2nd stage translation, and how, is decided
> during vmrun and stored in hflags2, along with nested_cr3 and
> nested_pg_mode.
> 
> As get_hphys performs a direct cpu_vmexit in case of NPT faults, we need
> retaddr in that function. To avoid changing the signature of
> cpu_handle_mmu_fault, this passes the value from tlb_fill to get_hphys
> via the CPU state.
> 
> This was tested successfully via the Jailhouse hypervisor.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - use hflags2 instead of hflags
>  - add conditional vmstate subsection
> 
>  target/i386/cpu.c         |   2 +-
>  target/i386/cpu.h         |   6 ++
>  target/i386/excp_helper.c | 216 +++++++++++++++++++++++++++++++++++++++++++++-
>  target/i386/machine.c     |  21 +++++
>  target/i386/mem_helper.c  |   6 +-
>  target/i386/svm.h         |  14 +++
>  target/i386/svm_helper.c  |  22 +++++
>  7 files changed, 281 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1e6a7d0a75..6e1f180249 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -751,7 +751,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>  #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
>            CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A)
>  #define TCG_EXT4_FEATURES 0
> -#define TCG_SVM_FEATURES 0
> +#define TCG_SVM_FEATURES CPUID_SVM_NPT
>  #define TCG_KVM_FEATURES 0
>  #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | \
>            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 8eaefeee3e..7f33755bf5 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -211,6 +211,7 @@ typedef enum X86Seg {
>  #define HF2_VINTR_SHIFT          3 /* value of V_INTR_MASKING bit */
>  #define HF2_SMM_INSIDE_NMI_SHIFT 4 /* CPU serving SMI nested inside NMI */
>  #define HF2_MPX_PR_SHIFT         5 /* BNDCFGx.BNDPRESERVE */
> +#define HF2_NPT_SHIFT            6 /* Nested Paging enabled */
>  
>  #define HF2_GIF_MASK            (1 << HF2_GIF_SHIFT)
>  #define HF2_HIF_MASK            (1 << HF2_HIF_SHIFT)
> @@ -218,6 +219,7 @@ typedef enum X86Seg {
>  #define HF2_VINTR_MASK          (1 << HF2_VINTR_SHIFT)
>  #define HF2_SMM_INSIDE_NMI_MASK (1 << HF2_SMM_INSIDE_NMI_SHIFT)
>  #define HF2_MPX_PR_MASK         (1 << HF2_MPX_PR_SHIFT)
> +#define HF2_NPT_MASK            (1 << HF2_NPT_SHIFT)
>  
>  #define CR0_PE_SHIFT 0
>  #define CR0_MP_SHIFT 1
> @@ -1265,12 +1267,16 @@ typedef struct CPUX86State {
>      uint16_t intercept_dr_read;
>      uint16_t intercept_dr_write;
>      uint32_t intercept_exceptions;
> +    uint64_t nested_cr3;
> +    uint32_t nested_pg_mode;
>      uint8_t v_tpr;
>  
>      /* KVM states, automatically cleared on reset */
>      uint8_t nmi_injected;
>      uint8_t nmi_pending;
>  
> +    uintptr_t retaddr;
> +
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>  
> diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
> index cb4d1b7d33..37a33d5ae0 100644
> --- a/target/i386/excp_helper.c
> +++ b/target/i386/excp_helper.c
> @@ -157,6 +157,209 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>  
>  #else
>  
> +static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
> +                        int *prot)
> +{
> +    CPUX86State *env = &X86_CPU(cs)->env;
> +    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
> +    uint64_t ptep, pte;
> +    uint64_t exit_info_1 = 0;
> +    target_ulong pde_addr, pte_addr;
> +    uint32_t page_offset;
> +    int page_size;
> +
> +    if (likely(!(env->hflags2 & HF2_NPT_MASK))) {
> +        return gphys;
> +    }
> +
> +    if (!(env->nested_pg_mode & SVM_NPT_NXE)) {
> +        rsvd_mask |= PG_NX_MASK;
> +    }
> +
> +    if (env->nested_pg_mode & SVM_NPT_PAE) {
> +        uint64_t pde, pdpe;
> +        target_ulong pdpe_addr;
> +
> +#ifdef TARGET_X86_64
> +        if (env->nested_pg_mode & SVM_NPT_LMA) {
> +            uint64_t pml5e;
> +            uint64_t pml4e_addr, pml4e;
> +
> +            pml5e = env->nested_cr3;
> +            ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
> +
> +            pml4e_addr = (pml5e & PG_ADDRESS_MASK) +
> +                    (((gphys >> 39) & 0x1ff) << 3);
> +            pml4e = x86_ldq_phys(cs, pml4e_addr);
> +            if (!(pml4e & PG_PRESENT_MASK)) {
> +                goto do_fault;
> +            }
> +            if (pml4e & (rsvd_mask | PG_PSE_MASK)) {
> +                goto do_fault_rsvd;
> +            }
> +            if (!(pml4e & PG_ACCESSED_MASK)) {
> +                pml4e |= PG_ACCESSED_MASK;
> +                x86_stl_phys_notdirty(cs, pml4e_addr, pml4e);
> +            }
> +            ptep &= pml4e ^ PG_NX_MASK;
> +            pdpe_addr = (pml4e & PG_ADDRESS_MASK) +
> +                    (((gphys >> 30) & 0x1ff) << 3);
> +            pdpe = x86_ldq_phys(cs, pdpe_addr);
> +            if (!(pdpe & PG_PRESENT_MASK)) {
> +                goto do_fault;
> +            }
> +            if (pdpe & rsvd_mask) {
> +                goto do_fault_rsvd;
> +            }
> +            ptep &= pdpe ^ PG_NX_MASK;
> +            if (!(pdpe & PG_ACCESSED_MASK)) {
> +                pdpe |= PG_ACCESSED_MASK;
> +                x86_stl_phys_notdirty(cs, pdpe_addr, pdpe);
> +            }
> +            if (pdpe & PG_PSE_MASK) {
> +                /* 1 GB page */
> +                page_size = 1024 * 1024 * 1024;
> +                pte_addr = pdpe_addr;
> +                pte = pdpe;
> +                goto do_check_protect;
> +            }
> +        } else
> +#endif
> +        {
> +            pdpe_addr = (env->nested_cr3 & ~0x1f) + ((gphys >> 27) & 0x18);
> +            pdpe = x86_ldq_phys(cs, pdpe_addr);
> +            if (!(pdpe & PG_PRESENT_MASK)) {
> +                goto do_fault;
> +            }
> +            rsvd_mask |= PG_HI_USER_MASK;
> +            if (pdpe & (rsvd_mask | PG_NX_MASK)) {
> +                goto do_fault_rsvd;
> +            }
> +            ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
> +        }
> +
> +        pde_addr = (pdpe & PG_ADDRESS_MASK) + (((gphys >> 21) & 0x1ff) << 3);
> +        pde = x86_ldq_phys(cs, pde_addr);
> +        if (!(pde & PG_PRESENT_MASK)) {
> +            goto do_fault;
> +        }
> +        if (pde & rsvd_mask) {
> +            goto do_fault_rsvd;
> +        }
> +        ptep &= pde ^ PG_NX_MASK;
> +        if (pde & PG_PSE_MASK) {
> +            /* 2 MB page */
> +            page_size = 2048 * 1024;
> +            pte_addr = pde_addr;
> +            pte = pde;
> +            goto do_check_protect;
> +        }
> +        /* 4 KB page */
> +        if (!(pde & PG_ACCESSED_MASK)) {
> +            pde |= PG_ACCESSED_MASK;
> +            x86_stl_phys_notdirty(cs, pde_addr, pde);
> +        }
> +        pte_addr = (pde & PG_ADDRESS_MASK) + (((gphys >> 12) & 0x1ff) << 3);
> +        pte = x86_ldq_phys(cs, pte_addr);
> +        if (!(pte & PG_PRESENT_MASK)) {
> +            goto do_fault;
> +        }
> +        if (pte & rsvd_mask) {
> +            goto do_fault_rsvd;
> +        }
> +        /* combine pde and pte nx, user and rw protections */
> +        ptep &= pte ^ PG_NX_MASK;
> +        page_size = 4096;
> +    } else {
> +        uint32_t pde;
> +
> +        /* page directory entry */
> +        pde_addr = (env->nested_cr3 & ~0xfff) + ((gphys >> 20) & 0xffc);
> +        pde = x86_ldl_phys(cs, pde_addr);
> +        if (!(pde & PG_PRESENT_MASK)) {
> +            goto do_fault;
> +        }
> +        ptep = pde | PG_NX_MASK;
> +
> +        /* if PSE bit is set, then we use a 4MB page */
> +        if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
> +            page_size = 4096 * 1024;
> +            pte_addr = pde_addr;
> +
> +            /* Bits 20-13 provide bits 39-32 of the address, bit 21 is reserved.
> +             * Leave bits 20-13 in place for setting accessed/dirty bits below.
> +             */
> +            pte = pde | ((pde & 0x1fe000LL) << (32 - 13));
> +            rsvd_mask = 0x200000;
> +            goto do_check_protect_pse36;
> +        }
> +
> +        if (!(pde & PG_ACCESSED_MASK)) {
> +            pde |= PG_ACCESSED_MASK;
> +            x86_stl_phys_notdirty(cs, pde_addr, pde);
> +        }
> +
> +        /* page directory entry */
> +        pte_addr = (pde & ~0xfff) + ((gphys >> 10) & 0xffc);
> +        pte = x86_ldl_phys(cs, pte_addr);
> +        if (!(pte & PG_PRESENT_MASK)) {
> +            goto do_fault;
> +        }
> +        /* combine pde and pte user and rw protections */
> +        ptep &= pte | PG_NX_MASK;
> +        page_size = 4096;
> +        rsvd_mask = 0;
> +    }
> +
> + do_check_protect:
> +    rsvd_mask |= (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;
> + do_check_protect_pse36:
> +    if (pte & rsvd_mask) {
> +        goto do_fault_rsvd;
> +    }
> +    ptep ^= PG_NX_MASK;
> +
> +    if (!(ptep & PG_USER_MASK)) {
> +        goto do_fault_protect;
> +    }
> +    if (ptep & PG_NX_MASK) {
> +        if (access_type == MMU_INST_FETCH) {
> +            goto do_fault_protect;
> +        }
> +        *prot &= ~PAGE_EXEC;
> +    }
> +    if (!(ptep & PG_RW_MASK)) {
> +        if (access_type == MMU_DATA_STORE) {
> +            goto do_fault_protect;
> +        }
> +        *prot &= ~PAGE_WRITE;
> +    }
> +
> +    pte &= PG_ADDRESS_MASK & ~(page_size - 1);
> +    page_offset = gphys & (page_size - 1);
> +    return pte + page_offset;
> +
> + do_fault_rsvd:
> +    exit_info_1 |= SVM_NPTEXIT_RSVD;
> + do_fault_protect:
> +    exit_info_1 |= SVM_NPTEXIT_P;
> + do_fault:
> +    x86_stq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, control.exit_info_2),
> +                 gphys);
> +    exit_info_1 |= SVM_NPTEXIT_US;
> +    if (access_type == MMU_DATA_STORE) {
> +        exit_info_1 |= SVM_NPTEXIT_RW;
> +    } else if (access_type == MMU_INST_FETCH) {
> +        exit_info_1 |= SVM_NPTEXIT_ID;
> +    }
> +    if (prot) {
> +        exit_info_1 |= SVM_NPTEXIT_GPA;
> +    } else { /* page table access */
> +        exit_info_1 |= SVM_NPTEXIT_GPT;
> +    }
> +    cpu_vmexit(env, SVM_EXIT_NPF, exit_info_1, env->retaddr);
> +}
> +
>  /* return value:
>   * -1 = cannot handle fault
>   * 0  = nothing more to do
> @@ -224,6 +427,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>              if (la57) {
>                  pml5e_addr = ((env->cr[3] & ~0xfff) +
>                          (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
> +                pml5e_addr = get_hphys(cs, pml5e_addr, MMU_DATA_STORE, NULL);
>                  pml5e = x86_ldq_phys(cs, pml5e_addr);
>                  if (!(pml5e & PG_PRESENT_MASK)) {
>                      goto do_fault;
> @@ -243,6 +447,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>  
>              pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
>                      (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
> +            pml4e_addr = get_hphys(cs, pml4e_addr, MMU_DATA_STORE, false);
>              pml4e = x86_ldq_phys(cs, pml4e_addr);
>              if (!(pml4e & PG_PRESENT_MASK)) {
>                  goto do_fault;
> @@ -257,6 +462,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>              ptep &= pml4e ^ PG_NX_MASK;
>              pdpe_addr = ((pml4e & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3)) &
>                  a20_mask;
> +            pdpe_addr = get_hphys(cs, pdpe_addr, MMU_DATA_STORE, NULL);
>              pdpe = x86_ldq_phys(cs, pdpe_addr);
>              if (!(pdpe & PG_PRESENT_MASK)) {
>                  goto do_fault;
> @@ -282,6 +488,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>              /* XXX: load them when cr3 is loaded ? */
>              pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
>                  a20_mask;
> +            pdpe_addr = get_hphys(cs, pdpe_addr, MMU_DATA_STORE, false);
>              pdpe = x86_ldq_phys(cs, pdpe_addr);
>              if (!(pdpe & PG_PRESENT_MASK)) {
>                  goto do_fault;
> @@ -295,6 +502,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>  
>          pde_addr = ((pdpe & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3)) &
>              a20_mask;
> +        pde_addr = get_hphys(cs, pde_addr, MMU_DATA_STORE, NULL);
>          pde = x86_ldq_phys(cs, pde_addr);
>          if (!(pde & PG_PRESENT_MASK)) {
>              goto do_fault;
> @@ -317,6 +525,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>          }
>          pte_addr = ((pde & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3)) &
>              a20_mask;
> +        pte_addr = get_hphys(cs, pte_addr, MMU_DATA_STORE, NULL);
>          pte = x86_ldq_phys(cs, pte_addr);
>          if (!(pte & PG_PRESENT_MASK)) {
>              goto do_fault;
> @@ -333,6 +542,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>          /* page directory entry */
>          pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) &
>              a20_mask;
> +        pde_addr = get_hphys(cs, pde_addr, MMU_DATA_STORE, NULL);
>          pde = x86_ldl_phys(cs, pde_addr);
>          if (!(pde & PG_PRESENT_MASK)) {
>              goto do_fault;
> @@ -360,6 +570,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size,
>          /* page directory entry */
>          pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) &
>              a20_mask;
> +        pte_addr = get_hphys(cs, pte_addr, MMU_DATA_STORE, NULL);
>          pte = x86_ldl_phys(cs, pte_addr);
>          if (!(pte & PG_PRESENT_MASK)) {
>              goto do_fault;
> @@ -442,12 +653,13 @@ do_check_protect_pse36:
>  
>      /* align to page_size */
>      pte &= PG_ADDRESS_MASK & ~(page_size - 1);
> +    page_offset = addr & (page_size - 1);
> +    paddr = get_hphys(cs, pte + page_offset, is_write1, &prot);
>  
>      /* Even if 4MB pages, we map only one 4KB page in the cache to
>         avoid filling it too fast */
>      vaddr = addr & TARGET_PAGE_MASK;
> -    page_offset = vaddr & (page_size - 1);
> -    paddr = pte + page_offset;
> +    paddr &= TARGET_PAGE_MASK;
>  
>      assert(prot & (1 << is_write1));
>      tlb_set_page_with_attrs(cs, vaddr, paddr, cpu_get_mem_attrs(env),
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 4d98d367c1..8b64dff487 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -935,6 +935,26 @@ static const VMStateDescription vmstate_msr_virt_ssbd = {
>      }
>  };
>  
> +static bool svm_npt_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return !!(env->hflags2 & HF2_NPT_MASK);
> +}
> +
> +static const VMStateDescription vmstate_svm_npt = {
> +    .name = "cpu/svn_npt",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = svm_npt_needed,
> +    .fields = (VMStateField[]){
> +        VMSTATE_UINT64(env.nested_cr3, X86CPU),
> +        VMSTATE_UINT32(env.nested_pg_mode, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  VMStateDescription vmstate_x86_cpu = {
>      .name = "cpu",
>      .version_id = 12,
> @@ -1059,6 +1079,7 @@ VMStateDescription vmstate_x86_cpu = {
>          &vmstate_mcg_ext_ctl,
>          &vmstate_msr_intel_pt,
>          &vmstate_msr_virt_ssbd,
> +        &vmstate_svm_npt,
>          NULL
>      }
>  };
> diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
> index a8ae694a9c..30c26b9d9c 100644
> --- a/target/i386/mem_helper.c
> +++ b/target/i386/mem_helper.c
> @@ -202,13 +202,13 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
>  void tlb_fill(CPUState *cs, target_ulong addr, int size,
>                MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
>  {
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
>      int ret;
>  
> +    env->retaddr = retaddr;
>      ret = x86_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
>      if (ret) {
> -        X86CPU *cpu = X86_CPU(cs);
> -        CPUX86State *env = &cpu->env;
> -
>          raise_exception_err_ra(env, cs->exception_index, env->error_code, retaddr);
>      }
>  }
> diff --git a/target/i386/svm.h b/target/i386/svm.h
> index 922c8fd39c..23a3a040b8 100644
> --- a/target/i386/svm.h
> +++ b/target/i386/svm.h
> @@ -130,6 +130,20 @@
>  
>  #define SVM_CR0_SELECTIVE_MASK (1 << 3 | 1) /* TS and MP */
>  
> +#define SVM_NPT_ENABLED     (1 << 0)
> +
> +#define SVM_NPT_PAE         (1 << 0)
> +#define SVM_NPT_LMA         (1 << 1)
> +#define SVM_NPT_NXE         (1 << 2)
> +
> +#define SVM_NPTEXIT_P       (1ULL << 0)
> +#define SVM_NPTEXIT_RW      (1ULL << 1)
> +#define SVM_NPTEXIT_US      (1ULL << 2)
> +#define SVM_NPTEXIT_RSVD    (1ULL << 3)
> +#define SVM_NPTEXIT_ID      (1ULL << 4)
> +#define SVM_NPTEXIT_GPA     (1ULL << 32)
> +#define SVM_NPTEXIT_GPT     (1ULL << 33)
> +
>  struct QEMU_PACKED vmcb_control_area {
>  	uint16_t intercept_cr_read;
>  	uint16_t intercept_cr_write;
> diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
> index f245aec310..342ece082f 100644
> --- a/target/i386/svm_helper.c
> +++ b/target/i386/svm_helper.c
> @@ -124,6 +124,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
>  {
>      CPUState *cs = CPU(x86_env_get_cpu(env));
>      target_ulong addr;
> +    uint64_t nested_ctl;
>      uint32_t event_inj;
>      uint32_t int_ctl;
>  
> @@ -206,6 +207,26 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
>                                                    control.intercept_exceptions
>                                                    ));
>  
> +    nested_ctl = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
> +                                                          control.nested_ctl));
> +    if (nested_ctl & SVM_NPT_ENABLED) {
> +        env->nested_cr3 = x86_ldq_phys(cs,
> +                                env->vm_vmcb + offsetof(struct vmcb,
> +                                                        control.nested_cr3));
> +        env->hflags2 |= HF2_NPT_MASK;
> +
> +        env->nested_pg_mode = 0;
> +        if (env->cr[4] & CR4_PAE_MASK) {
> +            env->nested_pg_mode |= SVM_NPT_PAE;
> +        }
> +        if (env->hflags & HF_LMA_MASK) {
> +            env->nested_pg_mode |= SVM_NPT_LMA;
> +        }
> +        if (env->efer & MSR_EFER_NXE) {
> +            env->nested_pg_mode |= SVM_NPT_NXE;
> +        }
> +    }
> +
>      /* enable intercepts */
>      env->hflags |= HF_SVMI_MASK;
>  
> @@ -616,6 +637,7 @@ void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
>          x86_stl_phys(cs,
>                   env->vm_vmcb + offsetof(struct vmcb, control.int_state), 0);
>      }
> +    env->hflags2 &= ~HF2_NPT_MASK;
>  
>      /* Save the VM state in the vmcb */
>      svm_save_seg(env, env->vm_vmcb + offsetof(struct vmcb, save.es),
> 

Queued, thanks.

Paolo
