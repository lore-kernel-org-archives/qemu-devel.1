Received: from eggs.gnu.org ([2001:4830:134:3::10]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7C-0002c8-G3
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7B-0003ys-IF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY7B-00020Y-87
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6D-0006n5-QM
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:09 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:23 +0100
Message-Id: <20181019165735.22511-34-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/45] target/arm: Use gvec for VSHR, VSHL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181011205206.3552-13-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 70 +++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7b13717c0dc..2d715d9b47b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6373,8 +6373,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     size--;
             }
             shift = (insn >> 16) & ((1 << (3 + size)) - 1);
-            /* To avoid excessive duplication of ops we implement shift
-               by immediate using the variable shift operations.  */
             if (op < 8) {
                 /* Shift by immediate:
                    VSHR, VSRA, VRSHR, VRSRA, VSRI, VSHL, VQSHL, VQSHLU.  */
@@ -6386,37 +6384,62 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
                 /* Right shifts are encoded as N - shift, where N is the
                    element size in bits.  */
-                if (op <= 4)
+                if (op <= 4) {
                     shift = shift - (1 << (size + 3));
+                }
+
+                switch (op) {
+                case 0:  /* VSHR */
+                    /* Right shift comes here negative.  */
+                    shift = -shift;
+                    /* Shifts larger than the element size are architecturally
+                     * valid.  Unsigned results in all zeros; signed results
+                     * in all sign bits.
+                     */
+                    if (!u) {
+                        tcg_gen_gvec_sari(size, rd_ofs, rm_ofs,
+                                          MIN(shift, (8 << size) - 1),
+                                          vec_size, vec_size);
+                    } else if (shift >= 8 << size) {
+                        tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_size, 0);
+                    } else {
+                        tcg_gen_gvec_shri(size, rd_ofs, rm_ofs, shift,
+                                          vec_size, vec_size);
+                    }
+                    return 0;
+
+                case 5: /* VSHL, VSLI */
+                    if (!u) { /* VSHL */
+                        /* Shifts larger than the element size are
+                         * architecturally valid and results in zero.
+                         */
+                        if (shift >= 8 << size) {
+                            tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_size, 0);
+                        } else {
+                            tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
+                                              vec_size, vec_size);
+                        }
+                        return 0;
+                    }
+                    break;
+                }
+
                 if (size == 3) {
                     count = q + 1;
                 } else {
                     count = q ? 4: 2;
                 }
-                switch (size) {
-                case 0:
-                    imm = (uint8_t) shift;
-                    imm |= imm << 8;
-                    imm |= imm << 16;
-                    break;
-                case 1:
-                    imm = (uint16_t) shift;
-                    imm |= imm << 16;
-                    break;
-                case 2:
-                case 3:
-                    imm = shift;
-                    break;
-                default:
-                    abort();
-                }
+
+                /* To avoid excessive duplication of ops we implement shift
+                 * by immediate using the variable shift operations.
+                  */
+                imm = dup_const(size, shift);
 
                 for (pass = 0; pass < count; pass++) {
                     if (size == 3) {
                         neon_load_reg64(cpu_V0, rm + pass);
                         tcg_gen_movi_i64(cpu_V1, imm);
                         switch (op) {
-                        case 0:  /* VSHR */
                         case 1:  /* VSRA */
                             if (u)
                                 gen_helper_neon_shl_u64(cpu_V0, cpu_V0, cpu_V1);
@@ -6447,6 +6470,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                                          cpu_V0, cpu_V1);
                             }
                             break;
+                        default:
+                            g_assert_not_reached();
                         }
                         if (op == 1 || op == 3) {
                             /* Accumulate.  */
@@ -6475,7 +6500,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         tmp2 = tcg_temp_new_i32();
                         tcg_gen_movi_i32(tmp2, imm);
                         switch (op) {
-                        case 0:  /* VSHR */
                         case 1:  /* VSRA */
                             GEN_NEON_INTEGER_OP(shl);
                             break;
@@ -6513,6 +6537,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case 7: /* VQSHL */
                             GEN_NEON_INTEGER_OP_ENV(qshl);
                             break;
+                        default:
+                            g_assert_not_reached();
                         }
                         tcg_temp_free_i32(tmp2);
 
-- 
2.19.1
