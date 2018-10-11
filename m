Received: from eggs.gnu.org ([2001:4830:134:3::10]:45145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwo-0006qV-Aw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwl-0005wg-LH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:42 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwl-0003kq-7R
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id p24-v6so4994676pff.10
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:52 -0700
Message-Id: <20181011205206.3552-7-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/20] target/arm: Use gvec for NEON VDUP
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

Also introduces neon_element_offset to find the env offset
of a specific element within a neon register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 63 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d59ffa1c67..4ac526e298 100644
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
2.17.1
