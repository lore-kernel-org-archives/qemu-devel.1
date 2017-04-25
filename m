Received: from eggs.gnu.org ([2001:4830:134:3::10]:55156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zhl-0007rK-9O
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zhk-00052g-Dp
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:36:29 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:07:04 +0100
Message-Id: <1493122030-32191-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/13] arm: Remove unnecessary check on
 cpu->pmsav7_dregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

Now that we enforce both:
 * pmsav7_dregion == 0 implies has_mpu == false
 * PMSA with has_mpu == false means SCTLR.M cannot be set
we can remove a check on pmsav7_dregion from get_phys_addr_pmsav7(),
because we can only reach this code path if the MPU is enabled
(and so region_translation_disabled() returned false).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f0f25c8..5c044d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8227,8 +8227,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
         }
 
         if (n == -1) { /* no hits */
-            if (cpu->pmsav7_dregion &&
-                (is_user || !(regime_sctlr(env, mmu_idx) & SCTLR_BR))) {
+            if (is_user || !(regime_sctlr(env, mmu_idx) & SCTLR_BR)) {
                 /* background fault */
                 *fsr = 0;
                 return true;
-- 
2.7.4
