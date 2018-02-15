Received: from eggs.gnu.org ([2001:4830:134:3::10]:52764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2I-00085l-E2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2H-000538-Fk
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emK2H-00052A-9u
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2G-0001ol-7n
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:57:16 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:56:58 +0000
Message-Id: <20180215135702.1340-18-peter.maydell@linaro.org>
In-Reply-To: <20180215135702.1340-1-peter.maydell@linaro.org>
References: <20180215135702.1340-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/21] target/arm: Implement writing to
 CONTROL_NS for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit 50f11062d4c896 we added support for MSR/MRS access
to the NS banked special registers, but we forgot to implement
the support for writing to CONTROL_NS. Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-8-peter.maydell@linaro.org
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 550dc3d290..1ae11997fb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10507,6 +10507,16 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
