Received: from eggs.gnu.org ([2001:4830:134:3::10]:42272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctC5J-0008OK-FX
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctC5I-0002FY-5i
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:48:17 -0400
Date: Wed, 29 Mar 2017 13:48:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170329134806.60e75dcc@nial.brq.redhat.com>
In-Reply-To: <20170329022449.GN21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-6-git-send-email-imammedo@redhat.com>
	<20170328041920.GC21068@umbus.fritz.box>
	<20170328125310.4fa3da50@Igors-MacBook-Pro.local>
	<20170329022449.GN21068@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/23] numa: move source of
 default CPUs to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, 29 Mar 2017 13:24:49 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Mar 28, 2017 at 12:53:10PM +0200, Igor Mammedov wrote:
> > On Tue, 28 Mar 2017 15:19:20 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Wed, Mar 22, 2017 at 02:32:30PM +0100, Igor Mammedov wrote:  
> > > > Originally CPU threads were by default assigned in
> > > > round-robin fashion. However it was causing issues in
> > > > guest since CPU threads from the same socket/core could
> > > > be placed on different NUMA nodes.
> > > > Commit fb43b73b (pc: fix default VCPU to NUMA node mapping)
> > > > fixed it by grouping threads within a socket on the same node
> > > > introducing cpu_index_to_socket_id() callback and commit
> > > > 20bb648d (spapr: Fix default NUMA node allocation for threads)
> > > > reused callback to fix similar issues for SPAPR machine
> > > > even though socket doesn't make much sense there.
> > > > 
> > > > As result QEMU ended up having 3 default distribution rules
> > > > used by 3 targets /virt-arm, spapr, pc/.
> > > > 
> > > > In effort of moving NUMA mapping for CPUs into possible_cpus,
> > > > generalize default mapping in numa.c by making boards decide
> > > > on default mapping and let them explicitly tell generic
> > > > numa code to which node a CPU thread belongs to by replacing
> > > > cpu_index_to_socket_id() with @cpu_index_to_instance_props()
> > > > which provides default node_id assigned by board to specified
> > > > cpu_index.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> [snip]
> > > > +static CpuInstanceProperties
> > > > +virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > > > +{
> > > > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > > > +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> > > > +
> > > > +    assert(cpu_index < possible_cpus->len);
> > > > +    return possible_cpus->cpus[cpu_index].props;;
> > > > +}
> > > > +  
> > > 
> > > It seems a bit weird to have a machine specific hook to pull the
> > > property information when one way or another it's coming from the
> > > possible_cpus table, which is already constructed by a machine
> > > specific hook.  Could we add a range or list of cpu_index values to
> > > each possible_cpus entry instead, and have a generic lookup of the
> > > right entry based on that?  
> 
> [snip]
> > > > -static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
> > > > +static CpuInstanceProperties
> > > > +pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > > >  {
> > > > -    X86CPUTopoInfo topo;
> > > > -    x86_topo_ids_from_idx(smp_cores, smp_threads, cpu_index,
> > > > -                          &topo);
> > > > -    return topo.pkg_id;
> > > > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > > > +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> > > > +
> > > > +    assert(cpu_index < possible_cpus->len);
> > > > +    return possible_cpus->cpus[cpu_index].props;;  
> > > 
> > > Since the pc and arm version of this are basically identical, I wonder
> > > if that should actually be the default implementation.  If we need it
> > > at all.  
> > ARM is still moving target and props are not really defined for it yet,
> > so I'd like to keep it separate for now and when it stabilizes we can think
> > about generalizing it.  
> 
> Fair enough.
> 
> Any thoughts on my more general query above
None so far.
