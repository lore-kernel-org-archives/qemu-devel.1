Received: from eggs.gnu.org ([209.51.188.92]:52027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXj-0008NC-44
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXg-0007Mx-Eh
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:57:58 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXV-0007Gl-LK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:57:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id y15so10336961wma.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:57:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:20 +0000
Message-Id: <20190221185739.25362-3-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/21] target/arm: v8M MPU should use background
 region as default, not always
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190214113408.10214-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a018eb23fe2..fe054897c78 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11387,9 +11387,11 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
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
@@ -11427,7 +11429,7 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                 *is_subpage = true;
             }
 
-            if (hit) {
+            if (matchregion != -1) {
                 /* Multiple regions match -- always a failure (unlike
                  * PMSAv7 where highest-numbered-region wins)
                  */
-- 
2.20.1
