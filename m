Received: from eggs.gnu.org ([2001:4830:134:3::10]:55649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD88-0003FK-C7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD85-0004LO-1p
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:44 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD84-0004L1-RT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:40 -0400
Received: by mail-wr0-x229.google.com with SMTP id 12so72190413wrb.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:17 +0100
Message-Id: <20170720150426.12393-15-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 14/23] target/arm/translate-a64.c:
 add ARMv8.2 fadd scalar half-precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This brings in the initial decode skeleton and the helpers for a
scalar half-precision fadd using SoftFloat3c.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/advsimd_helper.c | 15 ++++++++++++
 target/arm/translate-a64.c  | 60 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
index ec875a83bb..4e577e9602 100644
--- a/target/arm/advsimd_helper.c
+++ b/target/arm/advsimd_helper.c
@@ -83,3 +83,18 @@ uint32_t HELPER(advsimd_acgt_f16)(uint32_t a, uint32_t b, void *fpstp)
     sync_softfloat_flags_to_2a(fpstp);
     return r;
 }
+
+
+/* Data processing - scalar floating-point and advanced SIMD */
+
+uint32_t HELPER(advsimd_addh)(uint32_t a, uint32_t b, void *fpstp)
+{
+    union ui16_f16 uA = { .ui = a };
+    union ui16_f16 uB = { .ui = b };
+    float16_t r;
+
+    sync_softfloat_flags_from_2a(fpstp);
+    r = f16_add(uA.f, uB.f);
+    sync_softfloat_flags_to_2a(fpstp);
+    return r.v;
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f6aca395bd..a8876e4bcc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -581,6 +581,14 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int reg)
     return v;
 }
 
+static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
+{
+    TCGv_i32 v = tcg_temp_new_i32();
+
+    tcg_gen_ld16u_i32(v, cpu_env, fp_reg_offset(s, reg, MO_16));
+    return v;
+}
+
 static void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
 {
     TCGv_i64 tcg_zero = tcg_const_i64(0);
@@ -599,6 +607,15 @@ static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
     tcg_temp_free_i64(tmp);
 }
 
+static void write_fp_hreg(DisasContext *s, int reg, TCGv_i32 v)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_extu_i32_i64(tmp, v);
+    write_fp_dreg(s, reg, tmp);
+    tcg_temp_free_i64(tmp);
+}
+
 static TCGv_ptr get_fpstatus_ptr(void)
 {
     TCGv_ptr statusptr = tcg_temp_new_ptr();
@@ -4710,6 +4727,39 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     }
 }
 
+/* ARMv8.2 floating-point data-processing (2 source) - half precision
+ */
+static void handle_fp_2src_half(DisasContext *s, int opcode,
+                                int rd, int rn, int rm)
+{
+    TCGv_i32 tcg_op1;
+    TCGv_i32 tcg_op2;
+    TCGv_i32 tcg_res;
+    TCGv_ptr fpst;
+
+    tcg_res = tcg_temp_new_i32();
+    fpst = get_fpstatus_ptr();
+    tcg_op1 = read_fp_hreg(s, rn);
+    tcg_op2 = read_fp_hreg(s, rm);
+
+    switch (opcode) {
+    case 0x2: /* FADD */
+        gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    default:
+        fprintf(stderr, "%s: unhandled op %#x\n", __func__, opcode);
+        unsupported_encoding(s, opcode);
+        break;
+    }
+
+    write_fp_hreg(s, rd, tcg_res);
+
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tcg_op1);
+    tcg_temp_free_i32(tcg_op2);
+    tcg_temp_free_i32(tcg_res);
+}
+
 /* C3.6.26 Floating-point data-processing (2 source) - single precision */
 static void handle_fp_2src_single(DisasContext *s, int opcode,
                                   int rd, int rn, int rm)
@@ -4848,6 +4898,16 @@ static void disas_fp_2src(DisasContext *s, uint32_t insn)
         }
         handle_fp_2src_double(s, opcode, rd, rn, rm);
         break;
+    case 3:
+        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            if (!fp_access_check(s)) {
+                return;
+            }
+            handle_fp_2src_half(s, opcode, rd, rn, rm);
+        } else {
+            unallocated_encoding(s);
+        }
+        break;
     default:
         unallocated_encoding(s);
     }
-- 
2.13.0
