Received: from eggs.gnu.org ([209.51.188.92]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43v-0000o2-WA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43u-00032l-5v
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB43t-00031H-GZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrVht035181
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:43 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4ryj4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:43 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:42 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:48 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-15-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 14/97] target/arm: Ignore
 float_flag_input_denormal from fp_status_f16
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

When FZ is set, input_denormal exceptions are recognized, but this does
not happen with FZ16.  The softfloat code has no way to distinguish
these bits and will raise such exceptions into fp_status_f16.flags,
so ignore them when computing the accumulated flags.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 19062c169e5bcdda3d60df9161228e107bf0f96e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c2287c76e5..991b077e8f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11283,9 +11283,13 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
     fpscr = (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
             | (env->vfp.vec_len << 16)
             | (env->vfp.vec_stride << 20);
+
     i = get_float_exception_flags(&env->vfp.fp_status);
     i |= get_float_exception_flags(&env->vfp.standard_fp_status);
-    i |= get_float_exception_flags(&env->vfp.fp_status_f16);
+    /* FZ16 does not generate an input denormal exception.  */
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
+          & ~float_flag_input_denormal);
+
     fpscr |= vfp_exceptbits_from_host(i);
     return fpscr;
 }
-- 
2.17.1
