Received: from eggs.gnu.org ([2001:4830:134:3::10]:58283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgY3-0003Vr-8o
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgY0-0001Ai-Oz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:07 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgY0-000163-GK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:04 -0500
Received: by mail-wm0-x244.google.com with SMTP id q83so24679729wme.5
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:48:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:44 +0000
Message-Id: <20180227143852.11175-24-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 23/31] arm/translate-a64: add FP16 FRECPE
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

Now we have added f16 during the re-factoring we can simply call the
helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.15.1
