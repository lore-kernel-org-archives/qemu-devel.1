Received: from eggs.gnu.org ([2001:4830:134:3::10]:39230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4H-0000rT-9R
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4C-0006zZ-Ld
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:21 -0400
Received: from smtp.citrix.com ([66.165.176.89]:59596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4C-0006yi-Ec
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:16 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 15 Sep 2017 19:09:56 +0100
Message-ID: <1505498999-17427-4-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 3/6] xen: restrict: use
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
Cc: xen-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

And insist that it works.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 include/hw/xen/xen_common.h | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 86c7f26..b6cb024 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -12,6 +12,7 @@
 
 #include <xenctrl.h>
 #include <xenstore.h>
+#include <xentoolcore.h>
 #include <xen/io/xenbus.h>
 
 #include "hw/hw.h"
@@ -289,30 +290,7 @@ static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
 
 static inline int xen_restrict(domid_t domid)
 {
-    int rc;
-
-    /* Attempt to restrict devicemodel operations */
-    rc = xendevicemodel_restrict(xen_dmod, domid);
-    trace_xen_domid_restrict(rc ? errno : 0);
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
-    return rc;
+    return xentoolcore_restrict_all(domid);
 }
 
 void destroy_hvm_domain(bool reboot);
-- 
2.1.4
