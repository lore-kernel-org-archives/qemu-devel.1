Received: from eggs.gnu.org ([2001:4830:134:3::10]:39605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cPPa9-00048L-O2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cPPa5-00055t-No
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:09:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cPPa5-00055h-Hc
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:08:57 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  6 Jan 2017 09:08:53 +0100
Message-Id: <1483690133-25104-1-git-send-email-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] net: optimize checksum computation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, dmitry@daynix.com

Very simple loop optimization with a significant performance impact.

Microbenchmark results, modern x86-64:

buffer size | speed up
------------+---------
1500        | 1.7x
64          | 1.5x
8           | 1.15x

Microbenchmark results, POWER7:

buffer size | speed up
------------+---------
1500        | 5x
64          | 3.3x
8           | 1.13x

There is a lot of room for further improvement at the expense of
code complexity - aligned multibyte reads, LE/BE considerations,
architecture-specific optimizations, etc. This patch still keeps
things simple and readable.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 net/checksum.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/checksum.c b/net/checksum.c
index 23323b0..4da72a6 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -22,17 +22,22 @@
 
 uint32_t net_checksum_add_cont(int len, uint8_t *buf, int seq)
 {
-    uint32_t sum = 0;
+    uint32_t sum1 = 0, sum2 = 0;
     int i;
 
-    for (i = seq; i < seq + len; i++) {
-        if (i & 1) {
-            sum += (uint32_t)buf[i - seq];
-        } else {
-            sum += (uint32_t)buf[i - seq] << 8;
-        }
+    for (i = 0; i < len - 1; i += 2) {
+        sum1 += (uint32_t)buf[i];
+        sum2 += (uint32_t)buf[i + 1];
+    }
+    if (i < len) {
+        sum1 += (uint32_t)buf[i];
+    }
+
+    if (seq & 1) {
+        return sum1 + (sum2 << 8);
+    } else {
+        return sum2 + (sum1 << 8);
     }
-    return sum;
 }
 
 uint16_t net_checksum_finish(uint32_t sum)
-- 
2.7.4
