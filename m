Received: from eggs.gnu.org ([2001:4830:134:3::10]:41321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cYAWi-0005Yg-E3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cYAWf-0000vD-AC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:53:40 -0500
Date: Mon, 30 Jan 2017 12:53:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170130125326.2e9f4cc7@Igors-MacBook-Pro.local>
In-Reply-To: <20170126142635.GA8653@in.ibm.com>
References: <1466145399-32209-1-git-send-email-david@gibson.dropbear.id.au>
	<1466145399-32209-16-git-send-email-david@gibson.dropbear.id.au>
	<20170126123258.2d34fe95@Igors-MacBook-Pro.local>
	<20170126142635.GA8653@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 15/18] spapr: CPU hot unplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, agraf@suse.de, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 26 Jan 2017 19:56:35 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> On Thu, Jan 26, 2017 at 12:32:58PM +0100, Igor Mammedov wrote:
> > On Fri, 17 Jun 2016 16:36:36 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > 
> > > Remove the CPU core device by removing the underlying CPU thread devices.
> > > Hot removal of CPU for sPAPR guests is achieved by sending the hot unplug
> > > notification to the guest. Release the vCPU object after CPU hot unplug so
> > > that vCPU fd can be parked and reused.
> > > 
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > [...]
> > 
> > 
> > Bharata,
> > 
> > Here is some notes I've made while auditing spapr cpu hotplug code.
> >   
> > spapr_core_release() should be spapr_core_unrealize()
> > except of machine related
> >  spapr->cores[cc->core_id / smt] = NULL;
> > which should go to spapr_core_unplug()
> 
> There were some issues in calling cpu_remove_[sync] from unrealize
> path. I know that x86 does that way. let me remember and get back on this.
on the first glance it doesn't look like there should be issues with
making it spapr_core_unrealize(), but since it's way out of scope
numa rework I'd leave 'fixing' it upto you. 

> 
> > 
> > > +static void spapr_core_release(DeviceState *dev, void *opaque)
> > > +{
> > > +    sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> > > +    const char *typename = object_class_get_name(sc->cpu_class);
> > > +    size_t size = object_type_get_instance_size(typename);
> > > +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> > > +    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
> > > +    CPUCore *cc = CPU_CORE(dev);
> > > +    int smt = kvmppc_smt_threads();
> > > +    int i;
> > > +
> > > +    for (i = 0; i < cc->nr_threads; i++) {
> > > +        void *obj = sc->threads + i * size;
> > > +        DeviceState *dev = DEVICE(obj);
> > > +        CPUState *cs = CPU(dev);
> > > +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> > > +
> > > +        spapr_cpu_destroy(cpu);
> > > +        cpu_remove_sync(cs);
> > > +        object_unparent(obj);
> > > +    }
> > > +
> > > +    spapr->cores[cc->core_id / smt] = NULL;
> > > +
> > > +    g_free(core->threads);
> > > +    object_unparent(OBJECT(dev));
> > > +}
> > > +
> > 
> > spapr_core_[un]plug() functions belong to machine code and should
> > be in hw/ppc/spapr.c
> 
> That's how the series started, but eventually we consolidated all
> core related routines in spapr_cpu_core.c

Since spapr_core_[un]plug() manage spapr machine state and not internal
core state, I'd like to move them close to other machine code (spapr.c)
if you don't mind.

> 
> > 
> > > +void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > > +                       Error **errp)
> > > +{
> > > +    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
> > > +    PowerPCCPU *cpu = POWERPC_CPU(core->threads);
> > > +    int id = ppc_get_vcpu_dt_id(cpu);
> > > +    sPAPRDRConnector *drc =
> > > +        spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, id);
> > > +    sPAPRDRConnectorClass *drck;
> > > +    Error *local_err = NULL;
> > > +
> > > +    g_assert(drc);
> > > +
> > > +    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > > +    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
> > 
> > Could you explain call flow during cpu unplug?
> 
> In response to unplug request, spapr_core_unplug() gets called which
> does a detach() on the associated DRC object. The detach() registers
> a callback (spapr_core_release)  and signals the guest about the unplug
> request.
> 
> When the guest is ready to let go of the CPU core, DRC subsystem ends up
> calling the callback spapr_core_release. For each of the CPU thread objects
> of the core, spapr_core_release will call cpu_remove_sync() and waits
> for the CPU to be really removed. cpu_remove will result in CPU unrealize
> function being called (ppc_cpu_unrealizefn) for each of the removed
> CPU.
> 
> After we are done waiting for all the threads' removal, the core object is
> ready for removal.
> 
> > 
> > My expectations were that unplug_request() handler asks for CPU removal
> > and unplug() handler removes CPU.
> > It's obviously messed up somehow.
> 
> When we did CPU unplug, we didn't really implement ->unplug_request() for
> sPAPR. It was added later when memory unplug came in.
It ended up that spapr_core_unplug() is called from both ->unplug_request()
and ->unplug(). Where ->unplug() is dead path that's never called.
I'll send patches to fix hot-unlpug flow to conform to generic hotplug
pattern
   ->unplug_request() -> register callback
and
   callback ->unplug() -> release_core()

> 
> Regards,
> Bharata.
> 
> 
