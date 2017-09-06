Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqy-0000ad-0M
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqs-00031D-Bd
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:07:00 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:35367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqs-000304-5D
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:54 -0400
Received: by mail-pf0-x236.google.com with SMTP id g13so13484313pfm.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:06:09 -0700
Message-Id: <20170906160612.22769-30-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 29/32] target/arm: [a64] Move page and ss checks
 to init_disas_context
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

Since AArch64 uses a fixed-width ISA, we can pre-compute the number of
insns remaining on the page.  Also, we can check for single-step once.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 25c6622825..9017e30510 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11206,6 +11206,7 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
     ARMCPU *arm_cpu = arm_env_get_cpu(env);
+    int bound;
 
     dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
@@ -11254,8 +11255,14 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->is_ldex = false;
     dc->ss_same_el = (arm_debug_target_el(env) == dc->current_el);
 
-    dc->next_page_start =
-        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    /* Bound the number of insns to execute to those left on the page.  */
+    bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
+
+    /* If architectural single step active, limit to 1.  */
+    if (dc->ss_active) {
+        bound = 1;
+    }
+    max_insns = MIN(max_insns, bound);
 
     init_tmp_a64_array(dc);
 
@@ -11323,12 +11330,6 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         disas_a64_insn(env, dc);
     }
 
-    if (dc->base.is_jmp == DISAS_NEXT) {
-        if (dc->ss_active || dc->pc >= dc->next_page_start) {
-            dc->base.is_jmp = DISAS_TOO_MANY;
-        }
-    }
-
     dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
-- 
2.13.5
