Received: from eggs.gnu.org ([2001:4830:134:3::10]:35081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcU-00013Z-LK
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcT-00068F-RQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcT-00064g-KB
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcS-0007QX-Rb
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:21 +0100
Message-Id: <1496337035-30213-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/27] arm: Remove unnecessary check on
 cpu->pmsav7_dregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that we enforce both:
 * pmsav7_dregion == 0 implies has_mpu == false
 * PMSA with has_mpu == false means SCTLR.M cannot be set
we can remove a check on pmsav7_dregion from get_phys_addr_pmsav7(),
because we can only reach this code path if the MPU is enabled
(and so region_translation_disabled() returned false).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1493122030-32191-8-git-send-email-peter.maydell@linaro.org
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
