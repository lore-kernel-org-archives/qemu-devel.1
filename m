Received: from eggs.gnu.org ([2001:4830:134:3::10]:52975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3mLN-0004kj-5U
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3mLL-0002aU-6G
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:32:37 -0400
Date: Thu, 27 Apr 2017 13:32:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170427163225.GE3482@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-8-git-send-email-imammedo@redhat.com>
	<20170412210239.GC27126@thinpad.lan.raisama.net>
	<20170419131458.59e2d00e@nial.brq.redhat.com>
	<20170426122138.GU3482@thinpad.lan.raisama.net>
	<20170427151406.57fbfa79@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427151406.57fbfa79@nial.brq.redhat.com>
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Krempa <pkrempa@redhat.com>

On Thu, Apr 27, 2017 at 03:14:06PM +0200, Igor Mammedov wrote:
> On Wed, 26 Apr 2017 09:21:38 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> adding Peter to CC list
> 
> [...]
> 
> > On Wed, Apr 19, 2017 at 01:14:58PM +0200, Igor Mammedov wrote:
> > > On Wed, 12 Apr 2017 18:02:39 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > On Wed, Mar 22, 2017 at 02:32:32PM +0100, Igor Mammedov wrote:  
> > > > > it will allow switching from cpu_index to property based
> > > > > numa mapping in follow up patches.    
> > > > 
> > > > I am not sure I understand all the consequences of this, so I
> > > > will give it a try:
> > > > 
> > > > "node-id" is an existing field in CpuInstanceProperties.
> > > > CpuInstanceProperties is used on both query-hotpluggable-cpus
> > > > output and in MachineState::possible_cpus.
> > > > 
> > > > We will start using MachineState::possible_cpus to keep track of
> > > > NUMA CPU affinity, and that means query-hotpluggable-cpus will
> > > > start reporting a "node-id" property when a NUMA mapping is
> > > > configured.
> > > > 
> > > > To allow query-hotpluggable-cpus to report "node-id", the CPU
> > > > objects must have a "node-id" property that can be set. This
> > > > patch adds the "node-id" property to X86CPU.
> > > > 
> > > > Is this description accurate? Is the presence of "node-id" in
> > > > query-hotpluggable-cpus the only reason we really need this
> > > > patch, or is there something else that requires the "node-id"
> > > > property?  
> > > That accurate description, node-id is in the same 'address'
> > > properties category as socket/core/thread-id. So if you have
> > > numa enabled machine you'd see node-id property in
> > > query-hotpluggable-cpus.  
> > 
> > I agree that we can make -numa cpu affect query-hotpluggable-cpus
> > output (i.e. affect some field on HotpluggableCPU.props).
> > 
> > But it looks like we disagree about the purpose of
> > HotpluggableCPU.props:
> > 
> > I believe HotpluggableCPU.props is just an opaque identifier for
> > the location we want to plug the CPU, and the only requirement is
> > that it should be unique and have all the information device_add
> > needs. As socket IDs are already unique on our existing machines,
> > and socket<=>node mapping is already configured using -numa cpu,
> > node-id doesn't need to be in HotpluggableCPU.props. (see example
> > below)
> node-id is also location property which logically complements
> to socket/core/thread properties.  Also socket is not necessarily
> unique id that maps 1:1 to node-id from generic pov.
> BTW -numa cpu[s] is not the only way to specify mapping,
> it could be specified like we do with pc-dimm:
>    device_add pc-dimm,node=x
> 
> Looking at it more genericly, there could be the same
> socket-ids for different nodes, then we would have to add
> node-id to props anyway and end up with 2 node-id, one in props
> and another in the parent struct.

This is where my expectations are different: I think
HotpluggableCPU.props is just an identifier property for CPU
slots that is used for device_add (and will be used for -numa
cpu), and isn't supposed to be be interpreted by clients.

The problem I see is that the property has two completely
different purposes: identifying a given CPU slot for device_add
(and -numa cpu), and introspection of topology information about
the CPU slot. Today we are lucky and those goals don't conflict
with each other, but I worry this might cause trouble in the
future.

> 
> 
> > I don't think clients should assume topology information in
> > HotpluggableCPU.props is always present, because the field has a
> > different purpose: letting clients know what are the required
> > device_add arguments. If we need introspection of CPU topology,
> > we can add new fields to HotpluggableCPU, outside 'props'.
> looking at existing clients (libvirt), it doesn't treat 'props'
> as opaque set, but parses it into topology information (my guess
> is that because it's the sole source such info from QEMU).
> Actually we never forbade this, the only requirement for
> props was that mgmt should provide those properties to create
> a cpu. Property names where designed in topology/location
> friendly terms so that clients could make the sense from them.
> 
> So I wouldn't try now to reduce meaning of 'props' to
> opaque as you suggest.

I see. This means my expectation is not met even today. I am not
thrilled about it, but that's OK.

> 
> [..]
> > My question is: if we use:
> > 
> >  -numa cpu,socket=2,core=1,thread=0,node-id=3
> > 
> > and then:
> > 
> >  device_add ...,socket=2,core=1,thread=0
> >  (omitting node-id on device_add)
> > 
> > won't it work exactly the same, and place the new CPU on NUMA
> > node 3?
> yep, it's allowed for compat reasons:
>   1: to allow DST start with old CLI variant, that didn't have node-id
>      (migration)
>   2: to let old libvirt hotplug CPUs, it doesn't treat 'props'
>      as opaque set that is just replayed to device_add,
>      instead it composes command from topo info it got
>      from QEMU and unfortunately node-id is only read but is
>      not emitted when device_add is composed
>     (I consider this bug but it's out in the wild so we have to deal with it)
> 
> we can't enforce presence in these cases or at least have to
> keep it relaxed for old machine types.

I see.

>  
> > In this case, if we don't need a node-id argument on device_add,
> > so node-id doesn't need to be in HotpluggableCPU.props.
> I'd say we currently don't have to (for above reasons) but
> it doesn't hurt and actually allows to use pc-dimm way of
> mapping CPUs to nodes as David noted. i.e.:
>   -device cpu-foo,node-id=x,...
> without any of -numa cpu[s] options on CLI.
> It's currently explicitly disabled but should work if one
> doesn't care about hotplug or if target doesn't care about
> mapping at startup (sPAPR), it also might work for x86 as
> well using _PXM method in ACPI.
> (But that's out of scope of this series and needs more
> testing as some guest OSes might expect populated SRAT
> to work correctly).

Yep. I understand that setting node-id is useful, I just didn't
expect it to be mandatory and included on HotpluggableCPU.props.

> 
> [...]
> > > 
> > > In future to avoid starting QEMU twice we were thinking about
> > > configuring QEMU from QMP at runtime, that's where preconfigure
> > > approach could be used to help solving it in the future:
> > > 
> > >   1. introduce pause before machine_init CLI option to allow
> > >      preconfig machine from qmp/monitor
> > >   2. make query-hotpluggable-cpus usable at preconfig time
> > >   3. start qemu with needed number of numa nodes and default mapping:
> > >          #qemu -smp ... -numa node,nodeid=0 -node node,nodeid=1
> > >   4. get possible cpus list  
> > 
> > This is where things can get tricky: if we have the default
> > mapping set, step 4 would return "node-id" already set on all
> > possible CPUs.
> that would depend on impl.
>  - display node-id with default preset values to override
>  - do not set defaults and force user to do mapping

Right. We could choose to initialize default values much later,
and leave it uninitialized.

> 
> > >   5. add qmp/monitor command variant for '-numa cpu' to set numa mapping  
> > 
> > This is where I think we would make things simpler: if node-id
> > isn't present on 'props', we can simply document the arguments
> > that identify the CPU for the numa-cpu command as "just use the
> > properties you get on query-hotpluggable-cpus.props". Clients
> > would be able to treat CpuInstanceProperties as an opaque CPU
> > slot identifier.
> > 
> > i.e. I think this would be a better way to define and document
> > the interface:
> > 
> > ##
> > # @NumaCpuOptions:
> > #
> > # Mapping of a given CPU (or a set of CPUs) to a NUMA node.
> > #
> > # @cpu: Properties identifying the CPU(s). Use the 'props' field of
> > #       query-hotpluggable-cpus for possible values for this
> > #       field.
> > #       TODO: describe what happens when 'cpu' matches
> > #       multiple slots.
> > # @node-id: NUMA node where the CPUs are going to be located.
> > ##
> > { 'struct': 'NumaCpuOptions',
> >   'data': {
> >    'cpu': 'CpuInstanceProperties',
> >    'node-id': 'int' } }
> > 
> > This separates "what identifies the CPU slot(s) we are
> > configuring" from "what identifies the node ID we are binding
> > to".
> Doesn't look any simpler to me, I'd better document node-id usage
> in props, like
> 

Well, it still looks simpler and more intuitive to me, but just
because it matches my initial expectations about the semantics of
query-hotpluggable-cpus and CpuInstanceProperties. If your
alternative is very clearly documented (like below), it is not a
problem to me.

>  #
>  # A discriminated record of NUMA options. (for OptsVisitor)
>  #
> +# For 'cpu' type as arguments use a set of cpu properties returned
> +# by query-hotpluggable-cpus[].props, where node-id could be used
> +# to override default node mapping. Since: 2.10
> +#
>  # Since: 2.1
>  ##
>  { 'union': 'NumaOptions',
>    'base': { 'type': 'NumaOptionsType' },
>    'discriminator': 'type',
>    'data': {
> -    'node': 'NumaNodeOptions' }}
> +    'node': 'NumaNodeOptions',
> +    'cpu' : 'CpuInstanceProperties' }}

I worry about not being able to add extra options to "-numa cpu"
in the future without affecting HotpluggableCPU.props too. Being
able to document the semantics of -numa cpu inside a dedicated
NumaCpuOptions struct would be nice too.

I believe this can be addressed by defing "NumaCpuOptions" with
"CpuInstanceProperties" as base:

 { 'union': 'NumaOptions',
   'base': { 'type': 'NumaOptionsType' },
   'discriminator': 'type',
   'data': {
     'node': 'NumaNodeOptions',
     'cpu' : 'NumaCpuOptions' }}

##
# Options for -numa cpu,...
#
# "-numa cpu" accepts the same set of cpu properties returned by
# query-hotpluggable-cpus[].props, where node-id could be used to
# override default node mapping.
#
# Since: 2.10
##
{ 'struct': 'NumaCpuOptions',
  'base': 'CpuInstanceProperties' }

>  


>  ##
>  # @NumaNodeOptions:
> 
> 
> > In case we have trouble making this struct work with QemuOpts, we
> > could do this (temporarily?):
> > 
> > ##
> > # @NumaCpuOptions:
> > #
> > # Mapping of a given CPU (or a set of CPUs) to a NUMA node.
> > #
> > # @cpu: Properties identifying the CPU(s). Use the 'props' field of
> > #       query-hotpluggable-cpus for possible values for this
> > #       field.
> > #       TODO: describe what happens when 'cpu' matches
> > #       multiple slots.
> > # @node-id: NUMA node where the CPUs are going to be located.
> > #
> > # @socket-id: Shortcut for cpu.socket-id, to make this struct
> > #             friendly to QemuOpts.
> > # @core-id: Shortcut for cpu.core-id, to make this struct
> > #           friendly to QemuOpts.
> > # @thread-id: Shortcut for cpu.thread-id, to make this struct
> > #             friendly to QemuOpts.
> > ##
> > { 'struct': 'NumaCpuOptions',
> >   'data': {
> >    '*cpu': 'CpuInstanceProperties',
> >    '*socket-id': 'int',
> >    '*core-id': 'int',
> >    '*thread-id': 'int',
> >    'node-id': 'int' } }
> > 
> > >   6. optionally, set new numa mapping and get updated
> > >      possible cpus list with query-hotpluggable-cpus
> > >   7. optionally, add extra cpus with device_add using updated
> > >      cpus list and get updated cpus list as it's been changed again.
> > >   8. unpause preconfig stage and let qemu continue to execute
> > >      machine_init and the rest.
> > > 
> > > Since we would need to implement QMP configuration for '-device cpu',
> > > we as well might reuse it for custom numa mapping.
> > > 
> > >  [...]  
> > 
> 

-- 
Eduardo
