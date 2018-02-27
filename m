Received: from eggs.gnu.org ([2001:4830:134:3::10]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgYA-0003bg-91
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgY7-0001fL-I0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:14 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgY7-0001b5-55
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:11 -0500
Received: by mail-wr0-x244.google.com with SMTP id u49so25115733wrc.10
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:48:10 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:52 +0000
Message-Id: <20180227143852.11175-32-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 31/31] arm/translate-a64: add all single op
 FP16 to handle_fp_1src_half
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

This includes FMOV, FABS, FNEG, FSQRT and  FRINT[NPMZAXI]. We re-use
existing helpers to achieve this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - make fabs a bitwise operation
  - use read_vec_element_i32 to read value
  - properly wire into disas_fp_1rc
---
 target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 52cecae047..32811dc8b0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4596,6 +4596,65 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(t_true);
 }
 
+/* Floating-point data-processing (1 source) - half precision */
+static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
+{
+    TCGv_ptr fpst = NULL;
+    TCGv_i32 tcg_op = tcg_temp_new_i32();
+    TCGv_i32 tcg_res = tcg_temp_new_i32();
+
+    read_vec_element_i32(s, tcg_op, rn, 0, MO_16);
+
+    switch (opcode) {
+    case 0x0: /* FMOV */
+        tcg_gen_mov_i32(tcg_res, tcg_op);
+        break;
+    case 0x1: /* FABS */
+        tcg_gen_andi_i32(tcg_res, tcg_op, 0x7fff);
+        break;
+    case 0x2: /* FNEG */
+        tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
+        break;
+    case 0x3: /* FSQRT */
+        gen_helper_sqrt_f16(tcg_res, tcg_op, cpu_env);
+        break;
+    case 0x8: /* FRINTN */
+    case 0x9: /* FRINTP */
+    case 0xa: /* FRINTM */
+    case 0xb: /* FRINTZ */
+    case 0xc: /* FRINTA */
+    {
+        TCGv_i32 tcg_rmode = tcg_const_i32(arm_rmode_to_sf(opcode & 7));
+        fpst = get_fpstatus_ptr(true);
+
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+        gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
+
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+        tcg_temp_free_i32(tcg_rmode);
+        break;
+    }
+    case 0xe: /* FRINTX */
+        fpst = get_fpstatus_ptr(true);
+        gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, fpst);
+        break;
+    case 0xf: /* FRINTI */
+        fpst = get_fpstatus_ptr(true);
+        gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
+        break;
+    default:
+        abort();
+    }
+
+    write_fp_sreg(s, rd, tcg_res);
+
+    if (fpst) {
+        tcg_temp_free_ptr(fpst);
+    }
+    tcg_temp_free_i32(tcg_op);
+    tcg_temp_free_i32(tcg_res);
+}
+
 /* Floating-point data-processing (1 source) - single precision */
 static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -4825,6 +4884,18 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
 
             handle_fp_1src_double(s, opcode, rd, rn);
             break;
+        case 3:
+            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+                unallocated_encoding(s);
+                return;
+            }
+
+            if (!fp_access_check(s)) {
+                return;
+            }
+
+            handle_fp_1src_half(s, opcode, rd, rn);
+            break;
         default:
             unallocated_encoding(s);
         }
-- 
2.15.1
