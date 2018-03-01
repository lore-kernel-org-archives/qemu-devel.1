Received: from eggs.gnu.org ([2001:4830:134:3::10]:33999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK4-0003to-UO
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK4-0008DY-03
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:28 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMK3-0008Cl-Oo
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:27 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK2-0000fB-GF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:52 +0000
Message-Id: <20180301112403.12487-32-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/42] arm/translate-a64: add FP16 FRECPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Now we have added f16 during the re-factoring we can simply call the
helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-24-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9f2c3682dc..50b4fa4ce4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11311,6 +11311,8 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x6d: /* FCMLE (zero) */
         handle_2misc_fcmp_zero(s, fpop, is_scalar, 0, is_q, MO_16, rn, rd);
         return;
+    case 0x3d: /* FRECPE */
+        break;
     case 0x18: /* FRINTN */
         need_rmode = true;
         only_in_vector = true;
@@ -11431,6 +11433,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x3b: /* FCVTZS */
             gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
             break;
+        case 0x3d: /* FRECPE */
+            gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
+            break;
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x5c: /* FCVTAU */
@@ -11466,6 +11471,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x3b: /* FCVTZS */
                 gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
+            case 0x3d: /* FRECPE */
+                gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
+                break;
             case 0x5a: /* FCVTNU */
             case 0x5b: /* FCVTMU */
             case 0x5c: /* FCVTAU */
-- 
2.16.2
