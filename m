Received: from eggs.gnu.org ([2001:4830:134:3::10]:34485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu2-0003m0-Fq
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu0-0002QF-T4
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:50 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOu0-0002Pl-On
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:48 -0400
Received: by mail-qk0-x242.google.com with SMTP id d14so12249464qkb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:13 -0700
Message-Id: <20170607003119.14778-65-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 64/70] target/s390x: implement TEST DECIMAL
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
Message-Id: <20170531220129.27724-28-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  3 +++
 target/s390x/mem_helper.c  | 23 +++++++++++++++++++++++
 target/s390x/translate.c   |  9 +++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9d4bf64..5871568 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -91,6 +91,7 @@ DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(unpka, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_4(unpku, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
+DEF_HELPER_FLAGS_3(tp, TCG_CALL_NO_WG, i32, env, i64, i32)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
 DEF_HELPER_4(trt, i32, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 6aa0221..7db5133 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -852,6 +852,9 @@
     C(0xed11, TCDB,    RXE,   Z,   f1_o, a2, 0, 0, tcdb, 0)
     C(0xed12, TCXB,    RXE,   Z,   x1_o, a2, 0, 0, tcxb, 0)
 
+/* TEST DECIMAL */
+    C(0xebc0, TP,      RSL,   E2,  la1, 0, 0, 0, tp, 0)
+
 /* TEST UNDER MASK */
     C(0x9100, TM,      SI,    Z,   m1_8u, i2_8u, 0, 0, 0, tm32)
     C(0xeb51, TMY,     SIY,   LD,  m1_8u, i2_8u, 0, 0, 0, tm32)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 402147e..fa2bfbb 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1088,6 +1088,29 @@ uint32_t HELPER(unpku)(CPUS390XState *env, uint64_t dest, uint32_t destlen,
     return do_unpkau(env, dest, destlen, 2, src, GETPC());
 }
 
+uint32_t HELPER(tp)(CPUS390XState *env, uint64_t dest, uint32_t destlen)
+{
+    uintptr_t ra = GETPC();
+    uint32_t cc = 0;
+    int i;
+
+    for (i = 0; i < destlen; i++) {
+        uint8_t b = cpu_ldub_data_ra(env, dest + i, ra);
+        /* digit */
+        cc |= (b & 0xf0) > 0x90 ? 2 : 0;
+
+        if (i == (destlen - 1)) {
+            /* sign */
+            cc |= (b & 0xf) < 0xa ? 1 : 0;
+        } else {
+            /* digit */
+            cc |= (b & 0xf) > 0x9 ? 2 : 0;
+        }
+    }
+
+    return cc;
+}
+
 static uint32_t do_helper_tr(CPUS390XState *env, uint32_t len, uint64_t array,
                              uint64_t trans, uintptr_t ra)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index bba9ce8..2253ce6 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4305,6 +4305,15 @@ static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 
 #endif
 
+static ExitStatus op_tp(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 l1 = tcg_const_i32(get_field(s->fields, l1) + 1);
+    gen_helper_tp(cc_op, cpu_env, o->addr1, l1);
+    tcg_temp_free_i32(l1);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_tr(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-- 
2.9.4
