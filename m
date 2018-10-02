Received: from eggs.gnu.org ([2001:4830:134:3::10]:54792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7M9T-0006rv-Ul
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7M9T-0002bH-6F
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:59:55 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 15:59:40 +0100
Message-Id: <20181002145940.30931-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: Correct condition for v8M callee
 stack push
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

In v7m_exception_taken() we were incorrectly using a
"LR bit EXCRET.ES is 1" check when it should be 0
(compare the pseudocode ExceptionTaken() function).
This meant we didn't stack the callee-saved registers
when tailchaining from a NonSecure to a Secure exception.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 64b15645944..073fb3c5cb0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6938,7 +6938,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                  * not already saved.
                  */
                 if (lr & R_V7M_EXCRET_DCRS_MASK &&
-                    !(dotailchain && (lr & R_V7M_EXCRET_ES_MASK))) {
+                    !(dotailchain && !(lr & R_V7M_EXCRET_ES_MASK))) {
                     push_failed = v7m_push_callee_stack(cpu, lr, dotailchain,
                                                         ignore_stackfaults);
                 }
-- 
2.19.0
