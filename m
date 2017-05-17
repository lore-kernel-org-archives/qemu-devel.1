Received: from eggs.gnu.org ([2001:4830:134:3::10]:50074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAtzX-0008Bq-EQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAtzS-0001Q1-Po
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAtzS-0001Pp-Gq
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:07:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-24-ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:07:18 +0200
In-Reply-To: <20170511191843.13784-24-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Thu, 11 May 2017 16:18:37 -0300")
Message-ID: <87wp9f6h55.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 23/29] numa: use possible_cpus for not
 mapped CPUs check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> From: Igor Mammedov <imammedo@redhat.com>
>
> and remove corresponding part in numa.c that uses
> node_cpu bitmaps.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Message-Id: <1494415802-227633-16-git-send-email-imammedo@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/machine.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  numa.c            | 10 ----------
>  2 files changed, 58 insertions(+), 10 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 64e2a4ff2c..fd6a436064 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -20,6 +20,7 @@
>  #include "sysemu/numa.h"
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
> +#include "sysemu/numa.h"
>  
>  static char *machine_get_accel(Object *obj, Error **errp)
>  {
> @@ -678,9 +679,66 @@ bool machine_mem_merge(MachineState *machine)
>      return machine->mem_merge;
>  }
>  
> +static char *cpu_slot_to_string(const CPUArchId *cpu)
> +{
> +    GString *s = g_string_new(NULL);
> +    if (cpu->props.has_socket_id) {
> +        g_string_append_printf(s, "socket-id: %"PRId64, cpu->props.socket_id);
> +    }
> +    if (cpu->props.has_core_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "core-id: %"PRId64, cpu->props.core_id);
> +    }
> +    if (cpu->props.has_thread_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "thread-id: %"PRId64, cpu->props.thread_id);
> +    }
> +    return g_string_free(s, false);
> +}
> +
> +static void machine_numa_validate(MachineState *machine)
> +{
> +    int i;
> +    GString *s = g_string_new(NULL);
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
> +
> +    assert(nb_numa_nodes);
> +    for (i = 0; i < possible_cpus->len; i++) {
> +        const CPUArchId *cpu_slot = &possible_cpus->cpus[i];
> +
> +        /* at this point numa mappings are initilized by CLI options
> +         * or with default mappings so it's sufficient to list
> +         * all not yet mapped CPUs here */
> +        /* TODO: make it hard error in future */
> +        if (!cpu_slot->props.has_node_id) {
> +            char *cpu_str = cpu_slot_to_string(cpu_slot);
> +            g_string_append_printf(s, "%sCPU %d [%s]", s->len ? ", " : "", i,
> +                                   cpu_str);
> +            g_free(cpu_str);
> +        }
> +    }
> +    if (s->len) {
> +        error_report("warning: CPU(s) not present in any NUMA nodes: %s",
> +                     s->str);
> +        error_report("warning: All CPU(s) up to maxcpus should be described "
> +                     "in NUMA config, ability to start up with partial NUMA "
> +                     "mappings is obsoleted and will be removed in future");

I can see this gripes in output of make check.  Shouldn't you suppress
them on qtest_enabled(), like we do elsewhere?

> +    }
> +    g_string_free(s, true);
> +}

[...]
