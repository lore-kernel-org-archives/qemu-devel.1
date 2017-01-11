Received: from eggs.gnu.org ([2001:4830:134:3::10]:35100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Un-00067N-45
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Um-00039S-4i
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:37 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Ul-000397-VS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:36 -0500
Received: by mail-pf0-x241.google.com with SMTP id 127so31457461pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:35 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:30 -0800
Message-Id: <20170111021820.24416-16-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 15/65] target-i386: Use new deposit and extract
 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

A couple of places where it was easy to identify a right-shift
followed by an extract or and-with-immediate, and the obvious
sign-extract from a high byte register.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 59e11fc..816d0b1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -383,8 +383,7 @@ static void gen_op_mov_reg_v(TCGMemOp ot, int reg, TCGv t0)
 static inline void gen_op_mov_v_reg(TCGMemOp ot, TCGv t0, int reg)
 {
     if (ot == MO_8 && byte_reg_is_xH(reg)) {
-        tcg_gen_shri_tl(t0, cpu_regs[reg - 4], 8);
-        tcg_gen_ext8u_tl(t0, t0);
+        tcg_gen_extract_tl(t0, cpu_regs[reg - 4], 8, 8);
     } else {
         tcg_gen_mov_tl(t0, cpu_regs[reg]);
     }
@@ -3768,8 +3767,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 
                     /* Extract the LEN into a mask.  Lengths larger than
                        operand size get all ones.  */
-                    tcg_gen_shri_tl(cpu_A0, cpu_regs[s->vex_v], 8);
-                    tcg_gen_ext8u_tl(cpu_A0, cpu_A0);
+                    tcg_gen_extract_tl(cpu_A0, cpu_regs[s->vex_v], 8, 8);
                     tcg_gen_movcond_tl(TCG_COND_LEU, cpu_A0, cpu_A0, bound,
                                        cpu_A0, bound);
                     tcg_temp_free(bound);
@@ -3920,9 +3918,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                             gen_compute_eflags(s);
                         }
                         carry_in = cpu_tmp0;
-                        tcg_gen_shri_tl(carry_in, cpu_cc_src,
-                                        ctz32(b == 0x1f6 ? CC_C : CC_O));
-                        tcg_gen_andi_tl(carry_in, carry_in, 1);
+                        tcg_gen_extract_tl(carry_in, cpu_cc_src,
+                                           ctz32(b == 0x1f6 ? CC_C : CC_O), 1);
                     }
 
                     switch (ot) {
@@ -5447,21 +5444,25 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             rm = (modrm & 7) | REX_B(s);
 
             if (mod == 3) {
-                gen_op_mov_v_reg(ot, cpu_T0, rm);
-                switch (s_ot) {
-                case MO_UB:
-                    tcg_gen_ext8u_tl(cpu_T0, cpu_T0);
-                    break;
-                case MO_SB:
-                    tcg_gen_ext8s_tl(cpu_T0, cpu_T0);
-                    break;
-                case MO_UW:
-                    tcg_gen_ext16u_tl(cpu_T0, cpu_T0);
-                    break;
-                default:
-                case MO_SW:
-                    tcg_gen_ext16s_tl(cpu_T0, cpu_T0);
-                    break;
+                if (s_ot == MO_SB && byte_reg_is_xH(rm)) {
+                    tcg_gen_sextract_tl(cpu_T0, cpu_regs[rm - 4], 8, 8);
+                } else {
+                    gen_op_mov_v_reg(ot, cpu_T0, rm);
+                    switch (s_ot) {
+                    case MO_UB:
+                        tcg_gen_ext8u_tl(cpu_T0, cpu_T0);
+                        break;
+                    case MO_SB:
+                        tcg_gen_ext8s_tl(cpu_T0, cpu_T0);
+                        break;
+                    case MO_UW:
+                        tcg_gen_ext16u_tl(cpu_T0, cpu_T0);
+                        break;
+                    default:
+                    case MO_SW:
+                        tcg_gen_ext16s_tl(cpu_T0, cpu_T0);
+                        break;
+                    }
                 }
                 gen_op_mov_reg_v(d_ot, reg, cpu_T0);
             } else {
-- 
2.9.3
