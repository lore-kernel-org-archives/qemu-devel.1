Received: from eggs.gnu.org ([2001:4830:134:3::10]:40071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOliN-0001Rp-VQ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOliJ-0006kr-0m
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:43:55 -0500
Date: Mon, 19 Nov 2018 16:43:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181119164344.275b493f@redhat.com>
In-Reply-To: <20181105102044.20547-2-david@redhat.com>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/10] pci/pcie: rename hotplug handler
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Mon,  5 Nov 2018 11:20:35 +0100
David Hildenbrand <david@redhat.com> wrote:

> The callbacks are also called for cold plugged devices. Drop the "hot"
> to better match the actual callback names.
> 
> While at it, also rename  pcie_cap_slot_hotplug_common() to
> pcie_cap_slot_check_common().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
With commit message amended per David's suggestion

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/pci/pcie.c         | 17 ++++++++---------
>  hw/pci/pcie_port.c    |  4 ++--
>  include/hw/pci/pcie.h |  8 ++++----
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 6c91bd44a0..44737cc1cd 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -315,9 +315,8 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCIExpressHotPlugEvent event)
>      hotplug_event_notify(dev);
>  }
>  
> -static void pcie_cap_slot_hotplug_common(PCIDevice *hotplug_dev,
> -                                         DeviceState *dev,
> -                                         uint8_t **exp_cap, Error **errp)
> +static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
> +                                      uint8_t **exp_cap, Error **errp)
>  {
>      *exp_cap = hotplug_dev->config + hotplug_dev->exp.exp_cap;
>      uint16_t sltsta = pci_get_word(*exp_cap + PCI_EXP_SLTSTA);
> @@ -331,13 +330,13 @@ static void pcie_cap_slot_hotplug_common(PCIDevice *hotplug_dev,
>      }
>  }
>  
> -void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> -                              Error **errp)
> +void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp)
>  {
>      uint8_t *exp_cap;
>      PCIDevice *pci_dev = PCI_DEVICE(dev);
>  
> -    pcie_cap_slot_hotplug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, errp);
> +    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, errp);
>  
>      /* Don't send event when device is enabled during qemu machine creation:
>       * it is present on boot, no hotplug event is necessary. We do send an
> @@ -365,14 +364,14 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
>      object_unparent(OBJECT(dev));
>  }
>  
> -void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                         DeviceState *dev, Error **errp)
> +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
>  {
>      uint8_t *exp_cap;
>      PCIDevice *pci_dev = PCI_DEVICE(dev);
>      PCIBus *bus = pci_get_bus(pci_dev);
>  
> -    pcie_cap_slot_hotplug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, errp);
> +    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, errp);
>  
>      /* In case user cancel the operation of multi-function hot-add,
>       * remove the function that is unexposed to guest individually,
> diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
> index 6432b9ac1f..73e81e5847 100644
> --- a/hw/pci/pcie_port.c
> +++ b/hw/pci/pcie_port.c
> @@ -154,8 +154,8 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>  
>      dc->props = pcie_slot_props;
> -    hc->plug = pcie_cap_slot_hotplug_cb;
> -    hc->unplug_request = pcie_cap_slot_hot_unplug_request_cb;
> +    hc->plug = pcie_cap_slot_plug_cb;
> +    hc->unplug_request = pcie_cap_slot_unplug_request_cb;
>  }
>  
>  static const TypeInfo pcie_slot_type_info = {
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index b71e369703..735f8e8154 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -131,8 +131,8 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
>  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
>  
> -void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> -                              Error **errp);
> -void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                         DeviceState *dev, Error **errp);
> +void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp);
> +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp);
>  #endif /* QEMU_PCIE_H */
