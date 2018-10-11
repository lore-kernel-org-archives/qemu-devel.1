Received: from eggs.gnu.org ([2001:4830:134:3::10]:45128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-0006pu-N1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwk-0005qW-HE
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:35122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwk-0004Vi-54
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id f8-v6so4800477plb.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:57 -0700
Message-Id: <20181011205206.3552-12-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/20] target/arm: Use gvec for NEON_3R_VMUL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fae132791a..e195efcc55 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5959,6 +5959,19 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                  vec_size, vec_size);
             }
             return 0;
+
+        case NEON_3R_VMUL: /* VMUL */
+            if (u) {
+                /* Polynomial case allows only P8 and is handled below.  */
+                if (size != 0) {
+                    return 1;
+                }
+            } else {
+                tcg_gen_gvec_mul(size, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+                return 0;
+            }
+            break;
         }
         if (size == 3) {
             /* 64-bit element instructions. */
@@ -6065,12 +6078,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 1;
             }
             break;
-        case NEON_3R_VMUL:
-            if (u && (size != 0)) {
-                /* UNDEF on invalid size for polynomial subcase */
-                return 1;
-            }
-            break;
         case NEON_3R_VFM_VQRDMLSH:
             if (!arm_dc_feature(s, ARM_FEATURE_VFP4)) {
                 return 1;
@@ -6183,16 +6190,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             break;
         case NEON_3R_VMUL:
-            if (u) { /* polynomial */
-                gen_helper_neon_mul_p8(tmp, tmp, tmp2);
-            } else { /* Integer */
-                switch (size) {
-                case 0: gen_helper_neon_mul_u8(tmp, tmp, tmp2); break;
-                case 1: gen_helper_neon_mul_u16(tmp, tmp, tmp2); break;
-                case 2: tcg_gen_mul_i32(tmp, tmp, tmp2); break;
-                default: abort();
-                }
-            }
+            /* VMUL.P8; other cases already eliminated.  */
+            gen_helper_neon_mul_p8(tmp, tmp, tmp2);
             break;
         case NEON_3R_VPMAX:
             GEN_NEON_INTEGER_OP(pmax);
-- 
2.17.1
