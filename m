Received: from eggs.gnu.org ([2001:4830:134:3::10]:47859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cWl0o-0003se-Ar
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cWl0j-0008A8-Fg
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:26:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cWl0j-00089H-6H
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:26:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0QEPDlJ108337
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 09:26:46 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286ua1nh28-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 09:26:45 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 26 Jan 2017 19:56:41 +0530
Date: Thu, 26 Jan 2017 19:56:35 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1466145399-32209-1-git-send-email-david@gibson.dropbear.id.au>
	<1466145399-32209-16-git-send-email-david@gibson.dropbear.id.au>
	<20170126123258.2d34fe95@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170126123258.2d34fe95@Igors-MacBook-Pro.local>
Message-Id: <20170126142635.GA8653@in.ibm.com>
Subject: Re: [Qemu-devel] [PULL 15/18] spapr: CPU hot unplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org, agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, Jan 26, 2017 at 12:32:58PM +0100, Igor Mammedov wrote:
> On Fri, 17 Jun 2016 16:36:36 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > 
> > Remove the CPU core device by removing the underlying CPU thread devices.
> > Hot removal of CPU for sPAPR guests is achieved by sending the hot unplug
> > notification to the guest. Release the vCPU object after CPU hot unplug so
> > that vCPU fd can be parked and reused.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> [...]
> 
> 
> Bharata,
> 
> Here is some notes I've made while auditing spapr cpu hotplug code.
>   
> spapr_core_release() should be spapr_core_unrealize()
> except of machine related
>  spapr->cores[cc->core_id / smt] = NULL;
> which should go to spapr_core_unplug()

There were some issues in calling cpu_remove_[sync] from unrealize
path. I know that x86 does that way. let me remember and get back on this.

> 
> > +static void spapr_core_release(DeviceState *dev, void *opaque)
> > +{
> > +    sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> > +    const char *typename = object_class_get_name(sc->cpu_class);
> > +    size_t size = object_type_get_instance_size(typename);
> > +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> > +    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
> > +    CPUCore *cc = CPU_CORE(dev);
> > +    int smt = kvmppc_smt_threads();
> > +    int i;
> > +
> > +    for (i = 0; i < cc->nr_threads; i++) {
> > +        void *obj = sc->threads + i * size;
> > +        DeviceState *dev = DEVICE(obj);
> > +        CPUState *cs = CPU(dev);
> > +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> > +
> > +        spapr_cpu_destroy(cpu);
> > +        cpu_remove_sync(cs);
> > +        object_unparent(obj);
> > +    }
> > +
> > +    spapr->cores[cc->core_id / smt] = NULL;
> > +
> > +    g_free(core->threads);
> > +    object_unparent(OBJECT(dev));
> > +}
> > +
> 
> spapr_core_[un]plug() functions belong to machine code and should
> be in hw/ppc/spapr.c

That's how the series started, but eventually we consolidated all
core related routines in spapr_cpu_core.c

> 
> > +void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > +                       Error **errp)
> > +{
> > +    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
> > +    PowerPCCPU *cpu = POWERPC_CPU(core->threads);
> > +    int id = ppc_get_vcpu_dt_id(cpu);
> > +    sPAPRDRConnector *drc =
> > +        spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, id);
> > +    sPAPRDRConnectorClass *drck;
> > +    Error *local_err = NULL;
> > +
> > +    g_assert(drc);
> > +
> > +    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > +    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
> 
> Could you explain call flow during cpu unplug?

In response to unplug request, spapr_core_unplug() gets called which
does a detach() on the associated DRC object. The detach() registers
a callback (spapr_core_release)  and signals the guest about the unplug
request.

When the guest is ready to let go of the CPU core, DRC subsystem ends up
calling the callback spapr_core_release. For each of the CPU thread objects
of the core, spapr_core_release will call cpu_remove_sync() and waits
for the CPU to be really removed. cpu_remove will result in CPU unrealize
function being called (ppc_cpu_unrealizefn) for each of the removed
CPU.

After we are done waiting for all the threads' removal, the core object is
ready for removal.

> 
> My expectations were that unplug_request() handler asks for CPU removal
> and unplug() handler removes CPU.
> It's obviously messed up somehow.

When we did CPU unplug, we didn't really implement ->unplug_request() for
sPAPR. It was added later when memory unplug came in.

Regards,
Bharata.
