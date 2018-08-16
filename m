Received: from eggs.gnu.org ([2001:4830:134:3::10]:58909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQR-00009H-EB
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQQ-0001s3-7S
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:55 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQP-0001mH-Uz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:54 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQH-0008S6-2T
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:45 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:11 +0100
Message-Id: <20180816133438.17061-4-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/30] target/arm: Fix offset for LD1R
 instructions
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

The immediate should be scaled by the size of the memory reference,
not the size of the elements into which it is loaded.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9e63b5f8e55..f635822a613 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4819,6 +4819,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
     unsigned vsz = vec_full_reg_size(s);
     unsigned psz = pred_full_reg_size(s);
     unsigned esz = dtype_esz[a->dtype];
+    unsigned msz = dtype_msz(a->dtype);
     TCGLabel *over = gen_new_label();
     TCGv_i64 temp;
 
@@ -4842,7 +4843,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
 
     /* Load the data.  */
     temp = tcg_temp_new_i64();
-    tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << esz);
+    tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << msz);
     tcg_gen_qemu_ld_i64(temp, temp, get_mem_index(s),
                         s->be_data | dtype_mop[a->dtype]);
 
-- 
2.18.0
