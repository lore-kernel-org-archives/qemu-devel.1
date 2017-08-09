Received: from eggs.gnu.org ([2001:4830:134:3::10]:51370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfdfl-0003At-S3
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfdfi-0002eU-0T
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:2418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dfdfh-0002dc-L3
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:05 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Wed,  9 Aug 2017 16:51:21 -0400
Message-Id: <1502311882-11038-3-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
References: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH V2 2/3] xen-pt: bind/unbind interrupt remapping
 format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Chao Gao <chao.gao@intel.com>, sstabellini@kernel.org, anthony.perard@citrix.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kevin.tian@intel.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

If a vIOMMU is exposed to guest, guest will configure the msi to remapping
format. The original code isn't suitable to the new format. A new pair
bind/unbind interfaces are added for this usage. This patch recognizes
this case and uses new interfaces to bind/unbind msi.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 configure                     |  4 +++-
 hw/xen/xen_pt_msi.c           | 50 ++++++++++++++++++++++++++++++++-----------
 include/hw/i386/apic-msidef.h |  1 +
 include/hw/xen/xen_common.h   | 25 ++++++++++++++++++++++
 4 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/configure b/configure
index dd73cce..92b56d3 100755
--- a/configure
+++ b/configure
@@ -2108,13 +2108,15 @@ EOF
     elif
         cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_MAP_FOREIGN_API
+#include <xenctrl.h>
 #include <xenforeignmemory.h>
 int main(void) {
+  xc_interface *xc = NULL;
   xenforeignmemory_handle *xfmem;
 
   xfmem = xenforeignmemory_open(0, 0);
   xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
-
+  xc_domain_update_msi_irq_remapping(xc, 0, 0, 0, 0, 0, 0);
   return 0;
 }
 EOF
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index ff9a79f..5c5d15a 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -163,16 +163,23 @@ static int msi_msix_update(XenPCIPassthroughState *s,
     int rc = 0;
     uint64_t table_addr = 0;
 
-    XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
-               " (entry: %#x)\n",
-               is_msix ? "-X" : "", pirq, gvec, gflags, msix_entry);
-
     if (is_msix) {
         table_addr = s->msix->mmio_base_addr;
     }
 
-    rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
-                                  pirq, gflags, table_addr);
+    if (addr & MSI_ADDR_IF_MASK) {
+        XEN_PT_LOG(d, "Updating MSI%s with addr %#" PRIx64 " data %#x\n",
+                   is_msix ? "-X" : "", addr, data);
+        rc = xc_domain_update_msi_irq_remapping(xen_xc, xen_domid, pirq,
+                                             d->devfn, data, addr, table_addr);
+    } else {
+        XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
+                   " (entry: %#x)\n",
+                   is_msix ? "-X" : "", pirq, gvec, gflags, msix_entry);
+
+        rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
+                                      pirq, gflags, table_addr);
+    }
 
     if (rc) {
         XEN_PT_ERR(d, "Updating of MSI%s failed. (err: %d)\n",
@@ -204,13 +211,30 @@ static int msi_msix_disable(XenPCIPassthroughState *s,
     }
 
     if (is_binded) {
-        XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
-                   is_msix ? "-X" : "", pirq, gvec);
-        rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec, pirq, gflags);
-        if (rc) {
-            XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, gvec: %#x)\n",
-                       is_msix ? "-X" : "", errno, pirq, gvec);
-            return rc;
+        if (addr & MSI_ADDR_IF_MASK) {
+            XEN_PT_LOG(d, "Unbinding of MSI%s . ( pirq: %d, data: %x, "
+                       "addr: %#" PRIx64 ")\n",
+                       is_msix ? "-X" : "", pirq, data, addr);
+            rc = xc_domain_unbind_msi_irq_remapping(xen_xc, xen_domid, pirq,
+                                                    d->devfn, data, addr);
+            if (rc) {
+                XEN_PT_ERR(d, "Unbinding of MSI%s . (error: %d, pirq: %d, "
+                           "data: %x, addr: %#" PRIx64 ")\n",
+                           is_msix ? "-X" : "", rc, pirq, data, addr);
+                return rc;
+            }
+
+        } else {
+            XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
+                       is_msix ? "-X" : "", pirq, gvec);
+            rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec,
+                                          pirq, gflags);
+            if (rc) {
+                XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, "
+                           "gvec: %#x)\n",
+                           is_msix ? "-X" : "", errno, pirq, gvec);
+                return rc;
+            }
         }
     }
 
diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
index 420b411..a2b52d9 100644
--- a/include/hw/i386/apic-msidef.h
+++ b/include/hw/i386/apic-msidef.h
@@ -27,5 +27,6 @@
 #define MSI_ADDR_DEST_ID_SHIFT          12
 #define MSI_ADDR_DEST_IDX_SHIFT         4
 #define  MSI_ADDR_DEST_ID_MASK          0x000ff000
+#define  MSI_ADDR_IF_MASK               0x00000010
 
 #endif /* HW_APIC_MSIDEF_H */
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 86c7f26..454ab6d 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -680,4 +680,29 @@ static inline int xengnttab_grant_copy(xengnttab_handle *xgt, uint32_t count,
 }
 #endif
 
+/* Xen before 4.10 */
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
+
+static inline int xc_domain_update_msi_irq_remapping(xc_interface *xc,
+                                                     uint32_t domid,
+                                                     uint32_t pirq,
+                                                     uint32_t source_id,
+                                                     uint32_t data,
+                                                     uint64_t addr,
+                                                     uint64_t gtable)
+{
+    return -ENOSYS;
+}
+
+static inline int xc_domain_unbind_msi_irq_remapping(xc_interface *xc,
+                                                     uint32_t domid,
+                                                     uint32_t pirq,
+                                                     uint32_t source_id,
+                                                     uint32_t data,
+                                                     uint64_t addr)
+{
+    return -ENOSYS;
+}
+#endif
+
 #endif /* QEMU_HW_XEN_COMMON_H */
-- 
1.8.3.1
