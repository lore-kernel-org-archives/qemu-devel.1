Received: from eggs.gnu.org ([2001:4830:134:3::10]:39974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66078d76a=Paul.Durrant@citrix.com>)
	id 1fGRIE-0007U5-MT
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66078d76a=Paul.Durrant@citrix.com>)
	id 1fGRIC-000238-Hv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:46:14 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:59874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=66078d76a=Paul.Durrant@citrix.com>)
	id 1fGRIC-0001uW-7Z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:46:12 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 9 May 2018 16:46:04 +0100
Message-ID: <20180509154604.25530-3-paul.durrant@citrix.com>
In-Reply-To: <20180509154604.25530-1-paul.durrant@citrix.com>
References: <20180509154604.25530-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] xen-hvm: try to use
 xenforeignmemory_map_resource() to map ioreq pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Xen 4.11 has a new API to directly map guest resources. Among the resources
that can be mapped using this API are ioreq pages.

This patch modifies QEMU to attempt to use the new API should it exist,
falling back to the previous mechanism if it is unavailable.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 configure                   |  5 ++++
 hw/i386/xen/trace-events    |  1 +
 hw/i386/xen/xen-hvm.c       | 68 +++++++++++++++++++++++++++++++++++----------
 include/hw/xen/xen_common.h | 14 ++++++++++
 4 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 1443422e83..0f9c2f000e 100755
--- a/configure
+++ b/configure
@@ -2229,12 +2229,17 @@ EOF
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
 #define __XEN_TOOLS__
 #include <xendevicemodel.h>
+#include <xenforeignmemory.h>
 int main(void) {
   xendevicemodel_handle *xd;
+  xenforeignmemory_handle *xfmem;
 
   xd = xendevicemodel_open(0, 0);
   xendevicemodel_pin_memory_cacheattr(xd, 0, 0, 0, 0);
 
+  xfmem = xenforeignmemory_open(0, 0);
+  xenforeignmemory_map_resource(xfmem, 0, 0, 0, 0, 0, NULL, 0, 0);
+
   return 0;
 }
 EOF
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index 8dab7bcfe0..38616b698f 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -15,6 +15,7 @@ cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64
 cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio read reg data=0x%"PRIx64" port=0x%"PRIx64" size=%d"
 cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio write reg data=0x%"PRIx64" port=0x%"PRIx64" size=%d"
 cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p copy dir=%d df=%d ptr=%d port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
+xen_map_resource_ioreq(uint32_t id, void *addr) "id: %u addr: %p"
 
 # xen-mapcache.c
 xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 6ffa3c22cc..664cc52532 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1239,13 +1239,41 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
 
 static int xen_map_ioreq_server(XenIOState *state)
 {
+    void *addr = NULL;
+    xenforeignmemory_resource_handle *fres;
     xen_pfn_t ioreq_pfn;
     xen_pfn_t bufioreq_pfn;
     evtchn_port_t bufioreq_evtchn;
     int rc;
 
+    /*
+     * Attempt to map using the resource API and fall back to normal
+     * foreign mapping if this is not supported.
+     */
+    QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_bufioreq != 0);
+    QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_ioreq(0) != 1);
+    fres = xenforeignmemory_map_resource(xen_fmem, xen_domid,
+                                         XENMEM_resource_ioreq_server,
+                                         state->ioservid, 0, 2,
+                                         &addr,
+                                         PROT_READ | PROT_WRITE, 0);
+    if (fres != NULL) {
+        trace_xen_map_resource_ioreq(state->ioservid, addr);
+        state->buffered_io_page = addr;
+        state->shared_page = addr + TARGET_PAGE_SIZE;
+    } else {
+        error_report("failed to map ioreq server resources: error %d handle=%p",
+                     errno, xen_xc);
+        if (errno != EOPNOTSUPP) {
+            return -1;
+        }
+    }
+
     rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
-                                   &ioreq_pfn, &bufioreq_pfn,
+                                   (state->shared_page == NULL) ?
+                                   &ioreq_pfn : NULL,
+                                   (state->buffered_io_page == NULL) ?
+                                   &bufioreq_pfn : NULL,
                                    &bufioreq_evtchn);
     if (rc < 0) {
         error_report("failed to get ioreq server info: error %d handle=%p",
@@ -1253,27 +1281,37 @@ static int xen_map_ioreq_server(XenIOState *state)
         return rc;
     }
 
-    DPRINTF("shared page at pfn %lx\n", ioreq_pfn);
-    DPRINTF("buffered io page at pfn %lx\n", bufioreq_pfn);
-    DPRINTF("buffered io evtchn is %x\n", bufioreq_evtchn);
-
-    state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
-                                              PROT_READ | PROT_WRITE,
-                                              1, &ioreq_pfn, NULL);
     if (state->shared_page == NULL) {
-        error_report("map shared IO page returned error %d handle=%p",
-                     errno, xen_xc);
-        return -1;
+        DPRINTF("shared page at pfn %lx\n", ioreq_pfn);
+
+        state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
+                                                  PROT_READ | PROT_WRITE,
+                                                  1, &ioreq_pfn, NULL);
+        if (state->shared_page == NULL) {
+            error_report("map shared IO page returned error %d handle=%p",
+                         errno, xen_xc);
+        }
     }
 
-    state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
-                                                   PROT_READ | PROT_WRITE,
-                                                   1, &bufioreq_pfn, NULL);
     if (state->buffered_io_page == NULL) {
-        error_report("map buffered IO page returned error %d", errno);
+        DPRINTF("buffered io page at pfn %lx\n", bufioreq_pfn);
+
+        state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
+                                                       PROT_READ | PROT_WRITE,
+                                                       1, &bufioreq_pfn,
+                                                       NULL);
+        if (state->buffered_io_page == NULL) {
+            error_report("map buffered IO page returned error %d", errno);
+            return -1;
+        }
+    }
+
+    if (state->shared_page == NULL || state->buffered_io_page == NULL) {
         return -1;
     }
 
+    DPRINTF("buffered io evtchn is %x\n", bufioreq_evtchn);
+
     state->bufioreq_remote_port = bufioreq_evtchn;
 
     return 0;
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 5f1402b494..d925751040 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -119,6 +119,20 @@ static inline int xendevicemodel_pin_memory_cacheattr(
     return xc_domain_pin_memory_cacheattr(xen_xc, domid, start, end, type);
 }
 
+typedef void xenforeignmemory_resource_handle;
+
+#define XENMEM_resource_ioreq_server_frame_bufioreq 0
+#define XENMEM_resource_ioreq_server_frame_ioreq(n) (1 + (n))
+
+static inline xenforeignmemory_resource_handle *xenforeignmemory_map_resource(
+    xenforeignmemory_handle *fmem, domid_t domid, unsigned int type,
+    unsigned int id, unsigned long frame, unsigned long nr_frames,
+    void **paddr, int prot, int flags)
+{
+    errno = EOPNOTSUPP;
+    return -1;
+}
+
 #endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION < 41100 */
 
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
-- 
2.11.0
