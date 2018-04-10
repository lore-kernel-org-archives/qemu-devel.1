Received: from eggs.gnu.org ([2001:4830:134:3::10]:46180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Po-RP
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzp-0002z0-Ea
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzp-0002yW-9l
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:37 -0400
Message-Id: <1523377186-32578-2-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 01/10] target/riscv: avoid integer overflow in
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 808eab7..d2d2e5e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1849,11 +1849,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     CPURISCVState *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
-    target_ulong next_page_start;
+    target_ulong page_start;
     int num_insns;
     int max_insns;
     pc_start = tb->pc;
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     ctx.pc = pc_start;
 
     /* once we have GDB, the rest of the translate.c implementation should be
@@ -1903,7 +1903,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         if (cs->singlestep_enabled) {
             break;
         }
-        if (ctx.pc >= next_page_start) {
+        if (ctx.pc - page_start >= TARGET_PAGE_SIZE) {
             break;
         }
         if (tcg_op_buf_full()) {
-- 
2.7.4
