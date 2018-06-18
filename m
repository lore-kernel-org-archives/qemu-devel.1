Received: from eggs.gnu.org ([2001:4830:134:3::10]:57318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5N-0003OV-MQ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5L-0004dq-6F
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:05 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5L-0004cu-0P
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:03 -0400
Received: by mail-pl0-x241.google.com with SMTP id w17-v6so9497071pll.9
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:30 -1000
Message-Id: <20180618184046.6270-7-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 06/22] target/openrisc: Exit the TB after
 l.mtspr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

A store to SR changes interrupt state, which should return
to the main loop to recognize that state.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 16e69c75fa..6a7eb4a3e8 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -940,9 +940,31 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        TCGv_i32 ti = tcg_const_i32(a->k);
+        TCGv_i32 ti;
+
+        /* For SR, we will need to exit the TB to recognize the new
+         * exception state.  For NPC, in theory this counts as a branch
+         * (although the SPR only exists for use by an ICE).  Save all
+         * of the cpu state first, allowing it to be overwritten.
+         */
+        if (dc->tb_flags & TB_FLAGS_DFLAG) {
+            tcg_gen_movi_i32(cpu_dflag, 0);
+        }
+        tcg_gen_movi_tl(cpu_ppc, dc->base.pc_next);
+        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
+
+        ti = tcg_const_i32(a->k);
         gen_helper_mtspr(cpu_env, cpu_R[a->a], cpu_R[a->b], ti);
         tcg_temp_free_i32(ti);
+
+        /* For PPC, we want the value that was just written and not
+           the generic update that we'd get from DISAS_EXIT.  */
+        if (unlikely(dc->base.singlestep_enabled)) {
+            gen_exception(dc, EXCP_DEBUG);
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
+        dc->base.is_jmp = DISAS_NORETURN;
     }
     return true;
 }
-- 
2.17.1
