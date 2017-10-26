Received: from eggs.gnu.org ([2001:4830:134:3::10]:47546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e7WkG-0000aE-IJ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e7WkD-00055Q-DM
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:14:04 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Wed, 25 Oct 2017 21:13:46 -0400
Message-Id: <20171026011346.5758-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [libfdt][PATCH v4] implement strnlen for systems that
 need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, peter.maydell@linaro.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, devicetree-compiler@vger.kernel.org, ian@freebsd.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Prior the Mac OS 10.7, the function strnlen() was not available. This patch
implements strnlen() on Mac OS X versions that are below 10.7.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v4 changes:
- Added check for definition of MAC_OS_X_VERSION_10_7
- Renamed strnlen to fdt_strnlen
- Added macro that defines strnlen as fdt_strnlen

v3 changes:
- Replaced loop with memchr()

v2 changes:
- Simplified the code to make it static inline'ed
- Changed the type of count to size_t

 libfdt/libfdt_env.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
index 952056c..41fac04 100644
--- a/libfdt/libfdt_env.h
+++ b/libfdt/libfdt_env.h
@@ -109,4 +109,31 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
 #undef CPU_TO_FDT16
 #undef EXTRACT_BYTE
 
+#ifdef __APPLE__
+#include <AvailabilityMacros.h>
+
+/* strnlen() is not available on Mac OS < 10.7 */
+# if !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED < \
+                                         MAC_OS_X_VERSION_10_7)
+
+#define strnlen fdt_strnlen
+
+/*
+ * fdt_strnlen: returns the length of a string or max_count - which ever is
+ * smallest.
+ * Input 1 string: the string whose size is to be determined
+ * Input 2 max_count: the maximum value returned by this function
+ * Output: length of the string or max_count (the smallest of the two)
+ */
+static inline size_t fdt_strnlen(const char *string, size_t max_count)
+{
+    const char *p = memchr(string, 0, max_count);
+    return p ? p - string : max_count;
+}
+
+#endif /* !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED <
+          MAC_OS_X_VERSION_10_7) */
+
+#endif /* __APPLE__ */
+
 #endif /* _LIBFDT_ENV_H */
-- 
2.10.2
