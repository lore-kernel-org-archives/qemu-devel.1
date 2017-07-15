Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJcA-0004jc-FE
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJc9-0003c4-KS
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:54 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJc9-0003bt-Eh
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:53 -0400
Received: by mail-pg0-x242.google.com with SMTP id 123so1668944pgd.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:40 -1000
Message-Id: <20170715094243.28371-32-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v14 31/34] target/arm: [a64] Move page and ss
 checks to init_disas_context
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

Since AArch64 uses a fixed-width ISA, we can pre-compute the number of
insns remaining on the page.  Also, we can check for single-step once.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1aa4c14..41e5cc3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11196,6 +11196,7 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
     ARMCPU *arm_cpu = arm_env_get_cpu(env);
+    int bound;
 
     dc->pc = dc->base.pc_first;
     dc->condjmp = 0;
@@ -11244,8 +11245,14 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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
 
@@ -11313,12 +11320,6 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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
2.9.4
