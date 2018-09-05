Received: from eggs.gnu.org ([2001:4830:134:3::10]:57966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsG-000691-VX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsB-00072n-FJ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:49 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:37045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMs5-0006vx-V4
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:43 -0400
Received: by mail-lf1-x12c.google.com with SMTP id j8-v6so4584663lfb.4
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:41 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:46 -0700
Message-Id: <20180905014352.970-10-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 09/15] target/xtensa: extract test for division
 by zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

- mark quos/quou/rems/remu instructions;
- drop parameter 0 from the translate_quou and split translate_remu from
  it;
- put test for division by zero exception right after the coprocessor
  exception test;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 53 +++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index eb123f68b364..f8b9f65f7102 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -933,6 +933,15 @@ static TCGv_i32 gen_mac16_m(TCGv_i32 v, bool hi, bool is_unsigned)
     return m;
 }
 
+static void gen_zero_check(DisasContext *dc, const uint32_t arg[])
+{
+    TCGLabel *label = gen_new_label();
+
+    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0, label);
+    gen_exception_cause(dc, INTEGER_DIVIDE_BY_ZERO_CAUSE);
+    gen_set_label(label);
+}
+
 static inline unsigned xtensa_op0_insn_len(DisasContext *dc, uint8_t op0)
 {
     return xtensa_isa_length_from_chars(dc->config->isa, &op0);
@@ -1092,6 +1101,14 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         return;
     }
 
+    if (op_flags & XTENSA_OP_DIVIDE_BY_ZERO) {
+        for (slot = 0; slot < slots; ++slot) {
+            if (slot_prop[slot].ops->op_flags & XTENSA_OP_DIVIDE_BY_ZERO) {
+                gen_zero_check(dc, slot_prop[slot].arg);
+            }
+        }
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -2013,23 +2030,12 @@ static void translate_ptlb(DisasContext *dc, const uint32_t arg[],
 #endif
 }
 
-static void gen_zero_check(DisasContext *dc, const uint32_t arg[])
-{
-    TCGLabel *label = gen_new_label();
-
-    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0, label);
-    gen_exception_cause(dc, INTEGER_DIVIDE_BY_ZERO_CAUSE);
-    gen_set_label(label);
-}
-
 static void translate_quos(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
     TCGLabel *label1 = gen_new_label();
     TCGLabel *label2 = gen_new_label();
 
-    gen_zero_check(dc, arg);
-
     tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[1]], 0x80000000,
                         label1);
     tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[arg[2]], 0xffffffff,
@@ -2051,14 +2057,8 @@ static void translate_quos(DisasContext *dc, const uint32_t arg[],
 static void translate_quou(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
-    gen_zero_check(dc, arg);
-    if (par[0]) {
-        tcg_gen_divu_i32(cpu_R[arg[0]],
-                         cpu_R[arg[1]], cpu_R[arg[2]]);
-    } else {
-        tcg_gen_remu_i32(cpu_R[arg[0]],
-                         cpu_R[arg[1]], cpu_R[arg[2]]);
-    }
+    tcg_gen_divu_i32(cpu_R[arg[0]],
+                     cpu_R[arg[1]], cpu_R[arg[2]]);
 }
 
 static void translate_read_impwire(DisasContext *dc, const uint32_t arg[],
@@ -2068,6 +2068,13 @@ static void translate_read_impwire(DisasContext *dc, const uint32_t arg[],
     tcg_gen_movi_i32(cpu_R[arg[0]], 0);
 }
 
+static void translate_remu(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    tcg_gen_remu_i32(cpu_R[arg[0]],
+                     cpu_R[arg[1]], cpu_R[arg[2]]);
+}
+
 static void translate_rer(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
@@ -3457,11 +3464,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "quos",
         .translate = translate_quos,
         .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
         .windowed_register_op = 0x7,
     }, {
         .name = "quou",
         .translate = translate_quou,
-        .par = (const uint32_t[]){true},
+        .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
         .windowed_register_op = 0x7,
     }, {
         .name = "rdtlb0",
@@ -3483,11 +3491,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rems",
         .translate = translate_quos,
         .par = (const uint32_t[]){false},
+        .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
         .windowed_register_op = 0x7,
     }, {
         .name = "remu",
-        .translate = translate_quou,
-        .par = (const uint32_t[]){false},
+        .translate = translate_remu,
+        .op_flags = XTENSA_OP_DIVIDE_BY_ZERO,
         .windowed_register_op = 0x7,
     }, {
         .name = "rer",
-- 
2.11.0
