Received: from eggs.gnu.org ([2001:4830:134:3::10]:57727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQV-0008Rv-KJ
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQU-0004OD-RG
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:39 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMwQU-0004O4-Lq
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:38 -0400
Received: by mail-pg0-x242.google.com with SMTP id a13-v6so4191439pgu.4
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 07:13:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 27 May 2018 09:13:10 -0500
Message-Id: <20180527141324.11937-7-richard.henderson@linaro.org>
In-Reply-To: <20180527141324.11937-1-richard.henderson@linaro.org>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/20] target/openrisc: Exit the TB after
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
Cc: Stafford Horne <shorne@gmail.com>

A store to SR changes interrupt state, which should return
to the main loop to recognize that state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 61e6deef69..c7bfb395b0 100644
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
+            tcg_gen_exit_tb(0);
+        }
+        dc->base.is_jmp = DISAS_NORETURN;
     }
     return true;
 }
-- 
2.17.0
