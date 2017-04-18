Received: from eggs.gnu.org ([2001:4830:134:3::10]:39629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0XuX-0004Vh-EW
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0XuW-0001cR-Hw
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:31:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0XuW-0001bl-9B
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:31:32 -0400
Date: Tue, 18 Apr 2017 15:31:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170418183127.GR25239@thinpad.lan.raisama.net>
References: <20170418073946.4177-1-git@kirschju.re>
	<20170418073946.4177-5-git@kirschju.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418073946.4177-5-git@kirschju.re>
Subject: Re: [Qemu-devel] [PATCH RESEND v4 4/4] HMP: Introduce msr_get and
 msr_set HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Apr 18, 2017 at 09:39:46AM +0200, Julian Kirsch wrote:
> Add two new x86-specific HMP commands to read/write model specific
> registers (MSRs) of the current CPU.
> 
> Signed-off-by: Julian Kirsch <git@kirschju.re>
[...]
> @@ -651,3 +653,77 @@ void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
>          ioapic_dump_state(mon, qdict);
>      }
>  }
> +
> +void hmp_msr_get(Monitor *mon, const QDict *qdict)
> +{
> +    bool valid = false;
> +    X86CPU *cpu;
> +    CPUState *cs;
> +    Error *err = NULL;
> +    uint64_t value;
> +
> +    uint32_t index = qdict_get_int(qdict, "msr_index");
> +
> +    /* N.B.: mon_get_cpu already synchronizes the CPU state */
> +    cs = mon_get_cpu();
> +    if (cs != NULL) {
> +        cpu = X86_CPU(cs);
> +
> +        value = x86_cpu_rdmsr(&cpu->env, index, &valid);
> +        if (valid) {
> +            monitor_printf(mon, "0x%016" PRIx64 "\n", value);
> +        } else {
> +            error_setg(&err, "Failed to read MSR 0x%08x", index);
> +        }
> +    } else {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    if (err) {
> +        error_report_err(err);
> +    }
> +}
> +
> +void hmp_msr_set(Monitor *mon, const QDict *qdict)
> +{
> +    bool valid = false;
> +    X86CPU *cpu;
> +    CPUState *cs;
> +    Error *err = NULL;
> +    uint64_t new_value;
> +
> +    uint32_t index = qdict_get_int(qdict, "msr_index");
> +    uint64_t value = qdict_get_int(qdict, "value");
> +
> +    /* N.B.: mon_get_cpu already synchronizes the CPU state */
> +    cs = mon_get_cpu();
> +    if (cs != NULL) {
> +        cpu = X86_CPU(cs);
> +
> +        x86_cpu_wrmsr(&cpu->env, index, value, &valid);
> +        if (!valid) {
> +            error_setg(&err, "Failed to write MSR 0x%08x", index);
> +        }
> +#ifdef CONFIG_KVM
> +        else if (kvm_enabled()) {
> +            /* Force KVM to flush registers at KVM_PUT_FULL_STATE level. */
> +            cpu_synchronize_post_init(cs);

Do we really need KVM_PUT_FULL_STATE here? The MSRs that can be
changed at runtime are supposed to be handled by
KVM_PUT_RUNTIME_STATE, aren't they?

We can also consider the approach suggested by Paolo: calling
KVM_SET_MSR directly (but then we need to ensure
cpu->kvm_vcpu_dirty is cleared before getting/setting the MSR).

On either case, we seem to need a wrapper that does the opposite
of cpu_synchronize_state(), here. Then we can choose between:
1) calling the wrapper and then calling KVM_{GET,SET}_MSR; or
2) calling x86_cpu_{rd,wr}msr() and then (optionally) calling the wrapper.

> +
> +            /* Read back the value from KVM to check if it flushed them. */
> +            cpu_synchronize_state(cs);
> +            new_value = x86_cpu_rdmsr(&cpu->env, index, &valid);
> +            if (new_value != value) {
> +                error_setg(&err, "Failed to flush MSR 0x%08x to KVM", index);
> +            }
> +        }
> +#endif
> +    } else {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    if (err) {
> +        error_report_err(err);
> +    }
> +}
> -- 
> 2.11.0
> 

-- 
Eduardo
