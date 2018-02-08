Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBY-00033G-L4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBW-0000Vd-7W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:36 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejqBV-0000Ui-UE
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:34 -0500
Received: by mail-wm0-x243.google.com with SMTP id b21so11520027wme.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:40:33 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:47 +0000
Message-Id: <20180208173157.24705-23-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 22/32] arm/translate-a64: add FP16 FNEG/FABS
 to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

As these operations doesn't use the fpstatus pointer we can be smarter
about allocating it. The negh can also be done with a bitwise xor rather
than calling a helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5baf0261ff..da3c7bfa85 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10801,6 +10801,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     TCGv_i32 tcg_rmode = NULL;
     TCGv_ptr tcg_fpstatus = NULL;
     bool need_rmode = false;
+    bool need_fpst = true;
     int rmode;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
@@ -10917,6 +10918,10 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         need_rmode = true;
         rmode = FPROUNDING_ZERO;
         break;
+    case 0x2f: /* FABS */
+    case 0x6f: /* FNEG */
+        need_fpst = false;
+        break;
     default:
         fprintf(stderr, "%s: insn %#04x fpop %#2x\n", __func__, insn, fpop);
         g_assert_not_reached();
@@ -10970,6 +10975,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x7b: /* FCVTZU */
             gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
             break;
+        case 0x6f: /* FNEG */
+            tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -11013,6 +11021,12 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x59: /* FRINTX */
                 gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, tcg_fpstatus);
                 break;
+            case 0x2f: /* FABS */
+                gen_helper_advsimd_absh(tcg_res, tcg_op);
+                break;
+            case 0x6f: /* FNEG */
+                tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
+                break;
             default:
                 g_assert_not_reached();
             }
-- 
2.15.1
