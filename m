Received: from eggs.gnu.org ([2001:4830:134:3::10]:38524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJcC-0004lG-5U
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJcB-0003d7-Bm
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:56 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJcB-0003cz-5z
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:55 -0400
Received: by mail-pg0-x244.google.com with SMTP id 123so1669002pgd.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:41 -1000
Message-Id: <20170715094243.28371-33-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v14 32/34] target/arm: Move ss check to
 init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

We can check for single-step just once.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4b1230b..ebe1c1a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11845,6 +11845,11 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     dc->next_page_start =
         (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 
+    /* If architectural single step active, limit to 1.  */
+    if (is_singlestepping(dc)) {
+        max_insns = 1;
+    }
+
     cpu_F0s = tcg_temp_new_i32();
     cpu_F1s = tcg_temp_new_i32();
     cpu_F0d = tcg_temp_new_i64();
@@ -12000,11 +12005,9 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * Also stop translation when a page boundary is reached.  This
          * ensures prefetch aborts occur at the right place.  */
 
-        if (is_singlestepping(dc)) {
-            dc->base.is_jmp = DISAS_TOO_MANY;
-        } else if ((dc->pc >= dc->next_page_start) ||
-                   ((dc->pc >= dc->next_page_start - 3) &&
-                    insn_crosses_page(env, dc))) {
+        if (dc->pc >= dc->next_page_start ||
+            (dc->pc >= dc->next_page_start - 3 &&
+             insn_crosses_page(env, dc))) {
             /* We want to stop the TB if the next insn starts in a new page,
              * or if it spans between this page and the next. This means that
              * if we're looking at the last halfword in the page we need to
-- 
2.9.4
