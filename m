Received: from eggs.gnu.org ([2001:4830:134:3::10]:39940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDo-00050X-RP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDm-0007nW-BM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:48 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:45810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDm-0007mt-3x
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:46 -0400
Received: by mail-pg0-x22a.google.com with SMTP id z1-v6so1790113pgv.12
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:16 -0700
Message-Id: <20180628030330.15615-10-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 09/23] target/openrisc: Exit the TB after
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index db149986af..59605aacca 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -877,7 +877,22 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
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
+        if (dc->delayed_branch) {
+            tcg_gen_mov_tl(cpu_pc, jmp_pc);
+            tcg_gen_discard_tl(jmp_pc);
+        } else {
+            tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
+        }
+        dc->base.is_jmp = DISAS_EXIT;
+
+        ti = tcg_const_i32(a->k);
         gen_helper_mtspr(cpu_env, cpu_R[a->a], cpu_R[a->b], ti);
         tcg_temp_free_i32(ti);
     }
-- 
2.17.1
