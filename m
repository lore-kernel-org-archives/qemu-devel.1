Received: from eggs.gnu.org ([2001:4830:134:3::10]:32893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUavl-0006jR-QR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUavi-0004Ai-Mz
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:49:01 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUavi-0004AQ-Gd
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:48:58 -0400
Received: by mail-wr0-f177.google.com with SMTP id c11so144113337wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:48:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 16:47:46 +0100
Message-Id: <20170710154749.13624-4-alex.bennee@linaro.org>
In-Reply-To: <20170710154749.13624-1-alex.bennee@linaro.org>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/6] target/arm/translate-a64: make
 DISAS_UPDATE match declared semantics
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

As some DISAS_UPDATE users may update the PC dynamically via a helper
we also push the updating to the PC to the call sites which set
->is_jmp to DISAS_UPDATE.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d95d..fe1c49b565 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1393,6 +1393,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
+        gen_a64_set_pc_im(s->pc);
         s->is_jmp = DISAS_UPDATE;
         return;
     default:
@@ -1593,12 +1594,14 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
         gen_io_end();
+        gen_a64_set_pc_im(s->pc);
         s->is_jmp = DISAS_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
+        gen_a64_set_pc_im(s->pc);
         s->is_jmp = DISAS_UPDATE;
     }
 }
@@ -11364,16 +11367,9 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
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
@@ -11397,6 +11393,11 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
              */
             tcg_gen_exit_tb(0);
             break;
+        case DISAS_UPDATE:
+        case DISAS_EXIT:
+        default:
+            tcg_gen_exit_tb(0);
+            break;
         }
     }
 
-- 
2.13.0
