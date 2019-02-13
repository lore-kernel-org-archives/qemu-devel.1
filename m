Received: from eggs.gnu.org ([209.51.188.92]:36470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gttTH-00019W-Tp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gttTG-0002zL-R7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:16:59 -0500
Date: Wed, 13 Feb 2019 13:16:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190213131646.72641f94@redhat.com>
In-Reply-To: <0a8d418d-61e3-f958-c73f-f7dd9ab7b7bb@redhat.com>
References: <20190212214827.30543-1-lvivier@redhat.com>
	<20190212214827.30543-2-lvivier@redhat.com>
	<20190213012544.GS1884@umbus.fritz.box>
	<20190213094259.37f78c6f@redhat.com>
	<0a8d418d-61e3-f958-c73f-f7dd9ab7b7bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/4] numa,
 spapr: add thread-id in the possible_cpus list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 13 Feb 2019 10:08:24 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 13/02/2019 09:42, Igor Mammedov wrote:
> > On Wed, 13 Feb 2019 12:25:45 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> >> On Tue, Feb 12, 2019 at 10:48:24PM +0100, Laurent Vivier wrote:  
> >>> spapr_possible_cpu_arch_ids() counts only cores, and so
> >>> the number of available CPUs is the number of vCPU divided
> >>> by smp_threads.
> >>>
> >>> ... -smp 4,maxcpus=8,cores=2,threads=2,sockets=2 -numa node,cpus=0,cpus=1 \
> >>>                                                   -numa node,cpus=3,cpus=4 \
> >>>                                                   -numa node -numa node
> >>>
> >>> This generates (info hotpluggable-cpus)
> >>>
> >>>    node-id: 0 core-id: 0 thread-id: 0 [thread-id: 1]
> >>>    node-id: 0 core-id: 6 thread-id: 0 [thread-id: 1]
> >>>    node-id: 1 core-id: 2 thread-id: 0 [thread-id: 1]
> >>>    node-id: 1 core-id: 4 thread-id: 0 [thread-id: 1]
> >>>
> >>> And this command line generates the following error:
> >>>
> >>>    CPU(s) not present in any NUMA nodes: CPU 3 [core-id: 6]
> >>>
> >>> That is wrong because CPU 3 [core-id: 6] is assigned to node-id 0
> >>> Moreover "cpus=4" is not valid, because it means core-id 8 but
> >>> maxcpus is 8.
> >>>
> >>> With this patch we have now:
> >>>
> >>>    node-id: 0 core-id: 0 thread-id: 0
> >>>    node-id: 0 core-id: 0 thread-id: 1
> >>>    node-id: 0 core-id: 1 thread-id: 0
> >>>    node-id: 1 core-id: 1 thread-id: 1
> >>>    node-id: 0 core-id: 2 thread-id: 1
> >>>    node-id: 1 core-id: 2 thread-id: 0
> >>>    node-id: 0 core-id: 3 thread-id: 1
> >>>    node-id: 0 core-id: 3 thread-id: 0  
> >>
> >> I'm afraid this is not the right solution.  The point of the
> >> hotpluggable cpus table is that it has exactly one entry for each
> >> hotpluggable unit.  For PAPR that's a core, not a thread.
> >>
> >> So, the problem is with how the NUMA configuration code is
> >> interpreting possible-cpus, not how the machine is building the table.  
> > 
> > I'd suggest to deprecate/remove 'cpus' suboption in -numa.
> > One should use '-numa cpu' instead, which is written with
> > possible_cpus in mind.  
> 
> I agree.
> 
> Should I keep the patch to remove the incomplete CPU mapping support?
Considering code path didn't go through deprecation process (we didn't have it back then), lets keep it for now and deprecate option properly first.
Once deprecation period ends we well remove all related code at once.

Maybe amend affected/add error messages that it's been deprecated
and will be removed soon and point out to replacement option.



> Thanks,
> Laurent
