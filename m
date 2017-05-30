Received: from eggs.gnu.org ([2001:4830:134:3::10]:41013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFnMl-0000yB-BU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFnMj-00057M-Vk
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:43 -0400
Date: Tue, 30 May 2017 17:03:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530200332.GR32274@thinpad.lan.raisama.net>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
	<1496161442-96665-8-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496161442-96665-8-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] numa: cpu: calculate/set default
 node-ids after all -numa CLI options are parsed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, May 30, 2017 at 06:24:02PM +0200, Igor Mammedov wrote:
> Calculating default node-ids for CPUs in possible_cpu_arch_ids()
> is rather fragile since defaults calculation uses nb_numa_nodes but
> callback might be potentially called early before all -numa CLI
> options are parsed, which would lead to cpus assigned only upto
> nb_numa_nodes at the time possible_cpu_arch_ids() is called.
> 
> Issue was introduced by
> (7c88e65 numa: mirror cpu to node mapping in MachineState::possible_cpus)
> and for example CLI:
>   -smp 4 -numa node,cpus=0 -numa node
> would set props.node-id in possible_cpus array for every non
> explicitly mapped CPU to the first node.
> 
> Issue is not visible to guest nor to mgmt interface due to
>   1) implictly mapped cpus are forced to the first node in
>      case of partial mapping
>   2) in case of default mapping possible_cpu_arch_ids() is
>      called after all -numa options are parsed (resulting
>      in correct mapping).
> 
> However it's fragile to rely on late execution of
> possible_cpu_arch_ids(), therefore add machine specific
> callback that returns node-id for CPU and use it to calculate/
> set defaults at machine_numa_finish_init() time when all -numa
> options are parsed.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/boards.h   |  3 +++
>  include/sysemu/numa.h |  9 +++++++++
>  hw/arm/virt.c         | 16 ++++++++--------
>  hw/core/machine.c     |  1 +
>  hw/i386/pc.c          | 21 ++++++++++++---------
>  hw/ppc/spapr.c        | 16 +++++++---------
>  6 files changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 76ce021..063f329 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -94,6 +94,8 @@ typedef struct {
>   *    Returns an array of @CPUArchId architecture-dependent CPU IDs
>   *    which includes CPU IDs for present and possible to hotplug CPUs.
>   *    Caller is responsible for freeing returned list.
> + * @get_default_cpu_node_id:
> + *    returns default board specific node_id value for CPU
>   * @has_hotpluggable_cpus:
>   *    If true, board supports CPUs creation with -device/device_add.
>   * @minimum_page_bits:
> @@ -151,6 +153,7 @@ struct MachineClass {
>      CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
>                                                           unsigned cpu_index);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
> +    int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);

Aren't we trying to move away from cpu_index-based CPU
identification?  Shouldn't we make this get a CPUArchId argument?

>  };
>  
>  /**
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 610eece..ea123ef 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -36,4 +36,13 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>  void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>                                    int nb_nodes, ram_addr_t size);
>  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);
> +
> +static inline void assert_nb_numa_nodes_change(void)

Can you document the purpose of this function?

> +{
> +    static int saved_nb_numa_nodes;
> +    assert(nb_numa_nodes);
> +    assert(saved_nb_numa_nodes == 0 || saved_nb_numa_nodes == nb_numa_nodes);
> +    saved_nb_numa_nodes = nb_numa_nodes;
> +}
> +
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ce676df..74f1453 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1553,6 +1553,13 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>      return possible_cpus->cpus[cpu_index].props;
>  }
>  
> +static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +    assert(nb_numa_nodes);
> +    assert_nb_numa_nodes_change();

I would move this assert to common code instead of copying it to
all implementations.

A machine_get_default_cpu_node_id() wrapper that calls
assert_nb_numa_nodes_change() and mc->get_default_cpu_node_id()
would be enough, and it wouldn't even need to be declared in a
header as the only caller would be at hw/core/machine.c.

(Or, if you prefer to simply drop the assert(), I think that
would be OK too.)


> +    return idx % nb_numa_nodes;
> +}
> +
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  {
>      int n;
> @@ -1571,14 +1578,6 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>              virt_cpu_mp_affinity(vms, n);
>          ms->possible_cpus->cpus[n].props.has_thread_id = true;
>          ms->possible_cpus->cpus[n].props.thread_id = n;
> -
> -        /* default distribution of CPUs over NUMA nodes */
> -        if (nb_numa_nodes) {
> -            /* preset values but do not enable them i.e. 'has_node_id = false',
> -             * numa init code will enable them later if manual mapping wasn't
> -             * present on CLI */
> -            ms->possible_cpus->cpus[n].props.node_id = n % nb_numa_nodes;
> -        }
>      }
>      return ms->possible_cpus;
>  }
> @@ -1601,6 +1600,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->minimum_page_bits = 12;
>      mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
>      mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
> +    mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>  }
>  
>  static const TypeInfo virt_machine_info = {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 964b75d..01028c8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -723,6 +723,7 @@ static void machine_numa_finish_init(MachineState *machine)
>              /* fetch default mapping from board and enable it */
>              CpuInstanceProperties props = cpu_slot->props;
>  
> +            props.node_id = mc->get_default_cpu_node_id(machine, i);
>              if (!default_mapping) {
>                  /* record slots with not set mapping,
>                   * TODO: make it hard error in future */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 84f0a6f..51d5a1b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2253,6 +2253,17 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>      return possible_cpus->cpus[cpu_index].props;
>  }
>  
> +static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +   X86CPUTopoInfo topo;
> +
> +   assert_nb_numa_nodes_change();
> +   assert(ms->possible_cpus && (idx < ms->possible_cpus->len));
> +   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> +                            smp_cores, smp_threads, &topo);
> +   return topo.pkg_id % nb_numa_nodes;
> +}
> +
>  static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>  {
>      int i;
> @@ -2282,15 +2293,6 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>          ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
>          ms->possible_cpus->cpus[i].props.has_thread_id = true;
>          ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
> -
> -        /* default distribution of CPUs over NUMA nodes */
> -        if (nb_numa_nodes) {
> -            /* preset values but do not enable them i.e. 'has_node_id = false',
> -             * numa init code will enable them later if manual mapping wasn't
> -             * present on CLI */
> -            ms->possible_cpus->cpus[i].props.node_id =
> -                topo.pkg_id % nb_numa_nodes;
> -        }
>      }
>      return ms->possible_cpus;
>  }
> @@ -2335,6 +2337,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->linuxboot_dma_enabled = true;
>      mc->get_hotplug_handler = pc_get_hotpug_handler;
>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
> +    mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
>      mc->has_hotpluggable_cpus = true;
>      mc->default_boot_order = "cad";
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 96a2a74..06d0fb3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3002,6 +3002,12 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
>      return core_slot->props;
>  }
>  
> +static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +    assert_nb_numa_nodes_change();
> +    return idx / smp_cores % nb_numa_nodes;
> +}
> +
>  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
>  {
>      int i;
> @@ -3026,15 +3032,6 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
>          machine->possible_cpus->cpus[i].arch_id = core_id;
>          machine->possible_cpus->cpus[i].props.has_core_id = true;
>          machine->possible_cpus->cpus[i].props.core_id = core_id;
> -
> -        /* default distribution of CPUs over NUMA nodes */
> -        if (nb_numa_nodes) {
> -            /* preset values but do not enable them i.e. 'has_node_id = false',
> -             * numa init code will enable them later if manual mapping wasn't
> -             * present on CLI */
> -            machine->possible_cpus->cpus[i].props.node_id =
> -                core_id / smp_threads / smp_cores % nb_numa_nodes;
> -        }
>      }
>      return machine->possible_cpus;
>  }
> @@ -3160,6 +3157,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      hc->plug = spapr_machine_device_plug;
>      hc->unplug = spapr_machine_device_unplug;
>      mc->cpu_index_to_instance_props = spapr_cpu_index_to_props;
> +    mc->get_default_cpu_node_id = spapr_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
>      hc->unplug_request = spapr_machine_device_unplug_request;
>  
> -- 
> 2.7.4
> 

-- 
Eduardo
