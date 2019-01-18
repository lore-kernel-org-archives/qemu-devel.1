Received: from eggs.gnu.org ([209.51.188.92]:45105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkSjZ-0007P4-57
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkSjU-0000X6-Os
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:46 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:52776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkSjS-0008RF-Db
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:42 -0500
Received: from player731.ha.ovh.net (unknown [10.109.160.12])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 068ACDB65F
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 12:54:23 +0100 (CET)
Date: Fri, 18 Jan 2019 12:54:02 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190118125402.1c2b924b@bahia.lan>
In-Reply-To: <154774531230.1208625.17504534121479554909.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774531230.1208625.17504534121479554909.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/19] spapr_pci: add PHB unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On Thu, 17 Jan 2019 18:15:12 +0100
Greg Kurz <groug@kaod.org> wrote:

> To support PHB hotplug we need to clean up lingering references,
> memory, child properties, etc. prior to the PHB object being
> finalized. Generally this will be called as a result of calling
> object_unparent() on the PHB object, which in turn would normally
> be called as the result of an unplug() operation.
> 
> When the PHB is finalized, child objects will be unparented in
> turn, and finalized if the PHB was the only reference holder. so
> we don't bother to explicitly unparent child objects of the PHB
> (spapr_iommu, spapr_drc, etc).
> 
> The formula that gives the number of DMA windows is moved to an
> inline function in the hw/pci-host/spapr.h header because it
> will have other users.
> 
> The unrealize function is able to cope with partially realized PHBs.
> It is hence used to implement proper rollback on the realize error
> path. Note that older machines that used the legacy irq allocation
> cannot support PHB hotplug, so we don't care to free their LSIs in
> the unrealize function.
> 
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v3: - don't free LSIs at unrealize

Oops... I've mixed up with an intermediate version. We DO want to free LSIs
at unrealize.

Will fix in v4.

> v2: - implement rollback with unrealize function
> ---
>  hw/ppc/spapr_pci.c          |   63 ++++++++++++++++++++++++++++++++++++++++---
>  include/hw/pci-host/spapr.h |    5 +++
>  2 files changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index f5f13a4d4816..0f6a173d5323 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1559,6 +1559,56 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>      }
>  }
>  
> +static void spapr_phb_finalizefn(Object *obj)
> +{
> +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(obj);
> +
> +    g_free(sphb->dtbusname);
> +    sphb->dtbusname = NULL;
> +}
> +
> +static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(phb);
> +    sPAPRTCETable *tcet;
> +    int i;
> +    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
> +
> +    if (sphb->msi) {
> +        g_hash_table_unref(sphb->msi);
> +        sphb->msi = NULL;
> +    }
> +
> +    /*
> +     * Remove IO/MMIO subregions and aliases, rest should get cleaned
> +     * via PHB's unrealize->object_finalize
> +     */
> +    for (i = windows_supported - 1; i >= 0; i--) {
> +        tcet = spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
> +        if (tcet) {
> +            memory_region_del_subregion(&sphb->iommu_root,
> +                                        spapr_tce_get_iommu(tcet));
> +        }
> +    }
> +
> +    QLIST_REMOVE(sphb, list);
> +
> +    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
> +
> +    address_space_destroy(&sphb->iommu_as);
> +
> +    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
> +    pci_unregister_root_bus(phb->bus);
> +
> +    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
> +    if (sphb->mem64_win_pciaddr != (hwaddr)-1) {
> +        memory_region_del_subregion(get_system_memory(), &sphb->mem64window);
> +    }
> +    memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
> +}
> +
>  static uint32_t spapr_phb_index_to_lsi(int phb_index, int irq_index)
>  {
>      return SPAPR_IRQ_PCI_LSI + phb_index * PCI_NUM_PINS + irq_index;
> @@ -1592,8 +1642,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      PCIBus *bus;
>      uint64_t msi_window_size = 4096;
>      sPAPRTCETable *tcet;
> -    const unsigned windows_supported =
> -        sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> +    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
>  
>      if (!spapr) {
>          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
> @@ -1750,7 +1799,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>              if (local_err) {
>                  error_propagate_prepend(errp, local_err,
>                                          "can't allocate LSIs: ");
> -                return;
> +                goto unrealize;
>              }
>              spapr_irq_set_type(spapr, irq, true);
>          }
> @@ -1778,13 +1827,17 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>          if (!tcet) {
>              error_setg(errp, "Creating window#%d failed for %s",
>                         i, sphb->dtbusname);
> -            return;
> +            goto unrealize;
>          }
>          memory_region_add_subregion(&sphb->iommu_root, 0,
>                                      spapr_tce_get_iommu(tcet));
>      }
>  
>      sphb->msi = g_hash_table_new_full(g_int_hash, g_int_equal, g_free, g_free);
> +    return;
> +
> +unrealize:
> +    spapr_phb_unrealize(dev, NULL);
>  }
>  
>  static int spapr_phb_children_reset(Object *child, void *opaque)
> @@ -1983,6 +2036,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
>  
>      hc->root_bus_path = spapr_phb_root_bus_path;
>      dc->realize = spapr_phb_realize;
> +    dc->unrealize = spapr_phb_unrealize;
>      dc->props = spapr_phb_properties;
>      dc->reset = spapr_phb_reset;
>      dc->vmsd = &vmstate_spapr_pci;
> @@ -1998,6 +2052,7 @@ static const TypeInfo spapr_phb_info = {
>      .name          = TYPE_SPAPR_PCI_HOST_BRIDGE,
>      .parent        = TYPE_PCI_HOST_BRIDGE,
>      .instance_size = sizeof(sPAPRPHBState),
> +    .instance_finalize = spapr_phb_finalizefn,
>      .class_init    = spapr_phb_class_init,
>      .interfaces    = (InterfaceInfo[]) {
>          { TYPE_HOTPLUG_HANDLER },
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index bb0ae7fdd41d..2ab75e28dbb5 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -166,4 +166,9 @@ void spapr_phb_dma_reset(sPAPRPHBState *sphb);
>  
>  void spapr_phb_set_lsis(int index, sPAPRMachineState *spapr);
>  
> +static inline unsigned spapr_phb_windows_supported(sPAPRPHBState *sphb)
> +{
> +    return sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> +}
> +
>  #endif /* PCI_HOST_SPAPR_H */
> 
