Received: from eggs.gnu.org ([2001:4830:134:3::10]:60785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUauj-00061P-W8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUaui-0003Yg-R6
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:47:57 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUaui-0003XH-K9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:47:56 -0400
Received: by mail-wr0-x235.google.com with SMTP id c11so144112136wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:47:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 16:47:47 +0100
Message-Id: <20170710154749.13624-5-alex.bennee@linaro.org>
In-Reply-To: <20170710154749.13624-1-alex.bennee@linaro.org>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 4/6] target/arm/translate-a64: get rid of
 DISAS_EXIT
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

We already have an exit condition that declares we should exit to the
run-loop because wider CPU state changes have been made. Use
DISAS_UPDATE and kill the architecture specific DISAS_EXIT.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 3 +--
 target/arm/translate.c     | 6 ++++--
 target/arm/translate.h     | 4 ----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fe1c49b565..bde6ca934e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1425,7 +1425,7 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         tcg_temp_free_i32(tcg_op);
         /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
         gen_a64_set_pc_im(s->pc);
-        s->is_jmp = (op == 0x1f ? DISAS_EXIT : DISAS_JUMP);
+        s->is_jmp = (op == 0x1f ? DISAS_UPDATE : DISAS_JUMP);
         break;
     }
     default:
@@ -11394,7 +11394,6 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
             tcg_gen_exit_tb(0);
             break;
         case DISAS_UPDATE:
-        case DISAS_EXIT:
         default:
             tcg_gen_exit_tb(0);
             break;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f9c4aee1b6..e840499c6f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1194,11 +1194,13 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
     s->is_jmp = DISAS_EXC;
 }
 
-/* Force a TB lookup after an instruction that changes the CPU state.  */
+/* Force a TB lookup after an instruction that changes the CPU state.
+ * (other than just the PC)
+ */
 static inline void gen_lookup_tb(DisasContext *s)
 {
     tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
-    s->is_jmp = DISAS_EXIT;
+    s->is_jmp = DISAS_UPDATE;
 }
 
 static inline void gen_hlt(DisasContext *s, int imm)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 15d383d9af..6b2cc34c33 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -139,10 +139,6 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  * custom end-of-TB code)
  */
 #define DISAS_BX_EXCRET 11
-/* For instructions which want an immediate exit to the main loop,
- * as opposed to attempting to use lookup_and_goto_ptr.
- */
-#define DISAS_EXIT 12
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-- 
2.13.0
