Received: from eggs.gnu.org ([209.51.188.92]:54240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUcY-0005Wr-Be
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkUcW-0005Vm-P3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:55:42 -0500
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:40246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gkUcN-0004yE-Ho
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:55:35 -0500
Received: from player159.ha.ovh.net (unknown [10.109.146.211])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5B5791CB726
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 14:55:21 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774538467.1208625.18407245878514517740.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a229e2bc-eeee-619c-83c0-82dbeb379feb@kaod.org>
Date: Fri, 18 Jan 2019 14:55:02 +0100
MIME-Version: 1.0
In-Reply-To: <154774538467.1208625.18407245878514517740.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/19] spapr: add hotplug hooks for PHB
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On 1/17/19 6:16 PM, Greg Kurz wrote:
> Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> main system bus, so we register spapr machine as the handler for the
> main system bus.
> 
> We re-get the phandle of the interrupt controller systematically for
> simplicity.
> 
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v3: - reworked phandle handling some more
> v2: - reworked phandle handling
>     - sync LSIs to KVM
> ---
>  hw/ppc/spapr.c         |  124 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_drc.c     |    1 
>  hw/ppc/spapr_pci.c     |   16 ------
>  include/hw/ppc/spapr.h |    1 
>  4 files changed, 126 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 135136b4cf5f..d94284f423be 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2936,6 +2936,11 @@ static void spapr_machine_init(MachineState *machine)
>      register_savevm_live(NULL, "spapr/htab", -1, 1,
>                           &savevm_htab_handlers, spapr);
>  
> +    if (smc->dr_phb_enabled) {
> +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
> +                                 &error_fatal);
> +    }
> +
>      qemu_register_boot_set(spapr_boot_set, spapr);
>  
>      if (kvm_enabled()) {
> @@ -3733,6 +3738,111 @@ out:
>      error_propagate(errp, local_err);
>  }
>  
> +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                               Error **errp)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
> +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
> +
> +    if (sphb->index == (uint32_t)-1) {
> +        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> +        return;
> +    }
> +
> +    /*
> +     * This will check that sphb->index doesn't exceed the maximum number of
> +     * PHBs for the current machine type.
> +     */
> +    smc->phb_placement(spapr, sphb->index,
> +                       &sphb->buid, &sphb->io_win_addr,
> +                       &sphb->mem_win_addr, &sphb->mem64_win_addr,
> +                       windows_supported, sphb->dma_liobn, errp);
> +}
> +
> +static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp)
> +{
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
> +    void *fdt = NULL;
> +    int fdt_start_offset;
> +    int fdt_size;
> +    Error *local_err = NULL;
> +    sPAPRDRConnector *drc;
> +    int ret;
> +    bool hotplugged = spapr_drc_hotplugged(dev);
> +    int phandle;
> +
> +    if (!smc->dr_phb_enabled) {
> +        return;
> +    }
> +
> +    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> +    /* hotplug hooks should check it's enabled before getting this far */
> +    assert(drc);
> +
> +    if (hotplugged) {
> +        phandle = spapr_irq_get_phandle(spapr, spapr->fdt_blob, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    } else {
> +        phandle = PHANDLE_INTC;
> +    }
>

I am starting to think we should have a spapr->irq->phandle.

C.

> +    fdt = create_device_tree(&fdt_size);
> +    ret = spapr_populate_pci_dt(sphb, phandle, fdt, spapr->irq->nr_msis,
> +                                &fdt_start_offset);
> +    if (ret < 0) {
> +        error_setg(&local_err, "unable to create FDT for %sPHB",
> +                   dev->hotplugged ? "hotplugged " : "");
> +        goto out;
> +    }
> +
> +    if (hotplugged) {
> +        /* generally SLOF creates these, for hotplug it's up to QEMU */
> +        _FDT(fdt_setprop_string(fdt, fdt_start_offset, "name", "pci"));
> +    }
> +
> +    spapr_drc_attach(drc, DEVICE(dev), fdt, fdt_start_offset, &local_err);
> +
> +out:
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        g_free(fdt);
> +        return;
> +    }
> +
> +    if (hotplugged) {
> +        spapr_hotplug_req_add_by_index(drc);
> +    } else if (drc) {
> +        spapr_drc_reset(drc);
> +    }
> +}
> +
> +void spapr_phb_release(DeviceState *dev)
> +{
> +    object_unparent(OBJECT(dev));
> +}
> +
> +static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
> +{
> +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
> +    sPAPRDRConnector *drc;
> +
> +    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> +    assert(drc);
> +
> +    if (!spapr_drc_unplug_requested(drc)) {
> +        spapr_drc_detach(drc);
> +        spapr_hotplug_req_remove_by_index(drc);
> +    }
> +}
> +
>  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> @@ -3740,6 +3850,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>          spapr_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          spapr_core_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> +        spapr_phb_plug(hotplug_dev, dev, errp);
>      }
>  }
>  
> @@ -3758,6 +3870,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>  {
>      sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
>      MachineClass *mc = MACHINE_GET_CLASS(sms);
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> @@ -3777,6 +3890,12 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>              return;
>          }
>          spapr_core_unplug_request(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> +        if (!smc->dr_phb_enabled) {
> +            error_setg(errp, "PHB hot unplug not supported on this machine");
> +            return;
> +        }
> +        spapr_phb_unplug_request(hotplug_dev, dev, errp);
>      }
>  }
>  
> @@ -3787,6 +3906,8 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>          spapr_memory_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          spapr_core_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> +        spapr_phb_pre_plug(hotplug_dev, dev, errp);
>      }
>  }
>  
> @@ -3794,7 +3915,8 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
>                                                   DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      return NULL;
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 189ee681062a..7a2676716364 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -703,6 +703,7 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
>      drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
>      drck->typename = "PHB";
>      drck->drc_name_prefix = "PHB ";
> +    drck->release = spapr_phb_release;
>  }
>  
>  static const TypeInfo spapr_dr_connector_info = {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index a0311560e47b..b03bfcf3f446 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1649,21 +1649,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (sphb->index != (uint32_t)-1) {
> -        Error *local_err = NULL;
> -
> -        smc->phb_placement(spapr, sphb->index,
> -                           &sphb->buid, &sphb->io_win_addr,
> -                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
> -                           windows_supported, sphb->dma_liobn, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    } else {
> -        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> -        return;
> -    }
> +    assert(sphb->index != (uint32_t)-1); /* checked in spapr_phb_pre_plug() */
>  
>      if (sphb->mem64_win_size != 0) {
>          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index bc8ebb072258..f78e44d58cef 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -766,6 +766,7 @@ int spapr_max_server_number(sPAPRMachineState *spapr);
>  /* CPU and LMB DRC release callbacks. */
>  void spapr_core_release(DeviceState *dev);
>  void spapr_lmb_release(DeviceState *dev);
> +void spapr_phb_release(DeviceState *dev);
>  
>  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
>  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
> 
