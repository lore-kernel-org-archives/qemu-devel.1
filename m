Received: from eggs.gnu.org ([2001:4830:134:3::10]:36265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZv0n-0001cl-M7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZv0k-0002Ir-FM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:48:29 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZv0k-0002IT-4l
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:48:26 -0500
Received: by mail-wr0-f194.google.com with SMTP id x1so456775wrb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 00:48:25 -0800 (PST)
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<151299873579.4808.10809590157198430235.stgit@Misha-PC.lan02.inno>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a664c494-2c17-4189-8e5c-bf734675154b@redhat.com>
Date: Fri, 12 Jan 2018 09:48:22 +0100
MIME-Version: 1.0
In-Reply-To: <151299873579.4808.10809590157198430235.stgit@Misha-PC.lan02.inno>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 45/46] windbg: changed kd_api_read_msr
 and kd_api_write_msr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org

On 11/12/2017 14:25, Mihail Abakumov wrote:
> Added sub functions for helper_wrmsr and helper_rdmsr: cpu_x86_write_msr and cpu_x86_read_msr. Also they are used in packet handlers, i.e. duplication of code is removed.
> 
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  target/i386/cpu.h         |    3 
>  target/i386/misc_helper.c |   49 +++++--
>  target/i386/windbgstub.c  |  303 +--------------------------------------------
>  3 files changed, 43 insertions(+), 312 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 051867399b..04c5aac795 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1481,6 +1481,9 @@ void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3);
>  void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4);
>  void cpu_x86_update_dr7(CPUX86State *env, uint32_t new_dr7);
>  
> +void cpu_x86_write_msr(CPUX86State *env, uint64_t val);
> +uint64_t cpu_x86_read_msr(CPUX86State *env);
> +
>  /* hw/pc.c */
>  uint64_t cpu_get_tsc(CPUX86State *env);
>  
> diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
> index ec1fcd2899..5d74c31998 100644
> --- a/target/i386/misc_helper.c
> +++ b/target/i386/misc_helper.c
> @@ -220,6 +220,14 @@ void helper_rdpmc(CPUX86State *env)
>  }
>  
>  #if defined(CONFIG_USER_ONLY)
> +void cpu_x86_write_msr(CPUX86State *env, uint64_t val)
> +{
> +}
> +
> +uint64_t cpu_x86_read_msr(CPUX86State *env)
> +{
> +}
> +
>  void helper_wrmsr(CPUX86State *env)
>  {
>  }
> @@ -228,15 +236,8 @@ void helper_rdmsr(CPUX86State *env)
>  {
>  }
>  #else
> -void helper_wrmsr(CPUX86State *env)
> +void cpu_x86_write_msr(CPUX86State *env, uint64_t val)
>  {
> -    uint64_t val;
> -
> -    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
> -
> -    val = ((uint32_t)env->regs[R_EAX]) |
> -        ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
> -
>      switch ((uint32_t)env->regs[R_ECX]) {
>      case MSR_IA32_SYSENTER_CS:
>          env->sysenter_cs = val & 0xffff;
> @@ -386,16 +387,12 @@ void helper_wrmsr(CPUX86State *env)
>          /* XXX: exception? */
>          break;
>      }
> -
> -    windbg_try_load();
>  }
>  
> -void helper_rdmsr(CPUX86State *env)
> +uint64_t cpu_x86_read_msr(CPUX86State *env)
>  {
>      uint64_t val;
>  
> -    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
> -
>      switch ((uint32_t)env->regs[R_ECX]) {
>      case MSR_IA32_SYSENTER_CS:
>          val = env->sysenter_cs;
> @@ -534,6 +531,32 @@ void helper_rdmsr(CPUX86State *env)
>          val = 0;
>          break;
>      }
> +
> +    return val;
> +}
> +
> +void helper_wrmsr(CPUX86State *env)
> +{
> +    uint64_t val;
> +
> +    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
> +
> +    val = ((uint32_t)env->regs[R_EAX]) |
> +        ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
> +
> +    cpu_x86_write_msr(env, val);
> +
> +    windbg_try_load();
> +}
> +
> +void helper_rdmsr(CPUX86State *env)
> +{
> +    uint64_t val;
> +
> +    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
> +
> +    val = cpu_x86_read_msr(env);
> +
>      env->regs[R_EAX] = (uint32_t)(val);
>      env->regs[R_EDX] = (uint32_t)(val >> 32);
>  }
> diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
> index 96cb015752..c38bfa7448 100755
> --- a/target/i386/windbgstub.c
> +++ b/target/i386/windbgstub.c
> @@ -1076,150 +1076,9 @@ void kd_api_read_msr(CPUState *cpu, PacketData *pd)
>      DBGKD_READ_WRITE_MSR *m64c = &pd->m64.u.ReadWriteMsr;
>      CPUArchState *env = cpu->env_ptr;
>  
> -    uint64_t val;
> -
> -    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, 0);
> -
> -    switch ((uint32_t)env->regs[R_ECX]) {
> -    case MSR_IA32_SYSENTER_CS:
> -        val = env->sysenter_cs;
> -        break;
> -    case MSR_IA32_SYSENTER_ESP:
> -        val = env->sysenter_esp;
> -        break;
> -    case MSR_IA32_SYSENTER_EIP:
> -        val = env->sysenter_eip;
> -        break;
> -    case MSR_IA32_APICBASE:
> -        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
> -        break;
> -    case MSR_EFER:
> -        val = env->efer;
> -        break;
> -    case MSR_STAR:
> -        val = env->star;
> -        break;
> -    case MSR_PAT:
> -        val = env->pat;
> -        break;
> -    case MSR_VM_HSAVE_PA:
> -        val = env->vm_hsave;
> -        break;
> -    case MSR_IA32_PERF_STATUS:
> -        /* tsc_increment_by_tick */
> -        val = 1000ULL;
> -        /* CPU multiplier */
> -        val |= (((uint64_t)4ULL) << 40);
> -        break;
> -#ifdef TARGET_X86_64
> -    case MSR_LSTAR:
> -        val = env->lstar;
> -        break;
> -    case MSR_CSTAR:
> -        val = env->cstar;
> -        break;
> -    case MSR_FMASK:
> -        val = env->fmask;
> -        break;
> -    case MSR_FSBASE:
> -        val = env->segs[R_FS].base;
> -        break;
> -    case MSR_GSBASE:
> -        val = env->segs[R_GS].base;
> -        break;
> -    case MSR_KERNELGSBASE:
> -        val = env->kernelgsbase;
> -        break;
> -    case MSR_TSC_AUX:
> -        val = env->tsc_aux;
> -        break;
> -#endif
> -    case MSR_MTRRphysBase(0):
> -    case MSR_MTRRphysBase(1):
> -    case MSR_MTRRphysBase(2):
> -    case MSR_MTRRphysBase(3):
> -    case MSR_MTRRphysBase(4):
> -    case MSR_MTRRphysBase(5):
> -    case MSR_MTRRphysBase(6):
> -    case MSR_MTRRphysBase(7):
> -        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> -                             MSR_MTRRphysBase(0)) / 2].base;
> -        break;
> -    case MSR_MTRRphysMask(0):
> -    case MSR_MTRRphysMask(1):
> -    case MSR_MTRRphysMask(2):
> -    case MSR_MTRRphysMask(3):
> -    case MSR_MTRRphysMask(4):
> -    case MSR_MTRRphysMask(5):
> -    case MSR_MTRRphysMask(6):
> -    case MSR_MTRRphysMask(7):
> -        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> -                             MSR_MTRRphysMask(0)) / 2].mask;
> -        break;
> -    case MSR_MTRRfix64K_00000:
> -        val = env->mtrr_fixed[0];
> -        break;
> -    case MSR_MTRRfix16K_80000:
> -    case MSR_MTRRfix16K_A0000:
> -        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> -                              MSR_MTRRfix16K_80000 + 1];
> -        break;
> -    case MSR_MTRRfix4K_C0000:
> -    case MSR_MTRRfix4K_C8000:
> -    case MSR_MTRRfix4K_D0000:
> -    case MSR_MTRRfix4K_D8000:
> -    case MSR_MTRRfix4K_E0000:
> -    case MSR_MTRRfix4K_E8000:
> -    case MSR_MTRRfix4K_F0000:
> -    case MSR_MTRRfix4K_F8000:
> -        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> -                              MSR_MTRRfix4K_C0000 + 3];
> -        break;
> -    case MSR_MTRRdefType:
> -        val = env->mtrr_deftype;
> -        break;
> -    case MSR_MTRRcap:
> -        if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
> -            val = MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
> -                MSR_MTRRcap_WC_SUPPORTED;
> -        } else {
> -            /* XXX: exception? */
> -            val = 0;
> -        }
> -        break;
> -    case MSR_MCG_CAP:
> -        val = env->mcg_cap;
> -        break;
> -    case MSR_MCG_CTL:
> -        if (env->mcg_cap & MCG_CTL_P) {
> -            val = env->mcg_ctl;
> -        } else {
> -            val = 0;
> -        }
> -        break;
> -    case MSR_MCG_STATUS:
> -        val = env->mcg_status;
> -        break;
> -    case MSR_IA32_MISC_ENABLE:
> -        val = env->msr_ia32_misc_enable;
> -        break;
> -    case MSR_IA32_BNDCFGS:
> -        val = env->msr_bndcfgs;
> -        break;
> -    default:
> -        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
> -            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
> -            (4 * env->mcg_cap & 0xff)) {
> -            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
> -            val = env->mce_banks[offset];
> -            break;
> -        }
> -        /* XXX: exception? */
> -        val = 0;
> -        break;
> -    }
> -
> +    uint64_t val = cpu_x86_read_msr(env);
>      stq_p(&val, val);
> +
>      m64c->DataValueLow  = val;
>      m64c->DataValueHigh = val >> 32;
>      pd->m64.ReturnStatus = STATUS_SUCCESS;
> @@ -1230,162 +1089,8 @@ void kd_api_write_msr(CPUState *cpu, PacketData *pd)
>      DBGKD_READ_WRITE_MSR *m64c = &pd->m64.u.ReadWriteMsr;
>      CPUArchState *env = cpu->env_ptr;
>  
> -    uint64_t val;
> -
> -    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, 0);
> -
> -    val = m64c->DataValueLow | ((uint64_t) m64c->DataValueHigh) << 32;
> -    val = ldq_p(&val);
> -
> -    switch ((uint32_t)env->regs[R_ECX]) {
> -    case MSR_IA32_SYSENTER_CS:
> -        env->sysenter_cs = val & 0xffff;
> -        break;
> -    case MSR_IA32_SYSENTER_ESP:
> -        env->sysenter_esp = val;
> -        break;
> -    case MSR_IA32_SYSENTER_EIP:
> -        env->sysenter_eip = val;
> -        break;
> -    case MSR_IA32_APICBASE:
> -        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
> -        break;
> -    case MSR_EFER:
> -        {
> -            uint64_t update_mask;
> -
> -            update_mask = 0;
> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_SYSCALL) {
> -                update_mask |= MSR_EFER_SCE;
> -            }
> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> -                update_mask |= MSR_EFER_LME;
> -            }
> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> -                update_mask |= MSR_EFER_FFXSR;
> -            }
> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_NX) {
> -                update_mask |= MSR_EFER_NXE;
> -            }
> -            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> -                update_mask |= MSR_EFER_SVME;
> -            }
> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> -                update_mask |= MSR_EFER_FFXSR;
> -            }
> -            cpu_load_efer(env, (env->efer & ~update_mask) |
> -                          (val & update_mask));
> -        }
> -        break;
> -    case MSR_STAR:
> -        env->star = val;
> -        break;
> -    case MSR_PAT:
> -        env->pat = val;
> -        break;
> -    case MSR_VM_HSAVE_PA:
> -        env->vm_hsave = val;
> -        break;
> -#ifdef TARGET_X86_64
> -    case MSR_LSTAR:
> -        env->lstar = val;
> -        break;
> -    case MSR_CSTAR:
> -        env->cstar = val;
> -        break;
> -    case MSR_FMASK:
> -        env->fmask = val;
> -        break;
> -    case MSR_FSBASE:
> -        env->segs[R_FS].base = val;
> -        break;
> -    case MSR_GSBASE:
> -        env->segs[R_GS].base = val;
> -        break;
> -    case MSR_KERNELGSBASE:
> -        env->kernelgsbase = val;
> -        break;
> -#endif
> -    case MSR_MTRRphysBase(0):
> -    case MSR_MTRRphysBase(1):
> -    case MSR_MTRRphysBase(2):
> -    case MSR_MTRRphysBase(3):
> -    case MSR_MTRRphysBase(4):
> -    case MSR_MTRRphysBase(5):
> -    case MSR_MTRRphysBase(6):
> -    case MSR_MTRRphysBase(7):
> -        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> -                       MSR_MTRRphysBase(0)) / 2].base = val;
> -        break;
> -    case MSR_MTRRphysMask(0):
> -    case MSR_MTRRphysMask(1):
> -    case MSR_MTRRphysMask(2):
> -    case MSR_MTRRphysMask(3):
> -    case MSR_MTRRphysMask(4):
> -    case MSR_MTRRphysMask(5):
> -    case MSR_MTRRphysMask(6):
> -    case MSR_MTRRphysMask(7):
> -        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> -                       MSR_MTRRphysMask(0)) / 2].mask = val;
> -        break;
> -    case MSR_MTRRfix64K_00000:
> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> -                        MSR_MTRRfix64K_00000] = val;
> -        break;
> -    case MSR_MTRRfix16K_80000:
> -    case MSR_MTRRfix16K_A0000:
> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> -                        MSR_MTRRfix16K_80000 + 1] = val;
> -        break;
> -    case MSR_MTRRfix4K_C0000:
> -    case MSR_MTRRfix4K_C8000:
> -    case MSR_MTRRfix4K_D0000:
> -    case MSR_MTRRfix4K_D8000:
> -    case MSR_MTRRfix4K_E0000:
> -    case MSR_MTRRfix4K_E8000:
> -    case MSR_MTRRfix4K_F0000:
> -    case MSR_MTRRfix4K_F8000:
> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> -                        MSR_MTRRfix4K_C0000 + 3] = val;
> -        break;
> -    case MSR_MTRRdefType:
> -        env->mtrr_deftype = val;
> -        break;
> -    case MSR_MCG_STATUS:
> -        env->mcg_status = val;
> -        break;
> -    case MSR_MCG_CTL:
> -        if ((env->mcg_cap & MCG_CTL_P)
> -            && (val == 0 || val == ~(uint64_t)0)) {
> -            env->mcg_ctl = val;
> -        }
> -        break;
> -    case MSR_TSC_AUX:
> -        env->tsc_aux = val;
> -        break;
> -    case MSR_IA32_MISC_ENABLE:
> -        env->msr_ia32_misc_enable = val;
> -        break;
> -    case MSR_IA32_BNDCFGS:
> -        /* FIXME: #GP if reserved bits are set.  */
> -        /* FIXME: Extend highest implemented bit of linear address.  */
> -        env->msr_bndcfgs = val;
> -        cpu_sync_bndcs_hflags(env);
> -        break;
> -    default:
> -        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
> -            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
> -            (4 * env->mcg_cap & 0xff)) {
> -            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
> -            if ((offset & 0x3) != 0
> -                || (val == 0 || val == ~(uint64_t)0)) {
> -                env->mce_banks[offset] = val;
> -            }
> -            break;
> -        }
> -        /* XXX: exception? */
> -        break;
> -    }
> +    uint64_t val = m64c->DataValueLow | ((uint64_t) m64c->DataValueHigh) << 32;
> +    cpu_x86_write_msr(env, ldq_p(&val));
>  
>      pd->m64.ReturnStatus = STATUS_SUCCESS;
>  }
> 
> 

Please squash with patch 39 (windbg: implemented kd_api_read_msr and
kd_api_write_msr).

Paolo
