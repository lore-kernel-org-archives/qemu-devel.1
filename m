Received: from eggs.gnu.org ([2001:4830:134:3::10]:32855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUavi-0006g9-Sh
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUavf-00048d-QB
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:48:58 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUavf-00048A-Jo
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:48:55 -0400
Received: by mail-wr0-f170.google.com with SMTP id r103so144219685wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:48:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 16:47:45 +0100
Message-Id: <20170710154749.13624-3-alex.bennee@linaro.org>
In-Reply-To: <20170710154749.13624-1-alex.bennee@linaro.org>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/6] target/arm/translate.c: make
 DISAS_UPDATE match declared semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

DISAS_UPDATE should be used when the wider CPU state other than just
the PC has been updated and we should therefor exit the TCG runtime
and return to the main execution loop rather assuming DISAS_JUMP would
do that.

As some DISAS_UPDATE users may update the PC dynamically via a helper
we also push the updating to the PC to hhe call sites which set
->is_jmp to DISAS_UPDATE.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0862f9e4aa..f9c4aee1b6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4430,6 +4430,7 @@ static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_reg);
+    gen_set_pc_im(s, s->pc);
     s->is_jmp = DISAS_UPDATE;
 }
 
@@ -4452,6 +4453,7 @@ static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     store_reg(s, rn, tcg_reg);
+    gen_set_pc_im(s, s->pc);
     s->is_jmp = DISAS_UPDATE;
 }
 
@@ -8058,6 +8060,7 @@ static void gen_srs(DisasContext *s,
         tcg_temp_free_i32(tmp);
     }
     tcg_temp_free_i32(addr);
+    gen_set_pc_im(s, s->pc);
     s->is_jmp = DISAS_UPDATE;
 }
 
@@ -8146,6 +8149,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* setend */
             if (((insn >> 9) & 1) != !!(s->be_data == MO_BE)) {
                 gen_helper_setend(cpu_env);
+                gen_set_pc_im(s, s->pc);
                 s->is_jmp = DISAS_UPDATE;
             }
             return;
@@ -11619,6 +11623,7 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
                 ARCH(6);
                 if (((insn >> 3) & 1) != !!(s->be_data == MO_BE)) {
                     gen_helper_setend(cpu_env);
+                    gen_set_pc_im(s, s->pc);
                     s->is_jmp = DISAS_UPDATE;
                 }
                 break;
@@ -12076,7 +12081,6 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             break;
         case DISAS_NEXT:
         case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
             /* fall through */
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
@@ -12095,12 +12099,11 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
         case DISAS_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
-        case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
-            /* fall through */
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
+        case DISAS_UPDATE:
+            /* fall through */
         default:
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(0);
-- 
2.13.0
