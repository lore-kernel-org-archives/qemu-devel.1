Received: from eggs.gnu.org ([2001:4830:134:3::10]:56045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iu-0001fb-8C
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9it-0003jh-Cd
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:00 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dc9it-0003ax-4y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:59 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ih-0000ss-Ct
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:22:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:22:41 +0100
Message-Id: <1501503765-15639-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
References: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/7] target/arm: Don't allow guest to make
 System space executable for M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For an M profile v7PMSA, the system space (0xe0000000 - 0xffffffff) can
never be executable, even if the guest tries to set the MPU registers
up that way. Enforce this restriction.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1501153150-19984-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3d60575..f0299c5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8251,6 +8251,14 @@ static inline bool m_is_ppb_region(CPUARMState *env, uint32_t address)
         extract32(address, 20, 12) == 0xe00;
 }
 
+static inline bool m_is_system_region(CPUARMState *env, uint32_t address)
+{
+    /* True if address is in the M profile system region
+     * 0xe0000000 - 0xffffffff
+     */
+    return arm_feature(env, ARM_FEATURE_M) && extract32(address, 29, 3) == 0x7;
+}
+
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                                  int access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot, uint32_t *fsr)
@@ -8354,6 +8362,12 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
             get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
         } else { /* a MPU hit! */
             uint32_t ap = extract32(env->pmsav7.dracr[n], 8, 3);
+            uint32_t xn = extract32(env->pmsav7.dracr[n], 12, 1);
+
+            if (m_is_system_region(env, address)) {
+                /* System space is always execute never */
+                xn = 1;
+            }
 
             if (is_user) { /* User mode AP bit decoding */
                 switch (ap) {
@@ -8394,7 +8408,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
             }
 
             /* execute never */
-            if (env->pmsav7.dracr[n] & (1 << 12)) {
+            if (xn) {
                 *prot &= ~PAGE_EXEC;
             }
         }
-- 
2.7.4
