Received: from eggs.gnu.org ([2001:4830:134:3::10]:44947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fBwY1-0003Q2-7D
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fBwXy-0004Ld-2f
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:07:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fBwXx-0004LP-SF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:07:53 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-9-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
Date: Fri, 27 Apr 2018 14:07:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180425045129.17449-9-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, "Tian, Kevin" <kevin.tian@intel.com>



On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
> For each VTDAddressSpace, now we maintain what IOVA ranges we have
> mapped and what we have not.  With that information, now we only send
> MAP or UNMAP when necessary.  Say, we don't send MAP notifies if we kno=
w
> we have already mapped the range, meanwhile we don't send UNMAP notifie=
s
> if we know we never mapped the range at all.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/hw/i386/intel_iommu.h |  2 ++
>   hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
>   hw/i386/trace-events          |  2 ++
>   3 files changed, 32 insertions(+)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iomm=
u.h
> index 486e205e79..09a2e94404 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -27,6 +27,7 @@
>   #include "hw/i386/ioapic.h"
>   #include "hw/pci/msi.h"
>   #include "hw/sysbus.h"
> +#include "qemu/interval-tree.h"
>  =20
>   #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
>   #define INTEL_IOMMU_DEVICE(obj) \
> @@ -95,6 +96,7 @@ struct VTDAddressSpace {
>       QLIST_ENTRY(VTDAddressSpace) next;
>       /* Superset of notifier flags that this address space has */
>       IOMMUNotifierFlag notifier_flags;
> +    ITTree *iova_tree;          /* Traces mapped IOVA ranges */
>   };
>  =20
>   struct VTDBus {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a19c18b8d4..8f396a5d13 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -768,12 +768,37 @@ typedef struct {
>   static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
>                                vtd_page_walk_info *info)
>   {
> +    VTDAddressSpace *as =3D info->as;
>       vtd_page_walk_hook hook_fn =3D info->hook_fn;
>       void *private =3D info->private;
> +    ITRange *mapped =3D it_tree_find(as->iova_tree, entry->iova,
> +                                   entry->iova + entry->addr_mask);
>  =20
>       assert(hook_fn);
> +
> +    /* Update local IOVA mapped ranges */
> +    if (entry->perm) {
> +        if (mapped) {
> +            /* Skip since we have already mapped this range */
> +            trace_vtd_page_walk_one_skip_map(entry->iova, entry->addr_=
mask,
> +                                             mapped->start, mapped->en=
d);
> +            return 0;
> +        }
> +        it_tree_insert(as->iova_tree, entry->iova,
> +                       entry->iova + entry->addr_mask);

I was consider a case e.g:

1) map A (iova) to B (pa)
2) invalidate A
3) map A (iova) to C (pa)
4) invalidate A

In this case, we will probably miss a walk here. But I'm not sure it was=20
allowed by the spec (though I think so).

Thanks

> +    } else {
> +        if (!mapped) {
> +            /* Skip since we didn't map this range at all */
> +            trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->add=
r_mask);
> +            return 0;
> +        }
> +        it_tree_remove(as->iova_tree, entry->iova,
> +                       entry->iova + entry->addr_mask);
> +    }
> +
>       trace_vtd_page_walk_one(level, entry->iova, entry->translated_add=
r,
>                               entry->addr_mask, entry->perm);
> +
>       return hook_fn(entry, private);
>   }
>  =20
> @@ -2798,6 +2823,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus, int devfn)
>           vtd_dev_as->devfn =3D (uint8_t)devfn;
>           vtd_dev_as->iommu_state =3D s;
>           vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
> +        vtd_dev_as->iova_tree =3D it_tree_new();
>  =20
>           /*
>            * Memory region relationships looks like (Address range show=
s
> @@ -2894,6 +2920,8 @@ static void vtd_address_space_unmap(VTDAddressSpa=
ce *as, IOMMUNotifier *n)
>                                VTD_PCI_FUNC(as->devfn),
>                                entry.iova, size);
>  =20
> +    it_tree_remove(as->iova_tree, entry.iova, entry.iova + entry.addr_=
mask);
> +
>       memory_region_notify_one(n, &entry);
>   }
>  =20
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 22d44648af..677f83420d 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -40,6 +40,8 @@ vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t=
 fn, uint16_t domain, uint6
>   vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay i=
nvalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
>   vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, ui=
nt64_t end) "walk (base=3D0x%"PRIx64", level=3D%"PRIu32") iova range 0x%"=
PRIx64" - 0x%"PRIx64
>   vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64=
_t mask, int perm) "detected page level 0x%"PRIx32" iova 0x%"PRIx64" -> g=
pa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
> +vtd_page_walk_one_skip_map(uint64_t iova, uint64_t mask, uint64_t star=
t, uint64_t end) "iova 0x%"PRIx64" mask 0x%"PRIx64" start 0x%"PRIx64" end=
 0x%"PRIx64
> +vtd_page_walk_one_skip_unmap(uint64_t iova, uint64_t mask) "iova 0x%"P=
RIx64" mask 0x%"PRIx64
>   vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip=
 iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
>   vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip=
 iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
>   vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk s=
kip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
