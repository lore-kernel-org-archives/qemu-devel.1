Received: from eggs.gnu.org ([2001:4830:134:3::10]:50037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyfGL-0004X5-Ti
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyfGK-0004fm-Ve
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:58:17 -0400
Date: Thu, 13 Apr 2017 10:58:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170413135805.GE27126@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-11-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490189568-167621-11-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/23] numa: mirror cpu to node
 mapping in MachineState::possible_cpus
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

On Wed, Mar 22, 2017 at 02:32:35PM +0100, Igor Mammedov wrote:
> Introduce machine_set_cpu_numa_node() helper that stores
> node mapping for CPU in MachineState::possible_cpus.
> CPU and node it belongs to is specified by 'props' argument.
> 
> Patch doesn't remove old way of storing mapping in
> numa_info[X].node_cpu as removing it at the same time
> makes patch rather big. Instead it just mirrors mapping
> in possible_cpus and follow up per target patches will
> switch to possible_cpus and numa_info[X].node_cpu will
> be removed once there isn't any users left.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/boards.h |  2 ++
>  hw/core/machine.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  numa.c              |  8 +++++++
>  3 files changed, 78 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 1dd0fde..40f30f1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -42,6 +42,8 @@ bool machine_dump_guest_core(MachineState *machine);
>  bool machine_mem_merge(MachineState *machine);
>  void machine_register_compat_props(MachineState *machine);
>  HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
> +void machine_set_cpu_numa_node(MachineState *machine,
> +                               CpuInstanceProperties *props, Error **errp);
>  
>  /**
>   * CPUArchId:
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0d92672..6ff0b45 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -388,6 +388,74 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
>      return head;
>  }
>  
> +void machine_set_cpu_numa_node(MachineState *machine,
> +                               CpuInstanceProperties *props, Error **errp)

If you change this to:

  void cpu_slot_set_numa_node(CPUArchId *slot, uint64_t node_id,
                              Error **errp);

and move the CPU slot lookup code from machine_set_cpu_numa_node()
to a helper:

  CPUArchId *machine_get_cpu_slot(MachineState *machine,
                                  CpuInstanceProperties *props, Error **errp);

and change cpu_index_to_cpu_instance_props to return CPUArchId:

  CPUArchId *cpu_index_to_cpu_slot(MachineState *machine, int cpu_index);

We could simply have this on "-numa cpu" code:

    slot = machine_get_cpu_slot(machine, props);
    cpu_slot_set_numa_node(slot, node_id);

and this on the legacy "-numa node,cpu=..." code:

    slot = mc->cpu_index_to_cpu_slot(machine, i);
    cpu_slot_set_numa_node(slot, node_id);

I believe we will be able to reuse machine_get_cpu_slot() to
replace pc_find_cpu_slot() and spapr_find_cpu_slot() later.

(I also suggest renaming "CPUArchId" and "possible CPUs" to
"CPUSlot" and "CPU slots" in the code and comments. This would
help people reviewing the code, but it can be done later if you
prefer.)

[...]
> @@ -177,6 +178,10 @@ static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
>              return;
>          }
>          bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
> +        props = mc->cpu_index_to_instance_props(ms, cpus->value);
> +        props.node_id = nodenr;
> +        props.has_node_id = true;
> +        machine_set_cpu_numa_node(ms, &props, &error_fatal);
>      }
>  
>      if (node->has_mem && node->has_memdev) {
> @@ -393,9 +398,12 @@ void parse_numa_opts(MachineState *ms)
>          if (i == nb_numa_nodes) {
>              for (i = 0; i < max_cpus; i++) {
>                  CpuInstanceProperties props;
> +                /* fetch default mapping from board and enable it */
>                  props = mc->cpu_index_to_instance_props(ms, i);
> +                props.has_node_id = true;
>  
>                  set_bit(i, numa_info[props.node_id].node_cpu);
> +                machine_set_cpu_numa_node(ms, &props, &error_fatal);
>              }
>          }
>  
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
