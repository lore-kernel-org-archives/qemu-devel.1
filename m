Received: from eggs.gnu.org ([2001:4830:134:3::10]:58457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXatD-000864-PE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXatC-0004VF-SZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dXatC-0004St-KE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:46 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 18 Jul 2017 15:22:39 -0700
Message-Id: <1500416562-27337-4-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1500416562-27337-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
	<1500416562-27337-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL for-2.10 4/7] xen: move physmap saving into a
 separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Igor Druzhinin <igor.druzhinin@citrix.com>

From: Igor Druzhinin <igor.druzhinin@citrix.com>

Non-functional change.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
---
 hw/i386/xen/xen-hvm.c | 57 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 3d951a3..277919e 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -304,6 +304,36 @@ static hwaddr xen_phys_offset_to_gaddr(hwaddr start_addr,
     return start_addr;
 }
 
+static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
+{
+    char path[80], value[17];
+
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr",
+            xen_domid, (uint64_t)physmap->phys_offset);
+    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap->start_addr);
+    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
+        return -1;
+    }
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
+            xen_domid, (uint64_t)physmap->phys_offset);
+    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap->size);
+    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
+        return -1;
+    }
+    if (physmap->name) {
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
+                xen_domid, (uint64_t)physmap->phys_offset);
+        if (!xs_write(state->xenstore, 0, path,
+                      physmap->name, strlen(physmap->name))) {
+            return -1;
+        }
+    }
+    return 0;
+}
+
 static int xen_add_to_physmap(XenIOState *state,
                               hwaddr start_addr,
                               ram_addr_t size,
@@ -315,7 +345,6 @@ static int xen_add_to_physmap(XenIOState *state,
     XenPhysmap *physmap = NULL;
     hwaddr pfn, start_gpfn;
     hwaddr phys_offset = memory_region_get_ram_addr(mr);
-    char path[80], value[17];
     const char *mr_name;
 
     if (get_physmapping(state, start_addr, size)) {
@@ -367,31 +396,7 @@ go_physmap:
                                    start_addr >> TARGET_PAGE_BITS,
                                    (start_addr + size - 1) >> TARGET_PAGE_BITS,
                                    XEN_DOMCTL_MEM_CACHEATTR_WB);
-
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr",
-            xen_domid, (uint64_t)phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)start_addr);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
-            xen_domid, (uint64_t)phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)size);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    if (mr_name) {
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
-                xen_domid, (uint64_t)phys_offset);
-        if (!xs_write(state->xenstore, 0, path, mr_name, strlen(mr_name))) {
-            return -1;
-        }
-    }
-
-    return 0;
+    return xen_save_physmap(state, physmap);
 }
 
 static int xen_remove_from_physmap(XenIOState *state,
-- 
1.9.1
