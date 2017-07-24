Received: from eggs.gnu.org ([2001:4830:134:3::10]:48147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyH-0003nS-Nd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyG-0001wt-S3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:53 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjyG-0001wH-Mx
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:52 -0400
Received: by mail-qk0-x242.google.com with SMTP id q66so10950767qki.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:26 -0700
Message-Id: <20170724202728.25960-31-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 30/32] target/arm: Move ss check to
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
Cc: cota@braap.org, vilanova@ac.upc.edu

We can check for single-step just once.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5991422695..cdf2917cef 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11853,6 +11853,11 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
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
@@ -12007,11 +12012,9 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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
2.13.3
