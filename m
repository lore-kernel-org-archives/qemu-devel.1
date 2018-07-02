Received: from eggs.gnu.org ([2001:4830:134:3::10]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tr-00047K-7P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tm-0007tH-AD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:07 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0Tm-0007sn-4E
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:02 -0400
Received: by mail-pl0-x242.google.com with SMTP id w8-v6so8106837ply.8
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:02 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:07 +0900
Message-Id: <20180702151023.24532-10-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 09/25] target/openrisc: Exit the TB after
 l.mtspr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

A store to SR changes interrupt state, which should return
to the main loop to recognize that state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
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
2.17.0
