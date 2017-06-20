Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6ef-0003a3-L7
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6ee-0001zx-KO
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:25 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6ee-0001zg-EU
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:24 -0400
Received: by mail-pg0-x242.google.com with SMTP id u62so12966871pgb.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 17:04:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 17:04:02 -0700
Message-Id: <20170620000405.3391-16-rth@twiddle.net>
In-Reply-To: <20170620000405.3391-1-rth@twiddle.net>
References: <20170620000405.3391-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 15/18] target/s390x: Implement SRSTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  8 ++++++++
 4 files changed, 55 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index cd51b89..58d7f5b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -13,6 +13,7 @@ DEF_HELPER_FLAGS_3(divu32, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(divs64, TCG_CALL_NO_WG, s64, env, s64, s64)
 DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_3(srst, i64, env, i64, i64)
+DEF_HELPER_3(srstu, i64, env, i64, i64)
 DEF_HELPER_4(clst, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 634ef98..1bebcf2 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -736,6 +736,8 @@
 
 /* SEARCH STRING */
     C(0xb25e, SRST,    RRE,   Z,   r1_o, r2_o, 0, 0, srst, 0)
+/* SEARCH STRING UNICODE */
+    C(0xb9be, SRSTU,   RRE,   ETF3, r1_o, r2_o, 0, 0, srstu, 0)
 
 /* SET ACCESS */
     C(0xb24e, SAR,     RRE,   Z,   0, r2_o, 0, 0, sar, 0)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 990858e..ce288d9 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -578,6 +578,50 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t end, uint64_t str)
     return end;
 }
 
+uint64_t HELPER(srstu)(CPUS390XState *env, uint64_t end, uint64_t str)
+{
+    uintptr_t ra = GETPC();
+    uint32_t len;
+    uint16_t v, c = env->regs[0];
+    uint64_t adj_end;
+
+    /* Bits 32-47 of R0 must be zero.  */
+    if (env->regs[0] & 0xffff0000u) {
+        cpu_restore_state(ENV_GET_CPU(env), ra);
+        program_interrupt(env, PGM_SPECIFICATION, 6);
+    }
+
+    str = wrap_address(env, str);
+    end = wrap_address(env, end);
+
+    /* If the LSB of the two addresses differ, use one extra byte.  */
+    adj_end = end + ((str ^ end) & 1);
+
+    /* Assume for now that R2 is unmodified.  */
+    env->retxl = str;
+
+    /* Lest we fail to service interrupts in a timely manner, limit the
+       amount of work we're willing to do.  For now, let's cap at 8k.  */
+    for (len = 0; len < 0x2000; len += 2) {
+        if (str + len == adj_end) {
+            /* End of input found.  */
+            env->cc_op = 2;
+            return end;
+        }
+        v = cpu_lduw_data_ra(env, str + len, ra);
+        if (v == c) {
+            /* Character found.  Set R1 to the location; R2 is unmodified.  */
+            env->cc_op = 1;
+            return str + len;
+        }
+    }
+
+    /* CPU-determined bytes processed.  Advance R2 to next byte to process.  */
+    env->retxl = str + len;
+    env->cc_op = 3;
+    return end;
+}
+
 /* unsigned string compare (c is string terminator) */
 uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4a860f1..e594b91 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4262,6 +4262,14 @@ static ExitStatus op_srst(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_srstu(DisasContext *s, DisasOps *o)
+{
+    gen_helper_srstu(o->in1, cpu_env, o->in1, o->in2);
+    set_cc_static(s);
+    return_low128(o->in2);
+    return NO_EXIT;
+}
+
 static ExitStatus op_sub(DisasContext *s, DisasOps *o)
 {
     tcg_gen_sub_i64(o->out, o->in1, o->in2);
-- 
2.9.4
