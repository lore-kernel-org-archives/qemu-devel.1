Received: from eggs.gnu.org ([2001:4830:134:3::10]:55170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUagG-0004yp-A5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUagF-0002hR-Ai
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUagF-0002fI-1z
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:32:59 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 10 Jul 2017 17:32:35 +0200
Message-Id: <1499700760-4777-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1499700760-4777-1-git-send-email-thuth@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/10] pc-bios/s390-ccw: Move byteswap
 functions to a separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

We'll need them in code that is not related to bootmap.h, so
they should reside in an independent header.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c |  1 +
 pc-bios/s390-ccw/bootmap.h | 26 --------------------------
 pc-bios/s390-ccw/bswap.h   | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 26 deletions(-)
 create mode 100644 pc-bios/s390-ccw/bswap.h

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 458d3da..67a6123 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -12,6 +12,7 @@
 #include "s390-ccw.h"
 #include "bootmap.h"
 #include "virtio.h"
+#include "bswap.h"
 
 #ifdef DEBUG
 /* #define DEBUG_FALLBACK */
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 7f36782..cf99a4c 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -324,32 +324,6 @@ static inline int _memcmp(const void *s1, const void *s2, size_t n)
     return 0;
 }
 
-/* from include/qemu/bswap.h */
-
-/* El Torito is always little-endian */
-static inline uint16_t bswap16(uint16_t x)
-{
-    return ((x & 0x00ff) << 8) | ((x & 0xff00) >> 8);
-}
-
-static inline uint32_t bswap32(uint32_t x)
-{
-    return ((x & 0x000000ffU) << 24) | ((x & 0x0000ff00U) <<  8) |
-           ((x & 0x00ff0000U) >>  8) | ((x & 0xff000000U) >> 24);
-}
-
-static inline uint64_t bswap64(uint64_t x)
-{
-    return ((x & 0x00000000000000ffULL) << 56) |
-           ((x & 0x000000000000ff00ULL) << 40) |
-           ((x & 0x0000000000ff0000ULL) << 24) |
-           ((x & 0x00000000ff000000ULL) <<  8) |
-           ((x & 0x000000ff00000000ULL) >>  8) |
-           ((x & 0x0000ff0000000000ULL) >> 24) |
-           ((x & 0x00ff000000000000ULL) >> 40) |
-           ((x & 0xff00000000000000ULL) >> 56);
-}
-
 static inline uint32_t iso_733_to_u32(uint64_t x)
 {
     return (uint32_t)x;
diff --git a/pc-bios/s390-ccw/bswap.h b/pc-bios/s390-ccw/bswap.h
new file mode 100644
index 0000000..45b5ef4
--- /dev/null
+++ b/pc-bios/s390-ccw/bswap.h
@@ -0,0 +1,25 @@
+
+/* from include/qemu/bswap.h */
+
+static inline uint16_t bswap16(uint16_t x)
+{
+    return ((x & 0x00ff) << 8) | ((x & 0xff00) >> 8);
+}
+
+static inline uint32_t bswap32(uint32_t x)
+{
+    return ((x & 0x000000ffU) << 24) | ((x & 0x0000ff00U) <<  8) |
+           ((x & 0x00ff0000U) >>  8) | ((x & 0xff000000U) >> 24);
+}
+
+static inline uint64_t bswap64(uint64_t x)
+{
+    return ((x & 0x00000000000000ffULL) << 56) |
+           ((x & 0x000000000000ff00ULL) << 40) |
+           ((x & 0x0000000000ff0000ULL) << 24) |
+           ((x & 0x00000000ff000000ULL) <<  8) |
+           ((x & 0x000000ff00000000ULL) >>  8) |
+           ((x & 0x0000ff0000000000ULL) >> 24) |
+           ((x & 0x00ff000000000000ULL) >> 40) |
+           ((x & 0xff00000000000000ULL) >> 56);
+}
-- 
1.8.3.1
