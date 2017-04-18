Received: from eggs.gnu.org ([2001:4830:134:3::10]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Xg4-0008Qv-Sr
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0Xg0-0001BT-RN
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0Xg0-0001B1-EE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:16:32 -0400
Date: Tue, 18 Apr 2017 15:16:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170418181628.GQ25239@thinpad.lan.raisama.net>
References: <20170418073946.4177-1-git@kirschju.re>
	<20170418073946.4177-2-git@kirschju.re>
	<20170418152812.GO25239@thinpad.lan.raisama.net>
	<33c3e271-5934-2040-f45a-72b4d163ffdc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c3e271-5934-2040-f45a-72b4d163ffdc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v4 1/4] X86: Move rdmsr/wrmsr
 functionality to standalone functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Apr 18, 2017 at 05:38:01PM +0200, Paolo Bonzini wrote:
> 
> 
> On 18/04/2017 17:28, Eduardo Habkost wrote:
> > Hi,
> > 
> > A few comments below:
> > 
> > On Tue, Apr 18, 2017 at 09:39:43AM +0200, Julian Kirsch wrote:
> >> Add two new functions to provide read/write access to model specific registers
> >> (MSRs) on x86. Move original functionality to new functions
> >> x86_cpu_[rd|wr]msr.  This enables other parts of the qemu codebase to
> >> read/write MSRs by means of the newly introduced functions. The
> >> helper_[rd|wr]msr functions in misc_helper.c now consist of stubs
> >> extracting the arguments from the current state of the CPU registers and
> >> then pass control to the new functions.
> 
> I didn't receive patches 2-4 so apologies if this is wrong.
> 
> rdmsr/wrmsr should not use the helpers on KVM; it should instead use the
> KVM_GET_MSR and KVM_SET_MSR ioctls.  For HAX there are similar APIs.

This series seems to take a different approach: it get/sets the
MSR value inside X86CPU, and expect it to be synced later by
kvm_put_msrs().

I think both approaches are valid, but this series needs a call
to cpu_synchronize_state() before getting/setting the MSR value
or it won't work correctly.

(On the other hand, if we make the new msr_set/msr_get commands
call KVM_{GET,SET}_MSR directly, then it needs to ensure the VCPU
state isn't dirty first.)

> 
> As a first step, only supporting the new commands on TCG would be fine.
> 
> One possibility is to add a dispatcher function in helper.c
> 
>     if (tcg_enabled()) {
>         return tcg_cpu_wrmsr(env, idx, val, valid);
>     }
>     if (kvm_enabled()) {
>         return kvm_cpu_wrmsr(env, idx, val, valid);
>     }
>     ...
> 
> Paolo
> 
> >> Signed-off-by: Julian Kirsch <git@kirschju.re>
> >> ---
> >>  target/i386/cpu.h         |   3 +
> >>  target/i386/helper.c      | 303 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  target/i386/misc_helper.c | 297 ++-------------------------------------------
> >>  3 files changed, 317 insertions(+), 286 deletions(-)
> >>
> >> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> >> index 07401ad9fe..84b7080ade 100644
> >> --- a/target/i386/cpu.h
> >> +++ b/target/i386/cpu.h
> >> @@ -1310,6 +1310,9 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
> >>  void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
> >>                                  Error **errp);
> >>  
> >> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid);
> >> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid);
> >> +
> >>  void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
> >>                          int flags);
> >>  
> >> diff --git a/target/i386/helper.c b/target/i386/helper.c
> >> index e2af3404f2..9412fd180c 100644
> >> --- a/target/i386/helper.c
> >> +++ b/target/i386/helper.c
> >> @@ -26,6 +26,7 @@
> >>  #include "sysemu/sysemu.h"
> >>  #include "sysemu/hw_accel.h"
> >>  #include "monitor/monitor.h"
> >> +#include "hw/i386/apic.h"
> >>  #include "hw/i386/apic_internal.h"
> >>  #endif
> >>  
> >> @@ -364,11 +365,313 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
> >>      }
> >>      cpu_fprintf(f, " PPR 0x%02x\n", apic_get_ppr(s));
> >>  }
> >> +
> >> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid)
> >> +{
> >> +    *valid = true;
> >> +    /* FIXME: With KVM nabled, only report success if we are sure the new value
> > 
> > Typo: "KVM enabled".
> > 
> >> +     * will actually be written back by the KVM subsystem later. */
> >> +
> >> +    switch (idx) {
> >> +    case MSR_IA32_SYSENTER_CS:
> >> +        env->sysenter_cs = val & 0xffff;
> >> +        break;
> >> +    case MSR_IA32_SYSENTER_ESP:
> >> +        env->sysenter_esp = val;
> >> +        break;
> >> +    case MSR_IA32_SYSENTER_EIP:
> >> +        env->sysenter_eip = val;
> >> +        break;
> >> +    case MSR_IA32_APICBASE:
> >> +        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
> >> +        break;
> >> +    case MSR_EFER:
> >> +        {
> >> +            uint64_t update_mask;
> >> +
> >> +            update_mask = 0;
> >> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_SYSCALL) {
> >> +                update_mask |= MSR_EFER_SCE;
> >> +            }
> >> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> >> +                update_mask |= MSR_EFER_LME;
> >> +            }
> >> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> >> +                update_mask |= MSR_EFER_FFXSR;
> >> +            }
> >> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_NX) {
> >> +                update_mask |= MSR_EFER_NXE;
> >> +            }
> >> +            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> >> +                update_mask |= MSR_EFER_SVME;
> >> +            }
> >> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> >> +                update_mask |= MSR_EFER_FFXSR;
> >> +            }
> >> +            cpu_load_efer(env, (env->efer & ~update_mask) |
> >> +                          (val & update_mask));
> >> +        }
> >> +        break;
> >> +    case MSR_STAR:
> >> +        env->star = val;
> >> +        break;
> >> +    case MSR_PAT:
> >> +        env->pat = val;
> >> +        break;
> >> +    case MSR_VM_HSAVE_PA:
> >> +        env->vm_hsave = val;
> >> +        break;
> >> +#ifdef TARGET_X86_64
> >> +    case MSR_LSTAR:
> >> +        env->lstar = val;
> >> +        break;
> >> +    case MSR_CSTAR:
> >> +        env->cstar = val;
> >> +        break;
> >> +    case MSR_FMASK:
> >> +        env->fmask = val;
> >> +        break;
> >> +    case MSR_FSBASE:
> >> +        env->segs[R_FS].base = val;
> >> +        break;
> >> +    case MSR_GSBASE:
> >> +        env->segs[R_GS].base = val;
> >> +        break;
> >> +    case MSR_KERNELGSBASE:
> >> +        env->kernelgsbase = val;
> >> +        break;
> >> +#endif
> >> +    case MSR_MTRRphysBase(0):
> >> +    case MSR_MTRRphysBase(1):
> >> +    case MSR_MTRRphysBase(2):
> >> +    case MSR_MTRRphysBase(3):
> >> +    case MSR_MTRRphysBase(4):
> >> +    case MSR_MTRRphysBase(5):
> >> +    case MSR_MTRRphysBase(6):
> >> +    case MSR_MTRRphysBase(7):
> >> +        env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base = val;
> >> +        break;
> >> +    case MSR_MTRRphysMask(0):
> >> +    case MSR_MTRRphysMask(1):
> >> +    case MSR_MTRRphysMask(2):
> >> +    case MSR_MTRRphysMask(3):
> >> +    case MSR_MTRRphysMask(4):
> >> +    case MSR_MTRRphysMask(5):
> >> +    case MSR_MTRRphysMask(6):
> >> +    case MSR_MTRRphysMask(7):
> >> +        env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask = val;
> >> +        break;
> >> +    case MSR_MTRRfix64K_00000:
> >> +        env->mtrr_fixed[idx - MSR_MTRRfix64K_00000] = val;
> >> +        break;
> >> +    case MSR_MTRRfix16K_80000:
> >> +    case MSR_MTRRfix16K_A0000:
> >> +        env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1] = val;
> >> +        break;
> >> +    case MSR_MTRRfix4K_C0000:
> >> +    case MSR_MTRRfix4K_C8000:
> >> +    case MSR_MTRRfix4K_D0000:
> >> +    case MSR_MTRRfix4K_D8000:
> >> +    case MSR_MTRRfix4K_E0000:
> >> +    case MSR_MTRRfix4K_E8000:
> >> +    case MSR_MTRRfix4K_F0000:
> >> +    case MSR_MTRRfix4K_F8000:
> >> +        env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3] = val;
> >> +        break;
> >> +    case MSR_MTRRdefType:
> >> +        env->mtrr_deftype = val;
> >> +        break;
> >> +    case MSR_MCG_STATUS:
> >> +        env->mcg_status = val;
> >> +        break;
> >> +    case MSR_MCG_CTL:
> >> +        if ((env->mcg_cap & MCG_CTL_P)
> >> +            && (val == 0 || val == ~(uint64_t)0)) {
> >> +            env->mcg_ctl = val;
> >> +        }
> > 
> > [***]
> > 
> > Should we set *valid = false if MCG_CTL_P is not set?
> > 
> > Should we set *valid = false if 'val' is invalid?
> > 
> > 
> >> +        break;
> >> +    case MSR_TSC_AUX:
> >> +        env->tsc_aux = val;
> >> +        break;
> >> +    case MSR_IA32_MISC_ENABLE:
> >> +        env->msr_ia32_misc_enable = val;
> >> +        break;
> >> +    case MSR_IA32_BNDCFGS:
> >> +        /* FIXME: #GP if reserved bits are set.  */
> >> +        /* FIXME: Extend highest implemented bit of linear address.  */
> >> +        env->msr_bndcfgs = val;
> >> +        cpu_sync_bndcs_hflags(env);
> >> +        break;
> >> +    default:
> >> +        *valid = false;
> > 
> > [*]
> > 
> >> +        if (idx >= MSR_MC0_CTL && idx < MSR_MC0_CTL +
> >> +            (4 * env->mcg_cap & 0xff)) {
> >> +            uint32_t offset = idx - MSR_MC0_CTL;
> >> +            if ((offset & 0x3) != 0
> >> +                || (val == 0 || val == ~(uint64_t)0)) {
> >> +                env->mce_banks[offset] = val;
> >> +                *valid = true;
> > 
> > [**]
> > 
> >> +            }
> >> +            break;
> >> +        }
> > 
> > If you set *valid = false here instead of setting it above[*],
> > you don't need to set *valid = true again above[**].
> > 
> > I don't know if we should set *valid = false if 'val' is invalid,
> > though. You might want to move the 'break' statement to [**] to
> > keep the behavior of this patch.
> > 
> > 
> >> +        break;
> >> +    }
> >> +}
> >> +
> >> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
> >> +{
> >> +    uint64_t val;
> >> +    *valid = true;
> >> +
> >> +    switch (idx) {
> >> +    case MSR_IA32_SYSENTER_CS:
> >> +        val = env->sysenter_cs;
> >> +        break;
> >> +    case MSR_IA32_SYSENTER_ESP:
> >> +        val = env->sysenter_esp;
> >> +        break;
> >> +    case MSR_IA32_SYSENTER_EIP:
> >> +        val = env->sysenter_eip;
> >> +        break;
> >> +    case MSR_IA32_APICBASE:
> >> +        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
> >> +        break;
> >> +    case MSR_EFER:
> >> +        val = env->efer;
> >> +        break;
> >> +    case MSR_STAR:
> >> +        val = env->star;
> >> +        break;
> >> +    case MSR_PAT:
> >> +        val = env->pat;
> >> +        break;
> >> +    case MSR_VM_HSAVE_PA:
> >> +        val = env->vm_hsave;
> >> +        break;
> >> +    case MSR_IA32_PERF_STATUS:
> >> +        /* tsc_increment_by_tick */
> >> +        val = 1000ULL;
> >> +        /* CPU multiplier */
> >> +        val |= (((uint64_t)4ULL) << 40);
> >> +        break;
> >> +#ifdef TARGET_X86_64
> >> +    case MSR_LSTAR:
> >> +        val = env->lstar;
> >> +        break;
> >> +    case MSR_CSTAR:
> >> +        val = env->cstar;
> >> +        break;
> >> +    case MSR_FMASK:
> >> +        val = env->fmask;
> >> +        break;
> >> +    case MSR_FSBASE:
> >> +        val = env->segs[R_FS].base;
> >> +        break;
> >> +    case MSR_GSBASE:
> >> +        val = env->segs[R_GS].base;
> >> +        break;
> >> +    case MSR_KERNELGSBASE:
> >> +        val = env->kernelgsbase;
> >> +        break;
> >> +    case MSR_TSC_AUX:
> >> +        val = env->tsc_aux;
> >> +        break;
> >> +#endif
> >> +    case MSR_MTRRphysBase(0):
> >> +    case MSR_MTRRphysBase(1):
> >> +    case MSR_MTRRphysBase(2):
> >> +    case MSR_MTRRphysBase(3):
> >> +    case MSR_MTRRphysBase(4):
> >> +    case MSR_MTRRphysBase(5):
> >> +    case MSR_MTRRphysBase(6):
> >> +    case MSR_MTRRphysBase(7):
> >> +        val = env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base;
> >> +        break;
> >> +    case MSR_MTRRphysMask(0):
> >> +    case MSR_MTRRphysMask(1):
> >> +    case MSR_MTRRphysMask(2):
> >> +    case MSR_MTRRphysMask(3):
> >> +    case MSR_MTRRphysMask(4):
> >> +    case MSR_MTRRphysMask(5):
> >> +    case MSR_MTRRphysMask(6):
> >> +    case MSR_MTRRphysMask(7):
> >> +        val = env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask;
> >> +        break;
> >> +    case MSR_MTRRfix64K_00000:
> >> +        val = env->mtrr_fixed[0];
> >> +        break;
> >> +    case MSR_MTRRfix16K_80000:
> >> +    case MSR_MTRRfix16K_A0000:
> >> +        val = env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1];
> >> +        break;
> >> +    case MSR_MTRRfix4K_C0000:
> >> +    case MSR_MTRRfix4K_C8000:
> >> +    case MSR_MTRRfix4K_D0000:
> >> +    case MSR_MTRRfix4K_D8000:
> >> +    case MSR_MTRRfix4K_E0000:
> >> +    case MSR_MTRRfix4K_E8000:
> >> +    case MSR_MTRRfix4K_F0000:
> >> +    case MSR_MTRRfix4K_F8000:
> >> +        val = env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3];
> >> +        break;
> >> +    case MSR_MTRRdefType:
> >> +        val = env->mtrr_deftype;
> >> +        break;
> >> +    case MSR_MTRRcap:
> >> +        if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
> >> +            val = MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
> >> +                MSR_MTRRcap_WC_SUPPORTED;
> >> +        } else {
> >> +            *valid = false;
> >> +            val = 0;
> > 
> > This had a "XXX: exception?" comment on the original code, so I
> > guess this matches the original intention behind it.
> > 
> >> +        }
> >> +        break;
> >> +    case MSR_MCG_CAP:
> >> +        val = env->mcg_cap;
> >> +        break;
> >> +    case MSR_MCG_CTL:
> >> +        if (env->mcg_cap & MCG_CTL_P) {
> >> +            val = env->mcg_ctl;
> >> +        } else {
> >> +            *valid = false;
> >> +            val = 0;
> > 
> > I understand the intention behind setting *valid = false here,
> > but the existing kvm_put_msrs() code tries to set MSR_MCG_CTL
> > even if (mcg_cap & MCG_CTL_P) is not set. We need to keep that in
> > mind if we convert kvm_{get,put}_msrs() to use the wrmsr/rdmsr
> > helpers.
> > 
> > Also, if x86_cpu_rdmsr() is set *valid = false here, we probably
> > should set *valid = false at x86_cpu_wrmsr() too[***} for
> > consistency.
> > 
> >> +        }
> >> +        break;
> >> +    case MSR_MCG_STATUS:
> >> +        val = env->mcg_status;
> >> +        break;
> >> +    case MSR_IA32_MISC_ENABLE:
> >> +        val = env->msr_ia32_misc_enable;
> >> +        break;
> >> +    case MSR_IA32_BNDCFGS:
> >> +        val = env->msr_bndcfgs;
> >> +        break;
> >> +    default:
> >> +        if (idx >= MSR_MC0_CTL && idx < MSR_MC0_CTL +
> >> +            (4 * env->mcg_cap & 0xff)) {
> >> +            val = env->mce_banks[idx - MSR_MC0_CTL];
> > 
> > The original helper_rdmsr() code had a "offset" variable. Not
> > important, as the new code is equivalent, but it would make the
> > equivalency between x86_cpu_rdmsr() and x86_cpu_wrmsr() more
> > visible.
> > 
> >> +            break;
> >> +        }
> >> +        *valid = false;
> >> +        val = 0;
> >> +        break;
> >> +    }
> >> +    return val;
> >> +}
> >>  #else
> >>  void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
> >>                                     fprintf_function cpu_fprintf, int flags)
> >>  {
> >>  }
> >> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid)
> >> +{
> >> +    *valid = false;
> >> +}
> >> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
> >> +{
> >> +    *valid = false;
> >> +    return 0ULL;
> >> +}
> >>  #endif /* !CONFIG_USER_ONLY */
> >>  
> >>  #define DUMP_CODE_BYTES_TOTAL    50
> >> diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
> >> index ca2ea09f54..fbbf9d146e 100644
> >> --- a/target/i386/misc_helper.c
> >> +++ b/target/i386/misc_helper.c
> >> @@ -227,307 +227,32 @@ void helper_rdmsr(CPUX86State *env)
> >>  void helper_wrmsr(CPUX86State *env)
> >>  {
> >>      uint64_t val;
> >> +    bool res_valid;
> >>  
> >>      cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
> >>  
> >>      val = ((uint32_t)env->regs[R_EAX]) |
> >>          ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
> >>  
> >> -    switch ((uint32_t)env->regs[R_ECX]) {
> >> -    case MSR_IA32_SYSENTER_CS:
> >> -        env->sysenter_cs = val & 0xffff;
> >> -        break;
> >> -    case MSR_IA32_SYSENTER_ESP:
> >> -        env->sysenter_esp = val;
> >> -        break;
> >> -    case MSR_IA32_SYSENTER_EIP:
> >> -        env->sysenter_eip = val;
> >> -        break;
> >> -    case MSR_IA32_APICBASE:
> >> -        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
> >> -        break;
> >> -    case MSR_EFER:
> >> -        {
> >> -            uint64_t update_mask;
> >> +    x86_cpu_wrmsr(env, (uint32_t)env->regs[R_ECX], val, &res_valid);
> >> +
> >> +    /* XXX: exception? */
> >> +    if (!res_valid) { }
> >>  
> >> -            update_mask = 0;
> >> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_SYSCALL) {
> >> -                update_mask |= MSR_EFER_SCE;
> >> -            }
> >> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> >> -                update_mask |= MSR_EFER_LME;
> >> -            }
> >> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> >> -                update_mask |= MSR_EFER_FFXSR;
> >> -            }
> >> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_NX) {
> >> -                update_mask |= MSR_EFER_NXE;
> >> -            }
> >> -            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> >> -                update_mask |= MSR_EFER_SVME;
> >> -            }
> >> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> >> -                update_mask |= MSR_EFER_FFXSR;
> >> -            }
> >> -            cpu_load_efer(env, (env->efer & ~update_mask) |
> >> -                          (val & update_mask));
> >> -        }
> >> -        break;
> >> -    case MSR_STAR:
> >> -        env->star = val;
> >> -        break;
> >> -    case MSR_PAT:
> >> -        env->pat = val;
> >> -        break;
> >> -    case MSR_VM_HSAVE_PA:
> >> -        env->vm_hsave = val;
> >> -        break;
> >> -#ifdef TARGET_X86_64
> >> -    case MSR_LSTAR:
> >> -        env->lstar = val;
> >> -        break;
> >> -    case MSR_CSTAR:
> >> -        env->cstar = val;
> >> -        break;
> >> -    case MSR_FMASK:
> >> -        env->fmask = val;
> >> -        break;
> >> -    case MSR_FSBASE:
> >> -        env->segs[R_FS].base = val;
> >> -        break;
> >> -    case MSR_GSBASE:
> >> -        env->segs[R_GS].base = val;
> >> -        break;
> >> -    case MSR_KERNELGSBASE:
> >> -        env->kernelgsbase = val;
> >> -        break;
> >> -#endif
> >> -    case MSR_MTRRphysBase(0):
> >> -    case MSR_MTRRphysBase(1):
> >> -    case MSR_MTRRphysBase(2):
> >> -    case MSR_MTRRphysBase(3):
> >> -    case MSR_MTRRphysBase(4):
> >> -    case MSR_MTRRphysBase(5):
> >> -    case MSR_MTRRphysBase(6):
> >> -    case MSR_MTRRphysBase(7):
> >> -        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> >> -                       MSR_MTRRphysBase(0)) / 2].base = val;
> >> -        break;
> >> -    case MSR_MTRRphysMask(0):
> >> -    case MSR_MTRRphysMask(1):
> >> -    case MSR_MTRRphysMask(2):
> >> -    case MSR_MTRRphysMask(3):
> >> -    case MSR_MTRRphysMask(4):
> >> -    case MSR_MTRRphysMask(5):
> >> -    case MSR_MTRRphysMask(6):
> >> -    case MSR_MTRRphysMask(7):
> >> -        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> >> -                       MSR_MTRRphysMask(0)) / 2].mask = val;
> >> -        break;
> >> -    case MSR_MTRRfix64K_00000:
> >> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> >> -                        MSR_MTRRfix64K_00000] = val;
> >> -        break;
> >> -    case MSR_MTRRfix16K_80000:
> >> -    case MSR_MTRRfix16K_A0000:
> >> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> >> -                        MSR_MTRRfix16K_80000 + 1] = val;
> >> -        break;
> >> -    case MSR_MTRRfix4K_C0000:
> >> -    case MSR_MTRRfix4K_C8000:
> >> -    case MSR_MTRRfix4K_D0000:
> >> -    case MSR_MTRRfix4K_D8000:
> >> -    case MSR_MTRRfix4K_E0000:
> >> -    case MSR_MTRRfix4K_E8000:
> >> -    case MSR_MTRRfix4K_F0000:
> >> -    case MSR_MTRRfix4K_F8000:
> >> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> >> -                        MSR_MTRRfix4K_C0000 + 3] = val;
> >> -        break;
> >> -    case MSR_MTRRdefType:
> >> -        env->mtrr_deftype = val;
> >> -        break;
> >> -    case MSR_MCG_STATUS:
> >> -        env->mcg_status = val;
> >> -        break;
> >> -    case MSR_MCG_CTL:
> >> -        if ((env->mcg_cap & MCG_CTL_P)
> >> -            && (val == 0 || val == ~(uint64_t)0)) {
> >> -            env->mcg_ctl = val;
> >> -        }
> >> -        break;
> >> -    case MSR_TSC_AUX:
> >> -        env->tsc_aux = val;
> >> -        break;
> >> -    case MSR_IA32_MISC_ENABLE:
> >> -        env->msr_ia32_misc_enable = val;
> >> -        break;
> >> -    case MSR_IA32_BNDCFGS:
> >> -        /* FIXME: #GP if reserved bits are set.  */
> >> -        /* FIXME: Extend highest implemented bit of linear address.  */
> >> -        env->msr_bndcfgs = val;
> >> -        cpu_sync_bndcs_hflags(env);
> >> -        break;
> >> -    default:
> >> -        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
> >> -            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
> >> -            (4 * env->mcg_cap & 0xff)) {
> >> -            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
> >> -            if ((offset & 0x3) != 0
> >> -                || (val == 0 || val == ~(uint64_t)0)) {
> >> -                env->mce_banks[offset] = val;
> >> -            }
> >> -            break;
> >> -        }
> >> -        /* XXX: exception? */
> >> -        break;
> >> -    }
> >>  }
> >>  
> >>  void helper_rdmsr(CPUX86State *env)
> >>  {
> >>      uint64_t val;
> >> +    bool res_valid;
> >>  
> >>      cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
> >>  
> >> -    switch ((uint32_t)env->regs[R_ECX]) {
> >> -    case MSR_IA32_SYSENTER_CS:
> >> -        val = env->sysenter_cs;
> >> -        break;
> >> -    case MSR_IA32_SYSENTER_ESP:
> >> -        val = env->sysenter_esp;
> >> -        break;
> >> -    case MSR_IA32_SYSENTER_EIP:
> >> -        val = env->sysenter_eip;
> >> -        break;
> >> -    case MSR_IA32_APICBASE:
> >> -        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
> >> -        break;
> >> -    case MSR_EFER:
> >> -        val = env->efer;
> >> -        break;
> >> -    case MSR_STAR:
> >> -        val = env->star;
> >> -        break;
> >> -    case MSR_PAT:
> >> -        val = env->pat;
> >> -        break;
> >> -    case MSR_VM_HSAVE_PA:
> >> -        val = env->vm_hsave;
> >> -        break;
> >> -    case MSR_IA32_PERF_STATUS:
> >> -        /* tsc_increment_by_tick */
> >> -        val = 1000ULL;
> >> -        /* CPU multiplier */
> >> -        val |= (((uint64_t)4ULL) << 40);
> >> -        break;
> >> -#ifdef TARGET_X86_64
> >> -    case MSR_LSTAR:
> >> -        val = env->lstar;
> >> -        break;
> >> -    case MSR_CSTAR:
> >> -        val = env->cstar;
> >> -        break;
> >> -    case MSR_FMASK:
> >> -        val = env->fmask;
> >> -        break;
> >> -    case MSR_FSBASE:
> >> -        val = env->segs[R_FS].base;
> >> -        break;
> >> -    case MSR_GSBASE:
> >> -        val = env->segs[R_GS].base;
> >> -        break;
> >> -    case MSR_KERNELGSBASE:
> >> -        val = env->kernelgsbase;
> >> -        break;
> >> -    case MSR_TSC_AUX:
> >> -        val = env->tsc_aux;
> >> -        break;
> >> -#endif
> >> -    case MSR_MTRRphysBase(0):
> >> -    case MSR_MTRRphysBase(1):
> >> -    case MSR_MTRRphysBase(2):
> >> -    case MSR_MTRRphysBase(3):
> >> -    case MSR_MTRRphysBase(4):
> >> -    case MSR_MTRRphysBase(5):
> >> -    case MSR_MTRRphysBase(6):
> >> -    case MSR_MTRRphysBase(7):
> >> -        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> >> -                             MSR_MTRRphysBase(0)) / 2].base;
> >> -        break;
> >> -    case MSR_MTRRphysMask(0):
> >> -    case MSR_MTRRphysMask(1):
> >> -    case MSR_MTRRphysMask(2):
> >> -    case MSR_MTRRphysMask(3):
> >> -    case MSR_MTRRphysMask(4):
> >> -    case MSR_MTRRphysMask(5):
> >> -    case MSR_MTRRphysMask(6):
> >> -    case MSR_MTRRphysMask(7):
> >> -        val = env->mtrr_var[((uint32_t)env->regs[R_ECX] -
> >> -                             MSR_MTRRphysMask(0)) / 2].mask;
> >> -        break;
> >> -    case MSR_MTRRfix64K_00000:
> >> -        val = env->mtrr_fixed[0];
> >> -        break;
> >> -    case MSR_MTRRfix16K_80000:
> >> -    case MSR_MTRRfix16K_A0000:
> >> -        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> >> -                              MSR_MTRRfix16K_80000 + 1];
> >> -        break;
> >> -    case MSR_MTRRfix4K_C0000:
> >> -    case MSR_MTRRfix4K_C8000:
> >> -    case MSR_MTRRfix4K_D0000:
> >> -    case MSR_MTRRfix4K_D8000:
> >> -    case MSR_MTRRfix4K_E0000:
> >> -    case MSR_MTRRfix4K_E8000:
> >> -    case MSR_MTRRfix4K_F0000:
> >> -    case MSR_MTRRfix4K_F8000:
> >> -        val = env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
> >> -                              MSR_MTRRfix4K_C0000 + 3];
> >> -        break;
> >> -    case MSR_MTRRdefType:
> >> -        val = env->mtrr_deftype;
> >> -        break;
> >> -    case MSR_MTRRcap:
> >> -        if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
> >> -            val = MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
> >> -                MSR_MTRRcap_WC_SUPPORTED;
> >> -        } else {
> >> -            /* XXX: exception? */
> >> -            val = 0;
> >> -        }
> >> -        break;
> >> -    case MSR_MCG_CAP:
> >> -        val = env->mcg_cap;
> >> -        break;
> >> -    case MSR_MCG_CTL:
> >> -        if (env->mcg_cap & MCG_CTL_P) {
> >> -            val = env->mcg_ctl;
> >> -        } else {
> >> -            val = 0;
> >> -        }
> >> -        break;
> >> -    case MSR_MCG_STATUS:
> >> -        val = env->mcg_status;
> >> -        break;
> >> -    case MSR_IA32_MISC_ENABLE:
> >> -        val = env->msr_ia32_misc_enable;
> >> -        break;
> >> -    case MSR_IA32_BNDCFGS:
> >> -        val = env->msr_bndcfgs;
> >> -        break;
> >> -    default:
> >> -        if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
> >> -            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
> >> -            (4 * env->mcg_cap & 0xff)) {
> >> -            uint32_t offset = (uint32_t)env->regs[R_ECX] - MSR_MC0_CTL;
> >> -            val = env->mce_banks[offset];
> >> -            break;
> >> -        }
> >> -        /* XXX: exception? */
> >> -        val = 0;
> >> -        break;
> >> -    }
> >> +    val = x86_cpu_rdmsr(env, (uint32_t)env->regs[R_ECX], &res_valid);
> >> +
> >> +    /* XXX: exception? */
> >> +    if (!res_valid) { }
> >> +
> >>      env->regs[R_EAX] = (uint32_t)(val);
> >>      env->regs[R_EDX] = (uint32_t)(val >> 32);
> >>  }
> >> -- 
> >> 2.11.0
> >>
> > 

-- 
Eduardo
