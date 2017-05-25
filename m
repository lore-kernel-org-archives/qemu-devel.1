Received: from eggs.gnu.org ([2001:4830:134:3::10]:55255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwc-0005fB-Vd
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0001M6-Je
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwa-0001Kk-Ae
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:58 +0200
Message-Id: <20170525210508.4910-17-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 16/26] target/s390x: implement COMPARE LOGICAL
 LONG
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

As CLCL and CLCLE mostly differ by their operands, use a common do_clcl
helper. Another difference is that CLCL is not interruptible.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 86 ++++++++++++++++++++++++++++++++--------------
 target/s390x/translate.c   | 11 ++++++
 4 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index e1ab8d5686..32938d99de 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -6,6 +6,7 @@ DEF_HELPER_FLAGS_4(mvc, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvcin, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(clc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_3(mvcl, i32, env, i32, i32)
+DEF_HELPER_3(clcl, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(clm, TCG_CALL_NO_WG, i32, env, i32, i32, i64)
 DEF_HELPER_FLAGS_3(divs32, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_3(divu32, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c69e3f4216..e241c1e486 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -210,6 +210,8 @@
     C(0xc60e, CLGFRL,  RIL_b, GIE, r1_o, mri2_32u, 0, 0, 0, cmpu64)
     C(0xc607, CLHRL,   RIL_b, GIE, r1_o, mri2_16u, 0, 0, 0, cmpu32)
     C(0xc606, CLGHRL,  RIL_b, GIE, r1_o, mri2_16u, 0, 0, 0, cmpu64)
+/* COMPARE LOGICAL LONG */
+    C(0x0f00, CLCL,    RR_a,  Z,   0, 0, 0, 0, clcl, 0)
 /* COMPARE LOGICAL LONG EXTENDED */
     C(0xa900, CLCLE,   RS_a,  Z,   0, a2, 0, 0, clcle, 0)
 /* COMPARE LOGICAL CHARACTERS UNDER MASK */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bd3bce3623..aa665fe0f7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -706,27 +706,24 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     return cc;
 }
 
-/* compare logical long extended memcompare insn with padding */
-uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
-                       uint32_t r3)
-{
-    uintptr_t ra = GETPC();
-    uint64_t destlen = get_length(env, r1 + 1);
-    uint64_t dest = get_address(env, r1);
-    uint64_t srclen = get_length(env, r3 + 1);
-    uint64_t src = get_address(env, r3);
-    uint8_t pad = a2 & 0xff;
-    uint64_t len = MAX(srclen, destlen);
+/* compare logical long helper */
+static inline uint32_t do_clcl(CPUS390XState *env,
+                               uint64_t *dest, uint64_t *destlen,
+                               uint64_t *src, uint64_t *srclen,
+                               uint8_t pad, uint64_t limit,
+                               uintptr_t ra)
+{
+    uint64_t len = MAX(*srclen, *destlen);
     uint32_t cc = 0;
 
-    if (!(destlen || srclen)) {
+    if (!(*destlen || *srclen)) {
         return cc;
     }
 
     /* Lest we fail to service interrupts in a timely manner, limit the
-       amount of work we're willing to do.  For now, let's cap at 8k.  */
-    if (len > 0x2000) {
-        len = 0x2000;
+       amount of work we're willing to do.  */
+    if (len > limit) {
+        len = limit;
         cc = 3;
     }
 
@@ -734,11 +731,11 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
         uint8_t v1 = pad;
         uint8_t v2 = pad;
 
-        if (srclen) {
-            v1 = cpu_ldub_data_ra(env, src, ra);
+        if (*srclen) {
+            v1 = cpu_ldub_data_ra(env, *src, ra);
         }
-        if (destlen) {
-            v2 = cpu_ldub_data_ra(env, dest, ra);
+        if (*destlen) {
+            v2 = cpu_ldub_data_ra(env, *dest, ra);
         }
 
         if (v1 != v2) {
@@ -746,16 +743,55 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
             break;
         }
 
-        if (srclen) {
-            src++;
-            srclen--;
+        if (*srclen) {
+            *src += 1;
+            *srclen -= 1;
         }
-        if (destlen) {
-            dest++;
-            destlen--;
+        if (*destlen) {
+            *dest += 1;
+            *destlen -= 1;
         }
     }
 
+    return cc;
+}
+
+
+/* compare logical long */
+uint32_t HELPER(clcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+{
+    uintptr_t ra = GETPC();
+    uint64_t destlen = extract64(env->regs[r1 + 1], 0, 24);
+    uint64_t dest = get_address(env, r1);
+    uint64_t srclen = extract64(env->regs[r2 + 1], 0, 24);
+    uint64_t src = get_address(env, r2);
+    uint8_t pad = env->regs[r2 + 1] >> 24;
+    uint32_t cc;
+
+    cc = do_clcl(env, &dest, &destlen, &src, &srclen, pad, -1, ra);
+
+    env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, destlen);
+    env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, srclen);
+    set_address(env, r1, dest);
+    set_address(env, r2, src);
+
+    return cc;
+}
+
+/* compare logical long extended memcompare insn with padding */
+uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
+                       uint32_t r3)
+{
+    uintptr_t ra = GETPC();
+    uint64_t destlen = get_length(env, r1 + 1);
+    uint64_t dest = get_address(env, r1);
+    uint64_t srclen = get_length(env, r3 + 1);
+    uint64_t src = get_address(env, r3);
+    uint8_t pad = a2;
+    uint32_t cc;
+
+    cc = do_clcl(env, &dest, &destlen, &src, &srclen, pad, 0x2000, ra);
+
     set_length(env, r1 + 1, destlen);
     set_length(env, r3 + 1, srclen);
     set_address(env, r1, dest);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 87408df07a..6f8d75bc2e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1911,6 +1911,17 @@ static ExitStatus op_clc(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_clcl(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+    gen_helper_clcl(cc_op, cpu_env, r1, r2);
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
-- 
2.11.0
