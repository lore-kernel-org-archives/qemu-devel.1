Received: from eggs.gnu.org ([2001:4830:134:3::10]:35182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfZs-0002dz-G8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfZp-00058z-Bi
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUfZp-00058t-7M
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:41 -0400
Received: by mail-qt0-f196.google.com with SMTP id w12so14184670qta.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 13:46:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 10 Jul 2017 10:45:17 -1000
Message-Id: <20170710204521.2058-5-rth@twiddle.net>
In-Reply-To: <20170710204521.2058-1-rth@twiddle.net>
References: <20170710204521.2058-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 4/8] target/s390x: Implement SRSTU
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

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/mem_helper.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 13 +++++++++++++
 target/s390x/insn-data.def |  2 ++
 4 files changed, 57 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a2e5b9b..32314e0 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -13,6 +13,7 @@ DEF_HELPER_FLAGS_3(divu32, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(divs64, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_3(srst, void, env, i32, i32)
+DEF_HELPER_3(srstu, void, env, i32, i32)
 DEF_HELPER_4(clst, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 74b48aa..e3db68d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -576,6 +576,47 @@ void HELPER(srst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
     set_address(env, r2, str + len);
 }
 
+void HELPER(srstu)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+{
+    uintptr_t ra = GETPC();
+    uint32_t len;
+    uint16_t v, c = env->regs[0];
+    uint64_t end, str, adj_end;
+
+    /* Bits 32-47 of R0 must be zero.  */
+    if (env->regs[0] & 0xffff0000u) {
+        cpu_restore_state(ENV_GET_CPU(env), ra);
+        program_interrupt(env, PGM_SPECIFICATION, 6);
+    }
+
+    str = get_address(env, r2);
+    end = get_address(env, r1);
+
+    /* If the LSB of the two addresses differ, use one extra byte.  */
+    adj_end = end + ((str ^ end) & 1);
+
+    /* Lest we fail to service interrupts in a timely manner, limit the
+       amount of work we're willing to do.  For now, let's cap at 8k.  */
+    for (len = 0; len < 0x2000; len += 2) {
+        if (str + len == adj_end) {
+            /* End of input found.  */
+            env->cc_op = 2;
+            return;
+        }
+        v = cpu_lduw_data_ra(env, str + len, ra);
+        if (v == c) {
+            /* Character found.  Set R1 to the location; R2 is unmodified.  */
+            env->cc_op = 1;
+            set_address(env, r1, str + len);
+            return;
+        }
+    }
+
+    /* CPU-determined bytes processed.  Advance R2 to next byte to process.  */
+    env->cc_op = 3;
+    set_address(env, r2, str + len);
+}
+
 /* unsigned string compare (c is string terminator) */
 uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ba22e3d..57e6909 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4290,6 +4290,19 @@ static ExitStatus op_srst(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_srstu(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+
+    gen_helper_srstu(cpu_env, r1, r2);
+
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_sub(DisasContext *s, DisasOps *o)
 {
     tcg_gen_sub_i64(o->out, o->in1, o->in2);
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index bc6ff01..1d34df03 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -737,6 +737,8 @@
 
 /* SEARCH STRING */
     C(0xb25e, SRST,    RRE,   Z,   0, 0, 0, 0, srst, 0)
+/* SEARCH STRING UNICODE */
+    C(0xb9be, SRSTU,   RRE,   ETF3, 0, 0, 0, 0, srstu, 0)
 
 /* SET ACCESS */
     C(0xb24e, SAR,     RRE,   Z,   0, r2_o, 0, 0, sar, 0)
-- 
2.9.4
