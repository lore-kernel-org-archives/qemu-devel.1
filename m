Received: from eggs.gnu.org ([209.51.188.92]:40418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43w-0000oZ-PQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43v-00033f-19
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB43t-00030l-Q8
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrYJ4050042
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqrc06gj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:41 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:40 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:47 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-14-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/97] target/arm: Adjust FPCR_MASK for FZ16
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

When support for FZ16 was added, we failed to include the bit
within FPCR_MASK, which means that it could never be set.
Continue to zero FZ16 when ARMv8.2-FP16 is not enabled.

Fixes: d81ce0ef2c4
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 0b62159be33d45d00dfa34a317c6d3da30ffb480)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/cpu.h    | 2 +-
 target/arm/helper.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9526ed27cb..0dce472aae 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1263,7 +1263,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
  * we store the underlying state in fpscr and just mask on read/write.
  */
 #define FPSR_MASK 0xf800009f
-#define FPCR_MASK 0x07f79f00
+#define FPCR_MASK 0x07ff9f00
 
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c24c66d43e..c2287c76e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11320,6 +11320,11 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
     int i;
     uint32_t changed;
 
+    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
+    if (!arm_feature(env, ARM_FEATURE_V8_FP16)) {
+        val &= ~FPCR_FZ16;
+    }
+
     changed = env->vfp.xregs[ARM_VFP_FPSCR];
     env->vfp.xregs[ARM_VFP_FPSCR] = (val & 0xffc8ffff);
     env->vfp.vec_len = (val >> 16) & 7;
-- 
2.17.1
