Received: from eggs.gnu.org ([2001:4830:134:3::10]:53975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7KTp-0007jB-Pg
	for qemu-devel@nongnu.org; Sun, 07 May 2017 07:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7KTo-0004Xw-UF
	for qemu-devel@nongnu.org; Sun, 07 May 2017 07:36:01 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  7 May 2017 13:35:40 +0200
Message-Id: <20170507113540.8687-4-krzk@kernel.org>
In-Reply-To: <20170507113540.8687-1-krzk@kernel.org>
References: <20170507113540.8687-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 3/3] hw/arm/exynos: Add support for system
 poweroff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Krzysztof Kozlowski <krzk@kernel.org>

On all Exynos-based boards, the system powers down itself by driving
PS_HOLD signal low.  Handle writing to respective PMU register to fix
power off failure:

    reboot: Power down
    Unable to poweroff system
    shutdown: 31 output lines suppressed due to ratelimiting
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000

    CPU: 0 PID: 1 Comm: shutdown Not tainted 4.11.0-rc8 #846
    Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
    [<c031050c>] (unwind_backtrace) from [<c030ba6c>] (show_stack+0x10/0x14)
    [<c030ba6c>] (show_stack) from [<c05b2800>] (dump_stack+0x88/0x9c)
    [<c05b2800>] (dump_stack) from [<c03d3140>] (panic+0xdc/0x268)
    [<c03d3140>] (panic) from [<c0343614>] (do_exit+0xa90/0xab4)
    [<c0343614>] (do_exit) from [<c035f2dc>] (SyS_reboot+0x164/0x1d0)
    [<c035f2dc>] (SyS_reboot) from [<c0307c80>] (ret_fast_syscall+0x0/0x3c)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/misc/exynos4210_pmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 63a8ccd35559..2046e6313f10 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "sysemu/sysemu.h"
 
 #ifndef DEBUG_PMU
 #define DEBUG_PMU           0
@@ -397,6 +398,12 @@ typedef struct Exynos4210PmuState {
     uint32_t reg[PMU_NUM_OF_REGISTERS];
 } Exynos4210PmuState;
 
+static void exynos4210_pmu_poweroff(void)
+{
+    PRINT_DEBUG("QEMU PMU: PS_HOLD bit down, powering off\n");
+    qemu_system_shutdown_request();
+}
+
 static uint64_t exynos4210_pmu_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
@@ -428,6 +435,13 @@ static void exynos4210_pmu_write(void *opaque, hwaddr offset,
             PRINT_DEBUG_EXTEND("%s <0x%04x> <- 0x%04x\n", reg_p->name,
                     (uint32_t)offset, (uint32_t)val);
             s->reg[i] = val;
+            if ((offset == PS_HOLD_CONTROL) && ((val & BIT(8)) == 0)) {
+                /*
+                 * We are interested only in setting data bit
+                 * of PS_HOLD_CONTROL register to indicate power off request.
+                 */
+                exynos4210_pmu_poweroff();
+            }
             return;
         }
         reg_p++;
-- 
2.9.3
