Received: from eggs.gnu.org ([209.51.188.92]:46830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJu-0000st-Et
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJt-00020C-Ai
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:03:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:02:04 +0100
Message-Id: <20190304120210.31500-22-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/27] s390x/tcg: Check for exceptions in SET
 BFP ROUNDING MODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's split handling of BFP/DFP rounding mode configuration. Also,
let's not reuse the sfpc handler, use a separate handler so we can
properly check for specification exceptions for SRNMB.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218122710.23639-10-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/fpu_helper.c  | 11 ++++++++
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  6 ++--
 target/s390x/translate.c   | 56 ++++++++++++++++----------------------
 4 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 4dc70ec60f60..ed9c74c42004 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -819,3 +819,14 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
         tcg_s390_data_exception(env, s390_exc | 3, GETPC());
     }
 }
+
+/* set bfp rounding mode */
+void HELPER(srnm)(CPUS390XState *env, uint64_t rnd)
+{
+    if (rnd > 0x7 || fpc_to_rnd[rnd & 0x7] == -1) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
+    }
+
+    env->fpc = deposit32(env->fpc, 0, 3, rnd);
+    set_float_rounding_mode(fpc_to_rnd[rnd & 0x7], &env->fpu_status);
+}
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a99b067c9c50..d287d5dac093 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -106,6 +106,7 @@ DEF_HELPER_4(cksm, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_5(calc_cc, TCG_CALL_NO_RWG_SE, i32, env, i32, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sfpc, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_2(srnm, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f4f1d63ab44c..d80d168d4ef6 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -763,10 +763,10 @@
 /* SET FPC AND SIGNAL */
     F(0xb385, SFASR,   RRE,   IEEEE_SIM, 0, r1_o, 0, 0, sfas, 0, IF_DFP)
 /* SET BFP ROUNDING MODE */
-    F(0xb299, SRNM,    S,     Z,   0, 0, 0, 0, srnm, 0, IF_BFP)
-    F(0xb2b8, SRNMB,   S,     FPE, 0, 0, 0, 0, srnm, 0, IF_BFP)
+    F(0xb299, SRNM,    S,     Z,   la2, 0, 0, 0, srnm, 0, IF_BFP)
+    F(0xb2b8, SRNMB,   S,     FPE, la2, 0, 0, 0, srnmb, 0, IF_BFP)
 /* SET DFP ROUNDING MODE */
-    F(0xb2b9, SRNMT,   S,     DFPR, 0, 0, 0, 0, srnm, 0, IF_DFP)
+    F(0xb2b9, SRNMT,   S,     DFPR, la2, 0, 0, 0, srnmt, 0, IF_DFP)
 /* SET PROGRAM MASK */
     C(0x0400, SPM,     RR_a,  Z,   r1, 0, 0, 0, spm, 0)
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d9a89625c66c..80952a30f972 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3996,41 +3996,33 @@ static DisasJumpType op_sfas(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_srnm(DisasContext *s, DisasOps *o)
 {
-    int b2 = get_field(s->fields, b2);
-    int d2 = get_field(s->fields, d2);
-    TCGv_i64 t1 = tcg_temp_new_i64();
-    TCGv_i64 t2 = tcg_temp_new_i64();
-    int mask, pos, len;
+    /* Bits other than 62 and 63 are ignored. Bit 29 is set to zero. */
+    tcg_gen_andi_i64(o->addr1, o->addr1, 0x3ull);
+    gen_helper_srnm(cpu_env, o->addr1);
+    return DISAS_NEXT;
+}
 
-    switch (s->fields->op2) {
-    case 0x99: /* SRNM */
-        pos = 0, len = 2;
-        break;
-    case 0xb8: /* SRNMB */
-        pos = 0, len = 3;
-        break;
-    case 0xb9: /* SRNMT */
-        pos = 4, len = 3;
-        break;
-    default:
-        tcg_abort();
-    }
-    mask = (1 << len) - 1;
+static DisasJumpType op_srnmb(DisasContext *s, DisasOps *o)
+{
+    /* Bits 0-55 are are ignored. */
+    tcg_gen_andi_i64(o->addr1, o->addr1, 0xffull);
+    gen_helper_srnm(cpu_env, o->addr1);
+    return DISAS_NEXT;
+}
 
-    /* Insert the value into the appropriate field of the FPC.  */
-    if (b2 == 0) {
-        tcg_gen_movi_i64(t1, d2 & mask);
-    } else {
-        tcg_gen_addi_i64(t1, regs[b2], d2);
-        tcg_gen_andi_i64(t1, t1, mask);
-    }
-    tcg_gen_ld32u_i64(t2, cpu_env, offsetof(CPUS390XState, fpc));
-    tcg_gen_deposit_i64(t2, t2, t1, pos, len);
-    tcg_temp_free_i64(t1);
+static DisasJumpType op_srnmt(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
 
-    /* Then install the new FPC to set the rounding mode in fpu_status.  */
-    gen_helper_sfpc(cpu_env, t2);
-    tcg_temp_free_i64(t2);
+    /* Bits other than 61-63 are ignored. */
+    tcg_gen_andi_i64(o->addr1, o->addr1, 0x7ull);
+
+    /* No need to call a helper, we don't implement dfp */
+    tcg_gen_ld32u_i64(tmp, cpu_env, offsetof(CPUS390XState, fpc));
+    tcg_gen_deposit_i64(tmp, tmp, o->addr1, 4, 3);
+    tcg_gen_st32_i64(tmp, cpu_env, offsetof(CPUS390XState, fpc));
+
+    tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
 
-- 
2.17.2
