Received: from eggs.gnu.org ([2001:4830:134:3::10]:47897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjJ0S-0005FU-GU
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjJ0O-00080S-Da
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:10:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cjJ0O-0007zi-7D
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:10:20 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 922F77E9D3
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 05:10:19 +0000 (UTC)
Date: Thu, 2 Mar 2017 07:10:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170302051016.GA3893@redhat.com>
References: <1488341440-4347-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488341440-4347-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: unbreak virtio-pci with IOMMU
 after caching ring translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, wexu@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Mar 01, 2017 at 12:10:40PM +0800, Jason Wang wrote:
> Commit c611c76417f5 ("virtio: add MemoryListener to cache ring
> translations") registers a memory listener to dma_as. This may not
> work when IOMMU is enabled: dma_as(bus_master_as) were initialized in
> pcibus_machine_done() after virtio_realize(). This will cause a
> segfault. Fixing this by using pci_device_iommu_address_space()
> instead to make sure address space were initialized at this time.
> 
> With this fix, IOMMU device were required to be initialized before any
> virtio-pci devices.
> 
> Fixes: c611c76417f5 ("virtio: add MemoryListener to cache ring translations")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This is very ugly. I guess it's better than broken IOMMU ...
Paolo?


> ---
>  hw/virtio/virtio-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 5ce42af..b76f3f6 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1153,7 +1153,7 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
>      VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
>      PCIDevice *dev = &proxy->pci_dev;
>  
> -    return pci_get_address_space(dev);
> +    return pci_device_iommu_address_space(dev);
>  }
>  
>  static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
> -- 
> 2.7.4
