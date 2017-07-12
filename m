Received: from eggs.gnu.org ([2001:4830:134:3::10]:52008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVHXJ-00082c-VL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVHXF-0007MJ-Ud
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:18:37 -0400
Date: Wed, 12 Jul 2017 15:18:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712151821.5237af0a@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170711035620.4232-3-aik@ozlabs.ru>
References: <20170711035620.4232-1-aik@ozlabs.ru>
	<20170711035620.4232-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v9 2/2] memory/iommu: introduce
 IOMMUMemoryRegionClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org

On Tue, 11 Jul 2017 13:56:20 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This finishes QOM'fication of IOMMUMemoryRegion by introducing
> a IOMMUMemoryRegionClass. This also provides a fastpath analog for
> IOMMU_MEMORY_REGION_GET_CLASS().
> 
> This makes IOMMUMemoryRegion an abstract class.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v9:
> * moved IOMMU MR typenames next to respective IOMMU device typenames
> * renamed few definitions and functions to match the rest of the code
> (for example intel_vtd_iommu_memory_region_class_init -> vtd_iommu_memory_region_class_init
> as the rest of that file uses "vtd_" as a prefix)
> 
> v8:
> * first appearance
> ---
>  hw/i386/amd_iommu.h           |  5 ++---
>  hw/s390x/s390-pci-bus.h       |  1 +
>  include/exec/memory.h         | 45 +++++++++++++++++++++++++++++++++----------
>  include/hw/i386/intel_iommu.h |  3 ++-
>  include/hw/ppc/spapr.h        |  4 ++++
>  exec.c                        |  6 ++++--
>  hw/alpha/typhoon.c            | 23 +++++++++++++++++-----
>  hw/dma/rc4030.c               | 26 +++++++++++++++++++------
>  hw/i386/amd_iommu.c           | 24 +++++++++++++++++++----
>  hw/i386/intel_iommu.c         | 25 +++++++++++++++++++-----
>  hw/pci-host/apb.c             | 23 +++++++++++++++++-----
>  hw/ppc/spapr_iommu.c          | 26 ++++++++++++++++++-------
>  hw/s390x/s390-pci-bus.c       | 23 ++++++++++++++++------
>  hw/s390x/s390-pci-inst.c      |  5 ++++-
>  memory.c                      | 36 +++++++++++++++++++---------------
>  15 files changed, 205 insertions(+), 70 deletions(-)

(...)

> diff --git a/memory.c b/memory.c
> index 45e10e2e3b..69f697c20e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1506,19 +1506,20 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>      mr->ram_block = qemu_ram_alloc(size, mr, errp);
>  }
>  
> -void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
> +void memory_region_init_iommu(void *_iommu_mr,
> +                              size_t instance_size,
> +                              const char *mrtypename,
>                                Object *owner,
> -                              const MemoryRegionIOMMUOps *ops,
>                                const char *name,
>                                uint64_t size)
>  {
> +    struct IOMMUMemoryRegion *iommu_mr;
>      struct MemoryRegion *mr;
>  
> -    object_initialize(iommu_mr, sizeof(*iommu_mr), TYPE_IOMMU_MEMORY_REGION);
> -    mr = MEMORY_REGION(iommu_mr);
> +    object_initialize(_iommu_mr, instance_size, mrtypename);
> +    mr = MEMORY_REGION(_iommu_mr);
>      memory_region_do_init(mr, owner, name, size);
>      iommu_mr = IOMMU_MEMORY_REGION(mr);
> -    iommu_mr->iommu_ops = ops,

Ah, here the comma is gone anyway :)

>      mr->terminates = true;  /* then re-forwards */
>      QLIST_INIT(&iommu_mr->iommu_notify);
>      iommu_mr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;

(...)

> @@ -1655,8 +1656,10 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
>  
>  uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr)
>  {
> -    if (iommu_mr->iommu_ops && iommu_mr->iommu_ops->get_min_page_size) {
> -        return iommu_mr->iommu_ops->get_min_page_size(iommu_mr);
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +
> +    if (imrc->get_min_page_size) {
> +        return imrc->get_min_page_size(iommu_mr);

And this voids my other complaint for the previous patch as well.

>      }
>      return TARGET_PAGE_SIZE;
>  }

s390 parts look fine.
