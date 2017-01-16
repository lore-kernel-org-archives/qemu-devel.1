Received: from eggs.gnu.org ([2001:4830:134:3::10]:46081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT3QX-0005rK-Nq
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT3QU-0007Dz-Hf
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:18:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT3QU-0007Dm-8R
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:18:06 -0500
Date: Mon, 16 Jan 2017 17:18:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170116091801.GL30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-15-git-send-email-peterx@redhat.com>
	<fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Mon, Jan 16, 2017 at 02:30:20PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
> >This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
> >upstream:
> >
> >   "IOMMU: enable intel_iommu map and unmap notifiers"
> >   https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html
> >
> >However I removed/fixed some content, and added my own codes.
> >
> >Instead of translate() every page for iotlb invalidations (which is
> >slower), we walk the pages when needed and notify in a hook function.
> >
> >This patch enables vfio devices for VT-d emulation.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> >  hw/i386/intel_iommu.c         | 68 +++++++++++++++++++++++++++++++++=
++++------
> >  include/hw/i386/intel_iommu.h |  8 +++++
> >  2 files changed, 67 insertions(+), 9 deletions(-)
> >
> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index 2596f11..104200b 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -839,7 +839,8 @@ next:
> >   * @private: private data for the hook function
> >   */
> >  static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64=
_t end,
> >-                         vtd_page_walk_hook hook_fn, void *private)
> >+                         vtd_page_walk_hook hook_fn, void *private,
> >+                         bool notify_unmap)
> >  {
> >      dma_addr_t addr =3D vtd_get_slpt_base_from_context(ce);
> >      uint32_t level =3D vtd_get_level_from_context_entry(ce);
> >@@ -858,7 +859,7 @@ static int vtd_page_walk(VTDContextEntry *ce, uint=
64_t start, uint64_t end,
> >      trace_vtd_page_walk(ce->hi, ce->lo, start, end);
> >      return vtd_page_walk_level(addr, start, end, hook_fn, private,
> >-                               level, true, true, NULL, false);
> >+                               level, true, true, NULL, notify_unmap)=
;
> >  }
> >  /* Map a device to its corresponding domain (context-entry) */
> >@@ -1212,6 +1213,34 @@ static void vtd_iotlb_domain_invalidate(IntelIO=
MMUState *s, uint16_t domain_id)
> >                                  &domain_id);
> >  }
> >+static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
> >+                                           void *private)
> >+{
> >+    memory_region_notify_iommu((MemoryRegion *)private, *entry);
> >+    return 0;
> >+}
> >+
> >+static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> >+                                           uint16_t domain_id, hwaddr=
 addr,
> >+                                           uint8_t am)
> >+{
> >+    IntelIOMMUNotifierNode *node;
> >+    VTDContextEntry ce;
> >+    int ret;
> >+
> >+    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> >+        VTDAddressSpace *vtd_as =3D node->vtd_as;
> >+        ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> >+                                       vtd_as->devfn, &ce);
> >+        if (!ret && domain_id =3D=3D VTD_CONTEXT_ENTRY_DID(ce.hi)) {
> >+            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE=
,
> >+                          vtd_page_invalidate_notify_hook,
> >+                          (void *)&vtd_as->iommu, true);
> >+        }
> >+    }
> >+}
> >+
> >+
> >  static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t d=
omain_id,
> >                                        hwaddr addr, uint8_t am)
> >  {
> >@@ -1222,6 +1251,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMU=
State *s, uint16_t domain_id,
> >      info.addr =3D addr;
> >      info.mask =3D ~((1 << am) - 1);
> >      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &=
info);
> >+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
>=20
> Is the case of GLOBAL or DSI flush missed, or we don't care it at all?

IMHO we don't. For device assignment, since we are having CM=3D1 here,
we should have explicit page invalidations even if guest sends
global/domain invalidations.

Thanks,

-- peterx
