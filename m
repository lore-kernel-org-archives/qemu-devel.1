Received: from eggs.gnu.org ([209.51.188.92]:52672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv4-00008i-DM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv3-0004jn-Be
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:22 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:34736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzuz-0004aA-GX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:19 -0500
Received: by mail-pl1-x632.google.com with SMTP id w4so2573439plz.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:10 +1000
Message-Id: <20190108223129.5570-13-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 12/31] target/arm: Rearrange decode in
 disas_uncond_b_reg
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

This will enable PAuth decode in a subsequent patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 47 +++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2df2323646..e601753032 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1989,32 +1989,54 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
     rn = extract32(insn, 5, 5);
     op4 = extract32(insn, 0, 5);
 
-    if (op4 != 0x0 || op3 != 0x0 || op2 != 0x1f) {
-        unallocated_encoding(s);
-        return;
+    if (op2 != 0x1f) {
+        goto do_unallocated;
     }
 
     switch (opc) {
     case 0: /* BR */
     case 1: /* BLR */
     case 2: /* RET */
-        gen_a64_set_pc(s, cpu_reg(s, rn));
+        switch (op3) {
+        case 0:
+            if (op4 != 0) {
+                goto do_unallocated;
+            }
+            dst = cpu_reg(s, rn);
+            break;
+
+        default:
+            goto do_unallocated;
+        }
+
+        gen_a64_set_pc(s, dst);
         /* BLR also needs to load return address */
         if (opc == 1) {
             tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
         }
         break;
+
     case 4: /* ERET */
         if (s->current_el == 0) {
-            unallocated_encoding(s);
-            return;
+            goto do_unallocated;
+        }
+        switch (op3) {
+        case 0:
+            if (op4 != 0) {
+                goto do_unallocated;
+            }
+            dst = tcg_temp_new_i64();
+            tcg_gen_ld_i64(dst, cpu_env,
+                           offsetof(CPUARMState, elr_el[s->current_el]));
+            break;
+
+        default:
+            goto do_unallocated;
         }
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
-        dst = tcg_temp_new_i64();
-        tcg_gen_ld_i64(dst, cpu_env,
-                       offsetof(CPUARMState, elr_el[s->current_el]));
+
         gen_helper_exception_return(cpu_env, dst);
         tcg_temp_free_i64(dst);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -2023,14 +2045,17 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         /* Must exit loop to check un-masked IRQs */
         s->base.is_jmp = DISAS_EXIT;
         return;
+
     case 5: /* DRPS */
-        if (rn != 0x1f) {
-            unallocated_encoding(s);
+        if (op3 != 0 || op4 != 0 || rn != 0x1f) {
+            goto do_unallocated;
         } else {
             unsupported_encoding(s, insn);
         }
         return;
+
     default:
+    do_unallocated:
         unallocated_encoding(s);
         return;
     }
-- 
2.17.2
