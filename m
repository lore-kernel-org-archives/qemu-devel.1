Received: from eggs.gnu.org ([2001:4830:134:3::10]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-0006pt-Me
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwl-0005vB-Dg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:47047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwl-0003KD-03
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pf1-x441.google.com with SMTP id r64-v6so4992246pfb.13
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:49 -0700
Message-Id: <20181011205206.3552-4-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/20] target/arm: Use tcg_gen_gvec_dup_i64 for
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
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ac9723c1b9..fff99ca303 100644
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
2.17.1
