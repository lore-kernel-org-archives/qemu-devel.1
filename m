Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyPPd-0007aS-C5
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyPPc-0003xU-B9
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 17:02:49 -0400
Date: Wed, 12 Apr 2017 18:02:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170412210239.GC27126@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-8-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490189568-167621-8-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/23] pc: add node-id property to
 CPU
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

On Wed, Mar 22, 2017 at 02:32:32PM +0100, Igor Mammedov wrote:
> it will allow switching from cpu_index to property based
> numa mapping in follow up patches.

I am not sure I understand all the consequences of this, so I
will give it a try:

"node-id" is an existing field in CpuInstanceProperties.
CpuInstanceProperties is used on both query-hotpluggable-cpus
output and in MachineState::possible_cpus.

We will start using MachineState::possible_cpus to keep track of
NUMA CPU affinity, and that means query-hotpluggable-cpus will
start reporting a "node-id" property when a NUMA mapping is
configured.

To allow query-hotpluggable-cpus to report "node-id", the CPU
objects must have a "node-id" property that can be set. This
patch adds the "node-id" property to X86CPU.

Is this description accurate? Is the presence of "node-id" in
query-hotpluggable-cpus the only reason we really need this
patch, or is there something else that requires the "node-id"
property?

Why exactly do we need to change the output of
query-hotpluggable-cpus for all machines to include "node-id", to
make "-numa cpu" work?  Did you consider saving node_id inside
CPUArchId and outside CpuInstanceProperties, so
query-hotplugabble-cpus output won't be affected by "-numa cpu"?

I'm asking this because I believe we will eventually need a
mechanism that lets management check what are the valid arguments
for "-numa cpu" for a given machine, and it looks like
query-hotpluggable-cpus is already the right mechanism for that.
But we can't make query-hotpluggable-cpus output depend on "-numa
cpu" input, if the "-numa cpu" input will also depend on
query-hotpluggable-cpus output.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/pc.c      | 17 +++++++++++++++++
>  target/i386/cpu.c |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7031100..873bbfa 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1895,6 +1895,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                              DeviceState *dev, Error **errp)
>  {
>      int idx;
> +    int node_id;
>      CPUState *cs;
>      CPUArchId *cpu_slot;
>      X86CPUTopoInfo topo;
> @@ -1984,6 +1985,22 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>      cs = CPU(cpu);
>      cs->cpu_index = idx;
> +
> +    node_id = numa_get_node_for_cpu(cs->cpu_index);
> +    if (node_id == nb_numa_nodes) {
> +        /* by default CPUState::numa_node was 0 if it's not set via CLI
> +         * keep it this way for now but in future we probably should
> +         * refuse to start up with incomplete numa mapping */
> +        node_id = 0;
> +    }
> +    if (cs->numa_node == CPU_UNSET_NUMA_NODE_ID) {
> +        cs->numa_node = node_id;
> +    } else if (cs->numa_node != node_id) {
> +            error_setg(errp, "node-id %d must match numa node specified"
> +                "with -numa option for cpu-index %d",
> +                cs->numa_node, cs->cpu_index);
> +            return;
> +    }
>  }
>  
>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7aa7622..d690244 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3974,6 +3974,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
>  #endif
> +    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
>      { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
>      DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
