Received: from eggs.gnu.org ([2001:4830:134:3::10]:58882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQP-00006R-SD
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQO-0001r8-Us
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:53 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQO-0001mH-Io
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:52 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQJ-0008SX-Iq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:12 +0100
Message-Id: <20180816133438.17061-5-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/30] target/arm: Fix offset scaling for
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

From: Richard Henderson <richard.henderson@linaro.org>

The scaling should be solely on the memory operation size; the number
of registers being loaded does not come in to the initial computation.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f635822a613..d27bc8c946b 100644
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
2.18.0
