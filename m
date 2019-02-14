Received: from eggs.gnu.org ([209.51.188.92]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guFHQ-0003wY-UT
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guFHQ-0008Mb-4x
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:34:12 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guFHP-0008L7-SV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:34:12 -0500
Received: by mail-wr1-x443.google.com with SMTP id o17so6107253wrw.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 11:34:08 +0000
Message-Id: <20190214113408.10214-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: v8M MPU should use background
 region as default, not always
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

The "background region" for a v8M MPU is a default which will be used
(if enabled, and if the access is privileged) if the access does
not match any specific MPU region. We were incorrectly using it
always (by putting the condition at the wrong nesting level). This
meant that we would always return the default background permissions
rather than the correct permissions for a specific region, and also
that we would not return the right information in response to a
TT instruction.

Move the check for the background region to the same place in the
logic as the equivalent v8M MPUCheck() pseudocode puts it.
This in turn means we must adjust the condition we use to detect
matches in multiple regions to avoid false-positives.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I found this because the incorrect TT response eventually resulted
in the Zephyr RTOS writing an invalid region number back to the
NVIC and tripping the guest_errors logging.
---
 target/arm/helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0f5eb3229b7..d3e15585c25 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11291,9 +11291,11 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
         hit = true;
     } else if (m_is_ppb_region(env, address)) {
         hit = true;
-    } else if (pmsav7_use_background_region(cpu, mmu_idx, is_user)) {
-        hit = true;
     } else {
+        if (pmsav7_use_background_region(cpu, mmu_idx, is_user)) {
+            hit = true;
+        }
+
         for (n = (int)cpu->pmsav7_dregion - 1; n >= 0; n--) {
             /* region search */
             /* Note that the base address is bits [31:5] from the register
@@ -11331,7 +11333,7 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                 *is_subpage = true;
             }
 
-            if (hit) {
+            if (matchregion != -1) {
                 /* Multiple regions match -- always a failure (unlike
                  * PMSAv7 where highest-numbered-region wins)
                  */
-- 
2.20.1
