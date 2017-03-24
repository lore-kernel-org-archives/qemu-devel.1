Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSY2-0007x5-27
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSXz-0002cC-0V
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:58:46 -0400
Received: from smtp.citrix.com ([66.165.176.89]:38855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crSXy-0002bb-O1
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:58:42 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 24 Mar 2017 16:58:08 +0000
Message-ID: <1490374688-488-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen: additionally restrict xenforeignmemory
 operations
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

Commit f0f272baf3a7 "xen: use libxendevice model to restrict operations"
added a command-line option (-xen-domid-restrict) to limit operations
using the libxendevicemodel API to a specified domid. The commit also
noted that the restriction would be extended to cover operations issued
via other xen libraries by subsequent patches.

My recent Xen patch [1] added a call to the xenforeignmemory API to allow
it to be restricted. This patch now makes use of that new call when the
-xen-domid-restrict option is passed.

[1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=5823d6eb

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 include/hw/xen/xen_common.h | 52 +++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 4f3bd35..6f13e8c 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -213,19 +213,6 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
     return xendevicemodel_modified_memory(xen_dmod, domid, first_pfn, nr);
 }
 
-static inline int xen_restrict(domid_t domid)
-{
-    int rc = xendevicemodel_restrict(xen_dmod, domid);
-
-    trace_xen_domid_restrict(errno);
-
-    if (errno == ENOTTY) {
-        return 0;
-    }
-
-    return rc;
-}
-
 /* Xen 4.2 through 4.6 */
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
 
@@ -276,8 +263,47 @@ static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
 
 #endif
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
+
+static inline int xenforeignmemory_restrict(
+    xenforeignmemory_handle *fmem, domid_t domid)
+{
+    errno = ENOTTY;
+    return -1;
+}
+
+#endif
+
 extern xenforeignmemory_handle *xen_fmem;
 
+static inline int xen_restrict(domid_t domid)
+{
+    int rc;
+
+    /* Attempt to restrict devicemodel operations */
+    rc = xendevicemodel_restrict(xen_dmod, domid);
+    trace_xen_domid_restrict(rc ? errno : 0);
+
+    if (rc < 0) {
+        /*
+         * If errno is ENOTTY then restriction is not implemented so
+         * there's no point in trying to restrict other types of
+         * operation, but it should not be treated as a failure.
+         */
+        if (errno == ENOTTY) {
+            return 0;
+        }
+
+        return rc;
+    }
+
+    /* Restrict foreignmemory operations */
+    rc = xenforeignmemory_restrict(xen_fmem, domid);
+    trace_xen_domid_restrict(rc ? errno : 0);
+
+    return rc;
+}
+
 void destroy_hvm_domain(bool reboot);
 
 /* shutdown/destroy current domain because of an error */
-- 
2.1.4
