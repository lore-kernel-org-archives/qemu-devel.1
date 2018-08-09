Received: from eggs.gnu.org ([2001:4830:134:3::10]:37759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnbof-0006kk-9e
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnbod-0003Cb-Mk
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:49 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:33009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnbod-0003CC-HI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:47 -0400
Received: by mail-pl0-x22a.google.com with SMTP id b90-v6so1948822plb.0
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:29 -0700
Message-Id: <20180809034033.10579-8-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/11] target/arm: Fix offset for LD1R
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

The immediate should be scaled by the size of the memory reference,
not the size of the elements into which it is loaded.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9e63b5f8e5..f635822a61 100644
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
2.17.1
