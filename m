Received: from eggs.gnu.org ([209.51.188.92]:47218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghDf5-0003Fm-Fy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghDSC-00022e-2r
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:59:28 -0500
Date: Wed, 9 Jan 2019 13:59:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190109135919.3ebb7d03.cohuck@redhat.com>
In-Reply-To: <1546968819-8166-1-git-send-email-pmorel@linux.ibm.com>
References: <1546968819-8166-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/pci: Set the iommu region size as
 guest wants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On Tue,  8 Jan 2019 18:33:39 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The size of the accessible iommu memory region in the guest
> is calculated by the gues as:

s/gues/guest/

>     (PCI Address Limit) - (PCI Base Address) + 1.
> 
> Let's use this value to limit the IOMMU region size.

These are values provided by the guest in the mpcifc call, aren't they?
Let's mention that in the patch description, so it is more obvious :)

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
