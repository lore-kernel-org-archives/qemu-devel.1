Received: from eggs.gnu.org ([2001:4830:134:3::10]:59119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Of-0007uV-5S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oe-0002Hf-4C
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Od-0002Ci-Tn
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OV-0003UO-NW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:59 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:45 +0100
Message-Id: <1500295494-8991-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/18] target/arm: use DISAS_EXIT for eret
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Previously DISAS_JUMP did ensure this but with the optimisation of
8a6b28c7 (optimize indirect branches) we might not leave the loop.
This means if any pending interrupts are cleared by changing IRQ flags
we might never get around to servicing them. You usually notice this
by seeing the lookup_tb_ptr() helper gainfully chaining TBs together
while cpu->interrupt_request remains high and the exit_request has not
been set.

This breaks amongst other things the OPTEE test suite which executes
an eret from the secure world after a non-secure world IRQ has gone
pending which then never gets serviced.

Instead of using the previously implied semantics of DISAS_JUMP we use
DISAS_EXIT which will always exit the run-loop.

CC: Etienne Carriere <etienne.carriere@linaro.org>
CC: Joakim Bech <joakim.bech@linaro.org>
CC: Jaroslaw Pelczar <j.pelczar@samsung.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 20170713141928.25419-7-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 3 ++-
 target/arm/translate.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2ac565e..3fa3902 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1788,7 +1788,8 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
             return;
         }
         gen_helper_exception_return(cpu_env);
-        s->is_jmp = DISAS_JUMP;
+        /* Must exit loop to check un-masked IRQs */
+        s->is_jmp = DISAS_EXIT;
         return;
     case 5: /* DRPS */
         if (rn != 0x1f) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 75cdeca..e27736c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4479,7 +4479,8 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
      */
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
     tcg_temp_free_i32(cpsr);
-    s->is_jmp = DISAS_JUMP;
+    /* Must exit loop to check un-masked IRQs */
+    s->is_jmp = DISAS_EXIT;
 }
 
 /* Generate an old-style exception return. Marks pc as dead. */
@@ -9523,7 +9524,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     tmp = load_cpu_field(spsr);
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
                     tcg_temp_free_i32(tmp);
-                    s->is_jmp = DISAS_JUMP;
+                    /* Must exit loop to check un-masked IRQs */
+                    s->is_jmp = DISAS_EXIT;
                 }
             }
             break;
-- 
2.7.4
