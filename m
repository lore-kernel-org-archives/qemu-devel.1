Received: from eggs.gnu.org ([2001:4830:134:3::10]:58282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6fI6-00045o-Le
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6fI5-00018k-VO
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:42 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 12 Apr 2018 18:40:20 +0200
Message-Id: <1523551221-11612-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 3/4] arm: always start from first_cpu
 when registering loader cpu reset callback
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
---
 hw/arm/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 2f464ca..2591fee 100644
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
