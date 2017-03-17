Received: from eggs.gnu.org ([2001:4830:134:3::10]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBt-0003oT-KO
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBs-0007Dy-Lq
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:37369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1coqBs-0007DC-9m
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:04 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Fri, 17 Mar 2017 19:29:16 +0800
Message-Id: <1489750157-17401-4-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [RFC PATCH 3/4] xen-pt: bind/unbind interrupt
 remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xensource.com, qemu-devel@nongnu.org
Cc: chao.gao@intel.com, kevin.tian@intel.com, sstabellini@kernel.org, anthony.perard@citrix.com, mst@redhat.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

If a vIOMMU is exposed to guest, guest will configure the msi to remapping
format. The original code isn't suitable to the new format. A new pair
bind/unbind interfaces are added for this usage. This patch recognizes
this case and use new interfaces to bind/unbind msi.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/xen/xen_pt_msi.c           | 36 ++++++++++++++++++++++++++++--------
 include/hw/i386/apic-msidef.h |  1 +
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index 62add06..8b0d7fc 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -161,6 +161,7 @@ static int msi_msix_update(XenPCIPassthroughState *s,
     uint8_t gvec = msi_vector(data);
     uint32_t gflags = msi_gflags(data, addr);
     int rc = 0;
+    bool ir = !!(addr & MSI_ADDR_IM_MASK);
     uint64_t table_addr = 0;
 
     XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
@@ -171,8 +172,14 @@ static int msi_msix_update(XenPCIPassthroughState *s,
         table_addr = s->msix->mmio_base_addr;
     }
 
-    rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
+    if (ir) {
+        rc = xc_domain_update_msi_irq_remapping(xen_xc, xen_domid, pirq,
+                                    d->devfn, data, addr, table_addr);
+    }
+    else {
+        rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
                                   pirq, gflags, table_addr);
+    }
 
     if (rc) {
         XEN_PT_ERR(d, "Updating of MSI%s failed. (err: %d)\n",
@@ -204,13 +211,26 @@ static int msi_msix_disable(XenPCIPassthroughState *s,
     }
 
     if (is_binded) {
-        XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
-                   is_msix ? "-X" : "", pirq, gvec);
-        rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec, pirq, gflags);
-        if (rc) {
-            XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, gvec: %#x)\n",
-                       is_msix ? "-X" : "", errno, pirq, gvec);
-            return rc;
+        if ( addr & MSI_ADDR_IM_MASK ) {
+            XEN_PT_LOG(d, "Unbinding of MSI%s . ( pirq: %d, data: %x, addr: %lx)\n",
+                       is_msix ? "-X" : "", pirq, data, addr);
+            rc = xc_domain_unbind_msi_irq_remapping(xen_xc, xen_domid, pirq,
+                                                    d->devfn, data, addr);
+            if (rc) {
+                XEN_PT_ERR(d, "Unbinding of MSI%s . (error: %d, pirq: %d, data: %x, addr: %lx)\n",
+                           is_msix ? "-X" : "", rc, pirq, data, addr);
+                return rc;
+            }
+
+        } else {
+            XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
+                       is_msix ? "-X" : "", pirq, gvec);
+            rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec, pirq, gflags);
+            if (rc) {
+                XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, gvec: %#x)\n",
+                           is_msix ? "-X" : "", errno, pirq, gvec);
+                return rc;
+            }
         }
     }
 
diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
index 8b4d4cc..08b584f 100644
--- a/include/hw/i386/apic-msidef.h
+++ b/include/hw/i386/apic-msidef.h
@@ -27,5 +27,6 @@
 #define MSI_ADDR_DEST_ID_SHIFT          12
 #define MSI_ADDR_DEST_IDX_SHIFT         4
 #define  MSI_ADDR_DEST_ID_MASK          0x00ffff0
+#define  MSI_ADDR_IM_MASK               0x00000010
 
 #endif /* HW_APIC_MSIDEF_H */
-- 
1.8.3.1
