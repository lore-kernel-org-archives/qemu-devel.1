Received: from eggs.gnu.org ([2001:4830:134:3::10]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7e-000305-PT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7a-0004Fi-Ez
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY7S-00020Y-K5
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6B-0006mK-62
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:20 +0100
Message-Id: <20181019165735.22511-31-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/45] target/arm: Use gvec for
 NEON_3R_VADD_VSUB insns
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
Message-id: 20181011205206.3552-10-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 82710fb1175..fc0173076a4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5949,6 +5949,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;
             }
             return 0;
+
+        case NEON_3R_VADD_VSUB:
+            if (u) {
+                tcg_gen_gvec_sub(size, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+            } else {
+                tcg_gen_gvec_add(size, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+            }
+            return 0;
         }
         if (size == 3) {
             /* 64-bit element instructions. */
@@ -6006,13 +6016,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                                   cpu_V1, cpu_V0);
                     }
                     break;
-                case NEON_3R_VADD_VSUB:
-                    if (u) {
-                        tcg_gen_sub_i64(CPU_V001);
-                    } else {
-                        tcg_gen_add_i64(CPU_V001);
-                    }
-                    break;
                 default:
                     abort();
                 }
@@ -6147,18 +6150,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rd, pass);
             gen_neon_add(size, tmp, tmp2);
             break;
-        case NEON_3R_VADD_VSUB:
-            if (!u) { /* VADD */
-                gen_neon_add(size, tmp, tmp2);
-            } else { /* VSUB */
-                switch (size) {
-                case 0: gen_helper_neon_sub_u8(tmp, tmp, tmp2); break;
-                case 1: gen_helper_neon_sub_u16(tmp, tmp, tmp2); break;
-                case 2: tcg_gen_sub_i32(tmp, tmp, tmp2); break;
-                default: abort();
-                }
-            }
-            break;
         case NEON_3R_VTST_VCEQ:
             if (!u) { /* VTST */
                 switch (size) {
-- 
2.19.1
