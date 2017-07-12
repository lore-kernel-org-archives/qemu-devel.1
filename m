Received: from eggs.gnu.org ([2001:4830:134:3::10]:42410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH6E-00007B-3t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH6D-0004cM-38
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVH6C-0004ab-OP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Jul 2017 14:49:47 +0200
Message-Id: <1499863793-18627-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1499863793-18627-1-git-send-email-thuth@redhat.com>
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/11] pc-bios/s390-ccw: Move byteswap
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
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

We'll need them in code that is not related to bootmap.h, so
they should reside in an independent header.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c |  1 +
 pc-bios/s390-ccw/bootmap.h | 26 --------------------------
 pc-bios/s390-ccw/bswap.h   | 30 ++++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 26 deletions(-)
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
index 0000000..a422604
--- /dev/null
+++ b/pc-bios/s390-ccw/bswap.h
@@ -0,0 +1,30 @@
+/*
+ * Byte swap functions - taken from include/qemu/bswap.h
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
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
