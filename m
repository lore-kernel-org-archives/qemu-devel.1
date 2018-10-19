Received: from eggs.gnu.org ([2001:4830:134:3::10]:48144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7X-0002uF-HD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7K-00042N-7v
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY7J-0002Jh-WB
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6C-0006mp-Uq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:22 +0100
Message-Id: <20181019165735.22511-33-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/45] target/arm: Use gvec for NEON_3R_VMUL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181011205206.3552-12-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d29328774b6..7b13717c0dc 100644
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
2.19.1
