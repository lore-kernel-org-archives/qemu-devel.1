Received: from eggs.gnu.org ([209.51.188.92]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43r-0000mc-Ev
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43o-0002xt-H1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36700
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB43l-0002r8-KP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrYUe156165
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:28 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksyp8m6y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:28 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:27 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:42 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-9-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/97] target/arm: Fix offset scaling for
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
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

The scaling should be solely on the memory operation size; the number
of registers being loaded does not come in to the initial computation.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 50ef1cbf31caad21019ae6fa8036ed6f29244ba5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
