Received: from eggs.gnu.org ([209.51.188.92]:34130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjPFk-0000L4-F1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjPFj-0004aF-PE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:59:40 -0500
Date: Tue, 15 Jan 2019 14:59:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115145929.706e152a.cohuck@redhat.com>
In-Reply-To: <1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size
 mpcifc request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>, walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On Thu, 10 Jan 2019 14:00:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The size of the accessible iommu memory region in the guest
> is given to the IOMMU by the guest through the mpcifc request
> specifying the PCI Base Address and the PCI Address Limit.
> 
> Let set the size of the IOMMU region to:

s/Let/Let's/

>     (PCI Address Limit) - (PCI Base Address) + 1.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 69e0671..e97696a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -660,7 +660,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>      char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
>      memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
>                               TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> -                             name, iommu->pal + 1);
> +                             name, iommu->pal - iommu->pba + 1);
>      iommu->enabled = true;
>      memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>      g_free(name);

Looks good to me. Collin, can I get an ack from you so I can queue it?
