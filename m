Received: from eggs.gnu.org ([2001:4830:134:3::10]:56402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr1-0000zl-In
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqv-0007bx-Ar
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqv-0007ak-3z
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqp-0001Zi-6U
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:04 +0100
Message-Id: <1504790904-17018-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/31] target/arm: Register second AddressSpace
 for secure v8M CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If a v8M CPU supports the security extension then we need to
give it two AddressSpaces, the same way we do already for
an A profile core with EL3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-5-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f32317e..ae866be 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -843,22 +843,21 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     init_cpreg_list(cpu);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->has_el3) {
-        cs->num_ases = 2;
-    } else {
-        cs->num_ases = 1;
-    }
-
-    if (cpu->has_el3) {
+    if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         AddressSpace *as;
 
+        cs->num_ases = 2;
+
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
         as = address_space_init_shareable(cpu->secure_memory,
                                           "cpu-secure-memory");
         cpu_address_space_init(cs, as, ARMASIdx_S);
+    } else {
+        cs->num_ases = 1;
     }
+
     cpu_address_space_init(cs,
                            address_space_init_shareable(cs->memory,
                                                         "cpu-memory"),
-- 
2.7.4
