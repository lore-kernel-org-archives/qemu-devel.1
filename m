Received: from eggs.gnu.org ([2001:4830:134:3::10]:47550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhaba-0001SW-Ec
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhabV-0003qq-Gs
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:10:26 -0400
Date: Mon, 23 Jul 2018 15:10:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180723151010.7b4bfd8c@redhat.com>
In-Reply-To: <20180704124923.32483-4-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
	<20180704124923.32483-4-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] hw/arm/virt: DT: add cpu-map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, wei@redhat.com

On Wed,  4 Jul 2018 14:49:20 +0200
Andrew Jones <drjones@redhat.com> wrote:

> Support devicetree CPU topology descriptions.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt.c         | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 880441275031..6c5fecdd61df 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -40,6 +40,7 @@
>  #include "hw/devices.h"
>  #include "net/net.h"
>  #include "sysemu/device_tree.h"
> +#include "sysemu/cpus.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
> @@ -302,6 +303,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>      int cpu;
>      int addr_cells = 1;
>      const MachineState *ms = MACHINE(vms);
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>  
>      /*
>       * From Documentation/devicetree/bindings/arm/cpus.txt
> @@ -358,8 +360,38 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>                  ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
>          }
>  
> +        qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle",
> +                              qemu_fdt_alloc_phandle(vms->fdt));
it's not obvious how this hunk is related to patch
(also it affects ignore_cpu_topology = true which probably isn't intended)

>          g_free(nodename);
>      }
> +
> +    if (!vmc->ignore_cpu_topology) {
> +        /* From Documentation/devicetree/bindings/arm/topology.txt
> +         */
> +        qemu_fdt_add_subnode(vms->fdt, "/cpus/cpu-map");
> +
> +        for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
I'd iterate over possible_cpus array instead

> +            char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
> +            char *map_path;
> +
> +            if (smp_threads > 1) {
> +                map_path = g_strdup_printf(
> +                               "/cpus/cpu-map/%s%d/%s%d/%s%d",
> +                               "cluster", cpu / (smp_cores * smp_threads),
> +                               "core", (cpu / smp_threads) % smp_cores,
> +                               "thread", cpu % smp_threads);
> +            } else {
> +                map_path = g_strdup_printf(
> +                               "/cpus/cpu-map/%s%d/%s%d",
> +                               "cluster", cpu / smp_cores,
> +                               "core", cpu % smp_cores);
> +            }
not sure about direct calculation of numbers here,
do they relate in any way to ms->possible_cpus->cpus[].props.(socket|core|thread-id) ?


> +            qemu_fdt_add_path(vms->fdt, map_path);
> +            qemu_fdt_setprop_phandle(vms->fdt, map_path, "cpu", cpu_path);
> +            g_free(map_path);
> +            g_free(cpu_path);
> +        }
> +    }
>  }
>  
>  static void fdt_add_its_gic_node(VirtMachineState *vms)
> @@ -1839,7 +1871,10 @@ static void virt_3_0_instance_init(Object *obj)
>  
>  static void virt_machine_3_0_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_3_1_options(mc);
> +    vmc->ignore_cpu_topology = true;
>  }
>  DEFINE_VIRT_MACHINE(3, 0)
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 9a870ccb6a57..deb8bee72cda 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -94,6 +94,7 @@ typedef struct MemMapEntry {
>  typedef struct {
>      MachineClass parent;
>      bool disallow_affinity_adjustment;
> +    bool ignore_cpu_topology;
missing doc comment for the knob

>      bool no_its;
>      bool no_pmu;
>      bool claim_edge_triggered_timers;
