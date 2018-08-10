Received: from eggs.gnu.org ([2001:4830:134:3::10]:59043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8K-0002QL-LP
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8J-0005aP-O0
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:36 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD8J-0005ZR-IJ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:35 -0400
Received: by mail-pg1-x543.google.com with SMTP id y4-v6so4835842pgp.9
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 12:31:25 -0700
Message-Id: <20180810193129.1556-3-richard.henderson@linaro.org>
In-Reply-To: <20180810193129.1556-1-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/6] target/arm: Ignore
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

When FZ is set, input_denormal exceptions are recognized, but this does
not happen with FZ16.  The softfloat code has no way to distinguish
these bits and will raise such exceptions into fp_status_f16.flags,
so ignore them when computing the accumulated flags.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 452d5e182a..61454a77ec 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11314,9 +11314,13 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
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
