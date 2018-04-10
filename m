Received: from eggs.gnu.org ([2001:4830:134:3::10]:46186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Pw-Se
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzp-0002ze-Po
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzp-0002yw-Lh
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:42 -0400
Message-Id: <1523377186-32578-7-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 06/10] target/tilegx: avoid integer overflow in
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
Cc: Richard Henderson <richard.henderson@linaro.org>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/tilegx/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index d63bf5b..6c53c5e 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2375,7 +2375,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     DisasContext ctx;
     DisasContext *dc = &ctx;
     uint64_t pc_start = tb->pc;
-    uint64_t next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    uint64_t page_start = pc_start & TARGET_PAGE_MASK;
     int num_insns = 0;
     int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
 
@@ -2415,7 +2415,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         }
         dc->pc += TILEGX_BUNDLE_SIZE_IN_BYTES;
         if (num_insns >= max_insns
-            || dc->pc >= next_page_start
+            || (dc->pc - page_start >= TARGET_PAGE_SIZE)
             || tcg_op_buf_full()) {
             /* Ending the TB due to TB size or page boundary.  Set PC.  */
             tcg_gen_movi_tl(cpu_pc, dc->pc);
-- 
2.7.4
