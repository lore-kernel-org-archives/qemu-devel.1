Received: from eggs.gnu.org ([2001:4830:134:3::10]:57017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pQ-0000pk-W2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pP-0002ea-Pp
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:48 -0500
Received: from smtp.citrix.com ([66.165.176.89]:27694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pP-0002cK-Ji
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:47 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 19:02:58 +0000
Message-ID: <1520535787-6223-4-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 03/12] xen: restrict: use
 xentoolcore_restrict_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

And insist that it works.

Drop individual use of xendevicemodel_restrict and
xenforeignmemory_restrict.  These are not actually effective in this
version of qemu, because qemu has a large number of fds open onto
various Xen control devices.

The restriction arrangements are still not right, because the
restriction needs to be done very late - after qemu has opened all of
its control fds.

xentoolcore_restrict_all and xentoolcore.h are available in Xen 4.10
and later, only.  Provide a compatibility stub.  And drop the
compatibility stubs for the old functions.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
v2: Modify the compatibility code, too.
    Bump this patch ahead of "defer call to xen_restrict until running"
    Retain call to xentoolcore_restrict_all
---
 include/hw/xen/xen_common.h | 46 +++++++++++----------------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 64a978e..1766bb9 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -91,6 +91,16 @@ static inline void *xenforeignmemory_map2(xenforeignmemory_handle *h,
     return xenforeignmemory_map(h, dom, prot, pages, arr, err);
 }
 
+static inline int xentoolcore_restrict_all(domid_t domid)
+{
+    errno = ENOTTY;
+    return -1;
+}
+
+#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41000 */
+
+#include <xentoolcore.h>
+
 #endif
 
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
@@ -218,20 +228,6 @@ static inline int xendevicemodel_set_mem_type(
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
 }
 
-static inline int xendevicemodel_restrict(
-    xendevicemodel_handle *dmod, domid_t domid)
-{
-    errno = ENOTTY;
-    return -1;
-}
-
-static inline int xenforeignmemory_restrict(
-    xenforeignmemory_handle *fmem, domid_t domid)
-{
-    errno = ENOTTY;
-    return -1;
-}
-
 #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
 
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
@@ -290,28 +286,8 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
 static inline int xen_restrict(domid_t domid)
 {
     int rc;
-
-    /* Attempt to restrict devicemodel operations */
-    rc = xendevicemodel_restrict(xen_dmod, domid);
+    rc = xentoolcore_restrict_all(domid);
     trace_xen_domid_restrict(rc ? errno : 0);
-
-    if (rc < 0) {
-        /*
-         * If errno is ENOTTY then restriction is not implemented so
-         * there's no point in trying to restrict other types of
-         * operation, but it should not be treated as a failure.
-         */
-        if (errno == ENOTTY) {
-            return 0;
-        }
-
-        return rc;
-    }
-
-    /* Restrict foreignmemory operations */
-    rc = xenforeignmemory_restrict(xen_fmem, domid);
-    trace_xen_domid_restrict(rc ? errno : 0);
-
     return rc;
 }
 
-- 
2.1.4
