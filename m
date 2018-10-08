Received: from eggs.gnu.org ([2001:4830:134:3::10]:37430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PVP-0007Dq-8I
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PKL-0003ht-Gs
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9PKL-0003hh-7a
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74D8CC04D2AA
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 06:47:36 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  8 Oct 2018 14:47:12 +0800
Message-Id: <20181008064713.27349-2-peterx@redhat.com>
In-Reply-To: <20181008064713.27349-1-peterx@redhat.com>
References: <20181008064713.27349-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] intel_iommu: move ce fetching out when
 sync shadow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pei Zhang <pezhang@redhat.com>

There are two callers for vtd_sync_shadow_page_table_range(): one
provided a valid context entry and one not.  Move that fetching
operation into the caller vtd_sync_shadow_page_table() where we need to
fetch the context entry.

Meanwhile, remove the error_report_once() directly since we're already
tracing all the error cases in the previous call.  Instead, return error
number back to caller.  This will not change anything functional since
callers are dropping it after all.

We do this move majorly because we want to do something more later in
vtd_sync_shadow_page_table().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 dtc                   |  2 +-
 hw/i386/intel_iommu.c | 41 +++++++++++++----------------------------
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/dtc b/dtc
index 88f18909db..e54388015a 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 88f18909db731a627456f26d779445f84e449536
+Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3dfada19a6..d6b4f8705d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1035,7 +1035,6 @@ static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
     return 0;
 }
 
-/* If context entry is NULL, we'll try to fetch it on our own. */
 static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
                                             VTDContextEntry *ce,
                                             hwaddr addr, hwaddr size)
@@ -1047,39 +1046,25 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
         .notify_unmap = true,
         .aw = s->aw_bits,
         .as = vtd_as,
+        .domain_id = VTD_CONTEXT_ENTRY_DID(ce->hi),
     };
-    VTDContextEntry ce_cache;
-    int ret;
-
-    if (ce) {
-        /* If the caller provided context entry, use it */
-        ce_cache = *ce;
-    } else {
-        /* If the caller didn't provide ce, try to fetch */
-        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                       vtd_as->devfn, &ce_cache);
-        if (ret) {
-            /*
-             * This should not really happen, but in case it happens,
-             * we just skip the sync for this time.  After all we even
-             * don't have the root table pointer!
-             */
-            error_report_once("%s: invalid context entry for bus 0x%x"
-                              " devfn 0x%x",
-                              __func__, pci_bus_num(vtd_as->bus),
-                              vtd_as->devfn);
-            return 0;
-        }
-    }
 
-    info.domain_id = VTD_CONTEXT_ENTRY_DID(ce_cache.hi);
-
-    return vtd_page_walk(&ce_cache, addr, addr + size, &info);
+    return vtd_page_walk(ce, addr, addr + size, &info);
 }
 
 static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
 {
-    return vtd_sync_shadow_page_table_range(vtd_as, NULL, 0, UINT64_MAX);
+    int ret;
+    VTDContextEntry ce;
+
+    ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
+                                   pci_bus_num(vtd_as->bus),
+                                   vtd_as->devfn, &ce);
+    if (ret) {
+        return ret;
+    }
+
+    return vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX);
 }
 
 /*
-- 
2.17.1
