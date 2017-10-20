Received: from eggs.gnu.org ([2001:4830:134:3::10]:48547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e5bWi-00045c-Q9
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e5bWh-0000Tu-Tp
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:56:08 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Fri, 20 Oct 2017 13:55:48 -0400
Message-Id: <20171020175548.2566-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [libfdt][PATCH v2] implement strnlen for systems that
 need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, devicetree-compiler@vger.kernel.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Prior the Mac OS 10.7, the function strnlen() was not available. This patch
implements strnlen() on Mac OS X versions that are below 10.7.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
- Simplified the code to make it static inline'ed
- Changed the type of count to size_t

 libfdt/libfdt_env.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
index 952056c..2569339 100644
--- a/libfdt/libfdt_env.h
+++ b/libfdt/libfdt_env.h
@@ -109,4 +109,33 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
 #undef CPU_TO_FDT16
 #undef EXTRACT_BYTE

+#ifdef __APPLE__
+#include <AvailabilityMacros.h>
+
+#define MAC_OS_X_VERSION_10_7 1070
+
+/* strnlen() is not available on Mac OS < 10.7 */
+# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
+
+/*
+ * strnlen: returns the length of a string or max_count - which ever is smallest
+ * Input 1 string: the string whose size is to be determined
+ * Input 2 max_count: the maximum value returned by this function
+ * Output: length of the string or max_count (the smallest of the two)
+ */
+static inline size_t strnlen(const char *string, size_t max_count)
+{
+    size_t count;
+    for (count = 0; count < max_count; count++) {
+        if (string[count] == '\0') {
+            break;
+        }
+    }
+    return count;
+}
+
+#endif /* (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7) */
+
+#endif /* __APPLE__ */
+
 #endif /* _LIBFDT_ENV_H */
-- 
2.13.5 (Apple Git-94)
