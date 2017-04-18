Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0VCm-0005Df-Ly
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0VCj-0005rI-3w
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:38:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0VCi-0005qa-Nv
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:38:09 -0400
References: <20170418073946.4177-1-git@kirschju.re>
	<20170418073946.4177-2-git@kirschju.re>
	<20170418152812.GO25239@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33c3e271-5934-2040-f45a-72b4d163ffdc@redhat.com>
Date: Tue, 18 Apr 2017 17:38:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170418152812.GO25239@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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
To: Eduardo Habkost <ehabkost@redhat.com>, Julian Kirsch <git@kirschju.re>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>



On 18/04/2017 17:28, Eduardo Habkost wrote:
> Hi,
>=20
> A few comments below:
>=20
> On Tue, Apr 18, 2017 at 09:39:43AM +0200, Julian Kirsch wrote:
>> Add two new functions to provide read/write access to model specific r=
egisters
>> (MSRs) on x86. Move original functionality to new functions
>> x86_cpu_[rd|wr]msr.  This enables other parts of the qemu codebase to
>> read/write MSRs by means of the newly introduced functions. The
>> helper_[rd|wr]msr functions in misc_helper.c now consist of stubs
>> extracting the arguments from the current state of the CPU registers a=
nd
>> then pass control to the new functions.

I didn't receive patches 2-4 so apologies if this is wrong.

rdmsr/wrmsr should not use the helpers on KVM; it should instead use the
KVM_GET_MSR and KVM_SET_MSR ioctls.  For HAX there are similar APIs.

As a first step, only supporting the new commands on TCG would be fine.

One possibility is to add a dispatcher function in helper.c

    if (tcg_enabled()) {
        return tcg_cpu_wrmsr(env, idx, val, valid);
    }
    if (kvm_enabled()) {
        return kvm_cpu_wrmsr(env, idx, val, valid);
    }
    ...

Paolo

>> Signed-off-by: Julian Kirsch <git@kirschju.re>
>> ---
>>  target/i386/cpu.h         |   3 +
>>  target/i386/helper.c      | 303 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>  target/i386/misc_helper.c | 297 ++-----------------------------------=
--------
>>  3 files changed, 317 insertions(+), 286 deletions(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 07401ad9fe..84b7080ade 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1310,6 +1310,9 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFu=
nction f, CPUState *cpu,
>>  void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *lis=
t,
>>                                  Error **errp);
>> =20
>> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid);
>> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool=
 *valid);
>> +
>>  void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_f=
printf,
>>                          int flags);
>> =20
>> diff --git a/target/i386/helper.c b/target/i386/helper.c
>> index e2af3404f2..9412fd180c 100644
>> --- a/target/i386/helper.c
>> +++ b/target/i386/helper.c
>> @@ -26,6 +26,7 @@
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/hw_accel.h"
>>  #include "monitor/monitor.h"
>> +#include "hw/i386/apic.h"
>>  #include "hw/i386/apic_internal.h"
>>  #endif
>> =20
>> @@ -364,11 +365,313 @@ void x86_cpu_dump_local_apic_state(CPUState *cs=
, FILE *f,
>>      }
>>      cpu_fprintf(f, " PPR 0x%02x\n", apic_get_ppr(s));
>>  }
>> +
>> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool=
 *valid)
>> +{
>> +    *valid =3D true;
>> +    /* FIXME: With KVM nabled, only report success if we are sure the=
 new value
>=20
> Typo: "KVM enabled".
>=20
>> +     * will actually be written back by the KVM subsystem later. */
>> +
>> +    switch (idx) {
>> +    case MSR_IA32_SYSENTER_CS:
>> +        env->sysenter_cs =3D val & 0xffff;
>> +        break;
>> +    case MSR_IA32_SYSENTER_ESP:
>> +        env->sysenter_esp =3D val;
>> +        break;
>> +    case MSR_IA32_SYSENTER_EIP:
>> +        env->sysenter_eip =3D val;
>> +        break;
>> +    case MSR_IA32_APICBASE:
>> +        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
>> +        break;
>> +    case MSR_EFER:
>> +        {
>> +            uint64_t update_mask;
>> +
>> +            update_mask =3D 0;
>> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_SYSCAL=
L) {
>> +                update_mask |=3D MSR_EFER_SCE;
>> +            }
>> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>> +                update_mask |=3D MSR_EFER_LME;
>> +            }
>> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR)=
 {
>> +                update_mask |=3D MSR_EFER_FFXSR;
>> +            }
>> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_NX) {
>> +                update_mask |=3D MSR_EFER_NXE;
>> +            }
>> +            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>> +                update_mask |=3D MSR_EFER_SVME;
>> +            }
>> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR)=
 {
>> +                update_mask |=3D MSR_EFER_FFXSR;
>> +            }
>> +            cpu_load_efer(env, (env->efer & ~update_mask) |
>> +                          (val & update_mask));
>> +        }
>> +        break;
>> +    case MSR_STAR:
>> +        env->star =3D val;
>> +        break;
>> +    case MSR_PAT:
>> +        env->pat =3D val;
>> +        break;
>> +    case MSR_VM_HSAVE_PA:
>> +        env->vm_hsave =3D val;
>> +        break;
>> +#ifdef TARGET_X86_64
>> +    case MSR_LSTAR:
>> +        env->lstar =3D val;
>> +        break;
>> +    case MSR_CSTAR:
>> +        env->cstar =3D val;
>> +        break;
>> +    case MSR_FMASK:
>> +        env->fmask =3D val;
>> +        break;
>> +    case MSR_FSBASE:
>> +        env->segs[R_FS].base =3D val;
>> +        break;
>> +    case MSR_GSBASE:
>> +        env->segs[R_GS].base =3D val;
>> +        break;
>> +    case MSR_KERNELGSBASE:
>> +        env->kernelgsbase =3D val;
>> +        break;
>> +#endif
>> +    case MSR_MTRRphysBase(0):
>> +    case MSR_MTRRphysBase(1):
>> +    case MSR_MTRRphysBase(2):
>> +    case MSR_MTRRphysBase(3):
>> +    case MSR_MTRRphysBase(4):
>> +    case MSR_MTRRphysBase(5):
>> +    case MSR_MTRRphysBase(6):
>> +    case MSR_MTRRphysBase(7):
>> +        env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base =3D val;
>> +        break;
>> +    case MSR_MTRRphysMask(0):
>> +    case MSR_MTRRphysMask(1):
>> +    case MSR_MTRRphysMask(2):
>> +    case MSR_MTRRphysMask(3):
>> +    case MSR_MTRRphysMask(4):
>> +    case MSR_MTRRphysMask(5):
>> +    case MSR_MTRRphysMask(6):
>> +    case MSR_MTRRphysMask(7):
>> +        env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask =3D val;
>> +        break;
>> +    case MSR_MTRRfix64K_00000:
>> +        env->mtrr_fixed[idx - MSR_MTRRfix64K_00000] =3D val;
>> +        break;
>> +    case MSR_MTRRfix16K_80000:
>> +    case MSR_MTRRfix16K_A0000:
>> +        env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1] =3D val;
>> +        break;
>> +    case MSR_MTRRfix4K_C0000:
>> +    case MSR_MTRRfix4K_C8000:
>> +    case MSR_MTRRfix4K_D0000:
>> +    case MSR_MTRRfix4K_D8000:
>> +    case MSR_MTRRfix4K_E0000:
>> +    case MSR_MTRRfix4K_E8000:
>> +    case MSR_MTRRfix4K_F0000:
>> +    case MSR_MTRRfix4K_F8000:
>> +        env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3] =3D val;
>> +        break;
>> +    case MSR_MTRRdefType:
>> +        env->mtrr_deftype =3D val;
>> +        break;
>> +    case MSR_MCG_STATUS:
>> +        env->mcg_status =3D val;
>> +        break;
>> +    case MSR_MCG_CTL:
>> +        if ((env->mcg_cap & MCG_CTL_P)
>> +            && (val =3D=3D 0 || val =3D=3D ~(uint64_t)0)) {
>> +            env->mcg_ctl =3D val;
>> +        }
>=20
> [***]
>=20
> Should we set *valid =3D false if MCG_CTL_P is not set?
>=20
> Should we set *valid =3D false if 'val' is invalid?
>=20
>=20
>> +        break;
>> +    case MSR_TSC_AUX:
>> +        env->tsc_aux =3D val;
>> +        break;
>> +    case MSR_IA32_MISC_ENABLE:
>> +        env->msr_ia32_misc_enable =3D val;
>> +        break;
>> +    case MSR_IA32_BNDCFGS:
>> +        /* FIXME: #GP if reserved bits are set.  */
>> +        /* FIXME: Extend highest implemented bit of linear address.  =
*/
>> +        env->msr_bndcfgs =3D val;
>> +        cpu_sync_bndcs_hflags(env);
>> +        break;
>> +    default:
>> +        *valid =3D false;
>=20
> [*]
>=20
>> +        if (idx >=3D MSR_MC0_CTL && idx < MSR_MC0_CTL +
>> +            (4 * env->mcg_cap & 0xff)) {
>> +            uint32_t offset =3D idx - MSR_MC0_CTL;
>> +            if ((offset & 0x3) !=3D 0
>> +                || (val =3D=3D 0 || val =3D=3D ~(uint64_t)0)) {
>> +                env->mce_banks[offset] =3D val;
>> +                *valid =3D true;
>=20
> [**]
>=20
>> +            }
>> +            break;
>> +        }
>=20
> If you set *valid =3D false here instead of setting it above[*],
> you don't need to set *valid =3D true again above[**].
>=20
> I don't know if we should set *valid =3D false if 'val' is invalid,
> though. You might want to move the 'break' statement to [**] to
> keep the behavior of this patch.
>=20
>=20
>> +        break;
>> +    }
>> +}
>> +
>> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
>> +{
>> +    uint64_t val;
>> +    *valid =3D true;
>> +
>> +    switch (idx) {
>> +    case MSR_IA32_SYSENTER_CS:
>> +        val =3D env->sysenter_cs;
>> +        break;
>> +    case MSR_IA32_SYSENTER_ESP:
>> +        val =3D env->sysenter_esp;
>> +        break;
>> +    case MSR_IA32_SYSENTER_EIP:
>> +        val =3D env->sysenter_eip;
>> +        break;
>> +    case MSR_IA32_APICBASE:
>> +        val =3D cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
>> +        break;
>> +    case MSR_EFER:
>> +        val =3D env->efer;
>> +        break;
>> +    case MSR_STAR:
>> +        val =3D env->star;
>> +        break;
>> +    case MSR_PAT:
>> +        val =3D env->pat;
>> +        break;
>> +    case MSR_VM_HSAVE_PA:
>> +        val =3D env->vm_hsave;
>> +        break;
>> +    case MSR_IA32_PERF_STATUS:
>> +        /* tsc_increment_by_tick */
>> +        val =3D 1000ULL;
>> +        /* CPU multiplier */
>> +        val |=3D (((uint64_t)4ULL) << 40);
>> +        break;
>> +#ifdef TARGET_X86_64
>> +    case MSR_LSTAR:
>> +        val =3D env->lstar;
>> +        break;
>> +    case MSR_CSTAR:
>> +        val =3D env->cstar;
>> +        break;
>> +    case MSR_FMASK:
>> +        val =3D env->fmask;
>> +        break;
>> +    case MSR_FSBASE:
>> +        val =3D env->segs[R_FS].base;
>> +        break;
>> +    case MSR_GSBASE:
>> +        val =3D env->segs[R_GS].base;
>> +        break;
>> +    case MSR_KERNELGSBASE:
>> +        val =3D env->kernelgsbase;
>> +        break;
>> +    case MSR_TSC_AUX:
>> +        val =3D env->tsc_aux;
>> +        break;
>> +#endif
>> +    case MSR_MTRRphysBase(0):
>> +    case MSR_MTRRphysBase(1):
>> +    case MSR_MTRRphysBase(2):
>> +    case MSR_MTRRphysBase(3):
>> +    case MSR_MTRRphysBase(4):
>> +    case MSR_MTRRphysBase(5):
>> +    case MSR_MTRRphysBase(6):
>> +    case MSR_MTRRphysBase(7):
>> +        val =3D env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base;
>> +        break;
>> +    case MSR_MTRRphysMask(0):
>> +    case MSR_MTRRphysMask(1):
>> +    case MSR_MTRRphysMask(2):
>> +    case MSR_MTRRphysMask(3):
>> +    case MSR_MTRRphysMask(4):
>> +    case MSR_MTRRphysMask(5):
>> +    case MSR_MTRRphysMask(6):
>> +    case MSR_MTRRphysMask(7):
>> +        val =3D env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask;
>> +        break;
>> +    case MSR_MTRRfix64K_00000:
>> +        val =3D env->mtrr_fixed[0];
>> +        break;
>> +    case MSR_MTRRfix16K_80000:
>> +    case MSR_MTRRfix16K_A0000:
>> +        val =3D env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1];
>> +        break;
>> +    case MSR_MTRRfix4K_C0000:
>> +    case MSR_MTRRfix4K_C8000:
>> +    case MSR_MTRRfix4K_D0000:
>> +    case MSR_MTRRfix4K_D8000:
>> +    case MSR_MTRRfix4K_E0000:
>> +    case MSR_MTRRfix4K_E8000:
>> +    case MSR_MTRRfix4K_F0000:
>> +    case MSR_MTRRfix4K_F8000:
>> +        val =3D env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3];
>> +        break;
>> +    case MSR_MTRRdefType:
>> +        val =3D env->mtrr_deftype;
>> +        break;
>> +    case MSR_MTRRcap:
>> +        if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
>> +            val =3D MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
>> +                MSR_MTRRcap_WC_SUPPORTED;
>> +        } else {
>> +            *valid =3D false;
>> +            val =3D 0;
>=20
> This had a "XXX: exception?" comment on the original code, so I
> guess this matches the original intention behind it.
>=20
>> +        }
>> +        break;
>> +    case MSR_MCG_CAP:
>> +        val =3D env->mcg_cap;
>> +        break;
>> +    case MSR_MCG_CTL:
>> +        if (env->mcg_cap & MCG_CTL_P) {
>> +            val =3D env->mcg_ctl;
>> +        } else {
>> +            *valid =3D false;
>> +            val =3D 0;
>=20
> I understand the intention behind setting *valid =3D false here,
> but the existing kvm_put_msrs() code tries to set MSR_MCG_CTL
> even if (mcg_cap & MCG_CTL_P) is not set. We need to keep that in
> mind if we convert kvm_{get,put}_msrs() to use the wrmsr/rdmsr
> helpers.
>=20
> Also, if x86_cpu_rdmsr() is set *valid =3D false here, we probably
> should set *valid =3D false at x86_cpu_wrmsr() too[***} for
> consistency.
>=20
>> +        }
>> +        break;
>> +    case MSR_MCG_STATUS:
>> +        val =3D env->mcg_status;
>> +        break;
>> +    case MSR_IA32_MISC_ENABLE:
>> +        val =3D env->msr_ia32_misc_enable;
>> +        break;
>> +    case MSR_IA32_BNDCFGS:
>> +        val =3D env->msr_bndcfgs;
>> +        break;
>> +    default:
>> +        if (idx >=3D MSR_MC0_CTL && idx < MSR_MC0_CTL +
>> +            (4 * env->mcg_cap & 0xff)) {
>> +            val =3D env->mce_banks[idx - MSR_MC0_CTL];
>=20
> The original helper_rdmsr() code had a "offset" variable. Not
> important, as the new code is equivalent, but it would make the
> equivalency between x86_cpu_rdmsr() and x86_cpu_wrmsr() more
> visible.
>=20
>> +            break;
>> +        }
>> +        *valid =3D false;
>> +        val =3D 0;
>> +        break;
>> +    }
>> +    return val;
>> +}
>>  #else
>>  void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
>>                                     fprintf_function cpu_fprintf, int =
flags)
>>  {
>>  }
>> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool=
 *valid)
>> +{
>> +    *valid =3D false;
>> +}
>> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
>> +{
>> +    *valid =3D false;
>> +    return 0ULL;
>> +}
>>  #endif /* !CONFIG_USER_ONLY */
>> =20
>>  #define DUMP_CODE_BYTES_TOTAL    50
>> diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
>> index ca2ea09f54..fbbf9d146e 100644
>> --- a/target/i386/misc_helper.c
>> +++ b/target/i386/misc_helper.c
>> @@ -227,307 +227,32 @@ void helper_rdmsr(CPUX86State *env)
>>  void helper_wrmsr(CPUX86State *env)
>>  {
>>      uint64_t val;
>> +    bool res_valid;
>> =20
>>      cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
>> =20
>>      val =3D ((uint32_t)env->regs[R_EAX]) |
>>          ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
>> =20
>> -    switch ((uint32_t)env->regs[R_ECX]) {
>> -    case MSR_IA32_SYSENTER_CS:
>> -        env->sysenter_cs =3D val & 0xffff;
>> -        break;
>> -    case MSR_IA32_SYSENTER_ESP:
>> -        env->sysenter_esp =3D val;
>> -        break;
>> -    case MSR_IA32_SYSENTER_EIP:
>> -        env->sysenter_eip =3D val;
>> -        break;
>> -    case MSR_IA32_APICBASE:
>> -        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
>> -        break;
>> -    case MSR_EFER:
>> -        {
>> -            uint64_t update_mask;
>> +    x86_cpu_wrmsr(env, (uint32_t)env->regs[R_ECX], val, &res_valid);
>> +
>> +    /* XXX: exception? */
>> +    if (!res_valid) { }
>> =20
>> -            update_mask =3D 0;
>> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_SYSCAL=
L) {
>> -                update_mask |=3D MSR_EFER_SCE;
>> -            }
>> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>> -                update_mask |=3D MSR_EFER_LME;
>> -            }
>> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR)=
 {
>> -                update_mask |=3D MSR_EFER_FFXSR;
>> -            }
>> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_NX) {
>> -                update_mask |=3D MSR_EFER_NXE;
>> -            }
>> -            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>> -                update_mask |=3D MSR_EFER_SVME;
>> -            }
>> -            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR)=
 {
>> -                update_mask |=3D MSR_EFER_FFXSR;
>> -            }
>> -            cpu_load_efer(env, (env->efer & ~update_mask) |
>> -                          (val & update_mask));
>> -        }
>> -        break;
>> -    case MSR_STAR:
>> -        env->star =3D val;
>> -        break;
>> -    case MSR_PAT:
>> -        env->pat =3D val;
>> -        break;
>> -    case MSR_VM_HSAVE_PA:
>> -        env->vm_hsave =3D val;
>> -        break;
>> -#ifdef TARGET_X86_64
>> -    case MSR_LSTAR:
>> -        env->lstar =3D val;
>> -        break;
>> -    case MSR_CSTAR:
>> -        env->cstar =3D val;
>> -        break;
>> -    case MSR_FMASK:
>> -        env->fmask =3D val;
>> -        break;
>> -    case MSR_FSBASE:
>> -        env->segs[R_FS].base =3D val;
>> -        break;
>> -    case MSR_GSBASE:
>> -        env->segs[R_GS].base =3D val;
>> -        break;
>> -    case MSR_KERNELGSBASE:
>> -        env->kernelgsbase =3D val;
>> -        break;
>> -#endif
>> -    case MSR_MTRRphysBase(0):
>> -    case MSR_MTRRphysBase(1):
>> -    case MSR_MTRRphysBase(2):
>> -    case MSR_MTRRphysBase(3):
>> -    case MSR_MTRRphysBase(4):
>> -    case MSR_MTRRphysBase(5):
>> -    case MSR_MTRRphysBase(6):
>> -    case MSR_MTRRphysBase(7):
>> -        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
>> -                       MSR_MTRRphysBase(0)) / 2].base =3D val;
>> -        break;
>> -    case MSR_MTRRphysMask(0):
>> -    case MSR_MTRRphysMask(1):
>> -    case MSR_MTRRphysMask(2):
>> -    case MSR_MTRRphysMask(3):
>> -    case MSR_MTRRphysMask(4):
>> -    case MSR_MTRRphysMask(5):
>> -    case MSR_MTRRphysMask(6):
>> -    case MSR_MTRRphysMask(7):
>> -        env->mtrr_var[((uint32_t)env->regs[R_ECX] -
>> -                       MSR_MTRRphysMask(0)) / 2].mask =3D val;
>> -        break;
>> -    case MSR_MTRRfix64K_00000:
>> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
>> -                        MSR_MTRRfix64K_00000] =3D val;
>> -        break;
>> -    case MSR_MTRRfix16K_80000:
>> -    case MSR_MTRRfix16K_A0000:
>> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
>> -                        MSR_MTRRfix16K_80000 + 1] =3D val;
>> -        break;
>> -    case MSR_MTRRfix4K_C0000:
>> -    case MSR_MTRRfix4K_C8000:
>> -    case MSR_MTRRfix4K_D0000:
>> -    case MSR_MTRRfix4K_D8000:
>> -    case MSR_MTRRfix4K_E0000:
>> -    case MSR_MTRRfix4K_E8000:
>> -    case MSR_MTRRfix4K_F0000:
>> -    case MSR_MTRRfix4K_F8000:
>> -        env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
>> -                        MSR_MTRRfix4K_C0000 + 3] =3D val;
>> -        break;
>> -    case MSR_MTRRdefType:
>> -        env->mtrr_deftype =3D val;
>> -        break;
>> -    case MSR_MCG_STATUS:
>> -        env->mcg_status =3D val;
>> -        break;
>> -    case MSR_MCG_CTL:
>> -        if ((env->mcg_cap & MCG_CTL_P)
>> -            && (val =3D=3D 0 || val =3D=3D ~(uint64_t)0)) {
>> -            env->mcg_ctl =3D val;
>> -        }
>> -        break;
>> -    case MSR_TSC_AUX:
>> -        env->tsc_aux =3D val;
>> -        break;
>> -    case MSR_IA32_MISC_ENABLE:
>> -        env->msr_ia32_misc_enable =3D val;
>> -        break;
>> -    case MSR_IA32_BNDCFGS:
>> -        /* FIXME: #GP if reserved bits are set.  */
>> -        /* FIXME: Extend highest implemented bit of linear address.  =
*/
>> -        env->msr_bndcfgs =3D val;
>> -        cpu_sync_bndcs_hflags(env);
>> -        break;
>> -    default:
>> -        if ((uint32_t)env->regs[R_ECX] >=3D MSR_MC0_CTL
>> -            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
>> -            (4 * env->mcg_cap & 0xff)) {
>> -            uint32_t offset =3D (uint32_t)env->regs[R_ECX] - MSR_MC0_=
CTL;
>> -            if ((offset & 0x3) !=3D 0
>> -                || (val =3D=3D 0 || val =3D=3D ~(uint64_t)0)) {
>> -                env->mce_banks[offset] =3D val;
>> -            }
>> -            break;
>> -        }
>> -        /* XXX: exception? */
>> -        break;
>> -    }
>>  }
>> =20
>>  void helper_rdmsr(CPUX86State *env)
>>  {
>>      uint64_t val;
>> +    bool res_valid;
>> =20
>>      cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
>> =20
>> -    switch ((uint32_t)env->regs[R_ECX]) {
>> -    case MSR_IA32_SYSENTER_CS:
>> -        val =3D env->sysenter_cs;
>> -        break;
>> -    case MSR_IA32_SYSENTER_ESP:
>> -        val =3D env->sysenter_esp;
>> -        break;
>> -    case MSR_IA32_SYSENTER_EIP:
>> -        val =3D env->sysenter_eip;
>> -        break;
>> -    case MSR_IA32_APICBASE:
>> -        val =3D cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
>> -        break;
>> -    case MSR_EFER:
>> -        val =3D env->efer;
>> -        break;
>> -    case MSR_STAR:
>> -        val =3D env->star;
>> -        break;
>> -    case MSR_PAT:
>> -        val =3D env->pat;
>> -        break;
>> -    case MSR_VM_HSAVE_PA:
>> -        val =3D env->vm_hsave;
>> -        break;
>> -    case MSR_IA32_PERF_STATUS:
>> -        /* tsc_increment_by_tick */
>> -        val =3D 1000ULL;
>> -        /* CPU multiplier */
>> -        val |=3D (((uint64_t)4ULL) << 40);
>> -        break;
>> -#ifdef TARGET_X86_64
>> -    case MSR_LSTAR:
>> -        val =3D env->lstar;
>> -        break;
>> -    case MSR_CSTAR:
>> -        val =3D env->cstar;
>> -        break;
>> -    case MSR_FMASK:
>> -        val =3D env->fmask;
>> -        break;
>> -    case MSR_FSBASE:
>> -        val =3D env->segs[R_FS].base;
>> -        break;
>> -    case MSR_GSBASE:
>> -        val =3D env->segs[R_GS].base;
>> -        break;
>> -    case MSR_KERNELGSBASE:
>> -        val =3D env->kernelgsbase;
>> -        break;
>> -    case MSR_TSC_AUX:
>> -        val =3D env->tsc_aux;
>> -        break;
>> -#endif
>> -    case MSR_MTRRphysBase(0):
>> -    case MSR_MTRRphysBase(1):
>> -    case MSR_MTRRphysBase(2):
>> -    case MSR_MTRRphysBase(3):
>> -    case MSR_MTRRphysBase(4):
>> -    case MSR_MTRRphysBase(5):
>> -    case MSR_MTRRphysBase(6):
>> -    case MSR_MTRRphysBase(7):
>> -        val =3D env->mtrr_var[((uint32_t)env->regs[R_ECX] -
>> -                             MSR_MTRRphysBase(0)) / 2].base;
>> -        break;
>> -    case MSR_MTRRphysMask(0):
>> -    case MSR_MTRRphysMask(1):
>> -    case MSR_MTRRphysMask(2):
>> -    case MSR_MTRRphysMask(3):
>> -    case MSR_MTRRphysMask(4):
>> -    case MSR_MTRRphysMask(5):
>> -    case MSR_MTRRphysMask(6):
>> -    case MSR_MTRRphysMask(7):
>> -        val =3D env->mtrr_var[((uint32_t)env->regs[R_ECX] -
>> -                             MSR_MTRRphysMask(0)) / 2].mask;
>> -        break;
>> -    case MSR_MTRRfix64K_00000:
>> -        val =3D env->mtrr_fixed[0];
>> -        break;
>> -    case MSR_MTRRfix16K_80000:
>> -    case MSR_MTRRfix16K_A0000:
>> -        val =3D env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
>> -                              MSR_MTRRfix16K_80000 + 1];
>> -        break;
>> -    case MSR_MTRRfix4K_C0000:
>> -    case MSR_MTRRfix4K_C8000:
>> -    case MSR_MTRRfix4K_D0000:
>> -    case MSR_MTRRfix4K_D8000:
>> -    case MSR_MTRRfix4K_E0000:
>> -    case MSR_MTRRfix4K_E8000:
>> -    case MSR_MTRRfix4K_F0000:
>> -    case MSR_MTRRfix4K_F8000:
>> -        val =3D env->mtrr_fixed[(uint32_t)env->regs[R_ECX] -
>> -                              MSR_MTRRfix4K_C0000 + 3];
>> -        break;
>> -    case MSR_MTRRdefType:
>> -        val =3D env->mtrr_deftype;
>> -        break;
>> -    case MSR_MTRRcap:
>> -        if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
>> -            val =3D MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
>> -                MSR_MTRRcap_WC_SUPPORTED;
>> -        } else {
>> -            /* XXX: exception? */
>> -            val =3D 0;
>> -        }
>> -        break;
>> -    case MSR_MCG_CAP:
>> -        val =3D env->mcg_cap;
>> -        break;
>> -    case MSR_MCG_CTL:
>> -        if (env->mcg_cap & MCG_CTL_P) {
>> -            val =3D env->mcg_ctl;
>> -        } else {
>> -            val =3D 0;
>> -        }
>> -        break;
>> -    case MSR_MCG_STATUS:
>> -        val =3D env->mcg_status;
>> -        break;
>> -    case MSR_IA32_MISC_ENABLE:
>> -        val =3D env->msr_ia32_misc_enable;
>> -        break;
>> -    case MSR_IA32_BNDCFGS:
>> -        val =3D env->msr_bndcfgs;
>> -        break;
>> -    default:
>> -        if ((uint32_t)env->regs[R_ECX] >=3D MSR_MC0_CTL
>> -            && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
>> -            (4 * env->mcg_cap & 0xff)) {
>> -            uint32_t offset =3D (uint32_t)env->regs[R_ECX] - MSR_MC0_=
CTL;
>> -            val =3D env->mce_banks[offset];
>> -            break;
>> -        }
>> -        /* XXX: exception? */
>> -        val =3D 0;
>> -        break;
>> -    }
>> +    val =3D x86_cpu_rdmsr(env, (uint32_t)env->regs[R_ECX], &res_valid=
);
>> +
>> +    /* XXX: exception? */
>> +    if (!res_valid) { }
>> +
>>      env->regs[R_EAX] =3D (uint32_t)(val);
>>      env->regs[R_EDX] =3D (uint32_t)(val >> 32);
>>  }
>> --=20
>> 2.11.0
>>
>=20
