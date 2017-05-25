Received: from eggs.gnu.org ([2001:4830:134:3::10]:55284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwd-0005g6-Hq
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwa-0001Lv-GV
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:19 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwa-0001Ki-9H
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:05:01 +0200
Message-Id: <20170525210508.4910-20-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 19/26] target/s390x: implement MOVE LONG UNICODE
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
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 47 ++++++++++++++++++++++++++++++++++++++++------
 target/s390x/translate.c   | 11 +++++++++++
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 1b82d1a368..40b7544c4d 100644
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
index f9e69f9b09..ceaa245530 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -576,6 +576,8 @@
     C(0x0e00, MVCL,    RR_a,  Z,   0, 0, 0, 0, mvcl, 0)
 /* MOVE LONG EXTENDED */
     C(0xa800, MVCLE,   RS_a,  Z,   0, a2, 0, 0, mvcle, 0)
+/* MOVE LONG UNICODE */
+    C(0xeb8e, MVCLU,   RSY_a, E2,  0, a2, 0, 0, mvclu, 0)
 /* MOVE NUMERICS */
     C(0xd100, MVN,     SS_a,  Z,   la1, a2, 0, 0, mvn, 0)
 /* MOVE PAGE */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7ce7daaf11..134dde03c2 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -651,7 +651,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 static inline uint32_t do_mvcl(CPUS390XState *env,
                                uint64_t *dest, uint64_t *destlen,
                                uint64_t *src, uint64_t *srclen,
-                               uint8_t pad, uintptr_t ra)
+                               uint16_t pad, int wordsize, uintptr_t ra)
 {
     uint64_t len = MIN(*srclen, *destlen);
     uint32_t cc;
@@ -672,9 +672,22 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
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
+	    *dest += 1;
+	    *destlen -= 1;
+        }
+        /* The remaining length is even, pad using words.  */
+        for (; *destlen; *dest += 2, *destlen -= 2) {
+            cpu_stw_data_ra(env, *dest, pad, ra);
+        }
+    }
 
     return cc;
 }
@@ -690,7 +703,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     uint8_t pad = env->regs[r2 + 1] >> 24;
     uint32_t cc;
 
-    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, ra);
+    cc = do_mvcl(env, &dest, &destlen, &src, &srclen, pad, 1, ra);
 
     env->regs[r1 + 1] = deposit64(env->regs[r1 + 1], 0, 24, destlen);
     env->regs[r2 + 1] = deposit64(env->regs[r2 + 1], 0, 24, srclen);
@@ -712,7 +725,29 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
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
index 2ea96c0a8f..4ecda97997 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2978,6 +2978,17 @@ static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_mvclu(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
+    gen_helper_mvclu(cc_op, cpu_env, r1, o->in2, r3);
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r3);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_mvcp(DisasContext *s, DisasOps *o)
 {
-- 
2.11.0
