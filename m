Received: from eggs.gnu.org ([2001:4830:134:3::10]:38920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHe-0006UD-ER
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00075Q-Ho
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:54 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHa-00072l-5B
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:38 +0200
Message-Id: <20170529192440.5990-28-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 27/29] target/s390x: implement TEST DECIMAL
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
 target/s390x/insn-data.def |  3 +++
 target/s390x/mem_helper.c  | 23 +++++++++++++++++++++++
 target/s390x/translate.c   |  9 +++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index b2e269b6a5..c14268494e 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -88,6 +88,7 @@ DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(unpk, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(unpka, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_4(unpku, TCG_CALL_NO_WG, i32, env, i64, i32, i64)
+DEF_HELPER_FLAGS_3(tp, TCG_CALL_NO_WG, i32, env, i64, i32)
 DEF_HELPER_FLAGS_4(tr, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_4(tre, i64, env, i64, i64, i64)
 DEF_HELPER_4(trt, i32, env, i32, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 683f91bf7f..7f554ab133 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -856,6 +856,9 @@
     C(0xed11, TCDB,    RXE,   Z,   f1_o, a2, 0, 0, tcdb, 0)
     C(0xed12, TCXB,    RXE,   Z,   x1_o, a2, 0, 0, tcxb, 0)
 
+/* TEST DECIMAL */
+    C(0xebc0, TP,      RSL,   E2,  la1, 0, 0, 0, tp, 0)
+
 /* TEST UNDER MASK */
     C(0x9100, TM,      SI,    Z,   m1_8u, i2_8u, 0, 0, 0, tm32)
     C(0xeb51, TMY,     SIY,   LD,  m1_8u, i2_8u, 0, 0, 0, tm32)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 8063f42eb3..73a64bdda3 100644
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
index 747d4ebc10..a7c564fa93 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4313,6 +4313,15 @@ static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 
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
2.11.0
