Received: from eggs.gnu.org ([2001:4830:134:3::10]:59176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Og-0007xR-NM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Of-0002Jw-Od
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Of-0002Ci-HY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OT-0003Ss-K0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:41 +0100
Message-Id: <1500295494-8991-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/18] target/arm/translate: make DISAS_UPDATE
 match declared semantics
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

DISAS_UPDATE should be used when the wider CPU state other than just
the PC has been updated and we should therefore exit the TCG runtime
and return to the main execution loop rather assuming DISAS_JUMP would
do that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 20170713141928.25419-3-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 14 +++++++-------
 target/arm/translate.c     |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d..66139b6 100644
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
index 0862f9e..5f2cea8 100644
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
2.7.4
