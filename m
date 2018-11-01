Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIE7c-0005n5-Pb
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIE7b-00084Y-2l
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:38:56 -0400
Date: Thu, 1 Nov 2018 15:38:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101153823.1660c3ff@redhat.com>
In-Reply-To: <20181024101930.20674-5-david@redhat.com>
References: <20181024101930.20674-1-david@redhat.com>
	<20181024101930.20674-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/7] pci/pcie: route unplug via the
 hotplug handler
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
	. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 24 Oct 2018 12:19:27 +0200
David Hildenbrand <david@redhat.com> wrote:

> Preparation for multi-stage hotplug handlers.
commit message needs a rationale shat/why is done here, especially
if it's preliminary refactoring for some future work
(which I'd shortly describe here as well).

The same applies to patches 5-7.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/pci/pcie.c         | 10 +++++++++-
>  hw/pci/pcie_port.c    |  1 +
>  include/hw/pci/pcie.h |  2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 02a7bf3af5..744727dc0b 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -364,11 +364,19 @@ void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>      }
>  }
>  
> -static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
> +void pcie_cap_slot_hot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                 Error **errp)
>  {
>      object_unparent(OBJECT(dev));
>  }
>  
> +static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
> +{
> +    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
> +
> +    hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
> +}
> +
>  void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                           DeviceState *dev, Error **errp)
>  {
> diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
> index 13fe6c6945..6e993da603 100644
> --- a/hw/pci/pcie_port.c
> +++ b/hw/pci/pcie_port.c
> @@ -156,6 +156,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
>      dc->props = pcie_slot_props;
>      hc->pre_plug = pcie_cap_slot_pre_plug_cb;
>      hc->plug = pcie_cap_slot_hotplug_cb;
> +    hc->unplug = pcie_cap_slot_hot_unplug_cb;
>      hc->unplug_request = pcie_cap_slot_hot_unplug_request_cb;
>  }
>  
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 001d230d7d..b6f05a0e43 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -135,6 +135,8 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp);
>  void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                Error **errp);
> +void pcie_cap_slot_hot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                 Error **errp);
>  void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                           DeviceState *dev, Error **errp);
>  #endif /* QEMU_PCIE_H */
