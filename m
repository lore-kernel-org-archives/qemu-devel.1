Received: from eggs.gnu.org ([2001:4830:134:3::10]:56389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwg3-0004Xq-C2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwg0-0002pK-5R
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:14:23 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 12:14:07 +0300
Message-Id: <150002364681.22386.1701754996184325808.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 15/26] target/arm: [tcg] Port to tb_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
---
 target/arm/translate.c |   83 ++++++++++++++++++++++++++----------------=
------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0179b1ce79..9adefae7e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11853,6 +11853,50 @@ static void arm_tr_init_disas_context(DisasConte=
xtBase *dcbase,
     cpu_M0 =3D tcg_temp_new_i64();
 }
=20
+static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu,
+                            int *max_insns)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    /* A note on handling of the condexec (IT) bits:
+     *
+     * We want to avoid the overhead of having to write the updated cond=
exec
+     * bits back to the CPUARMState for every instruction in an IT block=
. So:
+     * (1) if the condexec bits are not already zero then we write
+     * zero back into the CPUARMState now. This avoids complications try=
ing
+     * to do it at the end of the block. (For example if we don't do thi=
s
+     * it's hard to identify whether we can safely skip writing condexec
+     * at the end of the TB, which we definitely want to do for the case
+     * where a TB doesn't do anything with the IT state at all.)
+     * (2) if we are going to leave the TB then we call gen_set_condexec=
()
+     * which will write the correct value into CPUARMState if zero is wr=
ong.
+     * This is done both for leaving the TB at the end, and for leaving
+     * it because of an exception we know will happen, which is done in
+     * gen_exception_insn(). The latter is necessary because we need to
+     * leave the TB with the PC/IT state just prior to execution of the
+     * instruction which caused the exception.
+     * (3) if we leave the TB unexpectedly (eg a data abort on a load)
+     * then the CPUARMState will be wrong and we need to reset it.
+     * This is handled in the same way as restoration of the
+     * PC in these situations; we save the value of the condexec bits
+     * for each PC via tcg_gen_insn_start(), and restore_state_to_opc()
+     * then uses this to restore them after an exception.
+     *
+     * Note that there are no instructions which can read the condexec
+     * bits, and none which can write non-static values to them, so
+     * we don't need to care about whether CPUARMState is correct in the
+     * middle of a TB.
+     */
+
+    /* Reset the conditional execution bits immediately. This avoids
+       complications trying to do it at the end of the block.  */
+    if (dc->condexec_mask || dc->condexec_cond) {
+        TCGv_i32 tmp =3D tcg_temp_new_i32();
+        tcg_gen_movi_i32(tmp, 0);
+        store_cpu_field(tmp, condexec_bits);
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -11892,45 +11936,8 @@ void gen_intermediate_code(CPUState *cs, Transla=
tionBlock *tb)
     gen_tb_start(tb);
=20
     tcg_clear_temp_count();
+    arm_tr_tb_start(&dc->base, cs, &max_insns);
=20
-    /* A note on handling of the condexec (IT) bits:
-     *
-     * We want to avoid the overhead of having to write the updated cond=
exec
-     * bits back to the CPUARMState for every instruction in an IT block=
. So:
-     * (1) if the condexec bits are not already zero then we write
-     * zero back into the CPUARMState now. This avoids complications try=
ing
-     * to do it at the end of the block. (For example if we don't do thi=
s
-     * it's hard to identify whether we can safely skip writing condexec
-     * at the end of the TB, which we definitely want to do for the case
-     * where a TB doesn't do anything with the IT state at all.)
-     * (2) if we are going to leave the TB then we call gen_set_condexec=
()
-     * which will write the correct value into CPUARMState if zero is wr=
ong.
-     * This is done both for leaving the TB at the end, and for leaving
-     * it because of an exception we know will happen, which is done in
-     * gen_exception_insn(). The latter is necessary because we need to
-     * leave the TB with the PC/IT state just prior to execution of the
-     * instruction which caused the exception.
-     * (3) if we leave the TB unexpectedly (eg a data abort on a load)
-     * then the CPUARMState will be wrong and we need to reset it.
-     * This is handled in the same way as restoration of the
-     * PC in these situations; we save the value of the condexec bits
-     * for each PC via tcg_gen_insn_start(), and restore_state_to_opc()
-     * then uses this to restore them after an exception.
-     *
-     * Note that there are no instructions which can read the condexec
-     * bits, and none which can write non-static values to them, so
-     * we don't need to care about whether CPUARMState is correct in the
-     * middle of a TB.
-     */
-
-    /* Reset the conditional execution bits immediately. This avoids
-       complications trying to do it at the end of the block.  */
-    if (dc->condexec_mask || dc->condexec_cond)
-      {
-        TCGv_i32 tmp =3D tcg_temp_new_i32();
-        tcg_gen_movi_i32(tmp, 0);
-        store_cpu_field(tmp, condexec_bits);
-      }
     do {
         dc->base.num_insns++;
         dc->insn_start_idx =3D tcg_op_buf_count();
