Received: from eggs.gnu.org ([2001:4830:134:3::10]:46193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Q1-Tc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzp-0002zZ-PV
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzp-0002z5-Lg
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:43 -0400
Message-Id: <1523377186-32578-8-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 07/10] target/microblaze: avoid integer
 overflow in next_page PC check
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
 target/microblaze/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7628b0e..401dbe6 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1637,7 +1637,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     uint32_t pc_start;
     struct DisasContext ctx;
     struct DisasContext *dc = &ctx;
-    uint32_t next_page_start, org_flags;
+    uint32_t page_start, org_flags;
     target_ulong npc;
     int num_insns;
     int max_insns;
@@ -1663,7 +1663,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         cpu_abort(cs, "Microblaze: unaligned PC=%x\n", pc_start);
     }
 
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
@@ -1749,7 +1749,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     } while (!dc->is_jmp && !dc->cpustate_changed
              && !tcg_op_buf_full()
              && !singlestep
-             && (dc->pc < next_page_start)
+             && (dc->pc - page_start < TARGET_PAGE_SIZE)
              && num_insns < max_insns);
 
     npc = dc->pc;
-- 
2.7.4
