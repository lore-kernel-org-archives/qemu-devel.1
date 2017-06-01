Received: from eggs.gnu.org ([2001:4830:134:3::10]:35114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcV-00014j-UF
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcU-000694-Re
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcU-00068M-K1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcT-0007Qt-Ki
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:45 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:22 +0100
Message-Id: <1496337035-30213-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/27] armv7m: Improve "-d mmu" tracing for
 PMSAv7 MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

Improve the "-d mmu" tracing for the PMSAv7 MPU translation
process as an aid in debugging guest MPU configurations:
 * fix a missing newline for a guest-error log
 * report the region number with guest-error or unimp
   logs of bad region register values
 * add a log message for the overall result of the lookup
 * print "0x" prefix for hex values

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1493122030-32191-9-git-send-email-peter.maydell@linaro.org
[PMM: a little tidyup, report region number in all messages
 rather than just one]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5c044d0..9e1ed1c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8169,16 +8169,18 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
             }
 
             if (!rsize) {
-                qemu_log_mask(LOG_GUEST_ERROR, "DRSR.Rsize field can not be 0");
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "DRSR[%d]: Rsize field cannot be 0\n", n);
                 continue;
             }
             rsize++;
             rmask = (1ull << rsize) - 1;
 
             if (base & rmask) {
-                qemu_log_mask(LOG_GUEST_ERROR, "DRBAR %" PRIx32 " misaligned "
-                              "to DRSR region size, mask = %" PRIx32,
-                              base, rmask);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "DRBAR[%d]: 0x%" PRIx32 " misaligned "
+                              "to DRSR region size, mask = 0x%" PRIx32 "\n",
+                              n, base, rmask);
                 continue;
             }
 
@@ -8215,9 +8217,10 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                 }
             }
             if (rsize < TARGET_PAGE_BITS) {
-                qemu_log_mask(LOG_UNIMP, "No support for MPU (sub)region"
+                qemu_log_mask(LOG_UNIMP,
+                              "DRSR[%d]: No support for MPU (sub)region "
                               "alignment of %" PRIu32 " bits. Minimum is %d\n",
-                              rsize, TARGET_PAGE_BITS);
+                              n, rsize, TARGET_PAGE_BITS);
                 continue;
             }
             if (srdis) {
@@ -8251,8 +8254,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                     break;
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
-                                  "Bad value for AP bits in DRACR %"
-                                  PRIx32 "\n", ap);
+                                  "DRACR[%d]: Bad value for AP bits: 0x%"
+                                  PRIx32 "\n", n, ap);
                 }
             } else { /* Priv. mode AP bits decoding */
                 switch (ap) {
@@ -8269,8 +8272,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                     break;
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
-                                  "Bad value for AP bits in DRACR %"
-                                  PRIx32 "\n", ap);
+                                  "DRACR[%d]: Bad value for AP bits: 0x%"
+                                  PRIx32 "\n", n, ap);
                 }
             }
 
@@ -8448,9 +8451,21 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
      */
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
         arm_feature(env, ARM_FEATURE_V7)) {
+        bool ret;
         *page_size = TARGET_PAGE_SIZE;
-        return get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
-                                    phys_ptr, prot, fsr);
+        ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
+                                   phys_ptr, prot, fsr);
+        qemu_log_mask(CPU_LOG_MMU, "PMSAv7 MPU lookup for %s at 0x%08" PRIx32
+                      " mmu_idx %u -> %s (prot %c%c%c)\n",
+                      access_type == 1 ? "reading" :
+                      (access_type == 2 ? "writing" : "execute"),
+                      (uint32_t)address, mmu_idx,
+                      ret ? "Miss" : "Hit",
+                      *prot & PAGE_READ ? 'r' : '-',
+                      *prot & PAGE_WRITE ? 'w' : '-',
+                      *prot & PAGE_EXEC ? 'x' : '-');
+
+        return ret;
     }
 
     if (regime_translation_disabled(env, mmu_idx)) {
-- 
2.7.4
