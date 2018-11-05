Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJaut-0000ht-JP
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJauq-0004ic-9F
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:11:27 -0500
References: <20181024101930.20674-1-david@redhat.com>
	<20181024101930.20674-6-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a3ff110b-286c-6a66-0638-6f18c7259777@redhat.com>
Date: Mon, 5 Nov 2018 10:11:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181024101930.20674-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/7] pci/shpc: move hotplug checks to
 preplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org

On 24.10.18 12:19, David Hildenbrand wrote:
> Move the checks to the pre_plug handler. I don't see a reason to check
> for the PCI slot when unplugging.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/pci-bridge/pci_bridge_dev.c  | 11 ++++++++--
>  hw/pci-bridge/pcie_pci_bridge.c | 11 ++++++++--
>  hw/pci/shpc.c                   | 36 ++++++++++++++-------------------
>  include/hw/pci/shpc.h           |  2 ++
>  4 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index 97a8e8b6a4..2362dcbc64 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -206,8 +206,8 @@ static const VMStateDescription pci_bridge_dev_vmstate = {
>      }
>  };
>  
> -static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> +static void pci_bridge_dev_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                       DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>  
> @@ -216,6 +216,12 @@ static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
>                     "this %s", TYPE_PCI_BRIDGE_DEV);
>          return;
>      }
> +    shpc_device_pre_plug_cb(hotplug_dev, dev, errp);
> +}
> +
> +static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
> +{
>      shpc_device_hotplug_cb(hotplug_dev, dev, errp);
>  }
>  
> @@ -251,6 +257,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
>      dc->props = pci_bridge_dev_properties;
>      dc->vmsd = &pci_bridge_dev_vmstate;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    hc->pre_plug = pci_bridge_dev_pre_plug_cb;
>      hc->plug = pci_bridge_dev_hotplug_cb;
>      hc->unplug_request = pci_bridge_dev_hot_unplug_request_cb;
>  }
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> index 04cf5a6a92..cde8af0a4e 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -137,8 +137,8 @@ static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
>          }
>  };
>  
> -static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> +static void pcie_pci_bridge_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>  
> @@ -147,6 +147,12 @@ static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
>                     "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
>          return;
>      }
> +    shpc_device_pre_plug_cb(hotplug_dev, dev, errp);
> +}
> +
> +static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
> +{
>      shpc_device_hotplug_cb(hotplug_dev, dev, errp);
>  }
>  
> @@ -180,6 +186,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
>      dc->props = pcie_pci_bridge_dev_properties;
>      dc->reset = &pcie_pci_bridge_reset;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    hc->pre_plug = pcie_pci_bridge_pre_plug_cb;
>      hc->plug = pcie_pci_bridge_hotplug_cb;
>      hc->unplug_request = pcie_pci_bridge_hot_unplug_request_cb;
>  }
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index a8462d48bb..1caf4a7ee9 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -482,13 +482,21 @@ static const MemoryRegionOps shpc_mmio_ops = {
>          .max_access_size = 4,
>      },
>  };
> -static void shpc_device_hotplug_common(PCIDevice *affected_dev, int *slot,
> -                                       SHPCDevice *shpc, Error **errp)
> +
> +static inline int shpc_device_get_slot(PCIDevice *dev)
> +{
> +    return SHPC_PCI_TO_IDX(dev->devfn);
> +}
> +
> +void shpc_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                             Error **errp)
>  {
> -    int pci_slot = PCI_SLOT(affected_dev->devfn);
> -    *slot = SHPC_PCI_TO_IDX(pci_slot);
> +    SHPCDevice *shpc = PCI_DEVICE(hotplug_dev)->shpc;
> +    PCIDevice *pdev = PCI_DEVICE(dev);
> +    int pci_slot = PCI_SLOT(pdev->devfn);
> +    int slot = shpc_device_get_slot(pdev);
>  
> -    if (pci_slot < SHPC_IDX_TO_PCI(0) || *slot >= shpc->nslots) {
> +    if (pci_slot < SHPC_IDX_TO_PCI(0) || slot >= shpc->nslots) {
>          error_setg(errp, "Unsupported PCI slot %d for standard hotplug "
>                     "controller. Valid slots are between %d and %d.",
>                     pci_slot, SHPC_IDX_TO_PCI(0),


Looking at the details, pdev->devfn might not be properly assigned yet
in pre_plug, as it will (currently) be done during realize(). So moving
this to pre_plug can only be done after the PCI realization has been
refactored.


-- 

Thanks,

David / dhildenb
