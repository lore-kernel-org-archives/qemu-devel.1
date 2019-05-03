Received: from eggs.gnu.org ([209.51.188.92]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMa0-0002ja-W8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 21:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMZw-0005na-7I
	for qemu-devel@nongnu.org; Thu, 02 May 2019 21:01:35 -0400
Date: Thu, 2 May 2019 22:01:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190503010127.GP28722@habkost.net>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
	<20190404162555.0a2267ee@redhat.com>
	<a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] cpu/topology: add general support for
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, like.xu@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 30, 2019 at 03:30:31PM +0800, Like Xu wrote:
> On 2019/4/4 22:25, Igor Mammedov wrote:
> > On Fri, 29 Mar 2019 16:48:38 +0800
> > Like Xu <like.xu@linux.intel.com> wrote:
> > 
> 
> <snipp>
> > 
> > > diff --git a/cpus.c b/cpus.c
> > > index e83f72b..834a697 100644
> > > --- a/cpus.c
> > > +++ b/cpus.c
> > > @@ -2067,6 +2067,10 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
> > >   void qemu_init_vcpu(CPUState *cpu)
> > >   {
> > > +    MachineState *ms = MACHINE(qdev_get_machine());
> > > +    unsigned int smp_cores = ms->topo.smp_cores;
> > > +    unsigned int smp_threads = ms->topo.smp_threads;
> > 
> > (***)
> > for once it probably will crash *-user builds

Will it?  cpus.o is compiled only on CONFIG_SOFTMMU.

> > and secondly the purpose of getting rid of smp_foo globals
> > is disentangle layer violations and not replace it with another global
> > (qdev_get_machine()).
> 
> I am happy to follow this rule on cpu-topo refactoring work, but sometimes
> calling qdev_get_machine() is inevitable.

I agree with Igor's goal, but let's do it one step at a time.
Replacing the smp_* globals with qdev_get_machine() is a step in
the right direction, IMO.


> 
> > 
> > What should be done is to make a properties of nr_cores/nr_threads and set
> > them from the parent object that creates CPUs. The point is CPUs shouldn't
> > reach out outside itself to fish out data bits it needs, it's responsibility
> > of creator to feed to being create CPU needed properties.
> > 
> > This kind of refactoring probably deserves its own series and should precede
> > -smp refactoring as it doesn't depend on CpuTopology at all.

I don't see why it should precede -smp refactoring.

We have a very specific user-visible goal here: making one extra
CPU topology option (CPU dies) available on PC only.  Asking the
author to refactor some code while implementing that is
reasonable.  Requiring the author to touch every single place
where a CPU object is created in QEMU just to avoid a
qdev_get_machine() call doesn't seem reasonable.


> > 
> 
> The division of responsibility for this case (refactoring qemu_init_vcpu)
> seems to be a poisonous apple.
> 
> The prerequisite for setting cpu-> nr_cores / nr_threads from the parent is
> that the CPU has been created, so if any process during initialization needs
> this topo information, it will use the default values form
> cpu_common_initfn() instead of user-configured parameters.
> 
> We may not want to repeat those assignment operations using the new values
> and what do you think, Igor?

I believe we need a better CPU creation API that all machines can
use, otherwise all of them will have to duplicate the same code
between object_new() and object_propert_set_bool("realized", true).

But I really don't think designing and implementing this new API
should be a requirement to get useful work done.

-- 
Eduardo
