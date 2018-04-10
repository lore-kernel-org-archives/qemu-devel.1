Received: from eggs.gnu.org ([2001:4830:134:3::10]:46190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzs-0007Pz-TJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f5vzp-0002zj-R6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f5vzp-0002zA-M5
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:19:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 10 Apr 2018 12:19:44 -0400
Message-Id: <1523377186-32578-9-git-send-email-cota@braap.org>
In-Reply-To: <1523377186-32578-1-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 08/10] target/arm: avoid integer overflow in
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate.h |  2 +-
 target/arm/translate.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index c47febf..2287894 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -9,7 +9,7 @@ typedef struct DisasContext {
     DisasContextBase base;
 
     target_ulong pc;
-    target_ulong next_page_start;
+    target_ulong page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index fc03b5b..ade8d2d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9913,7 +9913,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
         return false;
     }
 
-    if ((insn >> 11) == 0x1e && (s->pc < s->next_page_start - 3)) {
+    if ((insn >> 11) == 0x1e && s->pc - s->page_start < TARGET_PAGE_SIZE - 3) {
         /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix, and the suffix
          * is not on the next page; we merge this into a 32-bit
          * insn.
@@ -12269,8 +12269,7 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     dc->is_ldex = false;
     dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
 
-    dc->next_page_start =
-        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    dc->page_start = dc->base.pc_first & TARGET_PAGE_MASK;
 
     /* If architectural single step active, limit to 1.  */
     if (is_singlestepping(dc)) {
@@ -12280,7 +12279,7 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     /* ARM is a fixed-length ISA.  Bound the number of insns to execute
        to those left on the page.  */
     if (!dc->thumb) {
-        int bound = (dc->next_page_start - dc->base.pc_first) / 4;
+        int bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
         max_insns = MIN(max_insns, bound);
     }
 
@@ -12552,8 +12551,8 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
      * but isn't very efficient).
      */
     if (dc->base.is_jmp == DISAS_NEXT
-        && (dc->pc >= dc->next_page_start
-            || (dc->pc >= dc->next_page_start - 3
+        && (dc->pc - dc->page_start >= TARGET_PAGE_SIZE
+            || (dc->pc - dc->page_start >= TARGET_PAGE_SIZE - 3
                 && insn_crosses_page(env, dc)))) {
         dc->base.is_jmp = DISAS_TOO_MANY;
     }
-- 
2.7.4
