Received: from eggs.gnu.org ([2001:4830:134:3::10]:59588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6FuS-000130-8r
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6FuM-0004mG-6V
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:31:04 -0400
Date: Thu, 4 May 2017 14:30:44 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170504123044.dieszx6qvezdz5zf@kamzik.brq.redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-14-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-14-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/24] pc: get numa node mapping from
 possible_cpus instead of numa_get_node_for_cpu()
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

On Wed, May 03, 2017 at 02:57:07PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>    use numa_[has_]node_id() wrappers (Drew)
> ---
>  hw/acpi/cpu.c        |  7 +++----
>  hw/i386/acpi-build.c | 11 ++++-------
>  hw/i386/pc.c         | 18 ++++++++++--------
>  3 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 8c719d3..2002198 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -503,7 +503,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>  
>          /* build Processor object for each processor */
>          for (i = 0; i < arch_ids->len; i++) {
> -            int j;
>              Aml *dev;
>              Aml *uid = aml_int(i);
>              GArray *madt_buf = g_array_new(0, 1, 1);
> @@ -557,9 +556,9 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>               * as a result _PXM is required for all CPUs which might
>               * be hot-plugged. For simplicity, add it for all CPUs.
>               */
> -            j = numa_get_node_for_cpu(i);
> -            if (j < nb_numa_nodes) {
> -                aml_append(dev, aml_name_decl("_PXM", aml_int(j)));
> +            if (numa_has_node_id(arch_ids, i)) {
> +                aml_append(dev,
> +                    aml_name_decl("_PXM", aml_int(numa_node_id(arch_ids, i))));
>              }
>  
>              aml_append(cpus_dev, dev);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2073108..a66a968 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2306,7 +2306,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>      srat->reserved1 = cpu_to_le32(1);
>  
>      for (i = 0; i < apic_ids->len; i++) {
> -        int j = numa_get_node_for_cpu(i);
> +        int node_id = numa_has_node_id(apic_ids, i) ?
> +            numa_node_id(apic_ids, i) : 0;
>          uint32_t apic_id = apic_ids->cpus[i].arch_id;
>  
>          if (apic_id < 255) {
> @@ -2316,9 +2317,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>              core->type = ACPI_SRAT_PROCESSOR_APIC;
>              core->length = sizeof(*core);
>              core->local_apic_id = apic_id;
> -            if (j < nb_numa_nodes) {
> -                core->proximity_lo = j;
> -            }
> +            core->proximity_lo = node_id;
>              memset(core->proximity_hi, 0, 3);
>              core->local_sapic_eid = 0;
>              core->flags = cpu_to_le32(1);
> @@ -2329,9 +2328,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>              core->type = ACPI_SRAT_PROCESSOR_x2APIC;
>              core->length = sizeof(*core);
>              core->x2apic_id = cpu_to_le32(apic_id);
> -            if (j < nb_numa_nodes) {
> -                core->proximity_domain = cpu_to_le32(j);
> -            }
> +            core->proximity_domain = cpu_to_le32(node_id);
>              core->flags = cpu_to_le32(1);
>          }
>      }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4a4fb1c..aeecf4b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -747,7 +747,9 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
>  {
>      FWCfgState *fw_cfg;
>      uint64_t *numa_fw_cfg;
> -    int i, j;
> +    int i;
> +    const CPUArchIdList *cpus;
> +    MachineClass *mc = MACHINE_GET_CLASS(pcms);
>  
>      fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
> @@ -782,12 +784,12 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
>       */
>      numa_fw_cfg = g_new0(uint64_t, 1 + pcms->apic_id_limit + nb_numa_nodes);
>      numa_fw_cfg[0] = cpu_to_le64(nb_numa_nodes);
> -    for (i = 0; i < max_cpus; i++) {
> -        unsigned int apic_id = x86_cpu_apic_id_from_index(i);
> +    cpus = mc->possible_cpu_arch_ids(MACHINE(pcms));
> +    for (i = 0; i < cpus->len; i++) {
> +        unsigned int apic_id = cpus->cpus[i].arch_id;
>          assert(apic_id < pcms->apic_id_limit);
> -        j = numa_get_node_for_cpu(i);
> -        if (j < nb_numa_nodes) {
> -            numa_fw_cfg[apic_id + 1] = cpu_to_le64(j);
> +        if (numa_has_node_id(cpus, i)) {
> +            numa_fw_cfg[apic_id + 1] = cpu_to_le64(numa_node_id(cpus, i));
>          }
>      }
>      for (i = 0; i < nb_numa_nodes; i++) {
> @@ -1984,8 +1986,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      cs = CPU(cpu);
>      cs->cpu_index = idx;
>  
> -    node_id = numa_get_node_for_cpu(cs->cpu_index);
> -    if (node_id == nb_numa_nodes) {
> +    node_id = cpu_slot->props.node_id;
> +    if (!cpu_slot->props.has_node_id) {
>          /* by default CPUState::numa_node was 0 if it's not set via CLI
>           * keep it this way for now but in future we probably should
>           * refuse to start up with incomplete numa mapping */
> -- 
> 2.7.4
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
