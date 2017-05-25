Received: from eggs.gnu.org ([2001:4830:134:3::10]:55236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwc-0005ef-MZ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0001Lq-Er
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwa-0001Kg-6D
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:59 +0200
Message-Id: <20170525210508.4910-18-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 17/26] target/s390x: improve MOVE LONG and MOVE
 LONG EXTENDED
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

As MVCL and MVCLE only differ by their operands, use a common
do_mvcl helper. Optimize it calling fast_memmove and fast_memset.
Correctly write back addresses.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 90 +++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 50 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index aa665fe0f7..6add413531 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -621,49 +621,60 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
     }
 }
 
-/* move long */
-uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+/* move long helper */
+static inline uint32_t do_mvcl(CPUS390XState *env,
+                               uint64_t *dest, uint64_t *destlen,
+                               uint64_t *src, uint64_t *srclen,
+                               uint8_t pad, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
-    uint64_t destlen = env->regs[r1 + 1] & 0xffffff;
-    uint64_t dest = get_address(env, r1);
-    uint64_t srclen = env->regs[r2 + 1] & 0xffffff;
-    uint64_t src = get_address(env, r2);
-    uint8_t pad = env->regs[r2 + 1] >> 24;
-    uint8_t v;
+    uint64_t len = MIN(*srclen, *destlen);
     uint32_t cc;
 
-    if (destlen == srclen) {
+    if (*destlen == *srclen) {
         cc = 0;
-    } else if (destlen < srclen) {
+    } else if (*destlen < *srclen) {
         cc = 1;
     } else {
         cc = 2;
     }
 
-    if (srclen > destlen) {
-        srclen = destlen;
-    }
+    /* Copy the src array */
+    fast_memmove(env, *dest, *src, len, ra);
+    *src += len;
+    *srclen -= len;
+    *dest += len;
+    *destlen -= len;
 
-    for (; destlen && srclen; src++, dest++, destlen--, srclen--) {
-        v = cpu_ldub_data_ra(env, src, ra);
-        cpu_stb_data_ra(env, dest, v, ra);
-    }
+    /* Pad the remaining area */
+    fast_memset(env, *dest, pad, *destlen, ra);
+    *dest += *destlen;
+    *destlen = 0;
 
-    for (; destlen; dest++, destlen--) {
-        cpu_stb_data_ra(env, dest, pad, ra);
-    }
+    return cc;
+}
 
-    env->regs[r1 + 1] = destlen;
-    /* can't use srclen here, we trunc'ed it */
-    env->regs[r2 + 1] -= src - env->regs[r2];
+/* move long */
+uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+{
+    uintptr_t ra = GETPC();
+    uint64_t destlen = env->regs[r1 + 1] & 0xffffff;
+    uint64_t dest = get_address(env, r1);
+    uint64_t srclen = env->regs[r2 + 1] & 0xffffff;
+    uint64_t src = get_address(env, r2);
+    uint8_t pad = env->regs[r2 + 1] >> 24;
+    uint32_t cc;
+
+    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, ra);
+
+    env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, destlen);
+    env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, srclen);
     set_address(env, r1, dest);
     set_address(env, r2, src);
 
     return cc;
 }
 
-/* move long extended another memcopy insn with more bells and whistles */
+/* move long extended */
 uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
                        uint32_t r3)
 {
@@ -672,34 +683,13 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     uint64_t dest = get_address(env, r1);
     uint64_t srclen = get_length(env, r3 + 1);
     uint64_t src = get_address(env, r3);
-    uint8_t pad = a2 & 0xff;
-    uint8_t v;
+    uint8_t pad = a2;
     uint32_t cc;
 
-    if (destlen == srclen) {
-        cc = 0;
-    } else if (destlen < srclen) {
-        cc = 1;
-    } else {
-        cc = 2;
-    }
-
-    if (srclen > destlen) {
-        srclen = destlen;
-    }
-
-    for (; destlen && srclen; src++, dest++, destlen--, srclen--) {
-        v = cpu_ldub_data_ra(env, src, ra);
-        cpu_stb_data_ra(env, dest, v, ra);
-    }
-
-    for (; destlen; dest++, destlen--) {
-        cpu_stb_data_ra(env, dest, pad, ra);
-    }
+    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, ra);
 
-    set_length(env, r1 + 1 , destlen);
-    /* can't use srclen here, we trunc'ed it */
-    set_length(env, r3 + 1, env->regs[r3 + 1] - src - env->regs[r3]);
+    set_length(env, r1 + 1, destlen);
+    set_length(env, r3 + 1, srclen);
     set_address(env, r1, dest);
     set_address(env, r3, src);
 
-- 
2.11.0
