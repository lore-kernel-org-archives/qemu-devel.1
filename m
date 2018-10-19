Received: from eggs.gnu.org ([2001:4830:134:3::10]:48477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7q-0003DA-Gm
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7p-0004hp-AL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY7o-0002bn-T6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:49 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY69-0006ls-FK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:18 +0100
Message-Id: <20181019165735.22511-29-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/45] target/arm: Use gvec for NEON VMOV, VMVN,
 VBIC & VORR (immediate)
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
Message-id: 20181011205206.3552-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 67 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6fcc43f25c7..7cc0c76420f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6641,7 +6641,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 1;
             }
         } else { /* (insn & 0x00380080) == 0 */
-            int invert;
+            int invert, reg_ofs, vec_size;
+
             if (q && (rd & 1)) {
                 return 1;
             }
@@ -6681,8 +6682,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;
             case 14:
                 imm |= (imm << 8) | (imm << 16) | (imm << 24);
-                if (invert)
+                if (invert) {
                     imm = ~imm;
+                }
                 break;
             case 15:
                 if (invert) {
@@ -6692,36 +6694,45 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                       | ((imm & 0x40) ? (0x1f << 25) : (1 << 30));
                 break;
             }
-            if (invert)
+            if (invert) {
                 imm = ~imm;
+            }
 
-            for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                if (op & 1 && op < 12) {
-                    tmp = neon_load_reg(rd, pass);
-                    if (invert) {
-                        /* The immediate value has already been inverted, so
-                           BIC becomes AND.  */
-                        tcg_gen_andi_i32(tmp, tmp, imm);
-                    } else {
-                        tcg_gen_ori_i32(tmp, tmp, imm);
-                    }
+            reg_ofs = neon_reg_offset(rd, 0);
+            vec_size = q ? 16 : 8;
+
+            if (op & 1 && op < 12) {
+                if (invert) {
+                    /* The immediate value has already been inverted,
+                     * so BIC becomes AND.
+                     */
+                    tcg_gen_gvec_andi(MO_32, reg_ofs, reg_ofs, imm,
+                                      vec_size, vec_size);
                 } else {
-                    /* VMOV, VMVN.  */
-                    tmp = tcg_temp_new_i32();
-                    if (op == 14 && invert) {
-                        int n;
-                        uint32_t val;
-                        val = 0;
-                        for (n = 0; n < 4; n++) {
-                            if (imm & (1 << (n + (pass & 1) * 4)))
-                                val |= 0xff << (n * 8);
-                        }
-                        tcg_gen_movi_i32(tmp, val);
-                    } else {
-                        tcg_gen_movi_i32(tmp, imm);
-                    }
+                    tcg_gen_gvec_ori(MO_32, reg_ofs, reg_ofs, imm,
+                                     vec_size, vec_size);
+                }
+            } else {
+                /* VMOV, VMVN.  */
+                if (op == 14 && invert) {
+                    TCGv_i64 t64 = tcg_temp_new_i64();
+
+                    for (pass = 0; pass <= q; ++pass) {
+                        uint64_t val = 0;
+                        int n;
+
+                        for (n = 0; n < 8; n++) {
+                            if (imm & (1 << (n + pass * 8))) {
+                                val |= 0xffull << (n * 8);
+                            }
+                        }
+                        tcg_gen_movi_i64(t64, val);
+                        neon_store_reg64(t64, rd + pass);
+                    }
+                    tcg_temp_free_i64(t64);
+                } else {
+                    tcg_gen_gvec_dup32i(reg_ofs, vec_size, vec_size, imm);
                 }
-                neon_store_reg(rd, pass, tmp);
             }
         }
     } else { /* (insn & 0x00800010 == 0x00800000) */
-- 
2.19.1
