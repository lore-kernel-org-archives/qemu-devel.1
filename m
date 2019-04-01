Received: from eggs.gnu.org ([209.51.188.92]:42214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46J-0002xl-Uf
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46I-0004US-Mu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53978
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46I-0004Li-HP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L3tNK062270
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:02 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkskgsyq4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:58 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:10 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:41 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-8-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 07/97] target/arm: Fix offset for LD1R
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
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

The immediate should be scaled by the size of the memory reference,
not the size of the elements into which it is loaded.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d0e372b0298f897993f831dbff7ad4f1c70f138e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
