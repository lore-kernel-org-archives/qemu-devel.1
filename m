Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVDCB-0002gW-V8
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVDC7-0001Q2-0f
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:08:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVDC6-0001Px-O8
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:08:10 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <490bbb84-213b-1b2a-5a1b-fa42a5c6a359@redhat.com>
Date: Sun, 22 Jan 2017 16:08:04 +0800
MIME-Version: 1.0
In-Reply-To: <1484917736-32056-19-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 18/20] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
> This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
> upstream:
>
>    "IOMMU: enable intel_iommu map and unmap notifiers"
>    https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html
>
> However I removed/fixed some content, and added my own codes.
>
> Instead of translate() every page for iotlb invalidations (which is
> slower), we walk the pages when needed and notify in a hook function.
>
> This patch enables vfio devices for VT-d emulation.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c         | 66 ++++++++++++++++++++++++++++++++++=
+++------
>   include/hw/i386/intel_iommu.h |  8 ++++++
>   2 files changed, 65 insertions(+), 9 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 83a2e1f..7cbf057 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -833,7 +833,8 @@ next:
>    * @private: private data for the hook function
>    */
>   static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_=
t end,
> -                         vtd_page_walk_hook hook_fn, void *private)
> +                         vtd_page_walk_hook hook_fn, void *private,
> +                         bool notify_unmap)
>   {
>       dma_addr_t addr =3D vtd_get_slpt_base_from_context(ce);
>       uint32_t level =3D vtd_get_level_from_context_entry(ce);
> @@ -852,7 +853,7 @@ static int vtd_page_walk(VTDContextEntry *ce, uint6=
4_t start, uint64_t end,
>       trace_vtd_page_walk_level(addr, level, start, end);
>  =20
>       return vtd_page_walk_level(addr, start, end, hook_fn, private,
> -                               level, true, true, NULL, false);
> +                               level, true, true, NULL, notify_unmap);
>   }
>  =20
>   /* Map a device to its corresponding domain (context-entry) */
> @@ -1205,6 +1206,33 @@ static void vtd_iotlb_domain_invalidate(IntelIOM=
MUState *s, uint16_t domain_id)
>                                   &domain_id);
>   }
>  =20
> +static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
> +                                           void *private)
> +{
> +    memory_region_notify_iommu((MemoryRegion *)private, *entry);
> +    return 0;
> +}
> +
> +static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> +                                           uint16_t domain_id, hwaddr =
addr,
> +                                           uint8_t am)
> +{
> +    IntelIOMMUNotifierNode *node;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> +        VTDAddressSpace *vtd_as =3D node->vtd_as;
> +        ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                       vtd_as->devfn, &ce);
> +        if (!ret && domain_id =3D=3D VTD_CONTEXT_ENTRY_DID(ce.hi)) {
> +            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
> +                          vtd_page_invalidate_notify_hook,
> +                          (void *)&vtd_as->iommu, true);

Why not simply trigger the notifier here? (or is this vfio required?)

> +        }
> +    }
> +}
> +
>   static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t do=
main_id,
>                                         hwaddr addr, uint8_t am)
>   {
> @@ -1215,6 +1243,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUS=
tate *s, uint16_t domain_id,
>       info.addr =3D addr;
>       info.mask =3D ~((1 << am) - 1);
>       g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &i=
nfo);
> +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);

I think it's better to squash DSI and GLOBAL invalidation into this=20
patch, otherwise the patch is buggy.

Thanks
