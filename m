Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwe-0005gz-9P
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0001MR-O3
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:20 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwa-0001Kn-DW
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:05:00 +0200
Message-Id: <20170525210508.4910-19-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 18/26] target/s390x: implement COMPARE LOGICAL
 LONG UNICODE
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

For that we need to make program_interrupt available to qemu-user.
Fortunately there is almost nothing to change as both kvm_enabled and
CONFIG_KVM evaluate to false in that case.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 76 ++++++++++++++++++++++++++++++++++++++--------
 target/s390x/misc_helper.c |  4 +--
 target/s390x/translate.c   | 12 ++++++++
 5 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 32938d99de..1b82d1a368 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -24,6 +24,7 @@ DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_4(mvcle, i32, env, i32, i64, i32)
 DEF_HELPER_4(clcle, i32, env, i32, i64, i32)
+DEF_HELPER_4(clclu, i32, env, i32, i64, i32)
 DEF_HELPER_3(cegb, i64, env, s64, i32)
 DEF_HELPER_3(cdgb, i64, env, s64, i32)
 DEF_HELPER_3(cxgb, i64, env, s64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index e241c1e486..f9e69f9b09 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -214,6 +214,8 @@
     C(0x0f00, CLCL,    RR_a,  Z,   0, 0, 0, 0, clcl, 0)
 /* COMPARE LOGICAL LONG EXTENDED */
     C(0xa900, CLCLE,   RS_a,  Z,   0, a2, 0, 0, clcle, 0)
+/* COMPARE LOGICAL LONG UNICODE */
+    C(0xeb8f, CLCLU,   RSY_a, E2,  0, a2, 0, 0, clclu, 0)
 /* COMPARE LOGICAL CHARACTERS UNDER MASK */
     C(0xbd00, CLM,     RS_b,  Z,   r1_o, a2, 0, 0, clm, 0)
     C(0xeb21, CLMY,    RSY_b, LD,  r1_o, a2, 0, 0, clm, 0)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 6add413531..7ce7daaf11 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -67,6 +67,32 @@ static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
     return len;
 }
 
+/* Trigger a SPECIFICATION exception if an address or a length is not
+   naturally aligned.  */
+static inline void check_alignment(CPUS390XState *env, uint64_t v,
+                                   int wordsize, uintptr_t ra)
+{
+    if (v % wordsize) {
+        CPUState *cs = CPU(s390_env_get_cpu(env));
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIFICATION, 6);
+    }
+}
+
+/* Load a value from memory according to its size.  */
+static inline uint64_t cpu_ldusize_data_ra(CPUS390XState *env, uint64_t addr,
+                                           int wordsize, uintptr_t ra)
+{
+    switch (wordsize) {
+    case 1:
+        return cpu_ldub_data_ra(env, addr, ra);
+    case 2:
+        return cpu_lduw_data_ra(env, addr, ra);
+    default:
+        abort();
+    }
+}
+
 static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
                         uint32_t l, uintptr_t ra)
 {
@@ -700,12 +726,14 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
 static inline uint32_t do_clcl(CPUS390XState *env,
                                uint64_t *dest, uint64_t *destlen,
                                uint64_t *src, uint64_t *srclen,
-                               uint8_t pad, uint64_t limit,
-                               uintptr_t ra)
+                               uint16_t pad, uint64_t limit,
+                               int wordsize, uintptr_t ra)
 {
     uint64_t len = MAX(*srclen, *destlen);
     uint32_t cc = 0;
 
+    check_alignment(env, *srclen | *destlen, wordsize, ra);
+
     if (!(*destlen || *srclen)) {
         return cc;
     }
@@ -717,15 +745,15 @@ static inline uint32_t do_clcl(CPUS390XState *env,
         cc = 3;
     }
 
-    for (; len; len--) {
-        uint8_t v1 = pad;
-        uint8_t v2 = pad;
+    for (; len; len -= wordsize) {
+        uint16_t v1 = pad;
+        uint16_t v2 = pad;
 
         if (*srclen) {
-            v1 = cpu_ldub_data_ra(env, *src, ra);
+            v1 = cpu_ldusize_data_ra(env, *src, wordsize, ra);
         }
         if (*destlen) {
-            v2 = cpu_ldub_data_ra(env, *dest, ra);
+            v2 = cpu_ldusize_data_ra(env, *dest, wordsize, ra);
         }
 
         if (v1 != v2) {
@@ -734,12 +762,12 @@ static inline uint32_t do_clcl(CPUS390XState *env,
         }
 
         if (*srclen) {
-            *src += 1;
-            *srclen -= 1;
+            *src += wordsize;
+            *srclen -= wordsize;
         }
         if (*destlen) {
-            *dest += 1;
-            *destlen -= 1;
+            *dest += wordsize;
+            *destlen -= wordsize;
         }
     }
 
@@ -758,7 +786,7 @@ uint32_t HELPER(clcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     uint8_t pad = env->regs[r2 + 1] >> 24;
     uint32_t cc;
 
-    cc = do_clcl(env, &dest, &destlen, &src, &srclen, pad, -1, ra);
+    cc = do_clcl(env, &dest, &destlen, &src, &srclen, pad, -1, 1, ra);
 
     env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, destlen);
     env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, srclen);
@@ -780,7 +808,29 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     uint8_t pad = a2;
     uint32_t cc;
 
-    cc = do_clcl(env, &dest, &destlen, &src, &srclen, pad, 0x2000, ra);
+    cc = do_clcl(env, &dest, &destlen, &src, &srclen, pad, 0x2000, 1, ra);
+
+    set_length(env, r1 + 1, destlen);
+    set_length(env, r3 + 1, srclen);
+    set_address(env, r1, dest);
+    set_address(env, r3, src);
+
+    return cc;
+}
+
+/* compare logical long unicode memcompare insn with padding */
+uint32_t HELPER(clclu)(CPUS390XState *env, uint32_t r1, uint64_t a2,
+                       uint32_t r3)
+{
+    uintptr_t ra = GETPC();
+    uint64_t destlen = get_length(env, r1 + 1);
+    uint64_t dest = get_address(env, r1);
+    uint64_t srclen = get_length(env, r3 + 1);
+    uint64_t src = get_address(env, r3);
+    uint16_t pad = a2;
+    uint32_t cc = 0;
+
+    cc = do_clcl(env, &dest, &destlen, &src, &srclen, pad, 0x1000, 2, ra);
 
     set_length(env, r1 + 1, destlen);
     set_length(env, r3 + 1, srclen);
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 23ec52cf35..f083c8d3cf 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -80,8 +80,6 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
     cpu_loop_exit(cs);
 }
 
-#ifndef CONFIG_USER_ONLY
-
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
@@ -108,6 +106,8 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+
 /* SCLP service call */
 uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6f8d75bc2e..2ea96c0a8f 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1196,6 +1196,7 @@ typedef enum DisasFacility {
     FAC_ILA,                /* interlocked access facility 1 */
     FAC_LPP,                /* load-program-parameter */
     FAC_DAT_ENH,            /* DAT-enhancement */
+    FAC_E2,                 /* extended-translation facility 2 */
 } DisasFacility;
 
 struct DisasInsn {
@@ -1933,6 +1934,17 @@ static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_clclu(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
+    gen_helper_clclu(cc_op, cpu_env, r1, o->in2, r3);
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r3);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_clm(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-- 
2.11.0
