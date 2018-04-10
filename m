Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzu-0007Qy-AP
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzq-00030D-5R
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzq-0002zo-21
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:46 -0400
Message-Id: <1523377186-32578-11-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 10/10] target/mips: avoid integer overflow in
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d05ee67..d8e717d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20202,14 +20202,14 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     CPUMIPSState *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
-    target_ulong next_page_start;
+    target_ulong page_start;
     int num_insns;
     int max_insns;
     int insn_bytes;
     int is_slot;
 
     pc_start = tb->pc;
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     ctx.pc = pc_start;
     ctx.saved_pc = -1;
     ctx.singlestep_enabled = cs->singlestep_enabled;
@@ -20320,7 +20320,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
 
-        if (ctx.pc >= next_page_start) {
+        if (ctx.pc - page_start >= TARGET_PAGE_SIZE) {
             break;
         }
 
-- 
2.7.4
