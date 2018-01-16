Received: from eggs.gnu.org ([2001:4830:134:3::10]:37460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNz-0008Gi-Qp
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNt-0002q4-Uf
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNt-0002my-O8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNj-0002pm-Do
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:33:57 +0000
Message-Id: <1516109659-1557-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/24] get_phys_addr_pmsav7: Support AP=0b111
 for v7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For PMSAv7, the v7A/R Arm ARM defines that setting AP to 0b111
is an UNPREDICTABLE reserved combination. However, for v7M
this value is documented as having the same behaviour as 0b110:
read-only for both privileged and unprivileged. Accept this
value on an M profile core rather than treating it as a guest
error and a no-access page.

Reported-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1512742402-31669-1-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1395f9..eb80f79 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9272,6 +9272,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
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
@@ -9290,6 +9297,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
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
