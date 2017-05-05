Received: from eggs.gnu.org ([2001:4830:134:3::10]:55295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jr9-00055I-G6
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jr8-00019H-6b
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:29:39 -0400
Date: Fri, 5 May 2017 17:29:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505202923.GM3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-8-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-8-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/24] pc: add node-id property to CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 03, 2017 at 02:57:01PM +0200, Igor Mammedov wrote:
> it will allow switching from cpu_index to property based
> numa mapping in follow up patches.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/pc.c      | 17 +++++++++++++++++
>  target/i386/cpu.c |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9cec0c1..4a4fb1c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1893,6 +1893,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                              DeviceState *dev, Error **errp)
>  {
>      int idx;
> +    int node_id;
>      CPUState *cs;
>      CPUArchId *cpu_slot;
>      X86CPUTopoInfo topo;
> @@ -1982,6 +1983,22 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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

I suggest moving the above lines to cpu_common_realizefn(), and
deleting the code in numa_post_machine_init().

If you want to do this in v3 of this series, or as a follow-up
patch, it's up to you.


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
> index 13c0985..007a5bd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3982,6 +3982,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
>      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
>  #endif
> +    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),

This changes the default from 0 to CPU_UNSET_NUMA_NODE_ID, but it
looks like there's no existing i386 or PC code that ever looks at
CPUState::numa_node. Maybe worth mentioning in the commit
message.

>      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
>      { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
>      DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
> -- 
> 2.7.4
> 

-- 
Eduardo
