Received: from eggs.gnu.org ([2001:4830:134:3::10]:54519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1claFY-0007Y0-1o
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1claFU-000515-HU
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:59:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1claFU-00050s-41
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:59:20 -0500
Date: Wed, 8 Mar 2017 11:59:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170308115909.GD10232@work-vm>
References: <20170308001637.9838-1-git@kirschju.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308001637.9838-1-git@kirschju.re>
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>
Cc: qemu-devel@nongnu.org, Julian Kirsch <mail@kirschju.re>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>

* Julian Kirsch (git@kirschju.re) wrote:
> Provide read/write access to x86 model specific registers (MSRs) by means of
> two new HMP commands "msr-list" and "msr-set". The rationale behind this
> is to improve introspection capabilities for system virtualization mode.
> For instance, many modern x86-64 operating systems maintain access to internal
> data structures via the MSR_GSBASE/MSR_KERNELGSBASE MSRs. Giving
> introspection utilities (such as a remotely attached gdb) a way of
> accessing these registers improves analysis results drastically.

I'll leave those who know more about gdb to answer whether that's the best way
of doing it; but I can see them being useful to those just trying to debug
stuff from the monitor.

> Signed-off-by: Julian Kirsch <git@kirschju.re>
> ---
> This patch moves the logic of the rdmsr and wrmsr functions to helper.c and
> replaces their current versions in misc_helper.c with stubs calling the new
> functions.

I think the patch needs to be split up; you should at least have:
  a) The big part that moves the helpers (if that's the right thing to do)
  b) The qmp code
  c) The hmp code

I also don't see why you need to move the helpers.

> The ordering of MSRs now loosely follows the ordering used in the KVM
> module. As qemu operates on cached values in the CPUX86State struct, the msr-set
> command is implemented in a hackish way: In order to force qemu to flush the new
> values to KVM a call to cpu_synchronize_post_init is triggered, eventually
> ending up in calling kvm_put_msrs at KVM_PUT_FULL_STATE level. As MSR writes
> could *still* be caught by the code logic in this function, the msr-set function
> reads back the values written to determine whether the write was successful.
> This way, we don't have to duplicate the logic used in kvm_put_msrs (has_msr_XXX)
> to x86_cpu_wrmsr.
> There are several things I would like to pooint out about this patch:
>   - The "msr-list" command currently displays MSR values for all virtual cpus.
>     This is somewhat inconsistent with "info registers" just displaying the
>     value of the current default cpu. One might think about just displaying the
>     current value and offer access to other CPU's MSRs by means of switching
>     between CPUs using the "cpu" monitor command.

Yes, it's probably best to make it just the current CPU to be consistent.

>   - The new version of x86_cpu_rdmsr exposes MSRs that are arguably of
>     questionable help for any human / tool using the monitor. However I merely
>     felt a deep urge to reflect the full MSR list from kvm.c when writing the
>     code.

No point in guessing which ones the human will need; may as well give them
everything so they can debug bugs that are obscure.

>   - While the need for msr-list is evident (see commit msg), msr-set could be
>     used in more obscure cases. For instance, one might offer a way to access
>     and configure performance counter MSRs of the guest via the hmp. If this
>     feels too much like an inacceptable hack, I'll happily drop the msr-set
>     part.

It feels reasonable to have it for debugging.

(Heck, aren't those big switch statements depressing, I'm sure there
must be a way to turn a chunk of them into a table that could be shared between
the helpers and even maybe the kvm code; anyway, not the subject of this patch).

Dave

> Best,
> Julian
> 
>  cpus.c                    |  99 +++++++++
>  hmp-commands.hx           |  29 +++
>  hmp.c                     |  31 +++
>  hmp.h                     |   2 +
>  qapi-schema.json          |  49 +++++
>  target/i386/cpu.h         |   3 +
>  target/i386/helper.c      | 518 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/misc_helper.c | 298 +-------------------------
>  8 files changed, 742 insertions(+), 287 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index c857ad2957..c5088d2294 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1919,6 +1919,105 @@ exit:
>      fclose(f);
>  }
>  
> +MsrInfoList *qmp_msr_list(uint32_t msr_idx, Error **errp)
> +{
> +#ifdef TARGET_I386
> +    bool valid;
> +    X86CPU *cpu;
> +    CPUX86State *env;
> +    CPUState *cpu_state;
> +    MsrInfoList *head = NULL, *cur_item = NULL;
> +
> +    CPU_FOREACH(cpu_state) {
> +        cpu = X86_CPU(cpu_state);
> +        env = &cpu->env;
> +
> +        cpu_synchronize_state(cpu_state);
> +
> +        MsrInfoList *info;
> +        info = g_malloc0(sizeof(*info));
> +        info->value = g_malloc0(sizeof(*info->value));
> +
> +        info->value->cpu_idx = cpu_state->cpu_index;
> +        info->value->msr_idx = msr_idx;
> +        info->value->value = x86_cpu_rdmsr(env, msr_idx, &valid);
> +
> +        if (!valid) {
> +            error_setg(errp, "Failed to retreive MSR 0x%08x on CPU %u",
> +                       msr_idx, cpu_state->cpu_index);
> +            return head;
> +        }
> +
> +        /* XXX: waiting for the qapi to support GSList */
> +        if (!cur_item) {
> +            head = cur_item = info;
> +        } else {
> +            cur_item->next = info;
> +            cur_item = info;
> +        }
> +    }
> +
> +    return head;
> +#else
> +    error_setg(errp, "MSRs are not supported on this architecture");
> +    return NULL;
> +#endif
> +}

This should be abstracted some how so that we don't need
x86 specifics in cpus.c; perhaps just an architecture call
back on the CPU.

> +void qmp_msr_set(uint32_t cpu_idx, uint32_t msr_idx,
> +                 uint64_t value, Error **errp)
> +{
> +#ifdef TARGET_I386
> +    bool found_cpu = false, valid = false;
> +    uint64_t new_value;
> +    X86CPU *cpu;
> +    CPUX86State *env;
> +    CPUState *cpu_state;
> +
> +    CPU_FOREACH(cpu_state) {
> +        cpu = X86_CPU(cpu_state);
> +        env = &cpu->env;
> +
> +        if (cpu_idx != cpu_state->cpu_index) {
> +            continue;
> +        }
> +        found_cpu = true;
> +
> +        cpu_synchronize_state(cpu_state);
> +
> +        x86_cpu_wrmsr(env, msr_idx, value, &valid);
> +        if (!valid) {
> +            error_setg(errp, "Could not write MSR");
> +            break;
> +        }
> +#ifdef CONFIG_KVM
> +        if (kvm_enabled()) {
> +            /* Force KVM to flush registers at KVM_PUT_FULL_STATE level. */
> +            cpu_synchronize_post_init(cpu_state);
> +
> +            /* Read back the value from KVM to check if it flushed them. */
> +            cpu_synchronize_state(cpu_state);
> +            new_value = x86_cpu_rdmsr(env, msr_idx, &valid);
> +            if (new_value != value) {
> +                error_setg(errp, "Failed to flush MSR value to KVM");
> +            }
> +        }
> +#endif
> +        break;
> +    }
> +
> +    if (!found_cpu) {
> +        error_setg(errp, "Failed to find requested CPU");
> +    }
> +
> +    return;
> +
> +#else
> +    error_setg(errp, "MSRs are not supported on this architecture");
> +    return;
> +#endif
> +}
> +
>  void qmp_inject_nmi(Error **errp)
>  {
>      nmi_monitor_handle(monitor_get_cpu_index(), errp);
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 88192817b2..e50fafe5ef 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1775,5 +1775,34 @@ ETEXI
>      },
>  
>  STEXI
> +ETEXI
> +
> +    {
> +        .name         = "msr-list",
> +        .args_type    = "msr_idx:i",
> +        .params       = "msr_idx",
> +        .help         = "get value of model specific registers on x86",
> +        .cmd          =  hmp_msr_list,
> +    },
> +
> +STEXI
> +@item msr-list @var{msr_idx}
> +@findex msr-list
> +Print values of model specific register @var{msr_idx} on each CPU
> +ETEXI
> +
> +    {
> +        .name         = "msr-set",
> +        .args_type    = "cpu_idx:i,msr_idx:i,value:l",
> +        .params       = "cpu_idx msr_idx value",
> +        .help         = "set values of model specific registers on x86",
> +        .cmd          =  hmp_msr_set,
> +    },
> +
> +STEXI
> +@item msr-set @var{cpu_idx} @var{msr_idx} @var{value}
> +@findex msr-set
> +Set value of model specific register @var{msr_idx} on CPU @var{cpu_idx} to
> +@var{value}
>  @end table
>  ETEXI
> diff --git a/hmp.c b/hmp.c
> index 261843f7a2..00f530cb74 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1036,6 +1036,37 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> +void hmp_msr_list(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    MsrInfoList *msr_list, *info;
> +
> +    uint32_t msr_idx = qdict_get_int(qdict, "msr_idx");
> +
> +    msr_list = qmp_msr_list(msr_idx, &err);
> +    for (info = msr_list; info && !err; info = info->next)
> +        monitor_printf(mon, "%" PRIu64 " 0x%016" PRIx64 "\n",
> +            info->value->cpu_idx, info->value->value);
> +
> +    if (msr_list) {
> +        qapi_free_MsrInfoList(msr_list);
> +    }
> +
> +    hmp_handle_error(mon, &err);
> +}
> +
> +void hmp_msr_set(Monitor *mon, const QDict *qdict)
> +{
> +    uint32_t cpu_idx = qdict_get_int(qdict, "cpu_idx");
> +    uint32_t msr_idx = qdict_get_int(qdict, "msr_idx");
> +    uint64_t value = qdict_get_int(qdict, "value");
> +    Error *err = NULL;
> +
> +    qmp_msr_set(cpu_idx, msr_idx, value, &err);
> +
> +    hmp_handle_error(mon, &err);
> +}
> +
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
>  {
>      const char *chardev = qdict_get_str(qdict, "device");
> diff --git a/hmp.h b/hmp.h
> index 799fd371fa..c1d614a1f4 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -49,6 +49,8 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
> +void hmp_msr_list(Monitor *mon, const QDict *qdict);
> +void hmp_msr_set(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
>  void hmp_cont(Monitor *mon, const QDict *qdict);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 6febfa7b90..5e27b634f7 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2365,6 +2365,55 @@
>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>  
>  ##
> +# @MsrInfo:
> +#
> +# Information about a MSR
> +#
> +# @cpu_idx: CPU index
> +#
> +# @msr_idx: MSR index
> +#
> +# @value: MSR value
> +#
> +# Since: 2.8.1
> +##
> +{ 'struct': 'MsrInfo',
> +  'data': {'cpu_idx': 'int', 'msr_idx': 'uint32', 'value': 'uint64'} }
> +
> +##
> +# @msr-list:
> +#
> +# Retrieve model specific registers (MSRs) on x86
> +#
> +# @msr_idx: MSR index to read
> +#
> +# Returns: A list of one MSR value per CPU, or nothing
> +#
> +# Since: 2.8.1
> +##
> +{ 'command': 'msr-list', 'returns': ['MsrInfo'],
> +  'data': {'msr_idx': 'uint32'} }
> +
> +##
> +# @msr-set:
> +#
> +# Set model specific registers (MSRs) on x86
> +#
> +# @cpu_idx: CPU holding the MSR that should be written
> +#
> +# @msr_idx: MSR index to write
> +#
> +# @value: Value to write
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.8.1
> +##
> +{ 'command': 'msr-set',
> +  'data': {'cpu_idx': 'uint32', 'msr_idx': 'uint32', 'value': 'uint64'} }
> +
> +
> +##
>  # @cont:
>  #
>  # Resume guest VCPU execution.
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index ac2ad6d443..b3e07bda8c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1306,6 +1306,9 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>  void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
>                                  Error **errp);
>  
> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid);
> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid);
> +
>  void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>                          int flags);
>  
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e2af3404f2..ee10eb0a8f 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -26,6 +26,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "monitor/monitor.h"
> +#include "hw/i386/apic.h"
>  #include "hw/i386/apic_internal.h"
>  #endif
>  
> @@ -364,11 +365,528 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
>      }
>      cpu_fprintf(f, " PPR 0x%02x\n", apic_get_ppr(s));
>  }
> +
> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
> +{
> +    uint64_t val;
> +    *valid = true;
> +
> +    /* MSR list loosely following the order in kvm.c */
> +    switch (idx) {
> +    case MSR_IA32_SYSENTER_CS:
> +        val = env->sysenter_cs;
> +        break;
> +    case MSR_IA32_SYSENTER_ESP:
> +        val = env->sysenter_esp;
> +        break;
> +    case MSR_IA32_SYSENTER_EIP:
> +        val = env->sysenter_eip;
> +        break;
> +    case MSR_PAT:
> +        val = env->pat;
> +        break;
> +    case MSR_STAR:
> +        val = env->star;
> +        break;
> +#ifdef TARGET_X86_64
> +    case MSR_CSTAR:
> +        val = env->cstar;
> +        break;
> +    case MSR_KERNELGSBASE:
> +        val = env->kernelgsbase;
> +        break;
> +    case MSR_GSBASE:
> +        val = env->segs[R_GS].base;
> +        break;
> +    case MSR_FSBASE:
> +        val = env->segs[R_FS].base;
> +        break;
> +    case MSR_FMASK:
> +        val = env->fmask;
> +        break;
> +    case MSR_LSTAR:
> +        val = env->lstar;
> +        break;
> +#endif
> +    case MSR_EFER:
> +        val = env->efer;
> +        break;
> +    case MSR_IA32_APICBASE:
> +        val = cpu_get_apic_base(x86_env_get_cpu(env)->apic_state);
> +        break;
> +    case MSR_IA32_PERF_STATUS:
> +        /* tsc_increment_by_tick */
> +        val = 1000ULL;
> +        /* CPU multiplier */
> +        val |= (((uint64_t)4ULL) << 40);
> +        break;
> +    case MSR_IA32_TSC:
> +        val = env->tsc;
> +        break;
> +    case MSR_TSC_AUX:
> +        val = env->tsc_aux;
> +        break;
> +    case MSR_TSC_ADJUST:
> +        val = env->tsc_adjust;
> +        break;
> +    case MSR_IA32_TSCDEADLINE:
> +        val = env->tsc_deadline;
> +        break;
> +    case MSR_VM_HSAVE_PA:
> +        val = env->vm_hsave;
> +        break;
> +#ifdef CONFIG_KVM
> +    /* Export kvm specific pseudo MSRs using their new ordinals only */
> +    case MSR_KVM_SYSTEM_TIME_NEW:
> +        val = env->system_time_msr;
> +        break;
> +    case MSR_KVM_WALL_CLOCK_NEW:
> +        val = env->wall_clock_msr;
> +        break;
> +    case MSR_KVM_ASYNC_PF_EN:
> +        val = env->async_pf_en_msr;
> +        break;
> +    case MSR_KVM_PV_EOI_EN:
> +        val = env->pv_eoi_en_msr;
> +        break;
> +    case MSR_KVM_STEAL_TIME:
> +        val = env->steal_time_msr;
> +        break;
> +#endif
> +    case MSR_MCG_STATUS:
> +        val = env->mcg_status;
> +        break;
> +    case MSR_MCG_CAP:
> +        val = env->mcg_cap;
> +        break;
> +    case MSR_MCG_CTL:
> +        if (env->mcg_cap & MCG_CTL_P) {
> +            val = env->mcg_ctl;
> +        } else {
> +            val = 0;
> +        }
> +        break;
> +    case MSR_MCG_EXT_CTL:
> +        if (env->mcg_cap & MCG_CTL_P) {
> +            val = env->mcg_ext_ctl;
> +        } else {
> +            val = 0;
> +        }
> +        break;
> +    case MSR_IA32_MISC_ENABLE:
> +        val = env->msr_ia32_misc_enable;
> +        break;
> +    case MSR_IA32_SMBASE:
> +        val = env->smbase;
> +        break;
> +    case MSR_IA32_FEATURE_CONTROL:
> +        val = env->msr_ia32_feature_control;
> +        break;
> +    case MSR_IA32_BNDCFGS:
> +        val = env->msr_bndcfgs;
> +        break;
> +    case MSR_IA32_XSS:
> +        val = env->xss;
> +        break;
> +    default:
> +        if (idx >= MSR_MC0_CTL &&
> +            idx < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
> +            val = env->mce_banks[idx - MSR_MC0_CTL];
> +            break;
> +        }
> +        /* XXX: Pass request to underlying KVM? */
> +        val = 0;
> +        *valid = false;
> +        break;
> +    case MSR_CORE_PERF_FIXED_CTR_CTRL:
> +        val = env->msr_fixed_ctr_ctrl;
> +        break;
> +    case MSR_CORE_PERF_GLOBAL_CTRL:
> +        val = env->msr_global_ctrl;
> +        break;
> +    case MSR_CORE_PERF_GLOBAL_STATUS:
> +        val = env->msr_global_status;
> +        break;
> +    case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +        val = env->msr_global_ovf_ctrl;
> +        break;
> +    case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
> +        val = env->msr_fixed_counters[idx - MSR_CORE_PERF_FIXED_CTR0];
> +        break;
> +    case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR0 + MAX_GP_COUNTERS - 1:
> +        val = env->msr_gp_counters[idx - MSR_P6_PERFCTR0];
> +        break;
> +    case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
> +        val = env->msr_gp_evtsel[idx - MSR_P6_EVNTSEL0];
> +        break;
> +#if defined CONFIG_KVM && defined TARGET_X86_64
> +    case HV_X64_MSR_HYPERCALL:
> +        val = env->msr_hv_hypercall;
> +        break;
> +    case HV_X64_MSR_GUEST_OS_ID:
> +        val = env->msr_hv_guest_os_id;
> +        break;
> +    case HV_X64_MSR_APIC_ASSIST_PAGE:
> +        val = env->msr_hv_vapic;
> +        break;
> +    case HV_X64_MSR_REFERENCE_TSC:
> +        val = env->msr_hv_tsc;
> +        break;
> +    case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
> +        val = env->msr_hv_crash_params[idx - HV_X64_MSR_CRASH_P0];
> +        break;
> +    case HV_X64_MSR_VP_RUNTIME:
> +        val = env->msr_hv_runtime;
> +        break;
> +    case HV_X64_MSR_SCONTROL:
> +        val = env->msr_hv_synic_control;
> +        break;
> +    case HV_X64_MSR_SVERSION:
> +        val = env->msr_hv_synic_version;
> +        break;
> +    case HV_X64_MSR_SIEFP:
> +        val = env->msr_hv_synic_evt_page;
> +        break;
> +    case HV_X64_MSR_SIMP:
> +        val = env->msr_hv_synic_msg_page;
> +        break;
> +    case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
> +        val = env->msr_hv_synic_sint[idx - HV_X64_MSR_SINT0];
> +        break;
> +    case HV_X64_MSR_STIMER0_CONFIG:
> +    case HV_X64_MSR_STIMER1_CONFIG:
> +    case HV_X64_MSR_STIMER2_CONFIG:
> +    case HV_X64_MSR_STIMER3_CONFIG:
> +        val = env->msr_hv_stimer_config[(idx - HV_X64_MSR_STIMER0_CONFIG) / 2];
> +        break;
> +    case HV_X64_MSR_STIMER0_COUNT:
> +    case HV_X64_MSR_STIMER1_COUNT:
> +    case HV_X64_MSR_STIMER2_COUNT:
> +    case HV_X64_MSR_STIMER3_COUNT:
> +        val = env->msr_hv_stimer_count[(idx - HV_X64_MSR_STIMER0_COUNT) / 2];
> +        break;
> +#endif
> +    case MSR_MTRRdefType:
> +        val = env->mtrr_deftype;
> +        break;
> +    case MSR_MTRRfix64K_00000:
> +        val = env->mtrr_fixed[0];
> +        break;
> +    case MSR_MTRRfix16K_80000:
> +    case MSR_MTRRfix16K_A0000:
> +        val = env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1];
> +        break;
> +    case MSR_MTRRfix4K_C0000:
> +    case MSR_MTRRfix4K_C8000:
> +    case MSR_MTRRfix4K_D0000:
> +    case MSR_MTRRfix4K_D8000:
> +    case MSR_MTRRfix4K_E0000:
> +    case MSR_MTRRfix4K_E8000:
> +    case MSR_MTRRfix4K_F0000:
> +    case MSR_MTRRfix4K_F8000:
> +        val = env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3];
> +        break;
> +    case MSR_MTRRphysBase(0):
> +    case MSR_MTRRphysBase(1):
> +    case MSR_MTRRphysBase(2):
> +    case MSR_MTRRphysBase(3):
> +    case MSR_MTRRphysBase(4):
> +    case MSR_MTRRphysBase(5):
> +    case MSR_MTRRphysBase(6):
> +    case MSR_MTRRphysBase(7):
> +        val = env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base;
> +        break;
> +    case MSR_MTRRphysMask(0):
> +    case MSR_MTRRphysMask(1):
> +    case MSR_MTRRphysMask(2):
> +    case MSR_MTRRphysMask(3):
> +    case MSR_MTRRphysMask(4):
> +    case MSR_MTRRphysMask(5):
> +    case MSR_MTRRphysMask(6):
> +    case MSR_MTRRphysMask(7):
> +        val = env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask;
> +        break;
> +    case MSR_MTRRcap:
> +        if (env->features[FEAT_1_EDX] & CPUID_MTRR) {
> +            val = MSR_MTRRcap_VCNT | MSR_MTRRcap_FIXRANGE_SUPPORT |
> +                MSR_MTRRcap_WC_SUPPORTED;
> +        } else {
> +            /* XXX: exception? */
> +            *valid = false;
> +            val = 0;
> +        }
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid)
> +{
> +    *valid = true;
> +    /* FIXME: With KVM nabled, only report success if we are sure the new value
> +     * will actually be written back by the KVM subsystem later. */
> +
> +    switch (idx) {
> +    case MSR_IA32_SYSENTER_CS:
> +        env->sysenter_cs = val & 0xffff;
> +        break;
> +    case MSR_IA32_SYSENTER_ESP:
> +        env->sysenter_esp = val;
> +        break;
> +    case MSR_IA32_SYSENTER_EIP:
> +        env->sysenter_eip = val;
> +        break;
> +    case MSR_PAT:
> +        env->pat = val;
> +        break;
> +    case MSR_STAR:
> +        env->star = val;
> +        break;
> +    case MSR_VM_HSAVE_PA:
> +        env->vm_hsave = val;
> +        break;
> +    case MSR_TSC_AUX:
> +        env->tsc_aux = val;
> +        break;
> +    case MSR_TSC_ADJUST:
> +        env->tsc_adjust = val;
> +        break;
> +    case MSR_IA32_MISC_ENABLE:
> +        env->msr_ia32_misc_enable = val;
> +        break;
> +    case MSR_IA32_SMBASE:
> +        env->smbase = val;
> +        break;
> +    case MSR_IA32_BNDCFGS:
> +        /* FIXME: #GP if reserved bits are set.  */
> +        /* FIXME: Extend highest implemented bit of linear address.  */
> +        env->msr_bndcfgs = val;
> +        cpu_sync_bndcs_hflags(env);
> +        break;
> +    case MSR_IA32_XSS:
> +        env->xss = val;
> +        break;
> +#ifdef TARGET_X86_64
> +    case MSR_CSTAR:
> +        env->cstar = val;
> +        break;
> +    case MSR_KERNELGSBASE:
> +        env->kernelgsbase = val;
> +        break;
> +    case MSR_GSBASE:
> +        env->segs[R_GS].base = val;
> +        break;
> +    case MSR_FSBASE:
> +        env->segs[R_FS].base = val;
> +        break;
> +    case MSR_FMASK:
> +        env->fmask = val;
> +        break;
> +    case MSR_LSTAR:
> +        env->lstar = val;
> +        break;
> +#endif
> +    case MSR_EFER:
> +        {
> +            uint64_t update_mask;
> +
> +            update_mask = 0;
> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_SYSCALL) {
> +                update_mask |= MSR_EFER_SCE;
> +            }
> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> +                update_mask |= MSR_EFER_LME;
> +            }
> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> +                update_mask |= MSR_EFER_FFXSR;
> +            }
> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_NX) {
> +                update_mask |= MSR_EFER_NXE;
> +            }
> +            if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> +                update_mask |= MSR_EFER_SVME;
> +            }
> +            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_FFXSR) {
> +                update_mask |= MSR_EFER_FFXSR;
> +            }
> +            cpu_load_efer(env, (env->efer & ~update_mask) |
> +                          (val & update_mask));
> +        }
> +        break;
> +    case MSR_IA32_APICBASE:
> +        cpu_set_apic_base(x86_env_get_cpu(env)->apic_state, val);
> +        break;
> +    case MSR_IA32_TSC:
> +        env->tsc = val;
> +        break;
> +#ifdef CONFIG_KVM
> +    case MSR_KVM_SYSTEM_TIME:
> +        env->system_time_msr = val;
> +        break;
> +    case MSR_KVM_WALL_CLOCK:
> +        env->wall_clock_msr = val;
> +        break;
> +    case MSR_KVM_ASYNC_PF_EN:
> +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> +            env->async_pf_en_msr = val;
> +        } else {
> +            *valid = false;
> +        }
> +    case MSR_KVM_PV_EOI_EN:
> +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
> +            env->pv_eoi_en_msr = val;
> +        } else {
> +            *valid = false;
> +        }
> +
> +#endif
> +    case MSR_CORE_PERF_FIXED_CTR_CTRL:
> +        env->msr_fixed_ctr_ctrl = val;
> +        break;
> +    case MSR_CORE_PERF_GLOBAL_CTRL:
> +        env->msr_global_ctrl = val;
> +        break;
> +    case MSR_CORE_PERF_GLOBAL_STATUS:
> +        env->msr_global_status = val;
> +        break;
> +    case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +        env->msr_global_ovf_ctrl = val;
> +        break;
> +    case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
> +        env->msr_fixed_counters[idx - MSR_CORE_PERF_FIXED_CTR0] = val;
> +        break;
> +    case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR0 + MAX_GP_COUNTERS - 1:
> +        env->msr_gp_counters[idx - MSR_P6_PERFCTR0] = val;
> +        break;
> +    case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
> +        env->msr_gp_evtsel[idx - MSR_P6_EVNTSEL0] = val;
> +        break;
> +#if defined CONFIG_KVM && defined TARGET_X86_64
> +    case HV_X64_MSR_HYPERCALL:
> +        env->msr_hv_hypercall = val;
> +        break;
> +    case HV_X64_MSR_GUEST_OS_ID:
> +        env->msr_hv_guest_os_id = val;
> +        break;
> +    case HV_X64_MSR_APIC_ASSIST_PAGE:
> +        env->msr_hv_vapic = val;
> +        break;
> +    case HV_X64_MSR_REFERENCE_TSC:
> +        env->msr_hv_tsc = val;
> +        break;
> +    case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
> +        env->msr_hv_crash_params[idx - HV_X64_MSR_CRASH_P0] = val;
> +        break;
> +    case HV_X64_MSR_VP_RUNTIME:
> +        env->msr_hv_runtime = val;
> +        break;
> +    case HV_X64_MSR_SCONTROL:
> +        env->msr_hv_synic_control = val;
> +        break;
> +    case HV_X64_MSR_SVERSION:
> +        env->msr_hv_synic_version = val;
> +        break;
> +    case HV_X64_MSR_SIEFP:
> +        env->msr_hv_synic_evt_page = val;
> +        break;
> +    case HV_X64_MSR_SIMP:
> +        env->msr_hv_synic_msg_page = val;
> +        break;
> +    case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
> +        env->msr_hv_synic_sint[idx - HV_X64_MSR_SINT0] = val;
> +        break;
> +    case HV_X64_MSR_STIMER0_CONFIG:
> +    case HV_X64_MSR_STIMER1_CONFIG:
> +    case HV_X64_MSR_STIMER2_CONFIG:
> +    case HV_X64_MSR_STIMER3_CONFIG:
> +        env->msr_hv_stimer_config[(idx - HV_X64_MSR_STIMER0_CONFIG) / 2] = val;
> +        break;
> +    case HV_X64_MSR_STIMER0_COUNT:
> +    case HV_X64_MSR_STIMER1_COUNT:
> +    case HV_X64_MSR_STIMER2_COUNT:
> +    case HV_X64_MSR_STIMER3_COUNT:
> +        env->msr_hv_stimer_count[(idx - HV_X64_MSR_STIMER0_COUNT) / 2] = val;
> +        break;
> +#endif
> +    case MSR_MTRRdefType:
> +        env->mtrr_deftype = val;
> +        break;
> +    case MSR_MTRRfix64K_00000:
> +        env->mtrr_fixed[idx - MSR_MTRRfix64K_00000] = val;
> +        break;
> +    case MSR_MTRRfix16K_80000:
> +    case MSR_MTRRfix16K_A0000:
> +        env->mtrr_fixed[idx - MSR_MTRRfix16K_80000 + 1] = val;
> +        break;
> +    case MSR_MTRRfix4K_C0000:
> +    case MSR_MTRRfix4K_C8000:
> +    case MSR_MTRRfix4K_D0000:
> +    case MSR_MTRRfix4K_D8000:
> +    case MSR_MTRRfix4K_E0000:
> +    case MSR_MTRRfix4K_E8000:
> +    case MSR_MTRRfix4K_F0000:
> +    case MSR_MTRRfix4K_F8000:
> +        env->mtrr_fixed[idx - MSR_MTRRfix4K_C0000 + 3] = val;
> +        break;
> +    case MSR_MTRRphysBase(0):
> +    case MSR_MTRRphysBase(1):
> +    case MSR_MTRRphysBase(2):
> +    case MSR_MTRRphysBase(3):
> +    case MSR_MTRRphysBase(4):
> +    case MSR_MTRRphysBase(5):
> +    case MSR_MTRRphysBase(6):
> +    case MSR_MTRRphysBase(7):
> +        env->mtrr_var[(idx - MSR_MTRRphysBase(0)) / 2].base = val;
> +        break;
> +    case MSR_MTRRphysMask(0):
> +    case MSR_MTRRphysMask(1):
> +    case MSR_MTRRphysMask(2):
> +    case MSR_MTRRphysMask(3):
> +    case MSR_MTRRphysMask(4):
> +    case MSR_MTRRphysMask(5):
> +    case MSR_MTRRphysMask(6):
> +    case MSR_MTRRphysMask(7):
> +        env->mtrr_var[(idx - MSR_MTRRphysMask(0)) / 2].mask = val;
> +        break;
> +    case MSR_MCG_STATUS:
> +        env->mcg_status = val;
> +        break;
> +    case MSR_MCG_CTL:
> +        if ((env->mcg_cap & MCG_CTL_P)
> +            && (val == 0 || val == ~(uint64_t)0)) {
> +            env->mcg_ctl = val;
> +        }
> +        break;
> +    default:
> +        if (idx >= MSR_MC0_CTL &&
> +            idx < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
> +            uint32_t offset = idx - MSR_MC0_CTL;
> +            if ((offset & 0x3) != 0
> +                || (val == 0 || val == ~(uint64_t)0)) {
> +                env->mce_banks[offset] = val;
> +            }
> +            break;
> +        }
> +        /* XXX: Pass request to underlying KVM? */
> +        val = 0;
> +        *valid = false;
> +        break;
> +    }
> +}
>  #else
>  void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
>                                     fprintf_function cpu_fprintf, int flags)
>  {
>  }
> +
> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
> +{
> +}
> +
> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid)
> +{
> +}
>  #endif /* !CONFIG_USER_ONLY */
>  
>  #define DUMP_CODE_BYTES_TOTAL    50
> diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
> index ca2ea09f54..bc0d6aa349 100644
> --- a/target/i386/misc_helper.c
> +++ b/target/i386/misc_helper.c
> @@ -227,307 +227,31 @@ void helper_rdmsr(CPUX86State *env)
>  void helper_wrmsr(CPUX86State *env)
>  {
>      uint64_t val;
> +    bool res_valid;
>  
>      cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
>  
>      val = ((uint32_t)env->regs[R_EAX]) |
>          ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
>  
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
> +    x86_cpu_wrmsr(env, (uint32_t)env->regs[R_ECX], val, &res_valid);
> +
> +    /* XXX: exception? */
> +    if (!res_valid) { }
>  }
>  
>  void helper_rdmsr(CPUX86State *env)
>  {
>      uint64_t val;
> +    bool res_valid;
>  
>      cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
>  
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
> +    val = x86_cpu_rdmsr(env, (uint32_t)env->regs[R_ECX], &res_valid);
> +
> +    /* XXX: exception? */
> +    if (!res_valid) { }
> +
>      env->regs[R_EAX] = (uint32_t)(val);
>      env->regs[R_EDX] = (uint32_t)(val >> 32);
>  }
> -- 
> 2.11.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
