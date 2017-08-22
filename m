Received: from eggs.gnu.org ([2001:4830:134:3::10]:53488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAnt-0006Yh-8k
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dkAno-0003Ev-Or
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:08:43 +0100
Message-Id: <1503414539-28762-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 04/20] target/arm: Register second AddressSpace
 for secure v8M CPUs
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

If a v8M CPU supports the security extension then we need to
give it two AddressSpaces, the same way we do already for
an A profile core with EL3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
