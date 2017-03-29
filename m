Received: from eggs.gnu.org ([2001:4830:134:3::10]:49903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctDsy-0003X5-0f
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctDsu-0004qH-2E
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ctDst-0004ot-Rg
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E3EB9F74E
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 13:43:33 +0000 (UTC)
References: <1490769502-4723-1-git-send-email-jasowang@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f54c31dd-b3a8-4265-0db2-a4a1f0743d89@redhat.com>
Date: Wed, 29 Mar 2017 16:43:29 +0300
MIME-Version: 1.0
In-Reply-To: <1490769502-4723-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: correctly initialize bus master as
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org

On 03/29/2017 09:38 AM, Jason Wang wrote:
> After commit b86eacb804bdb ("hw/pci: delay bus_master_enable_region
> initialization"), if the device is hotplugged, bus master as will be
> initialized before pci_dev->name which will cause a NULL address space
> name. Things will be even worse after 3716d5902d743 ("pci: introduce a
> bus master container"). So fixing by making sure pci_dev->name is
> initialized before bus master as.
>
> Fixes: b86eacb804bdb ("hw/pci: delay bus_master_enable_region initialization")
> Fixes: 3716d5902d743 ("pci: introduce a bus master container")
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e6b08e1..309afb7 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -996,6 +996,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>
>      pci_dev->devfn = devfn;
>      pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
> +    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>
>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>                         "bus master container", UINT64_MAX);
> @@ -1005,7 +1006,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>      if (qdev_hotplug) {
>          pci_init_bus_master(pci_dev);
>      }
> -    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>      pci_dev->irq_state = 0;
>      pci_config_alloc(pci_dev);
>
>

Hi,

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
