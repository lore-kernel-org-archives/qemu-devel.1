Received: from eggs.gnu.org ([209.51.188.92]:40510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43z-0000qu-V4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43y-00036s-Lg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB43y-00035n-4S
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrcI4128195
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkq85hr1p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:47 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:45 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:50 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-17-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 16/97] target/arm: Use FZ not FZ16 for SVE FCVT
 single-half and double-half
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

We were using the wrong flush-to-zero bit for the non-half input.

Fixes: 46d33d1e3c9
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e4ab5124a5c2e2291006b24bdc21c3dd8d087ff4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d27bc8c946..667879564f 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4093,7 +4093,7 @@ static bool do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
 
 static bool trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_sh);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sh);
 }
 
 static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
@@ -4103,7 +4103,7 @@ static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 
 static bool trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_dh);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_dh);
 }
 
 static bool trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
-- 
2.17.1
