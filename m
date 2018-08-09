Received: from eggs.gnu.org ([2001:4830:134:3::10]:37779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnbof-0006lI-Q8
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnbof-0003DF-18
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:49 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnboe-0003Cs-RA
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:48 -0400
Received: by mail-pl0-x243.google.com with SMTP id b90-v6so1948846plb.0
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:30 -0700
Message-Id: <20180809034033.10579-9-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/11] target/arm: Fix offset scaling for
 LD_zprr and ST_zprr
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

The scaling should be solely on the memory operation size; the number
of registers being loaded does not come in to the initial computation.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f635822a61..d27bc8c946 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4665,8 +4665,7 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a, uint32_t insn)
     }
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
-        tcg_gen_muli_i64(addr, cpu_reg(s, a->rm),
-                         (a->nreg + 1) << dtype_msz(a->dtype));
+        tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
         do_ld_zpa(s, a->rd, a->pg, addr, a->dtype, a->nreg);
     }
@@ -4899,7 +4898,7 @@ static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a, uint32_t insn)
     }
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
-        tcg_gen_muli_i64(addr, cpu_reg(s, a->rm), (a->nreg + 1) << a->msz);
+        tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->msz);
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
         do_st_zpa(s, a->rd, a->pg, addr, a->msz, a->esz, a->nreg);
     }
-- 
2.17.1
