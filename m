Received: from eggs.gnu.org ([2001:4830:134:3::10]:44521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1crLfl-0008SU-1W
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1crLfh-00088e-M5
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:38:17 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1crLfh-00088K-Fp
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:38:13 -0400
Received: by mail-pf0-x241.google.com with SMTP id o126so1775360pfb.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 02:38:13 -0700 (PDT)
References: <1489600837-11541-1-git-send-email-mst@redhat.com>
	<1489600837-11541-6-git-send-email-mst@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7588d6d0-3dee-4234-8dab-7153b0602779@ozlabs.ru>
Date: Fri, 24 Mar 2017 20:38:06 +1100
MIME-Version: 1.0
In-Reply-To: <1489600837-11541-6-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 5/7] pci: introduce a bus master container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 16/03/17 05:01, Michael S. Tsirkin wrote:
> From: Jason Wang <jasowang@redhat.com>
> 
> 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU after caching ring
> translations") tries to make IOMMU works with virtio memory region
> cache, but it requires IOMMU to be created before any virtio
> devices. This is sub optimal, fixing this by introduce a bus master
> container to make sure address space can be initialized during device
> registering, and then we can safely set alias and make
> bus_master_enable_region as its subregion during bus master
> initialization.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


I am not sure why exactly (friday 20:00, gotta go :) ) but this broke PCI
hot uplug on my setup which is ppc64, pseries guest, vfio-pci device.

I run QEMU with:

-device nec-usb-xhci,id=nec-usb-xhci0 \
-device "vfio-pci,id=vfio0001_01_00_2,host=0001:01:00.2"

Then:
{ "execute": "device_del", "arguments": {"id": "vfio0001_01_00_2"} }

all good. Then repeat after 30s:
{   'error': {   'class': 'DeviceNotFound',
                 'desc': "Device 'vfio0001_01_00_2' not found"}}

which is expected, and then, after a minute or so:

{   'error': {   'class': 'GenericError',
                 'desc': 'vfio error: 0001:01:00.2: device is already '
                         'attached'}}

And I can definitely tell that vfio_exitfn() has been called but
vfio_instance_finalize() has not so something is holding vfio-pci device.

Any quick ideas why or I debug on Monday? Thanks!

btw I tried sha1 0832970119.



> ---
>  include/hw/pci/pci.h | 1 +
>  hw/pci/pci.c         | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 9349acb..713ede0 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -284,6 +284,7 @@ struct PCIDevice {
>      char name[64];
>      PCIIORegion io_regions[PCI_NUM_REGIONS];
>      AddressSpace bus_master_as;
> +    MemoryRegion bus_master_container_region;
>      MemoryRegion bus_master_enable_region;
>  
>      /* do not access the following fields */
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 273f1e4..ad46390 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -88,8 +88,8 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
>                               OBJECT(pci_dev), "bus master",
>                               dma_as->root, 0, memory_region_size(dma_as->root));
>      memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
> -    address_space_init(&pci_dev->bus_master_as,
> -                       &pci_dev->bus_master_enable_region, pci_dev->name);
> +    memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
> +                                &pci_dev->bus_master_enable_region);
>  }
>  
>  static void pcibus_machine_done(Notifier *notifier, void *data)
> @@ -995,6 +995,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>      pci_dev->devfn = devfn;
>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
>  
> +    memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
> +                       "bus master container", UINT64_MAX);
> +    address_space_init(&pci_dev->bus_master_as,
> +                       &pci_dev->bus_master_container_region, pci_dev->name);
> +
>      if (qdev_hotplug) {
>          pci_init_bus_master(pci_dev);
>      }
> 


-- 
Alexey
