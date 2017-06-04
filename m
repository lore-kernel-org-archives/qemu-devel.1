Received: from eggs.gnu.org ([2001:4830:134:3::10]:50721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZS0-000899-QB
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRz-0003sq-Rj
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:28 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRz-0003rq-MJ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:27 -0400
Received: by mail-pg0-x241.google.com with SMTP id f127so7256828pgc.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:54 -0700
Message-Id: <20170604173509.29684-55-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 54/69] target/s390x: improve 24-bit and 31-bit
 addresses write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-16-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 2425bfc..2113494 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -384,6 +384,29 @@ static inline uint64_t get_address(CPUS390XState *env, int reg)
     return wrap_address(env, env->regs[reg]);
 }
 
+static inline void set_address(CPUS390XState *env, int reg, uint64_t address)
+{
+    if (env->psw.mask & PSW_MASK_64) {
+        /* 64-Bit mode */
+        env->regs[reg] = address;
+    } else {
+        if (!(env->psw.mask & PSW_MASK_32)) {
+            /* 24-Bit mode. According to the PoO it is implementation
+            dependent if bits 32-39 remain unchanged or are set to
+            zeros.  Choose the former so that the function can also be
+            used for TRT.  */
+            env->regs[reg] = deposit64(env->regs[reg], 0, 24, address);
+        } else {
+            /* 31-Bit mode. According to the PoO it is implementation
+            dependent if bit 32 remains unchanged or is set to zero.
+            Choose the latter so that the function can also be used for
+            TRT.  */
+            address &= 0x7fffffff;
+            env->regs[reg] = deposit64(env->regs[reg], 0, 32, address);
+        }
+    }
+}
+
 /* search string (c is byte to search, r2 is string, r1 end of string) */
 uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
                       uint64_t str)
@@ -564,8 +587,8 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     env->regs[r1 + 1] = destlen;
     /* can't use srclen here, we trunc'ed it */
     env->regs[r2 + 1] -= src - env->regs[r2];
-    env->regs[r1] = dest;
-    env->regs[r2] = src;
+    set_address(env, r1, dest);
+    set_address(env, r2, src);
 
     return cc;
 }
@@ -613,8 +636,8 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     /* can't use srclen here, we trunc'ed it */
     /* FIXME: 31-bit mode! */
     env->regs[r3 + 1] -= src - env->regs[r3];
-    env->regs[r1] = dest;
-    env->regs[r3] = src;
+    set_address(env, r1, dest);
+    set_address(env, r3, src);
 
     return cc;
 }
@@ -651,8 +674,8 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     env->regs[r1 + 1] = destlen;
     /* can't use srclen here, we trunc'ed it */
     env->regs[r3 + 1] -= src - env->regs[r3];
-    env->regs[r1] = dest;
-    env->regs[r3] = src;
+    set_address(env, r1, dest);
+    set_address(env, r3, src);
 
     return cc;
 }
@@ -858,7 +881,7 @@ static uint32_t do_helper_trt(CPUS390XState *env, uint32_t len, uint64_t array,
         uint8_t sbyte = cpu_ldub_data_ra(env, trans + byte, ra);
 
         if (sbyte != 0) {
-            env->regs[1] = array + i;
+            set_address(env, 1, array + i);
             env->regs[2] = deposit64(env->regs[2], 0, 8, sbyte);
             return (i == len) ? 2 : 1;
         }
-- 
2.9.4
