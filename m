Received: from eggs.gnu.org ([2001:4830:134:3::10]:60315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQF-0007V8-1c
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQ7-0002TP-1Z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQ2-0002MQ-Sa
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:12 -0500
Date: Mon, 5 Nov 2018 13:15:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-9-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/33] intel_iommu: move ce fetching out when
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 306708eb3b..25e54671f4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1045,7 +1045,6 @@ static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
     return 0;
 }
 
-/* If context entry is NULL, we'll try to fetch it on our own. */
 static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
                                             VTDContextEntry *ce,
                                             hwaddr addr, hwaddr size)
@@ -1057,39 +1056,25 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
         .notify_unmap = true,
         .aw = s->aw_bits,
         .as = vtd_as,
+        .domain_id = VTD_CONTEXT_ENTRY_DID(ce->hi),
     };
-    VTDContextEntry ce_cache;
-    int ret;
 
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
-
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
MST
