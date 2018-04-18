Received: from eggs.gnu.org ([2001:4830:134:3::10]:45306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1f8ffS-0007rt-EF
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1f8ffN-0007m7-Ge
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:30:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:48627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1f8ffN-0007lb-4C
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:30:01 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Wed, 18 Apr 2018 05:29:56 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BDD8EC@SHSMSX104.ccr.corp.intel.com>
References: <20180418045121.14233-1-peterx@redhat.com>
In-Reply-To: <20180418045121.14233-1-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Witte <alexander.witte@baicanada.com>, Jintack Lim <jintack@cs.columbia.edu>

> Sent: Wednesday, April 18, 2018 12:51 PM
> Subject: [Qemu-devel] [PATCH] intel-iommu: send PSI always when notify_un=
map
> set
>=20
> During IOVA page table walk, there is a special case when:
>=20
> - notify_unmap is set, meanwhile
> - entry is invalid

This is very brief description, would you mind talk a little bit more.
=20
> In the past, we skip the entry always.  This is not correct.  We should s=
end UNMAP
> notification to registered notifiers in this case.  Otherwise some stall =
pages will still
> be mapped in the host even if L1 guest unmapped them already.
>
> Without this patch, nested device assignment to L2 guests might dump some=
 errors
> like:

Should it be physical device assigned from L0 host? Or emulated devices cou=
ld also
trigger this problem?

> qemu-system-x86_64: VFIO_MAP_DMA: -17
> qemu-system-x86_64: vfio_dma_map(0x557305420c30, 0xad000, 0x1000,
>                     0x7f89a920d000) =3D -17 (File exists)
>=20
> To fix this, we need to apply this patch to L1 QEMU (L2 QEMU is not affec=
ted by this
> problem).

Does this fix also apply to L0 QEMU?
=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>=20
> To test nested assignment, one also needs to apply below patchset:
> https://lkml.org/lkml/2018/4/18/5
> ---
>  hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> fb31de9416..b359efd6f9 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -722,6 +722,15 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, ui=
nt64_t
> iova, bool is_write,
>=20
>  typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
>=20
> +static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
> +                             vtd_page_walk_hook hook_fn, void *private)
> +{
> +    assert(hook_fn);
> +    trace_vtd_page_walk_one(level, entry->iova, entry->translated_addr,
> +                            entry->addr_mask, entry->perm);
> +    return hook_fn(entry, private);
> +}
> +
>  /**
>   * vtd_page_walk_level - walk over specific level for IOVA range
>   *
> @@ -781,28 +790,37 @@ static int vtd_page_walk_level(dma_addr_t addr, uin=
t64_t
> start,
>           */
>          entry_valid =3D read_cur | write_cur;
>=20
> +        entry.target_as =3D &address_space_memory;
> +        entry.iova =3D iova & subpage_mask;
> +        entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> +        entry.addr_mask =3D ~subpage_mask;
> +
>          if (vtd_is_last_slpte(slpte, level)) {
> -            entry.target_as =3D &address_space_memory;
> -            entry.iova =3D iova & subpage_mask;
>              /* NOTE: this is only meaningful if entry_valid =3D=3D true =
*/
>              entry.translated_addr =3D vtd_get_slpte_addr(slpte, aw);
> -            entry.addr_mask =3D ~subpage_mask;
> -            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
>              if (!entry_valid && !notify_unmap) {
>                  trace_vtd_page_walk_skip_perm(iova, iova_next);
>                  goto next;
>              }
> -            trace_vtd_page_walk_one(level, entry.iova, entry.translated_=
addr,
> -                                    entry.addr_mask, entry.perm);
> -            if (hook_fn) {
> -                ret =3D hook_fn(&entry, private);
> -                if (ret < 0) {
> -                    return ret;
> -                }
> +            ret =3D vtd_page_walk_one(&entry, level, hook_fn, private);
> +            if (ret < 0) {
> +                return ret;
>              }
>          } else {
>              if (!entry_valid) {
> -                trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                if (notify_unmap) {
> +                    /*
> +                     * The whole entry is invalid; unmap it all.
> +                     * Translated address is meaningless, zero it.
> +                     */
> +                    entry.translated_addr =3D 0x0;
> +                    ret =3D vtd_page_walk_one(&entry, level, hook_fn, pr=
ivate);
> +                    if (ret < 0) {
> +                        return ret;
> +                    }
> +                } else {
> +                    trace_vtd_page_walk_skip_perm(iova, iova_next);
> +                }
>                  goto next;
>              }
>              ret =3D vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw), i=
ova,
> --
> 2.14.3
>=20

Thanks,
Yi Liu
