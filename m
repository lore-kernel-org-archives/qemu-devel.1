Received: from eggs.gnu.org ([2001:4830:134:3::10]:46184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Pu-S7
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzp-0002zT-Ok
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzp-0002yx-Kp
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:41 -0400
Message-Id: <1523377186-32578-6-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 05/10] target/unicore32: avoid integer overflow
 in next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/unicore32/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 5b51f21..abe2ea8 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1875,7 +1875,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     CPUUniCore32State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     target_ulong pc_start;
-    uint32_t next_page_start;
+    uint32_t page_start;
     int num_insns;
     int max_insns;
 
@@ -1894,7 +1894,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     cpu_F1s = tcg_temp_new_i32();
     cpu_F0d = tcg_temp_new_i64();
     cpu_F1d = tcg_temp_new_i64();
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
@@ -1951,7 +1951,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     } while (!dc->is_jmp && !tcg_op_buf_full() &&
              !cs->singlestep_enabled &&
              !singlestep &&
-             dc->pc < next_page_start &&
+             dc->pc - page_start < TARGET_PAGE_SIZE &&
              num_insns < max_insns);
 
     if (tb_cflags(tb) & CF_LAST_IO) {
-- 
2.7.4
