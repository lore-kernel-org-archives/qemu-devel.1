Received: from eggs.gnu.org ([2001:4830:134:3::10]:54372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d0nZv-0007eT-H4
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d0nZr-0003k4-29
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:15:19 -0400
Date: Wed, 19 Apr 2017 13:14:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170419131458.59e2d00e@nial.brq.redhat.com>
In-Reply-To: <20170412210239.GC27126@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-8-git-send-email-imammedo@redhat.com>
	<20170412210239.GC27126@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 12 Apr 2017 18:02:39 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Mar 22, 2017 at 02:32:32PM +0100, Igor Mammedov wrote:
> > it will allow switching from cpu_index to property based
> > numa mapping in follow up patches.  
> 
> I am not sure I understand all the consequences of this, so I
> will give it a try:
> 
> "node-id" is an existing field in CpuInstanceProperties.
> CpuInstanceProperties is used on both query-hotpluggable-cpus
> output and in MachineState::possible_cpus.
> 
> We will start using MachineState::possible_cpus to keep track of
> NUMA CPU affinity, and that means query-hotpluggable-cpus will
> start reporting a "node-id" property when a NUMA mapping is
> configured.
> 
> To allow query-hotpluggable-cpus to report "node-id", the CPU
> objects must have a "node-id" property that can be set. This
> patch adds the "node-id" property to X86CPU.
> 
> Is this description accurate? Is the presence of "node-id" in
> query-hotpluggable-cpus the only reason we really need this
> patch, or is there something else that requires the "node-id"
> property?
That accurate description, node-id is in the same 'address'
properties category as socket/core/thread-id. So if you have
numa enabled machine you'd see node-id property in
query-hotpluggable-cpus.


> Why exactly do we need to change the output of
> query-hotpluggable-cpus for all machines to include "node-id", to
> make "-numa cpu" work?
It's for introspection as well as for consolidating topology data
in a single place purposes and complements already outputed
socket/core/thread-id address properties with numa node-id.
That way one doesn't need yet another command for introspecting
numa mapping for cpus and use existing query-hotpluggable-cpus
for full topology description.

>  Did you consider saving node_id inside
> CPUArchId and outside CpuInstanceProperties, so
> query-hotplugabble-cpus output won't be affected by "-numa cpu"?
nope, intent was to make node-id visible if numa is enabled and
I think that intent was there from the very begging when
query-hotplugabble-cpus was introduced with CpuInstanceProperties
having node_id field but unused since it has been out of scope
of cpu hotplug.


> I'm asking this because I believe we will eventually need a
> mechanism that lets management check what are the valid arguments
> for "-numa cpu" for a given machine, and it looks like
> query-hotpluggable-cpus is already the right mechanism for that.
it's problem similar with -device cpu_foo,...

> But we can't make query-hotpluggable-cpus output depend on "-numa
> cpu" input, if the "-numa cpu" input will also depend on
> query-hotpluggable-cpus output.
I don't think that query-hotpluggable-cpus must be independent of
'-numa' option.

query-hotpluggable-cpus is a function of -smp and machine type and
it's output is dynamic and can change during runtime so we've never
made promise to make it static. I think it's ok to make it depend
on -numa as extra input argument when present.

It bothers me as well, that '-numa cpu' as well as '-device cpu_foo'
options depend on query-hotpluggable-cpus and when we considered
generic '-device cpu' support, we though that initially
query-hotpluggable-cpus could be used to get list of CPUs
for given -smp/machine combination and then it could be used
for composing proper CLI. That makes mgmt to start QEMU twice
when creating configuration for the 1st time, but end result CLI
could be reused without repeating query step again provided
topology/machine stays the same. The same applies to '-numa cpu'.

In future to avoid starting QEMU twice we were thinking about
configuring QEMU from QMP at runtime, that's where preconfigure
approach could be used to help solving it in the future:

  1. introduce pause before machine_init CLI option to allow
     preconfig machine from qmp/monitor
  2. make query-hotpluggable-cpus usable at preconfig time
  3. start qemu with needed number of numa nodes and default mapping:
         #qemu -smp ... -numa node,nodeid=0 -node node,nodeid=1
  4. get possible cpus list
  5. add qmp/monitor command variant for '-numa cpu' to set numa mapping
  6. optionally, set new numa mapping and get updated
     possible cpus list with query-hotpluggable-cpus
  7. optionally, add extra cpus with device_add using updated
     cpus list and get updated cpus list as it's been changed again.
  8. unpause preconfig stage and let qemu continue to execute
     machine_init and the rest.

Since we would need to implement QMP configuration for '-device cpu',
we as well might reuse it for custom numa mapping.
 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/i386/pc.c      | 17 +++++++++++++++++
> >  target/i386/cpu.c |  1 +
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 7031100..873bbfa 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1895,6 +1895,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >                              DeviceState *dev, Error **errp)
> >  {
> >      int idx;
> > +    int node_id;
> >      CPUState *cs;
> >      CPUArchId *cpu_slot;
> >      X86CPUTopoInfo topo;
> > @@ -1984,6 +1985,22 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >  
> >      cs = CPU(cpu);
> >      cs->cpu_index = idx;
> > +
> > +    node_id = numa_get_node_for_cpu(cs->cpu_index);
> > +    if (node_id == nb_numa_nodes) {
> > +        /* by default CPUState::numa_node was 0 if it's not set via CLI
> > +         * keep it this way for now but in future we probably should
> > +         * refuse to start up with incomplete numa mapping */
> > +        node_id = 0;
> > +    }
> > +    if (cs->numa_node == CPU_UNSET_NUMA_NODE_ID) {
> > +        cs->numa_node = node_id;
> > +    } else if (cs->numa_node != node_id) {
> > +            error_setg(errp, "node-id %d must match numa node specified"
> > +                "with -numa option for cpu-index %d",
> > +                cs->numa_node, cs->cpu_index);
> > +            return;
> > +    }
> >  }
> >  
> >  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 7aa7622..d690244 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3974,6 +3974,7 @@ static Property x86_cpu_properties[] = {
> >      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
> >      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
> >  #endif
> > +    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
> >      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
> >      { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
> >      DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
> > -- 
> > 2.7.4
> > 
> >   
> 
