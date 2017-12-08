Received: from eggs.gnu.org ([2001:4830:134:3::10]:40292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNJP5-0005Ec-2O
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNJP4-0001g2-7U
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:13:27 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Dec 2017 14:13:22 +0000
Message-Id: <1512742402-31669-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] get_phys_addr_pmsav7: Support AP=0b111 for v7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Andy Gross <andy.gross@linaro.org>

For PMSAv7, the v7A/R Arm ARM defines that setting AP to 0b111
is an UNPREDICTABLE reserved combination. However, for v7M
this value is documented as having the same behaviour as 0b110:
read-only for both privileged and unprivileged. Accept this
value on an M profile core rather than treating it as a guest
error and a no-access page.

Reported-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 91a9300..2f53dd8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9229,6 +9229,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                 case 6:
                     *prot |= PAGE_READ | PAGE_EXEC;
                     break;
+                case 7:
+                    /* for v7M, same as 6; for R profile a reserved value */
+                    if (arm_feature(env, ARM_FEATURE_M)) {
+                        *prot |= PAGE_READ | PAGE_EXEC;
+                        break;
+                    }
+                    /* fall through */
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
                                   "DRACR[%d]: Bad value for AP bits: 0x%"
@@ -9247,6 +9254,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                 case 6:
                     *prot |= PAGE_READ | PAGE_EXEC;
                     break;
+                case 7:
+                    /* for v7M, same as 6; for R profile a reserved value */
+                    if (arm_feature(env, ARM_FEATURE_M)) {
+                        *prot |= PAGE_READ | PAGE_EXEC;
+                        break;
+                    }
+                    /* fall through */
                 default:
                     qemu_log_mask(LOG_GUEST_ERROR,
                                   "DRACR[%d]: Bad value for AP bits: 0x%"
-- 
2.7.4
