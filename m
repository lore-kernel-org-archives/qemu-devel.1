Received: from eggs.gnu.org ([209.51.188.92]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTz-0006uv-4E
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTs-0000Vg-ED
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:06 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJTq-0000Uf-DF
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:03 -0500
Received: by mail-pf1-x443.google.com with SMTP id q1so2580848pfi.5
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:39:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:41 -0800
Message-Id: <20190209033847.9014-7-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 06/12] target/arm: Fix vfp_gdb_get/set_reg
 vs FPSCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The components of this register is stored in several
different locations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 520ceea7a4..6ac81c2ca2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -81,7 +81,7 @@ static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
     }
     switch (reg - nregs) {
     case 0: stl_p(buf, env->vfp.xregs[ARM_VFP_FPSID]); return 4;
-    case 1: stl_p(buf, env->vfp.xregs[ARM_VFP_FPSCR]); return 4;
+    case 1: stl_p(buf, vfp_get_fpscr(env)); return 4;
     case 2: stl_p(buf, env->vfp.xregs[ARM_VFP_FPEXC]); return 4;
     }
     return 0;
@@ -107,7 +107,7 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
     }
     switch (reg - nregs) {
     case 0: env->vfp.xregs[ARM_VFP_FPSID] = ldl_p(buf); return 4;
-    case 1: env->vfp.xregs[ARM_VFP_FPSCR] = ldl_p(buf); return 4;
+    case 1: vfp_set_fpscr(env, ldl_p(buf)); return 4;
     case 2: env->vfp.xregs[ARM_VFP_FPEXC] = ldl_p(buf) & (1 << 30); return 4;
     }
     return 0;
-- 
2.17.2
