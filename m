Received: from eggs.gnu.org ([209.51.188.92]:57817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjQkp-0000Vu-Kh
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjQko-0007a8-R7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:35:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gjQko-0007Zj-Gi
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:35:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FFTHMm099836
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:35:48 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q1h3hvgkc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:35:48 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 15 Jan 2019 15:35:47 -0000
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 15 Jan 2019 10:35:42 -0500
MIME-Version: 1.0
In-Reply-To: <1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f6a5491a-1859-8e0a-7357-901d47ee8304@linux.ibm.com>
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
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On 1/10/19 8:00 AM, Pierre Morel wrote:
> The size of the accessible iommu memory region in the guest
> is given to the IOMMU by the guest through the mpcifc request
> specifying the PCI Base Address and the PCI Address Limit.
> 
> Let set the size of the IOMMU region to:
>      (PCI Address Limit) - (PCI Base Address) + 1.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 69e0671..e97696a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -660,7 +660,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>       char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
>       memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
>                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> -                             name, iommu->pal + 1);
> +                             name, iommu->pal - iommu->pba + 1);
>       iommu->enabled = true;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);
> 

Acked-by: Collin Walling <walling@linux.ibm.com>
