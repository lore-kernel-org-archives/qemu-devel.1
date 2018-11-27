Received: from eggs.gnu.org ([2001:4830:134:3::10]:35291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU1-0003s9-NZ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU0-0001ku-In
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:01 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gReU0-0001iI-BL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:00 -0500
Received: by mail-wr1-x443.google.com with SMTP id z5so18625415wrt.11
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:37:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 15:36:32 +0100
Message-Id: <1543329397-48407-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/15] target/i386: Generate #UD when applying
 LOCK to a register destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Fixes a TCG crash due to attempting the atomic operation without
having set up the address first.  This does not attempt to fix
all of the other missing checks for LOCK.

Fixes: a7cee522f35
Fixes: https://bugs.launchpad.net/qemu/+bug/1803160
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20181113193510.24862-1-richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index f8bc768..0dd5fbe 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1268,10 +1268,30 @@ static void gen_helper_fp_arith_STN_ST0(int op, int opreg)
     }
 }
 
+static void gen_exception(DisasContext *s, int trapno, target_ulong cur_eip)
+{
+    gen_update_cc_op(s);
+    gen_jmp_im(s, cur_eip);
+    gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
+    s->base.is_jmp = DISAS_NORETURN;
+}
+
+/* Generate #UD for the current instruction.  The assumption here is that
+   the instruction is known, but it isn't allowed in the current cpu mode.  */
+static void gen_illegal_opcode(DisasContext *s)
+{
+    gen_exception(s, EXCP06_ILLOP, s->pc_start - s->cs_base);
+}
+
 /* if d == OR_TMP0, it means memory operand (address in A0) */
 static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
 {
     if (d != OR_TMP0) {
+        if (s1->prefix & PREFIX_LOCK) {
+            /* Lock prefix when destination is not memory.  */
+            gen_illegal_opcode(s1);
+            return;
+        }
         gen_op_mov_v_reg(s1, ot, s1->T0, d);
     } else if (!(s1->prefix & PREFIX_LOCK)) {
         gen_op_ld_v(s1, ot, s1->T0, s1->A0);
@@ -2469,21 +2489,6 @@ static void gen_leave(DisasContext *s)
     gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
 }
 
-static void gen_exception(DisasContext *s, int trapno, target_ulong cur_eip)
-{
-    gen_update_cc_op(s);
-    gen_jmp_im(s, cur_eip);
-    gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
-    s->base.is_jmp = DISAS_NORETURN;
-}
-
-/* Generate #UD for the current instruction.  The assumption here is that
-   the instruction is known, but it isn't allowed in the current cpu mode.  */
-static void gen_illegal_opcode(DisasContext *s)
-{
-    gen_exception(s, EXCP06_ILLOP, s->pc_start - s->cs_base);
-}
-
 /* Similarly, except that the assumption here is that we don't decode
    the instruction at all -- either a missing opcode, an unimplemented
    feature, or just a bogus instruction stream.  */
-- 
1.8.3.1
