Received: from eggs.gnu.org ([2001:4830:134:3::10]:41162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0H-00041D-8m
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ekC0G-0007vO-BK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:58:25 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 16:58:06 +0000
Message-Id: <20180209165810.6668-8-peter.maydell@linaro.org>
In-Reply-To: <20180209165810.6668-1-peter.maydell@linaro.org>
References: <20180209165810.6668-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 07/11] target/arm: Implement writing to
 CONTROL_NS for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

In commit 50f11062d4c896 we added support for MSR/MRS access
to the NS banked special registers, but we forgot to implement
the support for writing to CONTROL_NS. Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 180ab75458..7c1dcb0330 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10519,6 +10519,16 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             }
             env->v7m.faultmask[M_REG_NS] = val & 1;
             return;
+        case 0x94: /* CONTROL_NS */
+            if (!env->v7m.secure) {
+                return;
+            }
+            write_v7m_control_spsel_for_secstate(env,
+                                                 val & R_V7M_CONTROL_SPSEL_MASK,
+                                                 M_REG_NS);
+            env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
+            env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;
+            return;
         case 0x98: /* SP_NS */
         {
             /* This gives the non-secure SP selected based on whether we're
-- 
2.16.1
