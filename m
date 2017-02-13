Received: from eggs.gnu.org ([2001:4830:134:3::10]:45582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8v-00054T-Gw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8t-0001bV-JN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:41 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8t-0001bG-EN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:39 -0500
Received: by mail-qk0-x241.google.com with SMTP id u25so16698969qki.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:39 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:30 +1100
Message-Id: <20170213212536.31871-19-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 18/24] target/openrisc: Represent MACHI:MACLO as
 a single unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Significantly simplifies the implementation of the use of MAC.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.h        |   3 +-
 target/openrisc/machine.c    |   5 +-
 target/openrisc/sys_helper.c |  13 +++++
 target/openrisc/translate.c  | 120 +++++++++++++++++++++++--------------------
 4 files changed, 80 insertions(+), 61 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index e693461..9528277 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -277,8 +277,7 @@ typedef struct CPUOpenRISCState {
     target_ulong ppc;         /* Prev PC */
     target_ulong jmp_pc;      /* Jump PC */
 
-    target_ulong machi;       /* Multiply register MACHI */
-    target_ulong maclo;       /* Multiply register MACLO */
+    uint64_t mac;             /* Multiply registers MACHI:MACLO */
 
     target_ulong fpmaddhi;    /* Multiply and add float register FPMADDHI */
     target_ulong fpmaddlo;    /* Multiply and add float register FPMADDLO */
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index b723138..4100957 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -47,8 +47,8 @@ static const VMStateInfo vmstate_sr = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(gpr, CPUOpenRISCState, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
@@ -82,6 +82,7 @@ static const VMStateDescription vmstate_env = {
         VMSTATE_UINT32(immucfgr, CPUOpenRISCState),
         VMSTATE_UINT32(esr, CPUOpenRISCState),
         VMSTATE_UINT32(fpcsr, CPUOpenRISCState),
+        VMSTATE_UINT64(mac, CPUOpenRISCState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 4a59728..9841a5b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -120,6 +120,12 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(2, 1280) ... TO_SPR(2, 1407): /* ITLBW3MR 0-127 */
     case TO_SPR(2, 1408) ... TO_SPR(2, 1535): /* ITLBW3TR 0-127 */
         break;
+    case TO_SPR(5, 1):  /* MACLO */
+        env->mac = deposit64(env->mac, 0, 32, rb);
+        break;
+    case TO_SPR(5, 2):  /* MACHI */
+        env->mac = deposit64(env->mac, 32, 32, rb);
+        break;
     case TO_SPR(9, 0):  /* PICMR */
         env->picmr |= rb;
         break;
@@ -245,6 +251,13 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     case TO_SPR(2, 1408) ... TO_SPR(2, 1535): /* ITLBW3TR 0-127 */
         break;
 
+    case TO_SPR(5, 1):  /* MACLO */
+        return (uint32_t)env->mac;
+        break;
+    case TO_SPR(5, 2):  /* MACHI */
+        return env->mac >> 32;
+        break;
+
     case TO_SPR(9, 0):  /* PICMR */
         return env->picmr;
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index dd4ba8c..82b8bec 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -60,7 +60,7 @@ static TCGv cpu_sr_ov;          /* signed overflow */
 static TCGv cpu_lock_addr;
 static TCGv cpu_lock_value;
 static TCGv_i32 fpcsr;
-static TCGv machi, maclo;
+static TCGv_i64 cpu_mac;        /* MACHI:MACLO */
 static TCGv fpmaddhi, fpmaddlo;
 static TCGv_i32 env_flags;
 #include "exec/gen-icount.h"
@@ -105,12 +105,9 @@ void openrisc_translate_init(void)
     fpcsr = tcg_global_mem_new_i32(cpu_env,
                                    offsetof(CPUOpenRISCState, fpcsr),
                                    "fpcsr");
-    machi = tcg_global_mem_new(cpu_env,
-                               offsetof(CPUOpenRISCState, machi),
-                               "machi");
-    maclo = tcg_global_mem_new(cpu_env,
-                               offsetof(CPUOpenRISCState, maclo),
-                               "maclo");
+    cpu_mac = tcg_global_mem_new_i64(cpu_env,
+                                     offsetof(CPUOpenRISCState, mac),
+                                     "mac");
     fpmaddhi = tcg_global_mem_new(cpu_env,
                                   offsetof(CPUOpenRISCState, fpmaddhi),
                                   "fpmaddhi");
@@ -365,6 +362,58 @@ static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
     gen_ove_cy(dc);
 }
 
+static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_ext_tl_i64(t1, srca);
+    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_mul_i64(t1, t1, t2);
+
+    /* Note that overflow is only computed during addition stage.  */
+    tcg_gen_xor_i64(t2, cpu_mac, t1);
+    tcg_gen_add_i64(cpu_mac, cpu_mac, t1);
+    tcg_gen_xor_i64(t1, t1, cpu_mac);
+    tcg_gen_andc_i64(t1, t1, t2);
+    tcg_temp_free_i64(t2);
+
+#if TARGET_LONG_BITS == 32
+    tcg_gen_extrh_i64_i32(cpu_sr_ov, t1);
+#else
+    tcg_gen_mov_i64(cpu_sr_ov, t1);
+#endif
+    tcg_temp_free_i64(t1);
+
+    gen_ove_ov(dc);
+}
+
+static void gen_msb(DisasContext *dc, TCGv srca, TCGv srcb)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_ext_tl_i64(t1, srca);
+    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_mul_i64(t1, t1, t2);
+
+    /* Note that overflow is only computed during subtraction stage.  */
+    tcg_gen_xor_i64(t2, cpu_mac, t1);
+    tcg_gen_sub_i64(cpu_mac, cpu_mac, t1);
+    tcg_gen_xor_i64(t1, t1, cpu_mac);
+    tcg_gen_and_i64(t1, t1, t2);
+    tcg_temp_free_i64(t2);
+
+#if TARGET_LONG_BITS == 32
+    tcg_gen_extrh_i64_i32(cpu_sr_ov, t1);
+#else
+    tcg_gen_mov_i64(cpu_sr_ov, t1);
+#endif
+    tcg_temp_free_i64(t1);
+
+    gen_ove_ov(dc);
+}
+
 static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
 {
     TCGv ea = tcg_temp_new();
@@ -628,23 +677,9 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
 
     case 0x13:    /* l.maci */
         LOG_DIS("l.maci r%d, %d\n", ra, I16);
-        {
-            TCGv_i64 t1 = tcg_temp_new_i64();
-            TCGv_i64 t2 = tcg_temp_new_i64();
-            TCGv_i32 dst = tcg_temp_new_i32();
-            TCGv ttmp = tcg_const_tl(I16);
-            tcg_gen_mul_tl(dst, cpu_R[ra], ttmp);
-            tcg_gen_ext_i32_i64(t1, dst);
-            tcg_gen_concat_i32_i64(t2, maclo, machi);
-            tcg_gen_add_i64(t2, t2, t1);
-            tcg_gen_extrl_i64_i32(maclo, t2);
-            tcg_gen_shri_i64(t2, t2, 32);
-            tcg_gen_extrl_i64_i32(machi, t2);
-            tcg_temp_free_i32(dst);
-            tcg_temp_free(ttmp);
-            tcg_temp_free_i64(t1);
-            tcg_temp_free_i64(t2);
-        }
+        t0 = tcg_const_tl(I16);
+        gen_mac(dc, cpu_R[ra], t0);
+        tcg_temp_free(t0);
         break;
 
     case 0x09:    /* l.rfe */
@@ -873,40 +908,12 @@ static void dec_mac(DisasContext *dc, uint32_t insn)
     switch (op0) {
     case 0x0001:    /* l.mac */
         LOG_DIS("l.mac r%d, r%d\n", ra, rb);
-        {
-            TCGv_i32 t0 = tcg_temp_new_i32();
-            TCGv_i64 t1 = tcg_temp_new_i64();
-            TCGv_i64 t2 = tcg_temp_new_i64();
-            tcg_gen_mul_tl(t0, cpu_R[ra], cpu_R[rb]);
-            tcg_gen_ext_i32_i64(t1, t0);
-            tcg_gen_concat_i32_i64(t2, maclo, machi);
-            tcg_gen_add_i64(t2, t2, t1);
-            tcg_gen_extrl_i64_i32(maclo, t2);
-            tcg_gen_shri_i64(t2, t2, 32);
-            tcg_gen_extrl_i64_i32(machi, t2);
-            tcg_temp_free_i32(t0);
-            tcg_temp_free_i64(t1);
-            tcg_temp_free_i64(t2);
-        }
+        gen_mac(dc, cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x0002:    /* l.msb */
         LOG_DIS("l.msb r%d, r%d\n", ra, rb);
-        {
-            TCGv_i32 t0 = tcg_temp_new_i32();
-            TCGv_i64 t1 = tcg_temp_new_i64();
-            TCGv_i64 t2 = tcg_temp_new_i64();
-            tcg_gen_mul_tl(t0, cpu_R[ra], cpu_R[rb]);
-            tcg_gen_ext_i32_i64(t1, t0);
-            tcg_gen_concat_i32_i64(t2, maclo, machi);
-            tcg_gen_sub_i64(t2, t2, t1);
-            tcg_gen_extrl_i64_i32(maclo, t2);
-            tcg_gen_shri_i64(t2, t2, 32);
-            tcg_gen_extrl_i64_i32(machi, t2);
-            tcg_temp_free_i32(t0);
-            tcg_temp_free_i64(t1);
-            tcg_temp_free_i64(t2);
-        }
+        gen_msb(dc, cpu_R[ra], cpu_R[rb]);
         break;
 
     default:
@@ -969,9 +976,8 @@ static void dec_M(DisasContext *dc, uint32_t insn)
 
     case 0x1:    /* l.macrc */
         LOG_DIS("l.macrc  r%d\n", rd);
-        tcg_gen_mov_tl(cpu_R[rd], maclo);
-        tcg_gen_movi_tl(maclo, 0x0);
-        tcg_gen_movi_tl(machi, 0x0);
+        tcg_gen_trunc_i64_tl(cpu_R[rd], cpu_mac);
+        tcg_gen_movi_i64(cpu_mac, 0);
         break;
 
     default:
-- 
2.9.3
