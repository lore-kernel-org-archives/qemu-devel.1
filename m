Received: from eggs.gnu.org ([2001:4830:134:3::10]:41402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csWZF-0007EK-KN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csWZC-0001YL-Io
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:28:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csWZC-0001Xi-Cv
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:28:22 -0400
References: <20170327044030.31306-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d474bbee-94aa-d8d2-7369-71058fb8a099@redhat.com>
Date: Mon, 27 Mar 2017 17:28:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170327044030.31306-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Add missing drop of bus master
 AS reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>



On 27/03/2017 06:40, Alexey Kardashevskiy wrote:
> The recent introduction of a bus master container added
> memory_region_add_subregion() into the PCI device registering path but
> missed memory_region_del_subregion() in the unregistering path leaving
> a reference to the root memory region of the new container.
> 
> This adds missing memory_region_del_subregion().
> 
> Fixes: 3716d5902d743 ("pci: introduce a bus master container")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e6b08e1988..bd8043c460 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
>      pci_dev->bus->devices[pci_dev->devfn] = NULL;
>      pci_config_free(pci_dev);
>  
> +    memory_region_del_subregion(&pci_dev->bus_master_container_region,
> +                                &pci_dev->bus_master_enable_region);
>      address_space_destroy(&pci_dev->bus_master_as);
>  }
>  
> 

My own review fail.  The enable subregion would be deleted when a memory
region is finalized, but the enable subregions is keeping the owner
alive.  And until the owner is alive, the container region is not
deleted either.  So there is a reference count cycle, which we need to
break.

It's probably good to revisit commit 2e2b8eb ("memory: allow destroying
a non-empty MemoryRegion", 2015-10-01).  For 2.9,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
