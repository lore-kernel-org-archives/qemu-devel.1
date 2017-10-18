Received: from eggs.gnu.org ([2001:4830:134:3::10]:40813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e4wsJ-00017G-Bv
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e4wsE-0005GJ-El
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:31:43 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Wed, 18 Oct 2017 18:31:16 -0400
Message-Id: <20171018223116.6035-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] fdt_ro.c: implement strnlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Implement the strnlen() function if it isn't implemented.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 libfdt/fdt_ro.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
index 3d00d2e..a7986fb 100644
--- a/libfdt/fdt_ro.c
+++ b/libfdt/fdt_ro.c
@@ -55,6 +55,30 @@
 
 #include "libfdt_internal.h"
 
+/* if the current environment does not define strnlen */
+#ifndef strnlen
+
+/* This eliminates the missing prototype warning */
+int strnlen(const char *string, int max_count);
+
+/*
+ * strnlen: return the length of a string or max_count
+ * which ever is shortest
+ */
+
+int strnlen(const char *string, int max_count)
+{
+    int count;
+    for(count = 0; count < max_count; count++) {
+        if (string[count] == '\0') {
+            break;
+        }
+    }
+    return count;
+}
+
+#endif /* strnlen */
+
 static int _fdt_nodename_eq(const void *fdt, int offset,
 			    const char *s, int len)
 {
-- 
2.13.5 (Apple Git-94)
