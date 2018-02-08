Received: from eggs.gnu.org ([2001:4830:134:3::10]:57602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBb-00037l-MD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejqBa-0000aO-C7
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:39 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejqBa-0000ZY-3t
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:38 -0500
Received: by mail-wm0-x243.google.com with SMTP id i186so10930162wmi.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:40:37 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:53 +0000
Message-Id: <20180208173157.24705-29-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 28/32] arm/translate-a64: add FP16 FRSQRTE
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 587d072d27..fa21299061 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10925,6 +10925,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x6f: /* FNEG */
         need_fpst = false;
         break;
+    case 0x7d: /* FRSQRTE */
     case 0x7f: /* FSQRT (vector) */
         break;
     default:
@@ -10989,6 +10990,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x6f: /* FNEG */
             tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
             break;
+        case 0x7d: /* FRSQRTE */
+            gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -11041,6 +11045,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
