Received: from eggs.gnu.org ([2001:4830:134:3::10]:55217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwc-0005e8-AG
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0001LT-9K
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwa-0001KH-0v
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:57 +0200
Message-Id: <20170525210508.4910-16-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 15/26] target/s390x: fix COMPARE LOGICAL LONG
 EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

There are multiple issues with the COMPARE LOGICAL LONG EXTENDED
instruction:
- The test between the two operands is inverted, leading to an inversion
  of the cc values 1 and 2.
- The address and length of an operand continue to be decreased after
  reaching the end of this operand. These values are then wrong write
  back to the registers.
- We should limit the amount of bytes to process, so that interrupts can
  be served correctly.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 1dc71fe5f0..bd3bce3623 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -716,28 +716,48 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     uint64_t srclen = get_length(env, r3 + 1);
     uint64_t src = get_address(env, r3);
     uint8_t pad = a2 & 0xff;
+    uint64_t len = MAX(srclen, destlen);
     uint32_t cc = 0;
 
     if (!(destlen || srclen)) {
         return cc;
     }
 
-    if (srclen > destlen) {
-        srclen = destlen;
+    /* Lest we fail to service interrupts in a timely manner, limit the
+       amount of work we're willing to do.  For now, let's cap at 8k.  */
+    if (len > 0x2000) {
+        len = 0x2000;
+        cc = 3;
     }
 
-    for (; destlen || srclen; src++, dest++, destlen--, srclen--) {
-        uint8_t v1 = srclen ? cpu_ldub_data_ra(env, src, ra) : pad;
-        uint8_t v2 = destlen ? cpu_ldub_data_ra(env, dest, ra) : pad;
+    for (; len; len--) {
+        uint8_t v1 = pad;
+        uint8_t v2 = pad;
+
+        if (srclen) {
+            v1 = cpu_ldub_data_ra(env, src, ra);
+        }
+        if (destlen) {
+            v2 = cpu_ldub_data_ra(env, dest, ra);
+        }
+
         if (v1 != v2) {
-            cc = (v1 < v2) ? 1 : 2;
+            cc = (v1 > v2) ? 1 : 2;
             break;
         }
+
+        if (srclen) {
+            src++;
+            srclen--;
+        }
+        if (destlen) {
+            dest++;
+            destlen--;
+        }
     }
 
     set_length(env, r1 + 1, destlen);
-    /* can't use srclen here, we trunc'ed it */
-    set_length(env, r3 + 1, env->regs[r3 + 1] - src - env->regs[r3]);
+    set_length(env, r3 + 1, srclen);
     set_address(env, r1, dest);
     set_address(env, r3, src);
 
-- 
2.11.0
