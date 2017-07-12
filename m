Received: from eggs.gnu.org ([2001:4830:134:3::10]:52873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVEmt-0006fP-22
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVEmp-0002xL-2f
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:22:31 -0400
Date: Wed, 12 Jul 2017 12:22:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712122217.607aa3f8@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170711035620.4232-2-aik@ozlabs.ru>
References: <20170711035620.4232-1-aik@ozlabs.ru>
	<20170711035620.4232-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v9 1/2] memory/iommu: QOM'fy IOMMU
 MemoryRegion
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

On Tue, 11 Jul 2017 13:56:19 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> as a parent.
> 
> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> dymanic QOM casting in fast path (address_space_translate, etc),
> this adds an @is_iommu boolean flag to MR and provides new helper to
> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> is set in the instance init callback. This defines
> memory_region_is_iommu as memory_region_get_iommu()!=NULL.
> 
> This switches MemoryRegion to IOMMUMemoryRegion in most places except
> the ones where MemoryRegion may be an alias.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> Changes:
> v9:
> * added rb:David
> 
> v8:
> * moved is_iommu flag closer to the beginning of the MemoryRegion struct
> * removed memory_region_init_iommu_type()
> 
> v7:
> * rebased on top of the current upstream
> 
> v6:
> * s/\<iommumr\>/iommu_mr/g
> 
> v5:
> * fixed sparc64, first time in many years did run "./configure" without
> --target-list :-D Sorry for the noise though :(
> 
> v4:
> * fixed alpha, mips64el and sparc
> 
> v3:
> * rebased on sha1 81b2d5ceb0
> 
> v2:
> * added mr->is_iommu
> * updated i386/x86_64/s390/sun
> ---
>  hw/s390x/s390-pci-bus.h       |   2 +-
>  include/exec/memory.h         |  55 ++++++++++++++--------
>  include/hw/i386/intel_iommu.h |   2 +-
>  include/hw/mips/mips.h        |   2 +-
>  include/hw/ppc/spapr.h        |   3 +-
>  include/hw/vfio/vfio-common.h |   2 +-
>  include/qemu/typedefs.h       |   1 +
>  exec.c                        |  12 ++---
>  hw/alpha/typhoon.c            |   8 ++--
>  hw/dma/rc4030.c               |   8 ++--
>  hw/i386/amd_iommu.c           |   9 ++--
>  hw/i386/intel_iommu.c         |  17 +++----
>  hw/mips/mips_jazz.c           |   2 +-
>  hw/pci-host/apb.c             |   6 +--
>  hw/ppc/spapr_iommu.c          |  16 ++++---
>  hw/s390x/s390-pci-bus.c       |   6 +--
>  hw/s390x/s390-pci-inst.c      |   8 ++--
>  hw/vfio/common.c              |  12 +++--
>  hw/vfio/spapr.c               |   3 +-
>  memory.c                      | 105 ++++++++++++++++++++++++++++--------------
>  20 files changed, 170 insertions(+), 109 deletions(-)
> 

> @@ -1491,17 +1506,22 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>      mr->ram_block = qemu_ram_alloc(size, mr, errp);
>  }
>  
> -void memory_region_init_iommu(MemoryRegion *mr,
> +void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
>                                Object *owner,
>                                const MemoryRegionIOMMUOps *ops,
>                                const char *name,
>                                uint64_t size)
>  {
> -    memory_region_init(mr, owner, name, size);
> -    mr->iommu_ops = ops,
> +    struct MemoryRegion *mr;
> +
> +    object_initialize(iommu_mr, sizeof(*iommu_mr), TYPE_IOMMU_MEMORY_REGION);
> +    mr = MEMORY_REGION(iommu_mr);
> +    memory_region_do_init(mr, owner, name, size);
> +    iommu_mr = IOMMU_MEMORY_REGION(mr);
> +    iommu_mr->iommu_ops = ops,

I'd finish with a semicolon instead.

Should this require ops != NULL? There are a number of places where
->iommu_ops is dereferenced unconditionally.

>      mr->terminates = true;  /* then re-forwards */
> -    QLIST_INIT(&mr->iommu_notify);
> -    mr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;
> +    QLIST_INIT(&iommu_mr->iommu_notify);
> +    iommu_mr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;
>  }
>  
>  static void memory_region_finalize(Object *obj)

(...)

> -uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
> +uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr)
>  {
> -    assert(memory_region_is_iommu(mr));
> -    if (mr->iommu_ops && mr->iommu_ops->get_min_page_size) {
> -        return mr->iommu_ops->get_min_page_size(mr);
> +    if (iommu_mr->iommu_ops && iommu_mr->iommu_ops->get_min_page_size) {

I think this is the only place that actually checks for iommu_ops.

> +        return iommu_mr->iommu_ops->get_min_page_size(iommu_mr);
>      }
>      return TARGET_PAGE_SIZE;
>  }

The s390 conversions look fine.
