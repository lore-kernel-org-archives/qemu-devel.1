Received: from eggs.gnu.org ([2001:4830:134:3::10]:46188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Py-Tb
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzq-000307-1x
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzp-0002yh-Tr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:40 -0400
Message-Id: <1523377186-32578-5-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 04/10] target/xtensa: avoid integer overflow in
 next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/xtensa/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f6d030..aad4963 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1061,8 +1061,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     int insn_count = 0;
     int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     uint32_t pc_start = tb->pc;
-    uint32_t next_page_start =
-        (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    uint32_t page_start = pc_start & TARGET_PAGE_MASK;
 
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -1162,9 +1161,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         }
     } while (dc.is_jmp == DISAS_NEXT &&
             insn_count < max_insns &&
-            dc.pc < next_page_start &&
-            dc.pc + xtensa_insn_len(env, &dc) <= next_page_start &&
-            !tcg_op_buf_full());
+            dc.pc - page_start < TARGET_PAGE_SIZE &&
+            dc.pc - page_start + xtensa_insn_len(env, &dc) <= TARGET_PAGE_SIZE
+            && !tcg_op_buf_full());
 done:
     reset_sar_tracker(&dc);
     if (dc.icount) {
-- 
2.7.4
