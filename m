Received: from eggs.gnu.org ([2001:4830:134:3::10]:48660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6YB4-0007nZ-E2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6YB3-0007KG-Ac
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:01:26 -0400
Date: Fri, 5 May 2017 10:01:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170505100113.36d941d2@nial.brq.redhat.com>
In-Reply-To: <20170504073213.GE14413@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-6-git-send-email-imammedo@redhat.com>
	<20170503144240.GL3482@thinpad.lan.raisama.net>
	<20170504073213.GE14413@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/24] numa: move source of default CPUs
 to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Thu, 4 May 2017 17:32:13 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, May 03, 2017 at 11:42:40AM -0300, Eduardo Habkost wrote:
> > On Wed, May 03, 2017 at 02:56:59PM +0200, Igor Mammedov wrote:  
> > > Originally CPU threads were by default assigned in
> > > round-robin fashion. However it was causing issues in
> > > guest since CPU threads from the same socket/core could
> > > be placed on different NUMA nodes.
> > > Commit fb43b73b (pc: fix default VCPU to NUMA node mapping)
> > > fixed it by grouping threads within a socket on the same node
> > > introducing cpu_index_to_socket_id() callback and commit
> > > 20bb648d (spapr: Fix default NUMA node allocation for threads)
> > > reused callback to fix similar issues for SPAPR machine
> > > even though socket doesn't make much sense there.
> > > 
> > > As result QEMU ended up having 3 default distribution rules
> > > used by 3 targets /virt-arm, spapr, pc/.
> > > 
> > > In effort of moving NUMA mapping for CPUs into possible_cpus,
> > > generalize default mapping in numa.c by making boards decide
> > > on default mapping and let them explicitly tell generic
> > > numa code to which node a CPU thread belongs to by replacing
> > > cpu_index_to_socket_id() with @cpu_index_to_instance_props()
> > > which provides default node_id assigned by board to specified
> > > cpu_index.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> > Just two extra comments below:
> > 
> > [...]  
> > > +static CpuInstanceProperties
> > > +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > > +{
> > > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > > +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> > > +
> > > +    assert(cpu_index < possible_cpus->len);
> > > +    return possible_cpus->cpus[cpu_index].props;;
> > > +}
> > > +  
> > [...]  
> > > +static CpuInstanceProperties
> > > +pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > >  {
> > > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > > +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> > > +
> > > +    assert(cpu_index < possible_cpus->len);
> > > +    return possible_cpus->cpus[cpu_index].props;;
> > >  }  
> > 
> > The fact that these two implementations look exactly the same
> > made me wonder:
> > 
> > 1) Why this isn't the default implementation;
> > 2) Why exactly spapr needs a different implementation.
> > 
> > Then I noticed that there's nothing in the common machine code
> > that specifies that possible_cpus->cpus[] is indexed by
> > cpu_index. This means it is indeed safer to require each machine
> > to provide its own cpu_index_to_props implementation than having
> > a default implementation that can unexpectedly break (e.g. if
> > granularity at possible_cpus is not at VCPU/thread level).
> > 
> > I would still like to have an abstraction that wouldn't require
> > writing machine-specific code (e.g. cpu_index ranges to
> > possible_cpus like David suggested), but that's for a follow-up
> > series.  
> 
> Yeah, that similarity bothered me to, but like you I realised the
> problem is that spapr simply doesn't have the same granularity of
> information as x86 and ARM - there's only one entry per core for PAPR
> instead of one per thread.
> 
> So, we do need a machine specific mapping of cpu_index to location
> properties, which is what the callback is for.
> 
> It does occur to me that another way of accomplishing that would be
> for possible_cpu_arch_ids() to create a cpu_index->props mapping as a
> simple array ofpointers, in addition to the list of possiblee props
> structures.
> 
> Not sure if that would end up looking better or not.
I'd like to remove foo_cpu_index_to_props() callbacks in future,
to do so we would need to obsolete and remove cpu_index based
'-numa node,cpus='. Lets give a year for new interface to settle
in and then remove old interface.

so I'd rather do not extend possible_cpus with more complex structure
and related mgmt routines.



> 
> > [...]  
> > > +static CpuInstanceProperties
> > > +spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
> > >  {
> > > +    CPUArchId *core_slot;
> > > +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> > > +
> > > +    /* make sure possible_cpu are intialized */
> > > +    mc->possible_cpu_arch_ids(machine);
> > > +    core_slot = spapr_find_cpu_slot(machine, cpu_index, NULL);
> > > +    assert(core_slot);
> > > +    return core_slot->props;
> > >  }  
> > 
> > If you need to submit v3, maybe a comment here explaining why
> > spapr needs a different cpu_index_to_props implementation would
> > be helpful. I took a while to figure it out.
> >   
> 
