Received: from eggs.gnu.org ([2001:4830:134:3::10]:44872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOluJ-0000tB-PA
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gOluD-0005vv-JS
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:56:15 -0500
Date: Mon, 19 Nov 2018 16:56:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181119165605.7878ae38@redhat.com>
In-Reply-To: <20181105102044.20547-3-david@redhat.com>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/10] pci/shpc: rename hotplug handler
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

On Mon,  5 Nov 2018 11:20:36 +0100
David Hildenbrand <david@redhat.com> wrote:

> The callbacks are also called for cold plugged devices. Drop the "hot"
> to better match the actual callback names.
> 
> While at it, also rename shpc_device_hotplug_common() to
> shpc_device_plug_common().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/pci-bridge/pci_bridge_dev.c  | 17 ++++++++---------
>  hw/pci-bridge/pcie_pci_bridge.c | 17 ++++++++---------
>  hw/pci/shpc.c                   | 14 +++++++-------
>  include/hw/pci/shpc.h           |  8 ++++----
>  4 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index 97a8e8b6a4..e1df9a52ac 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -206,8 +206,8 @@ static const VMStateDescription pci_bridge_dev_vmstate = {
>      }
>  };
>  
> -static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> +static void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>  
> @@ -216,12 +216,11 @@ static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
>                     "this %s", TYPE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hotplug_cb(hotplug_dev, dev, errp);
> +    shpc_device_plug_cb(hotplug_dev, dev, errp);
>  }
>  
> -static void pci_bridge_dev_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                                 DeviceState *dev,
> -                                                 Error **errp)
> +static void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                             DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>  
> @@ -230,7 +229,7 @@ static void pci_bridge_dev_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                     "this %s", TYPE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
> +    shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
>  }
>  
>  static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
> @@ -251,8 +250,8 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
>      dc->props = pci_bridge_dev_properties;
>      dc->vmsd = &pci_bridge_dev_vmstate;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    hc->plug = pci_bridge_dev_hotplug_cb;
> -    hc->unplug_request = pci_bridge_dev_hot_unplug_request_cb;
> +    hc->plug = pci_bridge_dev_plug_cb;
> +    hc->unplug_request = pci_bridge_dev_unplug_request_cb;
>  }
>  
>  static const TypeInfo pci_bridge_dev_info = {
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> index 04cf5a6a92..c634353b06 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -137,8 +137,8 @@ static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
>          }
>  };
>  
> -static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> +static void pcie_pci_bridge_plug_cb(HotplugHandler *hotplug_dev,
> +                                    DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>  
> @@ -147,12 +147,11 @@ static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
>                     "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hotplug_cb(hotplug_dev, dev, errp);
> +    shpc_device_plug_cb(hotplug_dev, dev, errp);
>  }
>  
> -static void pcie_pci_bridge_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                                 DeviceState *dev,
> -                                                 Error **errp)
> +static void pcie_pci_bridge_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                              DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>  
> @@ -161,7 +160,7 @@ static void pcie_pci_bridge_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                     "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
> +    shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
>  }
>  
>  static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
> @@ -180,8 +179,8 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
>      dc->props = pcie_pci_bridge_dev_properties;
>      dc->reset = &pcie_pci_bridge_reset;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    hc->plug = pcie_pci_bridge_hotplug_cb;
> -    hc->unplug_request = pcie_pci_bridge_hot_unplug_request_cb;
> +    hc->plug = pcie_pci_bridge_plug_cb;
> +    hc->unplug_request = pcie_pci_bridge_unplug_request_cb;
>  }
>  
>  static const TypeInfo pcie_pci_bridge_info = {
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index a8462d48bb..098ffaef1d 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -482,8 +482,8 @@ static const MemoryRegionOps shpc_mmio_ops = {
>          .max_access_size = 4,
>      },
>  };
> -static void shpc_device_hotplug_common(PCIDevice *affected_dev, int *slot,
> -                                       SHPCDevice *shpc, Error **errp)
> +static void shpc_device_plug_common(PCIDevice *affected_dev, int *slot,
> +                                    SHPCDevice *shpc, Error **errp)
>  {
>      int pci_slot = PCI_SLOT(affected_dev->devfn);
>      *slot = SHPC_PCI_TO_IDX(pci_slot);
> @@ -497,7 +497,7 @@ static void shpc_device_hotplug_common(PCIDevice *affected_dev, int *slot,
>      }
>  }
>  
> -void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                              Error **errp)
>  {
>      Error *local_err = NULL;
> @@ -505,7 +505,7 @@ void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>      SHPCDevice *shpc = pci_hotplug_dev->shpc;
>      int slot;
>  
> -    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
> +    shpc_device_plug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -540,8 +540,8 @@ void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>      shpc_interrupt_update(pci_hotplug_dev);
>  }
>  
> -void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                       DeviceState *dev, Error **errp)
> +void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp)
>  {
>      Error *local_err = NULL;
>      PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
> @@ -550,7 +550,7 @@ void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>      uint8_t led;
>      int slot;
>  
> -    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
> +    shpc_device_plug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
> index ee19fecf61..71293aca58 100644
> --- a/include/hw/pci/shpc.h
> +++ b/include/hw/pci/shpc.h
> @@ -45,10 +45,10 @@ void shpc_free(PCIDevice *dev);
>  void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len);
>  
>  
> -void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> -                            Error **errp);
> -void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                       DeviceState *dev, Error **errp);
> +void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                         Error **errp);
> +void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp);
>  
>  extern VMStateInfo shpc_vmstate_info;
>  #define SHPC_VMSTATE(_field, _type,  _test) \
