Received: from eggs.gnu.org ([2001:4830:134:3::10]:55231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwc-0005eS-K1
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0001Lk-Dg
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwa-0001Kb-4F
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:56 +0200
Message-Id: <20170525210508.4910-15-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 14/26] target/s390x: improve 24-bit and 31-bit
 lengths read/write
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

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bbb3eceb71..1dc71fe5f0 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -421,6 +421,31 @@ static inline void set_address(CPUS390XState *env, int reg, uint64_t address)
     }
 }
 
+static inline uint64_t wrap_length(CPUS390XState *env, uint64_t length)
+{
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        /* 24-Bit and 31-Bit mode */
+        length &= 0x7fffffff;
+    }
+    return length;
+}
+
+static inline uint64_t get_length(CPUS390XState *env, int reg)
+{
+    return wrap_length(env, env->regs[reg]);
+}
+
+static inline void set_length(CPUS390XState *env, int reg, uint64_t length)
+{
+    if (env->psw.mask & PSW_MASK_64) {
+        /* 64-Bit mode */
+        env->regs[reg] = length;
+    } else {
+        /* 24-Bit and 31-Bit mode */
+        env->regs[reg] = deposit64(env->regs[reg], 0, 32, length);
+    }
+}
+
 /* search string (c is byte to search, r2 is string, r1 end of string) */
 uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
                       uint64_t str)
@@ -643,19 +668,14 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
                        uint32_t r3)
 {
     uintptr_t ra = GETPC();
-    uint64_t destlen = env->regs[r1 + 1];
+    uint64_t destlen = get_length(env, r1 + 1);
     uint64_t dest = get_address(env, r1);
-    uint64_t srclen = env->regs[r3 + 1];
+    uint64_t srclen = get_length(env, r3 + 1);
     uint64_t src = get_address(env, r3);
     uint8_t pad = a2 & 0xff;
     uint8_t v;
     uint32_t cc;
 
-    if (!(env->psw.mask & PSW_MASK_64)) {
-        destlen = (uint32_t)destlen;
-        srclen = (uint32_t)srclen;
-    }
-
     if (destlen == srclen) {
         cc = 0;
     } else if (destlen < srclen) {
@@ -677,10 +697,9 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
         cpu_stb_data_ra(env, dest, pad, ra);
     }
 
-    env->regs[r1 + 1] = destlen;
+    set_length(env, r1 + 1 , destlen);
     /* can't use srclen here, we trunc'ed it */
-    /* FIXME: 31-bit mode! */
-    env->regs[r3 + 1] -= src - env->regs[r3];
+    set_length(env, r3 + 1, env->regs[r3 + 1] - src - env->regs[r3]);
     set_address(env, r1, dest);
     set_address(env, r3, src);
 
@@ -692,9 +711,9 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
                        uint32_t r3)
 {
     uintptr_t ra = GETPC();
-    uint64_t destlen = env->regs[r1 + 1];
+    uint64_t destlen = get_length(env, r1 + 1);
     uint64_t dest = get_address(env, r1);
-    uint64_t srclen = env->regs[r3 + 1];
+    uint64_t srclen = get_length(env, r3 + 1);
     uint64_t src = get_address(env, r3);
     uint8_t pad = a2 & 0xff;
     uint32_t cc = 0;
@@ -716,9 +735,9 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
         }
     }
 
-    env->regs[r1 + 1] = destlen;
+    set_length(env, r1 + 1, destlen);
     /* can't use srclen here, we trunc'ed it */
-    env->regs[r3 + 1] -= src - env->regs[r3];
+    set_length(env, r3 + 1, env->regs[r3 + 1] - src - env->regs[r3]);
     set_address(env, r1, dest);
     set_address(env, r3, src);
 
-- 
2.11.0
