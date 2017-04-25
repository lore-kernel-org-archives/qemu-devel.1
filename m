Received: from eggs.gnu.org ([2001:4830:134:3::10]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d33vN-0006Cr-0f
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d33vL-0007T6-SN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:06:48 -0400
Date: Tue, 25 Apr 2017 19:06:34 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170425170634.2mqfc45fujwy7qu3@kamzik.brq.redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-15-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490189568-167621-15-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 14/23] virt-arm: get numa node
 mapping from possible_cpus instead of numa_get_node_for_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Mar 22, 2017 at 02:32:39PM +0100, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 19 +++++++------------
>  hw/arm/virt.c            | 13 +++++++------
>  2 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 0835e59..ce7499c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -486,30 +486,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiSystemResourceAffinityTable *srat;
>      AcpiSratProcessorGiccAffinity *core;
>      AcpiSratMemoryAffinity *numamem;
> -    int i, j, srat_start;
> +    int i, srat_start;
>      uint64_t mem_base;
> -    uint32_t *cpu_node = g_malloc0(vms->smp_cpus * sizeof(uint32_t));
> -
> -    for (i = 0; i < vms->smp_cpus; i++) {
> -        j = numa_get_node_for_cpu(i);
> -        if (j < nb_numa_nodes) {
> -                cpu_node[i] = j;
> -        }
> -    }
> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
> +    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
>  
>      srat_start = table_data->len;
>      srat = acpi_data_push(table_data, sizeof(*srat));
>      srat->reserved1 = cpu_to_le32(1);
>  
> -    for (i = 0; i < vms->smp_cpus; ++i) {
> +    for (i = 0; i < cpu_list->len; ++i) {
> +        int node_id = cpu_list->cpus[i].props.has_node_id ?
> +            cpu_list->cpus[i].props.node_id : 0;
>          core = acpi_data_push(table_data, sizeof(*core));
>          core->type = ACPI_SRAT_PROCESSOR_GICC;
>          core->length = sizeof(*core);
> -        core->proximity = cpu_to_le32(cpu_node[i]);
> +        core->proximity = cpu_to_le32(node_id);
>          core->acpi_processor_uid = cpu_to_le32(i);
>          core->flags = cpu_to_le32(1);
>      }
> -    g_free(cpu_node);
>  
>      mem_base = vms->memmap[VIRT_MEM].base;
>      for (i = 0; i < nb_numa_nodes; ++i) {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 68d44f3..0a75df5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -338,7 +338,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>  {
>      int cpu;
>      int addr_cells = 1;
> -    unsigned int i;
> +    const MachineState *ms = MACHINE(vms);
>  
>      /*
>       * From Documentation/devicetree/bindings/arm/cpus.txt
> @@ -369,6 +369,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>      for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
>          char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
>          ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
> +        CPUState *cs = CPU(armcpu);
>  
>          qemu_fdt_add_subnode(vms->fdt, nodename);
>          qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "cpu");
> @@ -389,9 +390,9 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>                                    armcpu->mp_affinity);
>          }
>  
> -        i = numa_get_node_for_cpu(cpu);
> -        if (i < nb_numa_nodes) {
> -            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id", i);
> +        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
> +            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
> +                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
>          }
>  
>          g_free(nodename);
> @@ -1378,8 +1379,8 @@ static void machvirt_init(MachineState *machine)
>          cs = CPU(cpuobj);
>          cs->cpu_index = n;
>  
> -        node_id = numa_get_node_for_cpu(cs->cpu_index);
> -        if (node_id == nb_numa_nodes) {
> +        node_id = machine->possible_cpus->cpus[cs->cpu_index].props.node_id;
> +        if (!machine->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
>              /* by default CPUState::numa_node was 0 if it's not set via CLI
>               * keep it this way for now but in future we probably should
>               * refuse to start up with incomplete numa mapping */
> -- 
> 2.7.4
> 
>

We now have many machine->possible_cpus->cpus[index].props.[has_]node_id
instances. I think we need inline accessors added to include/sysemu/numa.h
like

 static inline bool numa_has_node_id(MachineState *ms, int index)
 {
   return ms->possible_cpus->cpus[index].props.has_node_id;
 }

 static inline int numa_node_id(MachineState *ms, int index)
 {
   return ms->possible_cpus->cpus[index].props.node_id;
 }

 ...

to improve readability and maintainability.

Or, instead, we could provide macros to allow assignments, e.g.

 #define NUMA_HAS_NODE_ID(ms, index) \
   ((ms)->possible_cpus->cpus[index].props.has_node_id)
 #define NUMA_NODE_ID(ms, index) \
   ((ms)->possible_cpus->cpus[index].props.node_id)


Thanks,
drew
