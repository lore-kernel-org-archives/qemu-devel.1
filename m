Received: from eggs.gnu.org ([2001:4830:134:3::10]:59130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQj-0000p0-3O
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQh-000271-CJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQg-00024i-Dq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQf-0000Ac-D5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:09 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:33 +0100
Message-Id: <20180816133438.17061-26-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/30] target/arm: Ignore
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
---
 target/arm/helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0fc6d2e2139..a3124082a63 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11312,9 +11312,13 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
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
2.18.0
