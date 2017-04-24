Received: from eggs.gnu.org ([2001:4830:134:3::10]:57528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2gv9-00056X-9W
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2gv6-0002tM-64
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2gv5-0002sl-TI
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:33:00 -0400
Date: Mon, 24 Apr 2017 17:32:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424163252.GI2362@work-vm>
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>

* Julian Kirsch (git@kirschju.re) wrote:
> Add two new x86-specific HMP commands to read/write model specific
> registers (MSRs) of the current CPU.
> 
> Signed-off-by: Julian Kirsch <git@kirschju.re>
> ---
>  hmp-commands.hx              | 38 ++++++++++++++++++++++
>  include/monitor/hmp-target.h |  2 ++
>  target/i386/monitor.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 88192817b2..07a09120aa 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1568,6 +1568,44 @@ STEXI
>  Inject an MCE on the given CPU (x86 only).
>  ETEXI
>  
> +
> +#if defined(TARGET_I386)
> +
> +    {
> +        .name         = "msr_get",
> +        .args_type    = "msr_index:i",
> +        .params       = "msrindex",
> +        .help         = "get value of model specific register (MSR) on x86",
> +        .cmd          =  hmp_msr_get,
> +    },
> +
> +#endif
> +STEXI
> +@item msr-get @var{msridx}
> +@findex msr-get (x86)

Shouldn't the use of '-' be '_' in those to match the .name (and in the -set variant
below) ?

Dave

> +Print value of model specific register @var{msr_index} on current CPU (x86
> +only).
> +ETEXI
> +
> +
> +#if defined(TARGET_I386)
> +
> +    {
> +        .name         = "msr_set",
> +        .args_type    = "msr_index:i,value:l",
> +        .params       = "msrindex value",
> +        .help         = "set value of model specific register (MSR) on x86",
> +        .cmd          =  hmp_msr_set,
> +    },
> +
> +#endif
> +STEXI
> +@item msr-set @var{msr_index} @var{value}
> +@findex msr-set
> +Set value of model specific register @var{msr_index} on current CPU to
> +@var{value} (x86 only).
> +ETEXI
> +
>      {
>          .name       = "getfd",
>          .args_type  = "fdname:s",
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index 454e8ed155..a0da1eb05b 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -46,5 +46,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict);
>  void hmp_mce(Monitor *mon, const QDict *qdict);
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
>  void hmp_info_io_apic(Monitor *mon, const QDict *qdict);
> +void hmp_msr_get(Monitor *mon, const QDict *qdict);
> +void hmp_msr_set(Monitor *mon, const QDict *qdict);
>  
>  #endif /* MONITOR_HMP_TARGET_H */
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 77ead60437..d33228416e 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -27,7 +27,9 @@
>  #include "monitor/hmp-target.h"
>  #include "hw/i386/pc.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/hw_accel.h"
>  #include "hmp.h"
> +#include "qapi/error.h"
>  
>  
>  static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
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
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
