Received: from eggs.gnu.org ([209.51.188.92]:43265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47Z-0004Dk-6w
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47I-0005Fx-QG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47F-0004xG-Pz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L505h140533
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:01 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksqasqe4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:05:00 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:44 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:49 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-16-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 15/97] target/arm: Use fp_status_fp16 for
 do_fmpa_zpzzz_h
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

This makes float16_muladd correctly use FZ16 not FZ.

Fixes: 6ceabaad110
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 52a339b11d1719a6589de40606859939875fda9a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index e03f954a26..0f98097253 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3358,7 +3358,7 @@ static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
                 e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
                 e2 = *(uint16_t *)(vm + H1_2(i));
                 e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
-                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
+                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status_f16);
                 *(uint16_t *)(vd + H1_2(i)) = r;
             }
         } while (i & 63);
-- 
2.17.1
