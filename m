Received: from eggs.gnu.org ([2001:4830:134:3::10]:56032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egn31-0005qD-EK
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1egn2y-0002yq-B6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:43:11 -0500
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4740d12b-4dc0-d836-2f9e-574b836b72e7@redhat.com>
Date: Wed, 31 Jan 2018 08:42:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/pci: fixup the code walking
 IOMMU tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: pasic@linux.vnet.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, marcel@redhat.com, qemu-s390x@nongnu.org

On 30.01.2018 10:47, Yi Min Zhao wrote:
> Current s390x PCI IOMMU code is lack of flags' checking, including:
> 1) protection bit
> 2) table length
> 3) table offset
> 4) intermediate tables' invalid bit
> 5) format control bit
> 
> This patch introduces a new struct named S390IOTLBEntry, and makes up
> these missed checkings. At the same time, inform the guest with the
> corresponding error number when the check fails.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 223 ++++++++++++++++++++++++++++++++++++++---------
>  hw/s390x/s390-pci-bus.h  |  10 +++
>  hw/s390x/s390-pci-inst.c |  10 ---
>  3 files changed, 190 insertions(+), 53 deletions(-)
[...]
> @@ -374,26 +511,26 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
>      DPRINTF("iommu trans addr 0x%" PRIx64 "\n", addr);
>  
>      if (addr < iommu->pba || addr > iommu->pal) {
> -        return ret;
> +        error = ERR_EVENT_OORANGE;
> +        goto err;
>      }
>  
> -    pte = s390_guest_io_table_walk(s390_pci_get_table_origin(iommu->g_iota),
> -                                   addr);
> -    if (!pte) {
> -        return ret;
> -    }
> +    error = s390_guest_io_table_walk(iommu->g_iota, addr, &entry);
>  
> -    flags = pte & ZPCI_PTE_FLAG_MASK;
> -    ret.iova = addr;
> -    ret.translated_addr = pte & ZPCI_PTE_ADDR_MASK;
> -    ret.addr_mask = 0xfff;
> +    ret.iova = entry.iova;
> +    ret.translated_addr = entry.translated_addr;
> +    ret.addr_mask = entry.len - 1;
> +    ret.perm = entry.perm;
>  
> -    if (flags & ZPCI_PTE_INVALID) {
> -        ret.perm = IOMMU_NONE;
> -    } else {
> -        ret.perm = IOMMU_RW;
> +    if ((flag != IOMMU_NONE) && !(flag & ret.perm)) {

You could drop the parentheses around "flag != IOMMU_NONE".

For the rest of the patch: Sorry, can't review due to missing PCI spec :-(

 Thomas
