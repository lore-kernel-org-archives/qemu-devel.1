Received: from eggs.gnu.org ([2001:4830:134:3::10]:60569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgS-00042c-HT
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMgR-0008NF-Q2
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:03:04 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHMgR-0008N5-LB
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:03:03 -0400
Received: by mail-pl0-x241.google.com with SMTP id c11-v6so4380232plr.5
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 22:03:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 22:02:49 -0700
Message-Id: <20180512050250.12774-9-richard.henderson@linaro.org>
In-Reply-To: <20180512050250.12774-1-richard.henderson@linaro.org>
References: <20180512050250.12774-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 8/9] target/m68k: Improve ending TB at page
 boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Rather than limit total TB size to PAGE-32 bytes, end the TB when
near the end of a page.  This should provide proper semantics of
SIGSEGV when executing near the end of a page.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0ab9ab1148..069558bc28 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6105,9 +6105,25 @@ static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     disas_m68k_insn(cpu->env_ptr, dc);
     dc->base.pc_next = dc->pc;
 
-    if (dc->base.is_jmp == DISAS_NEXT
-        && dc->pc - dc->base.pc_first >= TARGET_PAGE_SIZE - 32) {
-        dc->base.is_jmp = DISAS_TOO_MANY;
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        /* Stop translation when the next insn might touch a new page.
+         * This ensures that prefetch aborts at the right place.
+         *
+         * We cannot determine the size of the next insn without
+         * completely decoding it.  However, the maximum insn size
+         * is 32 bytes, so end if we do not have that much remaining.
+         * This may produce several small TBs at the end of each page,
+         * but they will all be linked with goto_tb.
+         *
+         * ??? ColdFire maximum is 4 bytes; MC68000's maximum is also
+         * smaller than MC68020's.
+         */
+        target_ulong start_page_offset
+            = dc->pc - (dc->base.pc_first & TARGET_PAGE_MASK);
+
+        if (start_page_offset >= TARGET_PAGE_SIZE - 32) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
     }
 }
 
-- 
2.17.0
