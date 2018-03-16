Received: from eggs.gnu.org ([2001:4830:134:3::10]:44195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1V-0005wg-AI
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1R-0003NJ-Jf
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:21 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:08 -0400
Message-Id: <1521232280-13089-11-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 10/22] target/arm: Allow EL change hooks to
 do IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

During code generation, surround CPSR writes and exception returns which
call the EL change hooks with gen_io_start/end. The immediate need is
for the PMU to access the clock and icount during EL change to support
mode filtering.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/translate-a64.c | 2 ++
 target/arm/translate.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 31ff047..e1ae676 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1919,7 +1919,9 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
+        gen_io_start();
         gen_helper_exception_return(cpu_env);
+        gen_io_end();
         /* Must exit loop to check un-masked IRQs */
         s->base.is_jmp = DISAS_EXIT;
         return;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ba6ab7d..fd5871e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4536,7 +4536,9 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
      * appropriately depending on the new Thumb bit, so it must
      * be called after storing the new PC.
      */
+    gen_io_start();
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
+    gen_io_end();
     tcg_temp_free_i32(cpsr);
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
@@ -9828,7 +9830,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 if (exc_return) {
                     /* Restore CPSR from SPSR.  */
                     tmp = load_cpu_field(spsr);
+                    gen_io_start();
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
+                    gen_io_end();
                     tcg_temp_free_i32(tmp);
                     /* Must exit loop to check un-masked IRQs */
                     s->base.is_jmp = DISAS_EXIT;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
