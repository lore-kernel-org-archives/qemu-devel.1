Received: from eggs.gnu.org ([2001:4830:134:3::10]:44116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dQY43-0006n4-JO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dQY3z-00075H-E3
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:32955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dQY3z-00074e-28
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:47 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 29 Jun 2017 01:49:53 -0400
Message-Id: <1498715394-16402-3-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
References: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH 2/3] xen-pt: bind/unbind interrupt remapping
 format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xensource.com
Cc: Chao Gao <chao.gao@intel.com>, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, anthony.perard@citrix.com, kevin.tian@intel.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

If a vIOMMU is exposed to guest, guest will configure the msi to remapping
format. The original code isn't suitable to the new format. A new pair
bind/unbind interfaces are added for this usage. This patch recognizes
this case and uses new interfaces to bind/unbind msi.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 configure                     | 54 +++++++++++++++++++++++++++++++++++++++++++
 hw/xen/xen_pt_msi.c           | 50 ++++++++++++++++++++++++++++-----------
 include/hw/i386/apic-msidef.h |  1 +
 include/hw/xen/xen_common.h   | 25 ++++++++++++++++++++
 4 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 476210b..b3ac49f 100755
--- a/configure
+++ b/configure
@@ -1982,6 +1982,60 @@ EOF
 /*
  * If we have stable libs the we don't want the libxc compat
  * layers, regardless of what CFLAGS we may have been given.
+ */
+#undef XC_WANT_COMPAT_EVTCHN_API
+#undef XC_WANT_COMPAT_GNTTAB_API
+#undef XC_WANT_COMPAT_MAP_FOREIGN_API
+#include <xenctrl.h>
+#include <xenstore.h>
+#include <xenevtchn.h>
+#include <xengnttab.h>
+#include <xenforeignmemory.h>
+#include <stdint.h>
+#include <xen/hvm/hvm_info_table.h>
+#if !defined(HVM_MAX_VCPUS)
+# error HVM_MAX_VCPUS not defined
+#endif
+int main(void) {
+  xc_interface *xc = NULL;
+  xenforeignmemory_handle *xfmem;
+  xenevtchn_handle *xe;
+  xengnttab_handle *xg;
+  xen_domain_handle_t handle;
+  xengnttab_grant_copy_segment_t* seg = NULL;
+
+  xs_daemon_open();
+
+  xc = xc_interface_open(0, 0, 0);
+  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
+  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
+  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
+  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
+  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
+
+  xfmem = xenforeignmemory_open(0, 0);
+  xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
+
+  xe = xenevtchn_open(0, 0);
+  xenevtchn_fd(xe);
+
+  xg = xengnttab_open(0, 0);
+  xengnttab_grant_copy(xg, 0, seg);
+
+  xc_domain_update_msi_irq_remapping(xc, 0, 0, 0, 0, 0 ,0);
+
+  return 0;
+}
+EOF
+      compile_prog "" "$xen_libs $xen_stable_libs"
+    then
+    xen_ctrl_version=4100
+    xen=yes
+  elif
+      cat > $TMPC <<EOF &&
+/*
+ * If we have stable libs the we don't want the libxc compat
+ * layers, regardless of what CFLAGS we may have been given.
  *
  * Also, check if xengnttab_grant_copy_segment_t is defined and
  * grant copy operation is implemented.
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index 62add06..26a69d9 100644
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
index 8e1580d..4ba43a8 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -438,4 +438,29 @@ static inline int xengnttab_grant_copy(xengnttab_handle *xgt, uint32_t count,
 }
 #endif
 
+/* Xen before 4.10 */
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 4100
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
