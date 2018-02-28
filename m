Received: from eggs.gnu.org ([2001:4830:134:3::10]:35536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Ry-0003JV-Co
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Rx-0006Jq-JP
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:38 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7Rx-0006JC-Ev
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:37 -0500
Received: by mail-pl0-x244.google.com with SMTP id f23-v6so2113512plr.10
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:15 -0800
Message-Id: <20180228193125.20577-7-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/16] target/arm: Decode aa64 armv8.1
 scalar/vector x indexed element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ae16313eb0..e4d2d548ba 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11987,6 +11987,13 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x19: /* FMULX */
         is_fp = true;
         break;
+    case 0x1d: /* SQRDMLAH */
+    case 0x1f: /* SQRDMLSH */
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_RDM)) {
+            unallocated_encoding(s);
+            return;
+        }
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -12230,6 +12237,28 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                                 tcg_op, tcg_idx);
                 }
                 break;
+            case 0x1d: /* SQRDMLAH */
+                read_vec_element_i32(s, tcg_res, rd, pass,
+                                     is_scalar ? size : MO_32);
+                if (size == 1) {
+                    gen_helper_neon_qrdmlah_s16(tcg_res, cpu_env,
+                                                tcg_op, tcg_idx, tcg_res);
+                } else {
+                    gen_helper_neon_qrdmlah_s32(tcg_res, cpu_env,
+                                                tcg_op, tcg_idx, tcg_res);
+                }
+                break;
+            case 0x1f: /* SQRDMLSH */
+                read_vec_element_i32(s, tcg_res, rd, pass,
+                                     is_scalar ? size : MO_32);
+                if (size == 1) {
+                    gen_helper_neon_qrdmlsh_s16(tcg_res, cpu_env,
+                                                tcg_op, tcg_idx, tcg_res);
+                } else {
+                    gen_helper_neon_qrdmlsh_s32(tcg_res, cpu_env,
+                                                tcg_op, tcg_idx, tcg_res);
+                }
+                break;
             default:
                 g_assert_not_reached();
             }
-- 
2.14.3
