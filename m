Received: from eggs.gnu.org ([2001:4830:134:3::10]:54527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3X-0003VU-9t
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3W-0006yp-4e
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:19 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3V-0006xH-SQ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:18 -0500
Received: by mail-wm0-x242.google.com with SMTP id r71so10969631wmd.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:17 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:49 +0000
Message-Id: <20180208173157.24705-25-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 24/32] arm/translate-a64: add FP16 FRECPE
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

Now we have added f16 during the re-factoring we can simply call the
helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index da3c7bfa85..4ad5e97f56 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10848,6 +10848,8 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         handle_2misc_fcmp_zero(s, fpop, is_scalar, 0, is_q, MO_16, rn, rd);
         return;
         break;
+    case 0x3d: /* FRECPE */
+        break;
     case 0x18: /* FRINTN */
         need_rmode = true;
         only_in_vector = true;
@@ -10968,6 +10970,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x3b: /* FCVTZS */
             gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
             break;
+        case 0x3d: /* FRECPE */
+            gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
+            break;
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x5c: /* FCVTAU */
@@ -11003,6 +11008,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
