Received: from eggs.gnu.org ([2001:4830:134:3::10]:56061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iv-0001ge-6N
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iu-0003kG-5h
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dc9it-0003ax-VB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:23:00 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ig-0000sH-Ta
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:22:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:22:40 +0100
Message-Id: <1501503765-15639-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
References: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/7] target/arm: Don't do MPU lookups for
 addresses in M profile PPB region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The M profile PMSAv7 specification says that if the address being looked
up is in the PPB region (0xe0000000 - 0xe00fffff) then we do not use
the MPU regions but always use the default memory map. Implement this
(we were previously behaving like an R profile PMSAv7, which does not
special case this).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1501153150-19984-2-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9ed5096..3d60575 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8244,6 +8244,13 @@ static bool pmsav7_use_background_region(ARMCPU *cpu,
     }
 }
 
+static inline bool m_is_ppb_region(CPUARMState *env, uint32_t address)
+{
+    /* True if address is in the M profile PPB region 0xe0000000 - 0xe00fffff */
+    return arm_feature(env, ARM_FEATURE_M) &&
+        extract32(address, 20, 12) == 0xe00;
+}
+
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                                  int access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot, uint32_t *fsr)
@@ -8255,7 +8262,15 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
     *phys_ptr = address;
     *prot = 0;
 
-    if (regime_translation_disabled(env, mmu_idx)) { /* MPU disabled */
+    if (regime_translation_disabled(env, mmu_idx) ||
+        m_is_ppb_region(env, address)) {
+        /* MPU disabled or M profile PPB access: use default memory map.
+         * The other case which uses the default memory map in the
+         * v7M ARM ARM pseudocode is exception vector reads from the vector
+         * table. In QEMU those accesses are done in arm_v7m_load_vector(),
+         * which always does a direct read using address_space_ldl(), rather
+         * than going via this function, so we don't need to check that here.
+         */
         get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
     } else { /* MPU enabled */
         for (n = (int)cpu->pmsav7_dregion - 1; n >= 0; n--) {
-- 
2.7.4
