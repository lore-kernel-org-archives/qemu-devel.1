Received: from eggs.gnu.org ([2001:4830:134:3::10]:48656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY81-0003Nd-7n
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY80-0004vQ-Cr
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY80-0002bn-1k
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY65-0006ky-Vq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:14 +0100
Message-Id: <20181019165735.22511-25-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/45] target/arm: Use tcg_gen_gvec_dup_i64 for
 LD[1-4]R
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
Message-id: 20181011205206.3552-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c3a0e5accd8..39ac45c0080 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3217,36 +3217,14 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     for (xs = 0; xs < selem; xs++) {
         if (replicate) {
             /* Load and replicate to all elements */
-            uint64_t mulconst;
             TCGv_i64 tcg_tmp = tcg_temp_new_i64();
 
             tcg_gen_qemu_ld_i64(tcg_tmp, tcg_addr,
                                 get_mem_index(s), s->be_data + scale);
-            switch (scale) {
-            case 0:
-                mulconst = 0x0101010101010101ULL;
-                break;
-            case 1:
-                mulconst = 0x0001000100010001ULL;
-                break;
-            case 2:
-                mulconst = 0x0000000100000001ULL;
-                break;
-            case 3:
-                mulconst = 0;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            if (mulconst) {
-                tcg_gen_muli_i64(tcg_tmp, tcg_tmp, mulconst);
-            }
-            write_vec_element(s, tcg_tmp, rt, 0, MO_64);
-            if (is_q) {
-                write_vec_element(s, tcg_tmp, rt, 1, MO_64);
-            }
+            tcg_gen_gvec_dup_i64(scale, vec_full_reg_offset(s, rt),
+                                 (is_q + 1) * 8, vec_full_reg_size(s),
+                                 tcg_tmp);
             tcg_temp_free_i64(tcg_tmp);
-            clear_vec_high(s, is_q, rt);
         } else {
             /* Load/store one element per register */
             if (is_load) {
-- 
2.19.1
