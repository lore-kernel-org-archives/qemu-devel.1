Received: from eggs.gnu.org ([2001:4830:134:3::10]:39684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQx-0002kQ-UC
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQw-0001Wy-Gy
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQw-0001OF-9M
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQu-00033j-E6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:07 +0100
Message-Id: <20180426104715.21702-12-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/19] target/arm: Allow EL change hooks to do IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

During code generation, surround CPSR writes and exception returns which
call the EL change hooks with gen_io_start/end. The immediate need is
for the PMU to access the clock and icount during EL change to support
mode filtering.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Message-id: 1523997485-1905-9-git-send-email-alindsay@codeaurora.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c |  6 ++++++
 target/arm/translate.c     | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c91329249d..bff4e13bf6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1930,7 +1930,13 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_helper_exception_return(cpu_env);
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
         /* Must exit loop to check un-masked IRQs */
         s->base.is_jmp = DISAS_EXIT;
         return;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index db1ce6510a..9bc2ce1a0b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4548,7 +4548,13 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
      * appropriately depending on the new Thumb bit, so it must
      * be called after storing the new PC.
      */
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
     tcg_temp_free_i32(cpsr);
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
@@ -9843,7 +9849,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 if (exc_return) {
                     /* Restore CPSR from SPSR.  */
                     tmp = load_cpu_field(spsr);
+                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                        gen_io_start();
+                    }
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
+                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                        gen_io_end();
+                    }
                     tcg_temp_free_i32(tmp);
                     /* Must exit loop to check un-masked IRQs */
                     s->base.is_jmp = DISAS_EXIT;
-- 
2.17.0
