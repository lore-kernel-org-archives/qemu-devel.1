Received: from eggs.gnu.org ([2001:4830:134:3::10]:60534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgy-0002GI-Qn
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgx-0006Es-GG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:52 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:53463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgx-00069l-2W
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:51 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 19 Apr 2018 17:45:14 +0100
Message-ID: <1524156319-11465-12-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 11/16] xen: Use newly added dmops for mapping
 VGA memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

Xen unstable (to be in 4.11) has two new dmops, relocate_memory and
pin_memory_cacheattr. Use these to set up the VGA memory, replacing the
previous calls to libxc. This allows the VGA console to work properly
when QEMU is running restricted (-xen-domid-restrict).

Wrapper functions are provided to allow QEMU to work with older versions
of Xen.

Tweak the error handling while making this change:
* Report pin_memory_cacheattr errors.
* Report errors even when DEBUG_HVM is not set. This is useful for
trying to understand why VGA is not working, since otherwise it just
fails silently.
* Fix the return values when an error occurs. The functions now
consistently return -1 and set errno.

CC: Ian Jackson <ian.jackson@eu.citrix.com>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Ian Jackson <ian.jackson@eu.citrix.com>
Signed-off-by: Ian Jackson <ian.jackson@eu.citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
v6.1: Fix printf formats to match types in error_report messages
      Fix spurious \n in error_report messages
      Fix { } style issue
v6: New patch in this version of the series
---
 configure                   | 19 +++++++++++++++++
 hw/i386/xen/xen-hvm.c       | 50 ++++++++++++++++++++++++---------------------
 include/hw/xen/xen_common.h | 32 +++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/configure b/configure
index f580255..d5435ff 100755
--- a/configure
+++ b/configure
@@ -2218,6 +2218,25 @@ EOF
     # Xen unstable
     elif
         cat > $TMPC <<EOF &&
+#undef XC_WANT_COMPAT_DEVICEMODEL_API
+#define __XEN_TOOLS__
+#include <xendevicemodel.h>
+int main(void) {
+  xendevicemodel_handle *xd;
+
+  xd = xendevicemodel_open(0, 0);
+  xendevicemodel_pin_memory_cacheattr(xd, 0, 0, 0, 0);
+
+  return 0;
+}
+EOF
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxentoolcore"
+      then
+      xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
+      xen_ctrl_version=41100
+      xen=yes
+    elif
+        cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_MAP_FOREIGN_API
 #include <xenforeignmemory.h>
 #include <xentoolcore.h>
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index fb727bc..caa563b 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -347,7 +347,7 @@ static int xen_add_to_physmap(XenIOState *state,
                               MemoryRegion *mr,
                               hwaddr offset_within_region)
 {
-    unsigned long i = 0;
+    unsigned long nr_pages;
     int rc = 0;
     XenPhysmap *physmap = NULL;
     hwaddr pfn, start_gpfn;
@@ -396,22 +396,26 @@ go_physmap:
 
     pfn = phys_offset >> TARGET_PAGE_BITS;
     start_gpfn = start_addr >> TARGET_PAGE_BITS;
-    for (i = 0; i < size >> TARGET_PAGE_BITS; i++) {
-        unsigned long idx = pfn + i;
-        xen_pfn_t gpfn = start_gpfn + i;
-
-        rc = xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE_gmfn, idx, gpfn);
-        if (rc) {
-            DPRINTF("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
-                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc, errno);
-            return -rc;
-        }
+    nr_pages = size >> TARGET_PAGE_BITS;
+    rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, nr_pages, pfn,
+                                        start_gpfn);
+    if (rc) {
+        int saved_errno = errno;
+
+        error_report("relocate_memory %lu pages from GFN %"HWADDR_PRIx
+                     " to GFN %"HWADDR_PRIx" failed: %s",
+                     nr_pages, pfn, start_gpfn, strerror(saved_errno));
+        errno = saved_errno;
+        return -1;
     }
 
-    xc_domain_pin_memory_cacheattr(xen_xc, xen_domid,
+    rc = xendevicemodel_pin_memory_cacheattr(xen_dmod, xen_domid,
                                    start_addr >> TARGET_PAGE_BITS,
                                    (start_addr + size - 1) >> TARGET_PAGE_BITS,
                                    XEN_DOMCTL_MEM_CACHEATTR_WB);
+    if (rc) {
+        error_report("pin_memory_cacheattr failed: %s", strerror(errno));
+    }
     return xen_save_physmap(state, physmap);
 }
 
@@ -419,7 +423,6 @@ static int xen_remove_from_physmap(XenIOState *state,
                                    hwaddr start_addr,
                                    ram_addr_t size)
 {
-    unsigned long i = 0;
     int rc = 0;
     XenPhysmap *physmap = NULL;
     hwaddr phys_offset = 0;
@@ -438,16 +441,17 @@ static int xen_remove_from_physmap(XenIOState *state,
     size >>= TARGET_PAGE_BITS;
     start_addr >>= TARGET_PAGE_BITS;
     phys_offset >>= TARGET_PAGE_BITS;
-    for (i = 0; i < size; i++) {
-        xen_pfn_t idx = start_addr + i;
-        xen_pfn_t gpfn = phys_offset + i;
-
-        rc = xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE_gmfn, idx, gpfn);
-        if (rc) {
-            fprintf(stderr, "add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
-                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc, errno);
-            return -rc;
-        }
+    rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, size, start_addr,
+                                        phys_offset);
+    if (rc) {
+        int saved_errno = errno;
+
+        error_report("relocate_memory "RAM_ADDR_FMT" pages"
+                     " from GFN %"HWADDR_PRIx
+                     " to GFN %"HWADDR_PRIx" failed: %s",
+                     size, start_addr, phys_offset, strerror(saved_errno));
+        errno = saved_errno;
+        return -1;
     }
 
     QLIST_REMOVE(physmap, list);
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 4bd30a3..2eed6fc 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -89,6 +89,38 @@ typedef xc_interface xendevicemodel_handle;
 
 #endif
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41100
+
+static inline int xendevicemodel_relocate_memory(
+    xendevicemodel_handle *dmod, domid_t domid, uint32_t size, uint64_t src_gfn,
+    uint64_t dst_gfn)
+{
+    uint32_t i;
+    int rc;
+
+    for (i = 0; i < size; i++) {
+        unsigned long idx = src_gfn + i;
+        xen_pfn_t gpfn = dst_gfn + i;
+
+        rc = xc_domain_add_to_physmap(xen_xc, domid, XENMAPSPACE_gmfn, idx,
+                                      gpfn);
+        if (rc) {
+            return rc;
+        }
+    }
+
+    return 0;
+}
+
+static inline int xendevicemodel_pin_memory_cacheattr(
+    xendevicemodel_handle *dmod, domid_t domid, uint64_t start, uint64_t end,
+    uint32_t type)
+{
+    return xc_domain_pin_memory_cacheattr(xen_xc, domid, start, end, type);
+}
+
+#endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION < 41100 */
+
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
 
 #define XEN_COMPAT_PHYSMAP
-- 
2.1.4
