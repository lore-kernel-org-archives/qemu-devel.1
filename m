Received: from eggs.gnu.org ([2001:4830:134:3::10]:51071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVE4f-0003M8-52
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVE4c-0005PT-2q
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:04:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVE4b-0005Ok-UQ
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 04:04:30 -0500
Date: Sun, 22 Jan 2017 17:04:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170122090425.GB26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
	<490bbb84-213b-1b2a-5a1b-fa42a5c6a359@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <490bbb84-213b-1b2a-5a1b-fa42a5c6a359@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Sun, Jan 22, 2017 at 04:08:04PM +0800, Jason Wang wrote:

[...]

> >+static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> >+                                           uint16_t domain_id, hwaddr addr,
> >+                                           uint8_t am)
> >+{
> >+    IntelIOMMUNotifierNode *node;
> >+    VTDContextEntry ce;
> >+    int ret;
> >+
> >+    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> >+        VTDAddressSpace *vtd_as = node->vtd_as;
> >+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> >+                                       vtd_as->devfn, &ce);
> >+        if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
> >+            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
> >+                          vtd_page_invalidate_notify_hook,
> >+                          (void *)&vtd_as->iommu, true);
> 
> Why not simply trigger the notifier here? (or is this vfio required?)

Because we may only want to notify part of the region - we are with
mask here, but not exact size.

Consider this: guest (with caching mode) maps 12K memory (4K*3 pages),
the mask will be extended to 16K in the guest. In that case, we need
to explicitly go over the page entry to know that the 4th page should
not be notified.

> 
> >+        }
> >+    }
> >+}
> >+
> >  static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> >                                        hwaddr addr, uint8_t am)
> >  {
> >@@ -1215,6 +1243,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> >      info.addr = addr;
> >      info.mask = ~((1 << am) - 1);
> >      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
> >+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
> 
> I think it's better to squash DSI and GLOBAL invalidation into this patch,
> otherwise the patch is buggy.

I can do this. Thanks,

-- peterx
