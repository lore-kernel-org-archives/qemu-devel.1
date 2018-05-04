Received: from eggs.gnu.org ([2001:4830:134:3::10]:38368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSW-0008UN-Oa
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSU-0004ma-Ej
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:44 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSU-0004lh-6X
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:42 -0400
Received: by mail-pg0-x244.google.com with SMTP id e1-v6so3378200pga.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:23 -0700
Message-Id: <20180504054030.24527-7-richard.henderson@linaro.org>
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/13] target/openrisc: Convert dec_calc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 322 +++++++++++++++++++++++--------------------
 target/openrisc/insns.decode |  76 +++++++---
 2 files changed, 229 insertions(+), 169 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 0100fbc460..90520b0805 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -457,171 +457,199 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_cy(dc);
 }
 
-static void dec_calc(DisasContext *dc, uint32_t insn)
+static bool trans_l_add(DisasContext *dc, arg_dab *a, uint32_t insn)
 {
-    uint32_t op0, op1, op2;
-    uint32_t ra, rb, rd;
-    op0 = extract32(insn, 0, 4);
-    op1 = extract32(insn, 8, 2);
-    op2 = extract32(insn, 6, 2);
-    ra = extract32(insn, 16, 5);
-    rb = extract32(insn, 11, 5);
-    rd = extract32(insn, 21, 5);
+    LOG_DIS("l.add r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    gen_add(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    switch (op1) {
-    case 0:
-        switch (op0) {
-        case 0x0: /* l.add */
-            LOG_DIS("l.add r%d, r%d, r%d\n", rd, ra, rb);
-            gen_add(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_addc(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.addc r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    gen_addc(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0x1: /* l.addc */
-            LOG_DIS("l.addc r%d, r%d, r%d\n", rd, ra, rb);
-            gen_addc(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_sub(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.sub r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    gen_sub(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0x2: /* l.sub */
-            LOG_DIS("l.sub r%d, r%d, r%d\n", rd, ra, rb);
-            gen_sub(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_and(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.and r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    tcg_gen_and_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0x3: /* l.and */
-            LOG_DIS("l.and r%d, r%d, r%d\n", rd, ra, rb);
-            tcg_gen_and_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_or(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.or r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    tcg_gen_or_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0x4: /* l.or */
-            LOG_DIS("l.or r%d, r%d, r%d\n", rd, ra, rb);
-            tcg_gen_or_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_xor(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.xor r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    tcg_gen_xor_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0x5: /* l.xor */
-            LOG_DIS("l.xor r%d, r%d, r%d\n", rd, ra, rb);
-            tcg_gen_xor_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_sll(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.sll r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    tcg_gen_shl_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0x8:
-            switch (op2) {
-            case 0: /* l.sll */
-                LOG_DIS("l.sll r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_shl_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                return;
-            case 1: /* l.srl */
-                LOG_DIS("l.srl r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_shr_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                return;
-            case 2: /* l.sra */
-                LOG_DIS("l.sra r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_sar_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                return;
-            case 3: /* l.ror */
-                LOG_DIS("l.ror r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_rotr_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                return;
-            }
-            break;
+static bool trans_l_srl(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.srl r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    tcg_gen_shr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0xc:
-            switch (op2) {
-            case 0: /* l.exths */
-                LOG_DIS("l.exths r%d, r%d\n", rd, ra);
-                tcg_gen_ext16s_tl(cpu_R[rd], cpu_R[ra]);
-                return;
-            case 1: /* l.extbs */
-                LOG_DIS("l.extbs r%d, r%d\n", rd, ra);
-                tcg_gen_ext8s_tl(cpu_R[rd], cpu_R[ra]);
-                return;
-            case 2: /* l.exthz */
-                LOG_DIS("l.exthz r%d, r%d\n", rd, ra);
-                tcg_gen_ext16u_tl(cpu_R[rd], cpu_R[ra]);
-                return;
-            case 3: /* l.extbz */
-                LOG_DIS("l.extbz r%d, r%d\n", rd, ra);
-                tcg_gen_ext8u_tl(cpu_R[rd], cpu_R[ra]);
-                return;
-            }
-            break;
+static bool trans_l_sra(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.sra r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    tcg_gen_sar_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0xd:
-            switch (op2) {
-            case 0: /* l.extws */
-                LOG_DIS("l.extws r%d, r%d\n", rd, ra);
-                tcg_gen_ext32s_tl(cpu_R[rd], cpu_R[ra]);
-                return;
-            case 1: /* l.extwz */
-                LOG_DIS("l.extwz r%d, r%d\n", rd, ra);
-                tcg_gen_ext32u_tl(cpu_R[rd], cpu_R[ra]);
-                return;
-            }
-            break;
+static bool trans_l_ror(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.ror r%d, r%d, r%d\n", a->d, a->a, a->b);
+    check_r0_write(a->d);
+    tcg_gen_rotr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-        case 0xe: /* l.cmov */
-            LOG_DIS("l.cmov r%d, r%d, r%d\n", rd, ra, rb);
-            {
-                TCGv zero = tcg_const_tl(0);
-                tcg_gen_movcond_tl(TCG_COND_NE, cpu_R[rd], cpu_sr_f, zero,
-                                   cpu_R[ra], cpu_R[rb]);
-                tcg_temp_free(zero);
-            }
-            return;
+static bool trans_l_exths(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("l.exths r%d, r%d\n", a->d, a->a);
+    check_r0_write(a->d);
+    tcg_gen_ext16s_tl(cpu_R[a->d], cpu_R[a->a]);
+    return true;
+}
 
-        case 0xf: /* l.ff1 */
-            LOG_DIS("l.ff1 r%d, r%d, r%d\n", rd, ra, rb);
-            tcg_gen_ctzi_tl(cpu_R[rd], cpu_R[ra], -1);
-            tcg_gen_addi_tl(cpu_R[rd], cpu_R[rd], 1);
-            return;
-        }
-        break;
+static bool trans_l_extbs(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("l.extbs r%d, r%d\n", a->d, a->a);
+    check_r0_write(a->d);
+    tcg_gen_ext8s_tl(cpu_R[a->d], cpu_R[a->a]);
+    return true;
+}
 
-    case 1:
-        switch (op0) {
-        case 0xf: /* l.fl1 */
-            LOG_DIS("l.fl1 r%d, r%d, r%d\n", rd, ra, rb);
-            tcg_gen_clzi_tl(cpu_R[rd], cpu_R[ra], TARGET_LONG_BITS);
-            tcg_gen_subfi_tl(cpu_R[rd], TARGET_LONG_BITS, cpu_R[rd]);
-            return;
-        }
-        break;
+static bool trans_l_exthz(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("l.exthz r%d, r%d\n", a->d, a->a);
+    check_r0_write(a->d);
+    tcg_gen_ext16u_tl(cpu_R[a->d], cpu_R[a->a]);
+    return true;
+}
 
-    case 2:
-        break;
+static bool trans_l_extbz(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("l.extbz r%d, r%d\n", a->d, a->a);
+    check_r0_write(a->d);
+    tcg_gen_ext8u_tl(cpu_R[a->d], cpu_R[a->a]);
+    return true;
+}
 
-    case 3:
-        switch (op0) {
-        case 0x6: /* l.mul */
-            LOG_DIS("l.mul r%d, r%d, r%d\n", rd, ra, rb);
-            gen_mul(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_cmov(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    TCGv zero;
+    LOG_DIS("l.cmov r%d, r%d, r%d\n", a->d, a->a, a->b);
 
-        case 0x7: /* l.muld */
-            LOG_DIS("l.muld r%d, r%d\n", ra, rb);
-            gen_muld(dc, cpu_R[ra], cpu_R[rb]);
-            break;
+    check_r0_write(a->d);
+    zero = tcg_const_tl(0);
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_R[a->d], cpu_sr_f, zero,
+                       cpu_R[a->a], cpu_R[a->b]);
+    tcg_temp_free(zero);
+    return true;
+}
 
-        case 0x9: /* l.div */
-            LOG_DIS("l.div r%d, r%d, r%d\n", rd, ra, rb);
-            gen_div(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_ff1(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("l.ff1 r%d, r%d\n", a->d, a->a);
 
-        case 0xa: /* l.divu */
-            LOG_DIS("l.divu r%d, r%d, r%d\n", rd, ra, rb);
-            gen_divu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+    check_r0_write(a->d);
+    tcg_gen_ctzi_tl(cpu_R[a->d], cpu_R[a->a], -1);
+    tcg_gen_addi_tl(cpu_R[a->d], cpu_R[a->d], 1);
+    return true;
+}
 
-        case 0xb: /* l.mulu */
-            LOG_DIS("l.mulu r%d, r%d, r%d\n", rd, ra, rb);
-            gen_mulu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            return;
+static bool trans_l_fl1(DisasContext *dc, arg_da *a, uint32_t insn)
+{
+    LOG_DIS("l.fl1 r%d, r%d\n", a->d, a->a);
 
-        case 0xc: /* l.muldu */
-            LOG_DIS("l.muldu r%d, r%d\n", ra, rb);
-            gen_muldu(dc, cpu_R[ra], cpu_R[rb]);
-            return;
-        }
-        break;
-    }
-    gen_illegal_exception(dc);
+    check_r0_write(a->d);
+    tcg_gen_clzi_tl(cpu_R[a->d], cpu_R[a->a], TARGET_LONG_BITS);
+    tcg_gen_subfi_tl(cpu_R[a->d], TARGET_LONG_BITS, cpu_R[a->d]);
+    return true;
+}
+
+static bool trans_l_mul(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.mul r%d, r%d, r%d\n", a->d, a->a, a->b);
+
+    check_r0_write(a->d);
+    gen_mul(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
+
+static bool trans_l_mulu(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.mulu r%d, r%d, r%d\n", a->d, a->a, a->b);
+
+    check_r0_write(a->d);
+    gen_mulu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
+
+static bool trans_l_div(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.div r%d, r%d, r%d\n", a->d, a->a, a->b);
+
+    check_r0_write(a->d);
+    gen_div(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
+
+static bool trans_l_divu(DisasContext *dc, arg_dab *a, uint32_t insn)
+{
+    LOG_DIS("l.divu r%d, r%d, r%d\n", a->d, a->a, a->b);
+
+    check_r0_write(a->d);
+    gen_divu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
+
+static bool trans_l_muld(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("l.muld r%d, r%d\n", a->a, a->b);
+    gen_muld(dc, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
+
+static bool trans_l_muldu(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("l.muldu r%d, r%d\n", a->a, a->b);
+    gen_muldu(dc, cpu_R[a->a], cpu_R[a->b]);
+    return true;
 }
 
 static bool trans_l_j(DisasContext *dc, arg_l_j *a, uint32_t insn)
@@ -1486,10 +1514,6 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
         dec_float(dc, insn);
         break;
 
-    case 0x38:
-        dec_calc(dc, insn);
-        break;
-
     case 0x39:
         dec_comp(dc, insn);
         break;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 247a2e14f2..20f035f488 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -17,6 +17,10 @@
 # License along with this library; if not, see <http://www.gnu.org/licenses/>.
 #
 
+&dab            d a b
+&da             d a
+&ab             a b
+
 ####
 # System Instructions
 ####
@@ -27,7 +31,7 @@ l_msync         001000 1000000000 00000000 00000000
 l_psync         001000 1010000000 00000000 00000000
 l_csync         001000 1100000000 00000000 00000000
 
-l_rfe		001001 ----- ----- -------- --------
+l_rfe           001001 ----- ----- -------- --------
 
 ####
 # Branch Instructions
@@ -60,32 +64,64 @@ l_lbs           100100 ..... ..... ........ ........    @load
 l_lhz           100101 ..... ..... ........ ........    @load
 l_lhs           100110 ..... ..... ........ ........    @load
 
-l_swa		110011 ..... ..... ..... ...........	@store
-l_sw		110101 ..... ..... ..... ...........	@store
-l_sb		110110 ..... ..... ..... ...........	@store
-l_sh		110111 ..... ..... ..... ...........	@store
+l_swa           110011 ..... ..... ..... ...........    @store
+l_sw            110101 ..... ..... ..... ...........    @store
+l_sb            110110 ..... ..... ..... ...........    @store
+l_sh            110111 ..... ..... ..... ...........    @store
 
 ####
 # Immediate Operand Instructions
 ####
 
-%mtspr_k	21:5 0:11
+%mtspr_k        21:5 0:11
 
-&rri		d a i
-&rrk		d a k
-@rri		...... d:5 a:5 i:s16			&rri
-@rrk		...... d:5 a:5 k:16			&rrk
+&rri            d a i
+&rrk            d a k
+@rri            ...... d:5 a:5 i:s16                    &rri
+@rrk            ...... d:5 a:5 k:16                     &rrk
 
-l_nop		000101 01--- ----- k:16
+l_nop           000101 01--- ----- k:16
 
-l_addi		100111 ..... ..... ........ ........	@rri
-l_addic		101000 ..... ..... ........ ........	@rri
-l_andi		101001 ..... ..... ........ ........	@rrk
-l_ori		101010 ..... ..... ........ ........	@rrk
-l_xori		101011 ..... ..... ........ ........	@rri
-l_muli		101100 ..... ..... ........ ........	@rri
+l_addi          100111 ..... ..... ........ ........    @rri
+l_addic         101000 ..... ..... ........ ........    @rri
+l_andi          101001 ..... ..... ........ ........    @rrk
+l_ori           101010 ..... ..... ........ ........    @rrk
+l_xori          101011 ..... ..... ........ ........    @rri
+l_muli          101100 ..... ..... ........ ........    @rri
 
-l_mfspr		101101 ..... ..... ........ ........	@rrk
-l_mtspr		110000 ..... a:5 b:5 ...........	k=%mtspr_k
+l_mfspr         101101 ..... ..... ........ ........    @rrk
+l_mtspr         110000 ..... a:5 b:5 ...........        k=%mtspr_k
 
-l_maci		010011 ----- a:5 i:s16
+l_maci          010011 ----- a:5 i:s16
+
+####
+# Arithmetic Instructions
+####
+
+l_exths         111000 d:5 a:5 ----- - 0000 -- 1100
+l_extbs         111000 d:5 a:5 ----- - 0001 -- 1100
+l_exthz         111000 d:5 a:5 ----- - 0010 -- 1100
+l_extbz         111000 d:5 a:5 ----- - 0011 -- 1100
+
+l_add           111000 d:5 a:5 b:5   - 00 ---- 0000
+l_addc          111000 d:5 a:5 b:5   - 00 ---- 0001
+l_sub           111000 d:5 a:5 b:5   - 00 ---- 0010
+l_and           111000 d:5 a:5 b:5   - 00 ---- 0011
+l_or            111000 d:5 a:5 b:5   - 00 ---- 0100
+l_xor           111000 d:5 a:5 b:5   - 00 ---- 0101
+l_cmov          111000 d:5 a:5 b:5   - 00 ---- 1110
+l_ff1           111000 d:5 a:5 ----- - 00 ---- 1111
+l_fl1           111000 d:5 a:5 ----- - 01 ---- 1111
+
+l_sll           111000 d:5 a:5 b:5   - 0000 -- 1000
+l_srl           111000 d:5 a:5 b:5   - 0001 -- 1000
+l_sra           111000 d:5 a:5 b:5   - 0010 -- 1000
+l_ror           111000 d:5 a:5 b:5   - 0011 -- 1000
+
+l_mul           111000 d:5 a:5 b:5   - 11 ---- 0110
+l_mulu          111000 d:5 a:5 b:5   - 11 ---- 1011
+l_div           111000 d:5 a:5 b:5   - 11 ---- 1001
+l_divu          111000 d:5 a:5 b:5   - 11 ---- 1010
+
+l_muld          111000 ----- a:5 b:5 - 11 ---- 0111
+l_muldu         111000 ----- a:5 b:5 - 11 ---- 1100
-- 
2.14.3
