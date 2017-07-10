Received: from eggs.gnu.org ([2001:4830:134:3::10]:35168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfZq-0002cT-Th
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfZn-00058d-PH
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:42 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUfZn-00058V-JO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:39 -0400
Received: by mail-qk0-f194.google.com with SMTP id 16so14398958qkg.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 13:46:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 10 Jul 2017 10:45:16 -1000
Message-Id: <20170710204521.2058-4-rth@twiddle.net>
In-Reply-To: <20170710204521.2058-1-rth@twiddle.net>
References: <20170710204521.2058-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 3/8] target/s390x: Tidy SRST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, david@redhat.com

Since we require all registers saved on input, read R0 from ENV instead
of passing it manually.  Recognize the specification exception when R0
contains incorrect data.  Keep high bits of result registers unmodified
when in 31 or 24-bit mode.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  2 +-
 target/s390x/mem_helper.c  | 25 ++++++++++++++-----------
 target/s390x/translate.c   |  9 +++++++--
 target/s390x/insn-data.def |  2 +-
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 2793cf3..a2e5b9b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -12,7 +12,7 @@ DEF_HELPER_FLAGS_3(divs32, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_3(divu32, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(divs64, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
-DEF_HELPER_4(srst, i64, env, i64, i64, i64)
+DEF_HELPER_3(srst, void, env, i32, i32)
 DEF_HELPER_4(clst, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 0b18560..74b48aa 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -538,18 +538,21 @@ static inline void set_length(CPUS390XState *env, int reg, uint64_t length)
 }
 
 /* search string (c is byte to search, r2 is string, r1 end of string) */
-uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
-                      uint64_t str)
+void HELPER(srst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
     uintptr_t ra = GETPC();
+    uint64_t end, str;
     uint32_t len;
-    uint8_t v, c = r0;
+    uint8_t v, c = env->regs[0];
 
-    str = wrap_address(env, str);
-    end = wrap_address(env, end);
+    /* Bits 32-55 must contain all 0.  */
+    if (env->regs[0] & 0xffffff00u) {
+        cpu_restore_state(ENV_GET_CPU(env), ra);
+        program_interrupt(env, PGM_SPECIFICATION, 6);
+    }
 
-    /* Assume for now that R2 is unmodified.  */
-    env->retxl = str;
+    str = get_address(env, r2);
+    end = get_address(env, r1);
 
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
@@ -557,20 +560,20 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
         if (str + len == end) {
             /* Character not found.  R1 & R2 are unmodified.  */
             env->cc_op = 2;
-            return end;
+            return;
         }
         v = cpu_ldub_data_ra(env, str + len, ra);
         if (v == c) {
             /* Character found.  Set R1 to the location; R2 is unmodified.  */
             env->cc_op = 1;
-            return str + len;
+            set_address(env, r1, str + len);
+            return;
         }
     }
 
     /* CPU-determined bytes processed.  Advance R2 to next byte to process.  */
-    env->retxl = str + len;
     env->cc_op = 3;
-    return end;
+    set_address(env, r2, str + len);
 }
 
 /* unsigned string compare (c is string terminator) */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 339b31e..ba22e3d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4279,9 +4279,14 @@ static ExitStatus op_stpq(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_srst(DisasContext *s, DisasOps *o)
 {
-    gen_helper_srst(o->in1, cpu_env, regs[0], o->in1, o->in2);
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+
+    gen_helper_srst(cpu_env, r1, r2);
+
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r2);
     set_cc_static(s);
-    return_low128(o->in2);
     return NO_EXIT;
 }
 
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 323a301..bc6ff01 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -736,7 +736,7 @@
     C(0xec57, RXSBG,   RIE_f, GIE, 0, r2, r1, 0, rosbg, 0)
 
 /* SEARCH STRING */
-    C(0xb25e, SRST,    RRE,   Z,   r1_o, r2_o, 0, 0, srst, 0)
+    C(0xb25e, SRST,    RRE,   Z,   0, 0, 0, 0, srst, 0)
 
 /* SET ACCESS */
     C(0xb24e, SAR,     RRE,   Z,   0, r2_o, 0, 0, sar, 0)
-- 
2.9.4
