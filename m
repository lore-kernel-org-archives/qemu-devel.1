Received: from eggs.gnu.org ([2001:4830:134:3::10]:55835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzRo-0001i1-Jp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzRn-0003nm-MP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:59:44 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUzRn-0003mH-FT
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:59:43 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c11so9458923wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:59:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Jul 2017 18:59:33 +0100
Message-Id: <20170711175937.23140-3-alex.bennee@linaro.org>
In-Reply-To: <20170711175937.23140-1-alex.bennee@linaro.org>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/6] target/arm/translate: make DISAS_UPDATE
 match declared semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

DISAS_UPDATE should be used when the wider CPU state other than just
the PC has been updated and we should therefor exit the TCG runtime
and return to the main execution loop rather assuming DISAS_JUMP would
do that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 14 +++++++-------
 target/arm/translate.c     |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d95d..66139b6046 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11364,16 +11364,9 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
         case DISAS_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
-        default:
-        case DISAS_UPDATE:
-            gen_a64_set_pc_im(dc->pc);
-            /* fall through */
         case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
             break;
-        case DISAS_EXIT:
-            tcg_gen_exit_tb(0);
-            break;
         case DISAS_TB_JUMP:
         case DISAS_EXC:
         case DISAS_SWI:
@@ -11397,6 +11390,13 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
              */
             tcg_gen_exit_tb(0);
             break;
+        case DISAS_UPDATE:
+            gen_a64_set_pc_im(dc->pc);
+            /* fall through */
+        case DISAS_EXIT:
+        default:
+            tcg_gen_exit_tb(0);
+            break;
         }
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0862f9e4aa..5f2cea8641 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12095,12 +12095,12 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
         case DISAS_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
-        case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
-            /* fall through */
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
+        case DISAS_UPDATE:
+            gen_set_pc_im(dc, dc->pc);
+            /* fall through */
         default:
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(0);
-- 
2.13.0
