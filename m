Received: from eggs.gnu.org ([2001:4830:134:3::10]:58508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgYD-0003g6-In
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgYB-0001se-0n
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:17 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgYA-0001pS-L6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:14 -0500
Received: by mail-wm0-x241.google.com with SMTP id q83so24680923wme.5
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:48:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:48 +0000
Message-Id: <20180227143852.11175-28-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 27/31] arm/translate-a64: add FP16 FRSQRTE
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
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1096ff48ac..86231b33bb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11388,6 +11388,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x6f: /* FNEG */
         need_fpst = false;
         break;
+    case 0x7d: /* FRSQRTE */
     case 0x7f: /* FSQRT (vector) */
         break;
     default:
@@ -11452,6 +11453,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x6f: /* FNEG */
             tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
             break;
+        case 0x7d: /* FRSQRTE */
+            gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -11504,6 +11508,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x6f: /* FNEG */
                 tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
                 break;
+            case 0x7d: /* FRSQRTE */
+                gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
+                break;
             case 0x7f: /* FSQRT */
                 gen_helper_sqrt_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-- 
2.15.1
