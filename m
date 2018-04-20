Received: from eggs.gnu.org ([2001:4830:134:3::10]:34539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f9O71-0002Tj-LN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f9O6y-00035G-IL
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:57:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f9O6y-00034j-DZ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:57:28 -0400
References: <20180418045121.14233-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d550eb50-c9e3-838a-ac9a-4a998375572b@redhat.com>
Date: Fri, 20 Apr 2018 12:57:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180418045121.14233-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] intel-iommu: send PSI always when
 notify_unmap set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Witte <alexander.witte@baicanada.com>, Jintack Lim <jintack@cs.columbia.edu>



On 2018=E5=B9=B404=E6=9C=8818=E6=97=A5 12:51, Peter Xu wrote:
> During IOVA page table walk, there is a special case when:
>
> - notify_unmap is set, meanwhile
> - entry is invalid
>
> In the past, we skip the entry always.  This is not correct.  We should
> send UNMAP notification to registered notifiers in this case.  Otherwis=
e
> some stall pages will still be mapped in the host even if L1 guest

You mean 'stale' here?

> unmapped them already.

It looks like some IOTLB invalidation were missed? If not, the page=20
should be unmaped during invalidation.

>
> Without this patch, nested device assignment to L2 guests might dump
> some errors like:
>
> qemu-system-x86_64: VFIO_MAP_DMA: -17
> qemu-system-x86_64: vfio_dma_map(0x557305420c30, 0xad000, 0x1000,
>                      0x7f89a920d000) =3D -17 (File exists)
>
> To fix this, we need to apply this patch to L1 QEMU (L2 QEMU is not
> affected by this problem).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> To test nested assignment, one also needs to apply below patchset:
> https://lkml.org/lkml/2018/4/18/5

Have a quick glance at it, looks like there's no need for this patch is=20
we had that kernel patch applied.

Thanks

> ---
>   hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index fb31de9416..b359efd6f9 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -722,6 +722,15 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, =
uint64_t iova, bool is_write,
>  =20
>   typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private=
);
>  =20
> +static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
> +                             vtd_page_walk_hook hook_fn, void *private=
)
> +{
> +    assert(hook_fn);
> +    trace_vtd_page_walk_one(level, entry->iova, entry->translated_addr=
,
> +                            entry->addr_mask, entry->perm);
> +    return hook_fn(entry, private);
> +}
> +
>   /**
>    * vtd_page_walk_level - walk over specific level for IOVA range
>    *
> @@ -781,28 +790,37 @@ static int vtd_page_walk_level(dma_addr_t addr, u=
int64_t start,
>            */
>           entry_valid =3D read_cur | write_cur;
>  =20
> +        entry.target_as =3D &address_space_memory;
> +        entry.iova =3D iova & subpage_mask;
> +        entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> +        entry.addr_mask =3D ~subpage_mask;
> +
>           if (vtd_is_last_slpte(slpte, level)) {
> -            entry.target_as =3D &address_space_memory;
> -            entry.iova =3D iova & subpage_mask;
>               /* NOTE: this is only meaningful if entry_valid =3D=3D tr=
ue */
>               entry.translated_addr =3D vtd_get_slpte_addr(slpte, aw);
> -            entry.addr_mask =3D ~subpage_mask;
> -            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
>               if (!entry_valid && !notify_unmap) {
>                   trace_vtd_page_walk_skip_perm(iova, iova_next);
>                   goto next;
>               }
> -            trace_vtd_page_walk_one(level, entry.iova, entry.translate=
d_addr,
> -                                    entry.addr_mask, entry.perm);
> -            if (hook_fn) {
> -                ret =3D hook_fn(&entry, private);
> -                if (ret < 0) {
> -                    return ret;
> -                }
> +            ret =3D vtd_page_walk_one(&entry, level, hook_fn, private)=
;
> +            if (ret < 0) {
> +                return ret;
>               }
>           } else {
>               if (!entry_valid) {
> -                trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                if (notify_unmap) {
> +                    /*
> +                     * The whole entry is invalid; unmap it all.
> +                     * Translated address is meaningless, zero it.
> +                     */
> +                    entry.translated_addr =3D 0x0;
> +                    ret =3D vtd_page_walk_one(&entry, level, hook_fn, =
private);
> +                    if (ret < 0) {
> +                        return ret;
> +                    }
> +                } else {
> +                    trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                }
>                   goto next;
>               }
>               ret =3D vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw)=
, iova,
