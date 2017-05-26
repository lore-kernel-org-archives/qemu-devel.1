Received: from eggs.gnu.org ([2001:4830:134:3::10]:52906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEHRp-0005Pm-6y
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dEHRo-0001z9-GH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:46:41 -0400
Date: Fri, 26 May 2017 12:46:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170526154625.GI22043@thinpad.lan.raisama.net>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
	<1494415802-227633-7-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494415802-227633-7-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/18] numa: mirror cpu to node mapping
 in MachineState::possible_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, May 10, 2017 at 01:29:50PM +0200, Igor Mammedov wrote:
[...]
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2482c63..420c8c4 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -389,6 +389,102 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
[...]
> +void machine_set_cpu_numa_node(MachineState *machine,
> +                               const CpuInstanceProperties *props, Error **errp)
> +{
[...]
> +    /* force board to initialize possible_cpus if it hasn't been done yet */
> +    mc->possible_cpu_arch_ids(machine);
[...]
> diff --git a/numa.c b/numa.c
> index 7182481..7db5dde 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -170,6 +170,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          exit(1);
>      }
>      for (cpus = node->cpus; cpus; cpus = cpus->next) {
> +        CpuInstanceProperties props;
>          if (cpus->value >= max_cpus) {
>              error_setg(errp,
>                         "CPU index (%" PRIu16 ")"
> @@ -178,6 +179,10 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>              return;
>          }
>          bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
> +        props = mc->cpu_index_to_instance_props(ms, cpus->value);
> +        props.node_id = nodenr;
> +        props.has_node_id = true;
> +        machine_set_cpu_numa_node(ms, &props, &error_fatal);

This triggers a call to possible_cpu_arch_ids() before
nb_numa_nodes is set to the actual number of NUMA nodes in the
machine, breaking the "node_id = ... % nb_numa_nodes"
initialization logic in pc, virt, and spapr.

The initialization ordering between possible_cpus and NUMA data
structures looks very subtle and fragile.  I still don't see an
obvious way to untangle that.

I suggest moving the default-NUMA-mapping code to a separate
machine class method, instead of relying on
possible_cpu_arch_ids() to initialize node_id.

-- 
Eduardo
