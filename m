Received: from eggs.gnu.org ([209.51.188.92]:50154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuY9-0005WL-Je
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuY7-0005sK-Lk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:26:05 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:42301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtuY2-0005Nv-Eg
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:26:03 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.253])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E5C2FF2D75
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 14:25:47 +0100 (CET)
Date: Wed, 13 Feb 2019 14:25:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190213142531.5a988b09@bahia.lan>
In-Reply-To: <7dc24c62-2ca0-8de4-e9e3-def6fb2a554f@redhat.com>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999592549.690774.13071669609040970763.stgit@bahia.lan>
	<7dc24c62-2ca0-8de4-e9e3-def6fb2a554f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/15] spapr: add hotplug hooks for PHB
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On Wed, 13 Feb 2019 10:25:07 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 12.02.19 19:25, Greg Kurz wrote:
> > Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> > main system bus, so we register spapr machine as the handler for the
> > main system bus.
> > 
> > Provide the usual pre-plug, plug and unplug-request handlers.
> > 
> > Move the checking of the PHB index to the pre-plug handler. It is okay
> > to do that and assert in the realize function because the pre-plug
> > handler is always called, even for the oldest machine types we support.
> > 
> > Unlike with other device types, there are some cases where we cannot
> > provide the FDT fragment of the PHB from the plug handler, eg, before
> > KVMPPC_H_UPDATE_DT was called. Do this from a DRC callback that is
> > called just before the first FDT fragment is exposed to the guest.
> > 
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > (Fixed interrupt controller phandle in "interrupt-map" and
> >  TCE table size in "ibm,dma-window" FDT fragment, Greg Kurz)
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v4: - populate FDT fragment in a DRC callback
> > v3: - reworked phandle handling some more
> > v2: - reworked phandle handling
> >     - sync LSIs to KVM
> > ---
> > ---
> >  hw/ppc/spapr.c         |  121 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/ppc/spapr_drc.c     |    2 +
> >  hw/ppc/spapr_pci.c     |   16 ------
> >  include/hw/ppc/spapr.h |    5 ++
> >  4 files changed, 127 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 021758825b7e..06ce0babcb54 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2930,6 +2930,11 @@ static void spapr_machine_init(MachineState *machine)
> >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> >                           &savevm_htab_handlers, spapr);
> >  
> > +    if (smc->dr_phb_enabled) {
> > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
> > +                                 &error_fatal);
> > +    }
> > +
> >      qemu_register_boot_set(spapr_boot_set, spapr);
> >  
> >      if (kvm_enabled()) {
> > @@ -3733,6 +3738,108 @@ out:
> >      error_propagate(errp, local_err);
> >  }
> >  
> > +int spapr_dt_phb(DeviceState *dev, sPAPRMachineState *spapr, void *fdt,
> > +                 int *fdt_start_offset, Error **errp)
> > +{
> > +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
> > +    uint32_t intc_phandle;
> > +
> > +    if (spapr_irq_get_phandle(spapr, spapr->fdt_blob, &intc_phandle, errp)) {
> > +        return -1;
> > +    }
> > +
> > +    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
> > +                              fdt_start_offset)) {
> > +        error_setg(errp, "unable to create FDT node for PHB %d", sphb->index);
> > +        return -1;
> > +    }
> > +
> > +    /* generally SLOF creates these, for hotplug it's up to QEMU */
> > +    _FDT(fdt_setprop_string(fdt, *fdt_start_offset, "name", "pci"));
> > +
> > +    return 0;
> > +}
> > +
> > +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > +                               Error **errp)
> > +{
> > +    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
> > +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
> > +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> > +    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
> > +
> > +    if (sphb->index == (uint32_t)-1) {
> > +        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * This will check that sphb->index doesn't exceed the maximum number of
> > +     * PHBs for the current machine type.
> > +     */
> > +    smc->phb_placement(spapr, sphb->index,
> > +                       &sphb->buid, &sphb->io_win_addr,
> > +                       &sphb->mem_win_addr, &sphb->mem64_win_addr,
> > +                       windows_supported, sphb->dma_liobn, errp);
> > +}
> > +
> > +static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > +                           Error **errp)
> > +{
> > +    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
> > +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> > +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
> > +    sPAPRDRConnector *drc;
> > +    bool hotplugged = spapr_drc_hotplugged(dev);
> > +    Error *local_err = NULL;
> > +
> > +    if (!smc->dr_phb_enabled) {
> > +        return;
> > +    }
> > +
> > +    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> > +    /* hotplug hooks should check it's enabled before getting this far */
> > +    assert(drc);
> > +
> > +    /*
> > +     * The FDT fragment will be added during the first invocation of RTAS
> > +     * ibm,client-architecture-support  for this device, when we're sure
> > +     * that the IOMMU is configured and that QEMU knows the phandle of the
> > +     * interrupt controller.
> > +     */
> > +    spapr_drc_attach(drc, DEVICE(dev), NULL, 0, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    if (hotplugged) {
> > +        spapr_hotplug_req_add_by_index(drc);
> > +    } else {
> > +        spapr_drc_reset(drc);
> > +    }
> > +}
> > +
> > +void spapr_phb_release(DeviceState *dev)
> > +{
> > +    object_unparent(OBJECT(dev));
> > +}
> > +  
> 
> Please call the unplug handler here just like we already do with
> spapr_phb_remove_pci_device_cb().
> 
> And add a _unplug handler that simply calls e.g.
> 
> qdev_simple_device_unplug_cb
> 
> 
> Otherwise this will break with
> [PATCH RFCv2 0/9] qdev: Hotplug handler chaining + virtio-pmem
> 

Yes, I'll do that.

> 
> > +static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
> > +                                     DeviceState *dev, Error **errp)
> > +{
> > +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
> > +    sPAPRDRConnector *drc;
> > +
> > +    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> > +    assert(drc);
> > +
> > +    if (!spapr_drc_unplug_requested(drc)) {
> > +        spapr_drc_detach(drc);
> > +        spapr_hotplug_req_remove_by_index(drc);
> > +    }
> > +}
> > +
> >  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> >                                        DeviceState *dev, Error **errp)
> >  {
> > @@ -3740,6 +3847,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> >          spapr_memory_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> >          spapr_core_plug(hotplug_dev, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> > +        spapr_phb_plug(hotplug_dev, dev, errp);
> >      }
> >  }
> >  
> > @@ -3758,6 +3867,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
> >  {
> >      sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
> >      MachineClass *mc = MACHINE_GET_CLASS(sms);
> > +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> >  
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> > @@ -3777,6 +3887,12 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
> >              return;
> >          }
> >          spapr_core_unplug_request(hotplug_dev, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> > +        if (!smc->dr_phb_enabled) {
> > +            error_setg(errp, "PHB hot unplug not supported on this machine");
> > +            return;
> > +        }
> > +        spapr_phb_unplug_request(hotplug_dev, dev, errp);
> >      }
> >  }
> >  
> > @@ -3787,6 +3903,8 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
> >          spapr_memory_pre_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> >          spapr_core_pre_plug(hotplug_dev, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> > +        spapr_phb_pre_plug(hotplug_dev, dev, errp);
> >      }
> >  }
> >  
> > @@ -3794,7 +3912,8 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
> >                                                   DeviceState *dev)
> >  {
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> > -        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
> > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> >          return HOTPLUG_HANDLER(machine);
> >      }
> >      return NULL;
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index c5a281915665..22563a381a37 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -709,6 +709,8 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
> >      drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> >      drck->typename = "PHB";
> >      drck->drc_name_prefix = "PHB ";
> > +    drck->release = spapr_phb_release;
> > +    drck->populate_dt = spapr_dt_phb;
> >  }
> >  
> >  static const TypeInfo spapr_dr_connector_info = {
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 7df7f6502f93..d0caca627455 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1647,21 +1647,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >          return;
> >      }
> >  
> > -    if (sphb->index != (uint32_t)-1) {
> > -        Error *local_err = NULL;
> > -
> > -        smc->phb_placement(spapr, sphb->index,
> > -                           &sphb->buid, &sphb->io_win_addr,
> > -                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
> > -                           windows_supported, sphb->dma_liobn, &local_err);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            return;
> > -        }
> > -    } else {
> > -        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> > -        return;
> > -    }
> > +    assert(sphb->index != (uint32_t)-1); /* checked in spapr_phb_pre_plug() */
> >  
> >      if (sphb->mem64_win_size != 0) {
> >          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index a3074e7fea37..69d9c2196ca2 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -764,9 +764,12 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> >  void spapr_clear_pending_events(sPAPRMachineState *spapr);
> >  int spapr_max_server_number(sPAPRMachineState *spapr);
> >  
> > -/* CPU and LMB DRC release callbacks. */
> > +/* DRC callbacks. */
> >  void spapr_core_release(DeviceState *dev);
> >  void spapr_lmb_release(DeviceState *dev);
> > +void spapr_phb_release(DeviceState *dev);
> > +int spapr_dt_phb(DeviceState *dev, sPAPRMachineState *spapr, void *fdt,
> > +                 int *fdt_start_offset, Error **errp);
> >  
> >  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
> >  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
> >   
> 
> 
