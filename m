Received: from eggs.gnu.org ([2001:4830:134:3::10]:46194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Q2-UB
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzp-0002zE-IQ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzp-0002yZ-FE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:38 -0400
Message-Id: <1523377186-32578-3-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 02/10] target/cris: avoid integer overflow in
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
Cc: Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/cris/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index f51a731..64b9ec6 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3091,7 +3091,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     unsigned int insn_len;
     struct DisasContext ctx;
     struct DisasContext *dc = &ctx;
-    uint32_t next_page_start;
+    uint32_t page_start;
     target_ulong npc;
     int num_insns;
     int max_insns;
@@ -3138,7 +3138,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     dc->cpustate_changed = 0;
 
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
@@ -3234,7 +3234,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     } while (!dc->is_jmp && !dc->cpustate_changed
             && !tcg_op_buf_full()
             && !singlestep
-            && (dc->pc < next_page_start)
+            && (dc->pc - page_start < TARGET_PAGE_SIZE)
             && num_insns < max_insns);
 
     if (dc->clear_locked_irq) {
-- 
2.7.4
