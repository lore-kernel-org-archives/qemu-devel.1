Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7o-0003B6-B6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7n-0004el-2q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY7m-00020Y-JH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY68-0006le-Jv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:04 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:17 +0100
Message-Id: <20181019165735.22511-28-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/45] target/arm: Use gvec for NEON VDUP
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

Also introduces neon_element_offset to find the env offset
of a specific element within a neon register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181011205206.3552-7-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 63 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 869dadbe8db..6fcc43f25c7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1585,6 +1585,25 @@ neon_reg_offset (int reg, int n)
     return vfp_reg_offset(0, sreg);
 }
 
+/* Return the offset of a 2**SIZE piece of a NEON register, at index ELE,
+ * where 0 is the least significant end of the register.
+ */
+static inline long
+neon_element_offset(int reg, int element, TCGMemOp size)
+{
+    int element_size = 1 << size;
+    int ofs = element * element_size;
+#ifdef HOST_WORDS_BIGENDIAN
+    /* Calculate the offset assuming fully little-endian,
+     * then XOR to account for the order of the 8-byte units.
+     */
+    if (element_size < 8) {
+        ofs ^= 8 - element_size;
+    }
+#endif
+    return neon_reg_offset(reg, 0) + ofs;
+}
+
 static TCGv_i32 neon_load_reg(int reg, int pass)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -3432,17 +3451,10 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     tmp = load_reg(s, rd);
                     if (insn & (1 << 23)) {
                         /* VDUP */
-                        if (size == 0) {
-                            gen_neon_dup_u8(tmp, 0);
-                        } else if (size == 1) {
-                            gen_neon_dup_low16(tmp);
-                        }
-                        for (n = 0; n <= pass * 2; n++) {
-                            tmp2 = tcg_temp_new_i32();
-                            tcg_gen_mov_i32(tmp2, tmp);
-                            neon_store_reg(rn, n, tmp2);
-                        }
-                        neon_store_reg(rn, n, tmp);
+                        int vec_size = pass ? 16 : 8;
+                        tcg_gen_gvec_dup_i32(size, neon_reg_offset(rn, 0),
+                                             vec_size, vec_size, tmp);
+                        tcg_temp_free_i32(tmp);
                     } else {
                         /* VMOV */
                         switch (size) {
@@ -7755,28 +7767,25 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 tcg_temp_free_i32(tmp);
             } else if ((insn & 0x380) == 0) {
                 /* VDUP */
+                int element;
+                TCGMemOp size;
+
                 if ((insn & (7 << 16)) == 0 || (q && (rd & 1))) {
                     return 1;
                 }
-                if (insn & (1 << 19)) {
-                    tmp = neon_load_reg(rm, 1);
-                } else {
-                    tmp = neon_load_reg(rm, 0);
-                }
                 if (insn & (1 << 16)) {
-                    gen_neon_dup_u8(tmp, ((insn >> 17) & 3) * 8);
+                    size = MO_8;
+                    element = (insn >> 17) & 7;
                 } else if (insn & (1 << 17)) {
-                    if ((insn >> 18) & 1)
-                        gen_neon_dup_high16(tmp);
-                    else
-                        gen_neon_dup_low16(tmp);
+                    size = MO_16;
+                    element = (insn >> 18) & 3;
+                } else {
+                    size = MO_32;
+                    element = (insn >> 19) & 1;
                 }
-                for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                    tmp2 = tcg_temp_new_i32();
-                    tcg_gen_mov_i32(tmp2, tmp);
-                    neon_store_reg(rd, pass, tmp2);
-                }
-                tcg_temp_free_i32(tmp);
+                tcg_gen_gvec_dup_mem(size, neon_reg_offset(rd, 0),
+                                     neon_element_offset(rm, element, size),
+                                     q ? 16 : 8, q ? 16 : 8);
             } else {
                 return 1;
             }
-- 
2.19.1
