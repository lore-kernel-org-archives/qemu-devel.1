Received: from eggs.gnu.org ([2001:4830:134:3::10]:34421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtu-0003by-G9
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtt-0002IT-2r
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:42 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOts-0002HX-Ur
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:41 -0400
Received: by mail-qk0-x243.google.com with SMTP id d14so12249164qkb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:07 -0700
Message-Id: <20170607003119.14778-59-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 58/70] target/s390x: implement COMPARE
 LOGICAL LONG UNICODE
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

For that we need to make program_interrupt available to qemu-user.
Fortunately there is almost nothing to change as both kvm_enabled and
CONFIG_KVM evaluate to false in that case.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-22-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 76 ++++++++++++++++++++++++++++++++++++++--------
 target/s390x/misc_helper.c |  4 +--
 target/s390x/translate.c   | 22 ++++++++++++++
 5 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a06e276..b672c3b 100644
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
index e30b1b9..a6aaf50 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -220,6 +220,8 @@
     C(0x0f00, CLCL,    RR_a,  Z,   0, 0, 0, 0, clcl, 0)
 /* COMPARE LOGICAL LONG EXTENDED */
     C(0xa900, CLCLE,   RS_a,  Z,   0, a2, 0, 0, clcle, 0)
+/* COMPARE LOGICAL LONG UNICODE */
+    C(0xeb8f, CLCLU,   RSY_a, E2,  0, a2, 0, 0, clclu, 0)
 /* COMPARE LOGICAL CHARACTERS UNDER MASK */
     C(0xbd00, CLM,     RS_b,  Z,   r1_o, a2, 0, 0, clm, 0)
     C(0xeb21, CLMY,    RSY_b, LD,  r1_o, a2, 0, 0, clm, 0)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3b2ff09..4a7c66c 100644
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
@@ -655,12 +681,14 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
 static inline uint32_t do_clcl(CPUS390XState *env,
                                uint64_t *src1, uint64_t *src1len,
                                uint64_t *src3, uint64_t *src3len,
-                               uint8_t pad, uint64_t limit,
-                               uintptr_t ra)
+                               uint16_t pad, uint64_t limit,
+                               int wordsize, uintptr_t ra)
 {
     uint64_t len = MAX(*src1len, *src3len);
     uint32_t cc = 0;
 
+    check_alignment(env, *src1len | *src3len, wordsize, ra);
+
     if (!len) {
         return cc;
     }
@@ -672,15 +700,15 @@ static inline uint32_t do_clcl(CPUS390XState *env,
         cc = 3;
     }
 
-    for (; len; len--) {
-        uint8_t v1 = pad;
-        uint8_t v3 = pad;
+    for (; len; len -= wordsize) {
+        uint16_t v1 = pad;
+        uint16_t v3 = pad;
 
         if (*src1len) {
-            v1 = cpu_ldub_data_ra(env, *src1, ra);
+            v1 = cpu_ldusize_data_ra(env, *src1, wordsize, ra);
         }
         if (*src3len) {
-            v3 = cpu_ldub_data_ra(env, *src3, ra);
+            v3 = cpu_ldusize_data_ra(env, *src3, wordsize, ra);
         }
 
         if (v1 != v3) {
@@ -689,12 +717,12 @@ static inline uint32_t do_clcl(CPUS390XState *env,
         }
 
         if (*src1len) {
-            *src1 += 1;
-            *src1len -= 1;
+            *src1 += wordsize;
+            *src1len -= wordsize;
         }
         if (*src3len) {
-            *src3 += 1;
-            *src3len -= 1;
+            *src3 += wordsize;
+            *src3len -= wordsize;
         }
     }
 
@@ -713,7 +741,7 @@ uint32_t HELPER(clcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     uint8_t pad = env->regs[r2 + 1] >> 24;
     uint32_t cc;
 
-    cc = do_clcl(env, &src1, &src1len, &src3, &src3len, pad, -1, ra);
+    cc = do_clcl(env, &src1, &src1len, &src3, &src3len, pad, -1, 1, ra);
 
     env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, src1len);
     env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, src3len);
@@ -735,7 +763,29 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     uint8_t pad = a2;
     uint32_t cc;
 
-    cc = do_clcl(env, &src1, &src1len, &src3, &src3len, pad, 0x2000, ra);
+    cc = do_clcl(env, &src1, &src1len, &src3, &src3len, pad, 0x2000, 1, ra);
+
+    set_length(env, r1 + 1, src1len);
+    set_length(env, r3 + 1, src3len);
+    set_address(env, r1, src1);
+    set_address(env, r3, src3);
+
+    return cc;
+}
+
+/* compare logical long unicode memcompare insn with padding */
+uint32_t HELPER(clclu)(CPUS390XState *env, uint32_t r1, uint64_t a2,
+                       uint32_t r3)
+{
+    uintptr_t ra = GETPC();
+    uint64_t src1len = get_length(env, r1 + 1);
+    uint64_t src1 = get_address(env, r1);
+    uint64_t src3len = get_length(env, r3 + 1);
+    uint64_t src3 = get_address(env, r3);
+    uint16_t pad = a2;
+    uint32_t cc = 0;
+
+    cc = do_clcl(env, &src1, &src1len, &src3, &src3len, pad, 0x1000, 2, ra);
 
     set_length(env, r1 + 1, src1len);
     set_length(env, r3 + 1, src3len);
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 1b9f448..edcdf17 100644
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
index c131f67..d371d45 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1205,6 +1205,7 @@ typedef enum DisasFacility {
     FAC_ILA,                /* interlocked access facility 1 */
     FAC_LPP,                /* load-program-parameter */
     FAC_DAT_ENH,            /* DAT-enhancement */
+    FAC_E2,                 /* extended-translation facility 2 */
 } DisasFacility;
 
 struct DisasInsn {
@@ -1962,6 +1963,27 @@ static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_clclu(DisasContext *s, DisasOps *o)
+{
+    int r1 = get_field(s->fields, r1);
+    int r3 = get_field(s->fields, r3);
+    TCGv_i32 t1, t3;
+
+    /* r1 and r3 must be even.  */
+    if (r1 & 1 || r3 & 1) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+
+    t1 = tcg_const_i32(r1);
+    t3 = tcg_const_i32(r3);
+    gen_helper_clclu(cc_op, cpu_env, t1, o->in2, t3);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t3);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_clm(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-- 
2.9.4
