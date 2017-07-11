Received: from eggs.gnu.org ([2001:4830:134:3::10]:56272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSu-0002WS-0R
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSq-0005HG-Q8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:52 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:32853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUzSq-0005G0-KE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:48 -0400
Received: by mail-wr0-f177.google.com with SMTP id r103so9571833wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:00:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Jul 2017 18:59:37 +0100
Message-Id: <20170711175937.23140-7-alex.bennee@linaro.org>
In-Reply-To: <20170711175937.23140-1-alex.bennee@linaro.org>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/6] target/arm: use DISAS_EXIT for eret
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

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
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 3 ++-
 target/arm/translate.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2ac565eb10..3fa39023ca 100644
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
index dbf919cce3..f1023d5263 100644
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
2.13.0
