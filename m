Received: from eggs.gnu.org ([2001:4830:134:3::10]:42041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqy-0000bM-Oq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqu-00037Y-02
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:07:00 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:34785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqt-00032z-Pc
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:55 -0400
Received: by mail-pf0-x22a.google.com with SMTP id m1so13486478pfk.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:06:10 -0700
Message-Id: <20170906160612.22769-31-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/32] target/arm: Move ss check to
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

We can check for single-step just once.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index dabd5eb89a..0dd24aad90 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11883,6 +11883,11 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
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
@@ -12037,11 +12042,9 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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
2.13.5
