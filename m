Received: from eggs.gnu.org ([2001:4830:134:3::10]:44835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApP7-0005rG-DW
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApP6-0000TX-L4
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:45:53 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:49622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApP6-0000SF-Dk
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:45:52 -0400
Received: by mail-lf0-x242.google.com with SMTP id w21so5156653lfc.6
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:45:52 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:06 -0700
Message-Id: <1509767121-26925-2-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 01/16] target/xtensa: pass actual frame size to
 the entry helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

Currently 'entry' opcode helper accepts frame size divided by 8, as it
is encoded in the opcode. Make it more natural and accept actual frame
size instead.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/op_helper.c | 2 +-
 target/xtensa/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 3d990c0caa44..012552817f74 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -249,7 +249,7 @@ void HELPER(entry)(CPUXtensaState *env, uint32_t pc, uint32_t s, uint32_t imm)
         if (windowstart & ((1 << callinc) - 1)) {
             HELPER(window_check)(env, pc, callinc);
         }
-        env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - (imm << 3);
+        env->regs[(callinc << 2) | (s & 3)] = env->regs[s] - imm;
         rotate_window(env, callinc);
         env->sregs[WINDOW_START] |=
             windowstart_bit(env->sregs[WINDOW_BASE], env);
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 20f7ddf042f8..225e4a5fe870 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2830,7 +2830,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 {
                     TCGv_i32 pc = tcg_const_i32(dc->pc);
                     TCGv_i32 s = tcg_const_i32(BRI12_S);
-                    TCGv_i32 imm = tcg_const_i32(BRI12_IMM12);
+                    TCGv_i32 imm = tcg_const_i32(BRI12_IMM12 << 3);
                     gen_helper_entry(cpu_env, pc, s, imm);
                     tcg_temp_free(imm);
                     tcg_temp_free(s);
-- 
2.1.4
