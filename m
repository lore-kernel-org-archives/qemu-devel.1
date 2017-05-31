Received: from eggs.gnu.org ([2001:4830:134:3::10]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgV-0000yn-5l
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGBgT-0005Ny-Nn
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:43 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGBgT-0005Ma-Ew
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:01:41 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu,  1 Jun 2017 00:01:21 +0200
Message-Id: <20170531220129.27724-23-aurelien@aurel32.net>
In-Reply-To: <20170531220129.27724-1-aurelien@aurel32.net>
References: <20170531220129.27724-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v3 22/30] target/s390x: implement MOVE LONG
 UNICODE
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 47 ++++++++++++++++++++++++++++++++++++++++------
 target/s390x/translate.c   | 21 +++++++++++++++++++++
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 509e3f381c..5811911c34 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -23,6 +23,7 @@ DEF_HELPER_4(ex, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_FLAGS_4(lam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
 DEF_HELPER_4(mvcle, i32, env, i32, i64, i32)
+DEF_HELPER_4(mvclu, i32, env, i32, i64, i32)
 DEF_HELPER_4(clcle, i32, env, i32, i64, i32)
 DEF_HELPER_4(clclu, i32, env, i32, i64, i32)
 DEF_HELPER_3(cegb, i64, env, s64, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c781a97a3a..e3b7b78834 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -582,6 +582,8 @@
     C(0x0e00, MVCL,    RR_a,  Z,   0, 0, 0, 0, mvcl, 0)
 /* MOVE LONG EXTENDED */
     C(0xa800, MVCLE,   RS_a,  Z,   0, a2, 0, 0, mvcle, 0)
+/* MOVE LONG UNICODE */
+    C(0xeb8e, MVCLU,   RSY_a, E2,  0, a2, 0, 0, mvclu, 0)
 /* MOVE NUMERICS */
     C(0xd100, MVN,     SS_a,  Z,   la1, a2, 0, 0, mvn, 0)
 /* MOVE PAGE */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 59992faf69..a2d65cfbbb 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -606,7 +606,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 static inline uint32_t do_mvcl(CPUS390XState *env,
                                uint64_t *dest, uint64_t *destlen,
                                uint64_t *src, uint64_t *srclen,
-                               uint8_t pad, uintptr_t ra)
+                               uint16_t pad, int wordsize, uintptr_t ra)
 {
     uint64_t len = MIN(*srclen, *destlen);
     uint32_t cc;
@@ -627,9 +627,22 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
     *destlen -= len;
 
     /* Pad the remaining area */
-    fast_memset(env, *dest, pad, *destlen, ra);
-    *dest += *destlen;
-    *destlen = 0;
+    if (wordsize == 1) {
+        fast_memset(env, *dest, pad, *destlen, ra);
+        *dest += *destlen;
+        *destlen = 0;
+    } else {
+        /* If remaining length is odd, pad with odd byte first.  */
+        if (*destlen & 1) {
+            cpu_stb_data_ra(env, *dest, pad & 0xff, ra);
+            *dest += 1;
+            *destlen -= 1;
+        }
+        /* The remaining length is even, pad using words.  */
+        for (; *destlen; *dest += 2, *destlen -= 2) {
+            cpu_stw_data_ra(env, *dest, pad, ra);
+        }
+    }
 
     return cc;
 }
@@ -645,7 +658,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     uint8_t pad = env->regs[r2 + 1] >> 24;
     uint32_t cc;
 
-    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, ra);
+    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 1, ra);
 
     env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, destlen);
     env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, srclen);
@@ -667,7 +680,29 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
     uint8_t pad = a2;
     uint32_t cc;
 
-    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, ra);
+    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 1, ra);
+
+    set_length(env, r1 + 1, destlen);
+    set_length(env, r3 + 1, srclen);
+    set_address(env, r1, dest);
+    set_address(env, r3, src);
+
+    return cc;
+}
+
+/* move long unicode */
+uint32_t HELPER(mvclu)(CPUS390XState *env, uint32_t r1, uint64_t a2,
+                       uint32_t r3)
+{
+    uintptr_t ra = GETPC();
+    uint64_t destlen = get_length(env, r1 + 1);
+    uint64_t dest = get_address(env, r1);
+    uint64_t srclen = get_length(env, r3 + 1);
+    uint64_t src = get_address(env, r3);
+    uint16_t pad = a2;
+    uint32_t cc;
+
+    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 2, ra);
 
     set_length(env, r1 + 1, destlen);
     set_length(env, r3 + 1, srclen);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 892949a05f..b160a0cad7 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3043,6 +3043,27 @@ static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_mvclu(DisasContext *s, DisasOps *o)
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
+    gen_helper_mvclu(cc_op, cpu_env, t1, o->in2, t3);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t3);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_mvcp(DisasContext *s, DisasOps *o)
 {
-- 
2.11.0
