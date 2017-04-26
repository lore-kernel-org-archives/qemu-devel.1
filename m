Received: from eggs.gnu.org ([2001:4830:134:3::10]:56068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3Lx7-0001NM-3j
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3Lx5-0007NX-HM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:21:49 -0400
Date: Wed, 26 Apr 2017 09:21:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170426122138.GU3482@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-8-git-send-email-imammedo@redhat.com>
	<20170412210239.GC27126@thinpad.lan.raisama.net>
	<20170419131458.59e2d00e@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419131458.59e2d00e@nial.brq.redhat.com>
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


(Sorry for taking so long to continue the discussion. I thought I
was convinced setting node-id on HotpluggableCPU.props was
required, but after thinking more about it, it looks like it's
still not required.)

On Wed, Apr 19, 2017 at 01:14:58PM +0200, Igor Mammedov wrote:
> On Wed, 12 Apr 2017 18:02:39 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Mar 22, 2017 at 02:32:32PM +0100, Igor Mammedov wrote:
> > > it will allow switching from cpu_index to property based
> > > numa mapping in follow up patches.  
> > 
> > I am not sure I understand all the consequences of this, so I
> > will give it a try:
> > 
> > "node-id" is an existing field in CpuInstanceProperties.
> > CpuInstanceProperties is used on both query-hotpluggable-cpus
> > output and in MachineState::possible_cpus.
> > 
> > We will start using MachineState::possible_cpus to keep track of
> > NUMA CPU affinity, and that means query-hotpluggable-cpus will
> > start reporting a "node-id" property when a NUMA mapping is
> > configured.
> > 
> > To allow query-hotpluggable-cpus to report "node-id", the CPU
> > objects must have a "node-id" property that can be set. This
> > patch adds the "node-id" property to X86CPU.
> > 
> > Is this description accurate? Is the presence of "node-id" in
> > query-hotpluggable-cpus the only reason we really need this
> > patch, or is there something else that requires the "node-id"
> > property?
> That accurate description, node-id is in the same 'address'
> properties category as socket/core/thread-id. So if you have
> numa enabled machine you'd see node-id property in
> query-hotpluggable-cpus.

I agree that we can make -numa cpu affect query-hotpluggable-cpus
output (i.e. affect some field on HotpluggableCPU.props).

But it looks like we disagree about the purpose of
HotpluggableCPU.props:

I believe HotpluggableCPU.props is just an opaque identifier for
the location we want to plug the CPU, and the only requirement is
that it should be unique and have all the information device_add
needs. As socket IDs are already unique on our existing machines,
and socket<=>node mapping is already configured using -numa cpu,
node-id doesn't need to be in HotpluggableCPU.props. (see example
below)

I don't think clients should assume topology information in
HotpluggableCPU.props is always present, because the field has a
different purpose: letting clients know what are the required
device_add arguments. If we need introspection of CPU topology,
we can add new fields to HotpluggableCPU, outside 'props'.

> 
> 
> > Why exactly do we need to change the output of
> > query-hotpluggable-cpus for all machines to include "node-id", to
> > make "-numa cpu" work?
> It's for introspection as well as for consolidating topology data
> in a single place purposes and complements already outputed
> socket/core/thread-id address properties with numa node-id.
> That way one doesn't need yet another command for introspecting
> numa mapping for cpus and use existing query-hotpluggable-cpus
> for full topology description.

I don't disagree about including node-id in HotpluggableCPU
struct, I am just unsure about including it in
HotpluggableCPU.props.

My question is: if we use:

 -numa cpu,socket=2,core=1,thread=0,node-id=3

and then:

 device_add ...,socket=2,core=1,thread=0
 (omitting node-id on device_add)

won't it work exactly the same, and place the new CPU on NUMA
node 3?

In this case, if we don't need a node-id argument on device_add,
so node-id doesn't need to be in HotpluggableCPU.props.

> 
> >  Did you consider saving node_id inside
> > CPUArchId and outside CpuInstanceProperties, so
> > query-hotplugabble-cpus output won't be affected by "-numa cpu"?
> nope, intent was to make node-id visible if numa is enabled and
> I think that intent was there from the very begging when
> query-hotplugabble-cpus was introduced with CpuInstanceProperties
> having node_id field but unused since it has been out of scope
> of cpu hotplug.
> 
> 
> > I'm asking this because I believe we will eventually need a
> > mechanism that lets management check what are the valid arguments
> > for "-numa cpu" for a given machine, and it looks like
> > query-hotpluggable-cpus is already the right mechanism for that.
> it's problem similar with -device cpu_foo,...

True.

> 
> > But we can't make query-hotpluggable-cpus output depend on "-numa
> > cpu" input, if the "-numa cpu" input will also depend on
> > query-hotpluggable-cpus output.
> I don't think that query-hotpluggable-cpus must be independent of
> '-numa' option.
> 
> query-hotpluggable-cpus is a function of -smp and machine type and
> it's output is dynamic and can change during runtime so we've never
> made promise to make it static. I think it's ok to make it depend
> on -numa as extra input argument when present.

OK, I agree that we can make -numa cpu affect
query-hotpluggable-cpus output.

I also think it might be OK to make -numa affect
HotpluggableCPU.props, as clients should be prepared for that. I
just want to understand if we really _have_ to make it so.
Because not including it would help us avoid surprises, and even
simplify the code (making this series shorter).

> 
> It bothers me as well, that '-numa cpu' as well as '-device cpu_foo'
> options depend on query-hotpluggable-cpus and when we considered
> generic '-device cpu' support, we though that initially
> query-hotpluggable-cpus could be used to get list of CPUs
> for given -smp/machine combination and then it could be used
> for composing proper CLI. That makes mgmt to start QEMU twice
> when creating configuration for the 1st time, but end result CLI
> could be reused without repeating query step again provided
> topology/machine stays the same. The same applies to '-numa cpu'.
> 
> In future to avoid starting QEMU twice we were thinking about
> configuring QEMU from QMP at runtime, that's where preconfigure
> approach could be used to help solving it in the future:
> 
>   1. introduce pause before machine_init CLI option to allow
>      preconfig machine from qmp/monitor
>   2. make query-hotpluggable-cpus usable at preconfig time
>   3. start qemu with needed number of numa nodes and default mapping:
>          #qemu -smp ... -numa node,nodeid=0 -node node,nodeid=1
>   4. get possible cpus list

This is where things can get tricky: if we have the default
mapping set, step 4 would return "node-id" already set on all
possible CPUs.

>   5. add qmp/monitor command variant for '-numa cpu' to set numa mapping

This is where I think we would make things simpler: if node-id
isn't present on 'props', we can simply document the arguments
that identify the CPU for the numa-cpu command as "just use the
properties you get on query-hotpluggable-cpus.props". Clients
would be able to treat CpuInstanceProperties as an opaque CPU
slot identifier.

i.e. I think this would be a better way to define and document
the interface:

##
# @NumaCpuOptions:
#
# Mapping of a given CPU (or a set of CPUs) to a NUMA node.
#
# @cpu: Properties identifying the CPU(s). Use the 'props' field of
#       query-hotpluggable-cpus for possible values for this
#       field.
#       TODO: describe what happens when 'cpu' matches
#       multiple slots.
# @node-id: NUMA node where the CPUs are going to be located.
##
{ 'struct': 'NumaCpuOptions',
  'data': {
   'cpu': 'CpuInstanceProperties',
   'node-id': 'int' } }

This separates "what identifies the CPU slot(s) we are
configuring" from "what identifies the node ID we are binding
to".

In case we have trouble making this struct work with QemuOpts, we
could do this (temporarily?):

##
# @NumaCpuOptions:
#
# Mapping of a given CPU (or a set of CPUs) to a NUMA node.
#
# @cpu: Properties identifying the CPU(s). Use the 'props' field of
#       query-hotpluggable-cpus for possible values for this
#       field.
#       TODO: describe what happens when 'cpu' matches
#       multiple slots.
# @node-id: NUMA node where the CPUs are going to be located.
#
# @socket-id: Shortcut for cpu.socket-id, to make this struct
#             friendly to QemuOpts.
# @core-id: Shortcut for cpu.core-id, to make this struct
#           friendly to QemuOpts.
# @thread-id: Shortcut for cpu.thread-id, to make this struct
#             friendly to QemuOpts.
##
{ 'struct': 'NumaCpuOptions',
  'data': {
   '*cpu': 'CpuInstanceProperties',
   '*socket-id': 'int',
   '*core-id': 'int',
   '*thread-id': 'int',
   'node-id': 'int' } }

>   6. optionally, set new numa mapping and get updated
>      possible cpus list with query-hotpluggable-cpus
>   7. optionally, add extra cpus with device_add using updated
>      cpus list and get updated cpus list as it's been changed again.
>   8. unpause preconfig stage and let qemu continue to execute
>      machine_init and the rest.
> 
> Since we would need to implement QMP configuration for '-device cpu',
> we as well might reuse it for custom numa mapping.
> 
>  [...]

-- 
Eduardo
