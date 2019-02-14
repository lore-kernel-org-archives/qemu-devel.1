Received: from eggs.gnu.org ([209.51.188.92]:54077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLL-00084E-Ax
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLK-0004uN-89
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:43 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLJ-0004og-Ts
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:42 -0500
Received: by mail-wr1-x42c.google.com with SMTP id v13so7709602wrw.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.28 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:56 +0000
Message-Id: <20190214190603.25030-21-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/27] target/arm: Fix vfp_gdb_get/set_reg vs
 FPSCR
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

The components of this register is stored in several
different locations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-7-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7653aa6a50a..8eedce113c1 100644
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
2.20.1
