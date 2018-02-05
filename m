Received: from eggs.gnu.org ([2001:4830:134:3::10]:58289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eifVs-000590-7h
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eifVn-0000Tf-2f
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:04:44 -0500
Date: Mon, 5 Feb 2018 13:04:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205130427.4b6612d4.cohuck@redhat.com>
In-Reply-To: <20180202143746.204851-2-borntraeger@de.ibm.com>
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
	<20180202143746.204851-2-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On Fri,  2 Feb 2018 14:37:46 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This patch is the s390 implementation of guest crash information,
> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
> property") and the related commits. We will detect several crash
> reasons, with the "disabled wait" being the most important one, since
> this is used by all s390 guests as a "panic like" notification.
> 
> Demonstrate these ways with examples as follows.
> 
>   1. crash-information QOM property;
> 
>   Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
>   to execute "qom-get" command, and might get the result like,
> 
>   (QEMU) qom-get path=/machine/cpu[0]/ property=crash-information
>   {"return": {"psw-addr": 1105350, "psw-mask": 562956395872256, "reason":
>    "disabled wait", "type": "s390"}}
> 
>   2. GUEST_PANICKED event reporting;
> 
>   Run qemu with a socket option, and telnet or nc to that,
>   -chardev socket,id=qmp,port=4444,host=localhost,server \
>   -mon chardev=qmp,mode=control,pretty=on \
>   Negotiating the mode by { "execute": "qmp_capabilities" }, and the crash
>   information will be reported on a guest crash event like,
> 
>   {
>       "timestamp": {
>           "seconds": 1499931739,
>           "microseconds": 961296
>       },
>       "event": "GUEST_PANICKED",
>       "data": {
>           "action": "pause",
>           "info": {
>               "psw-addr": 1105350,
>               "reason": "disabled wait",
>               "psw-mask": 562956395872256,
>               "type": "s390"
>           }
>       }
>   }
> 
>   3. log;
> 
>   Run qemu with the parameters: -D <logfile> -d guest_errors, to
>   specify the logfile and log item. The results might be,
> 
>   Guest crashed
>   S390 crash parameters: (0x0000100000000000 0x0000000000000006)
>   S390 crash reason: operation exception loop
> 
> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  qapi/run-state.json   | 29 ++++++++++++++++++++++++--
>  target/s390x/cpu.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h    | 10 +++++++++
>  target/s390x/helper.c |  5 ++++-
>  target/s390x/kvm.c    | 27 +++++++++++++++++++-----
>  vl.c                  |  6 ++++++
>  6 files changed, 126 insertions(+), 8 deletions(-)

Generally (and with your fixup folded in), this looks sane. Just some
minor nits below.
 
(...)

> +##
> +# @GuestPanicInformationS390:
> +#
> +# S390 specific guest panic information (PSW)
> +#
> +# @psw-mask: control fields of guest PSW
> +# @psw-addr: guest instruction address
> +# @reason: guest crash reason for human reading

"in human readable form"?

> +#
> +# Since: 2.12
> +##
> +{'struct': 'GuestPanicInformationS390',
> + 'data': { 'psw-mask': 'uint64',
> +           'psw-addr': 'uint64',
> +           'reason': 'str' } }
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index d2e6b9f5c7..ac8e963307 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -35,6 +35,8 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  #include "qapi/visitor.h"
> +#include "qapi-visit.h"
> +#include "sysemu/hw_accel.h"
>  #include "exec/exec-all.h"
>  #include "hw/qdev-properties.h"
>  #ifndef CONFIG_USER_ONLY
> @@ -237,6 +239,58 @@ out:
>      error_propagate(errp, err);
>  }
>  
> +static GuestPanicInformation *s390x_cpu_get_crash_info(CPUState *cs)

Use s390_ instead of s390x_? That seems to be the more common usage.

> +{
> +    GuestPanicInformation *panic_info;
> +    S390CPU *cpu = S390_CPU(cs);
> +
> +    cpu_synchronize_state(cs);
> +    panic_info = g_malloc0(sizeof(GuestPanicInformation));
> +
> +    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_S390;
> +    panic_info->u.s390.psw_mask = cpu->env.psw.mask;
> +    panic_info->u.s390.psw_addr = cpu->env.psw.addr;
> +
> +    switch (cpu->env.crash_reason) {
> +    case CRASH_REASON_PGM:
> +        panic_info->u.s390.reason = g_strdup("program interrupt loop");
> +        break;
> +    case CRASH_REASON_EXT:
> +        panic_info->u.s390.reason = g_strdup("external interrupt loop");
> +        break;
> +    case CRASH_REASON_WAITPSW:
> +        panic_info->u.s390.reason = g_strdup("disabled wait");
> +        break;
> +    case CRASH_REASON_OPEREXC:
> +        panic_info->u.s390.reason = g_strdup("operation exception loop");
> +        break;
> +    default:
> +        panic_info->u.s390.reason = g_strdup("unknown crash reason");
> +        break;
> +    }

You're doing the crash_reason -> reason mapping here and also below.
Maybe introduce a helper for it?

> +
> +    return panic_info;
> +}
> +
> +static void s390x_cpu_get_crash_info_qom(Object *obj, Visitor *v,
> +                                         const char *name, void *opaque,
> +                                         Error **errp)
> +{
> +    CPUState *cs = CPU(obj);
> +    GuestPanicInformation *panic_info;
> +
> +    if (!cs->crash_occurred) {
> +        error_setg(errp, "No crash occured");
> +        return;
> +    }
> +
> +    panic_info = s390x_cpu_get_crash_info(cs);
> +
> +    visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
> +                                     errp);
> +    qapi_free_GuestPanicInformation(panic_info);
> +}
> +
>  static void s390_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);

(...)

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8736001156..c6a23262a8 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1568,15 +1568,32 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
>      return r;
>  }
>  
> -static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
> +static void unmanageable_intercept(S390CPU *cpu, enum crash_reasons reason,
> +                                   int pswoffset)
>  {
>      CPUState *cs = CPU(cpu);
> +    const char *str;
>  
> +    switch (reason) {
> +    case CRASH_REASON_PGM:
> +        str = "program interrupt loop";
> +        break;
> +    case CRASH_REASON_EXT:
> +        str = "external interrupt loop";
> +        break;
> +    case CRASH_REASON_OPEREXC:
> +        str = "operation exception loop";
> +        break;
> +    default:
> +        str = "unknown crash reason";
> +        break;
> +    }
>      error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",

"Unmanageable unknown crash reason!" looks a bit odd. In this case,
"Unmanageable intercept!" would actually look a bit saner (but you
would not be able to use a common converter in that case). We can also
just simply keep it :)

>                   str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
>                   ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
>      s390_cpu_halt(cpu);
> -    qemu_system_guest_panicked(NULL);
> +    cpu->env.crash_reason = reason;
> +    qemu_system_guest_panicked(cpu_get_crash_info(cs));
>  }
>  
>  /* try to detect pgm check loops */
