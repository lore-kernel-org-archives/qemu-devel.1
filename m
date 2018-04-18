Received: from eggs.gnu.org ([2001:4830:134:3::10]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8o5E-0006pl-8m
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8o5A-0003wk-DB
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:29:16 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Apr 2018 16:28:01 +0200
Message-Id: <1524061685-83305-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v2 1/5] arm: always start from
 first_cpu when registering loader cpu reset callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

if arm_load_kernel() were passed non first_cpu, QEMU would end up
with partially set do_cpu_reset() callback leaving some CPUs without it.

Make sure that do_cpu_reset() is registered for all CPUs by enumerating
CPUs from first_cpu.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 26184bc..9ae6ab2 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1188,7 +1188,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
      * actually loading a kernel, the handler is also responsible for
      * arranging that we start it correctly.
      */
-    for (cs = CPU(cpu); cs; cs = CPU_NEXT(cs)) {
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
         qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
     }
 }
-- 
2.7.4
