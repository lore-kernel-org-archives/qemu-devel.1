Received: from eggs.gnu.org ([2001:4830:134:3::10]:37550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5weq-00006h-Px
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5wep-0000wV-N4
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:57:40 -0400
Date: Wed, 3 May 2017 17:57:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170503175724.69a5a4e3@nial.brq.redhat.com>
In-Reply-To: <20170503144240.GL3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-6-git-send-email-imammedo@redhat.com>
	<20170503144240.GL3482@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 3 May 2017 11:42:40 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, May 03, 2017 at 02:56:59PM +0200, Igor Mammedov wrote:
> > Originally CPU threads were by default assigned in
> > round-robin fashion. However it was causing issues in
> > guest since CPU threads from the same socket/core could
> > be placed on different NUMA nodes.
> > Commit fb43b73b (pc: fix default VCPU to NUMA node mapping)
> > fixed it by grouping threads within a socket on the same node
> > introducing cpu_index_to_socket_id() callback and commit
> > 20bb648d (spapr: Fix default NUMA node allocation for threads)
> > reused callback to fix similar issues for SPAPR machine
> > even though socket doesn't make much sense there.
> > 
> > As result QEMU ended up having 3 default distribution rules
> > used by 3 targets /virt-arm, spapr, pc/.
> > 
> > In effort of moving NUMA mapping for CPUs into possible_cpus,
> > generalize default mapping in numa.c by making boards decide
> > on default mapping and let them explicitly tell generic
> > numa code to which node a CPU thread belongs to by replacing
> > cpu_index_to_socket_id() with @cpu_index_to_instance_props()
> > which provides default node_id assigned by board to specified
> > cpu_index.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Just two extra comments below:
> 
> [...]
> > +static CpuInstanceProperties
> > +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > +{
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> > +
> > +    assert(cpu_index < possible_cpus->len);
> > +    return possible_cpus->cpus[cpu_index].props;;
> > +}
> > +  
> [...]
> > +static CpuInstanceProperties
> > +pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> >  {
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> > +
> > +    assert(cpu_index < possible_cpus->len);
> > +    return possible_cpus->cpus[cpu_index].props;;
> >  }  
> 
> The fact that these two implementations look exactly the same
> made me wonder:
> 
> 1) Why this isn't the default implementation;
> 2) Why exactly spapr needs a different implementation.
> 
> Then I noticed that there's nothing in the common machine code
> that specifies that possible_cpus->cpus[] is indexed by
> cpu_index. This means it is indeed safer to require each machine
> to provide its own cpu_index_to_props implementation than having
> a default implementation that can unexpectedly break (e.g. if
> granularity at possible_cpus is not at VCPU/thread level).
> 
> I would still like to have an abstraction that wouldn't require
> writing machine-specific code (e.g. cpu_index ranges to
> possible_cpus like David suggested), but that's for a follow-up
> series.
I've left generalizing this part until we have defined/stable
topology for aarch64.
Also I hope, that instead of generalizing we might
depricate/drop -numa node,cpus=0,1,... in future and just drop
this hooks altogether as they are there only for compatibility
with old cpu_index based mapping


> [...]
> > +static CpuInstanceProperties
> > +spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
> >  {
> > +    CPUArchId *core_slot;
> > +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> > +
> > +    /* make sure possible_cpu are intialized */
> > +    mc->possible_cpu_arch_ids(machine);
> > +    core_slot = spapr_find_cpu_slot(machine, cpu_index, NULL);
> > +    assert(core_slot);
> > +    return core_slot->props;
> >  }  
> 
> If you need to submit v3, maybe a comment here explaining why
> spapr needs a different cpu_index_to_props implementation would
> be helpful. I took a while to figure it out.
I'll add comment if series is respinned.
