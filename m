Received: from eggs.gnu.org ([2001:4830:134:3::10]:33160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTc-0005I4-BN
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTb-0006hn-CD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTb-0006cz-4B
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTS-00013q-0R
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:06:58 +0100
Message-Id: <1497362826-21125-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/17] hw/misc/exynos4210_pmu: Add support for
 system poweroff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Krzysztof Kozlowski <krzk@kernel.org>

On all Exynos-based boards, the system powers down itself by driving
PS_HOLD signal low - eight bit in PS_HOLD_CONTROL register of PMU.
Handle writing to respective PMU register to fix power off failure:

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

Additionally the initial value of PS_HOLD has to be changed because
recent Linux kernel (v4.12-rc1) uses regmap cache for this access.
When the register is kept at reset value, the kernel will not issue a
write to it.  Usually the bootloader sets the eight bit of PS_HOLD high
so mimic its existence here.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/exynos4210_pmu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 63a8ccd..0d7b64c 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "sysemu/sysemu.h"
 
 #ifndef DEBUG_PMU
 #define DEBUG_PMU           0
@@ -350,7 +351,11 @@ static const Exynos4210PmuReg exynos4210_pmu_regs[] = {
     {"PAD_RETENTION_MMCB_OPTION", PAD_RETENTION_MMCB_OPTION, 0x00000000},
     {"PAD_RETENTION_EBIA_OPTION", PAD_RETENTION_EBIA_OPTION, 0x00000000},
     {"PAD_RETENTION_EBIB_OPTION", PAD_RETENTION_EBIB_OPTION, 0x00000000},
-    {"PS_HOLD_CONTROL", PS_HOLD_CONTROL, 0x00005200},
+    /*
+     * PS_HOLD_CONTROL: reset value and manually toggle high the DATA bit.
+     * DATA bit high, set usually by bootloader, keeps system on.
+     */
+    {"PS_HOLD_CONTROL", PS_HOLD_CONTROL, 0x00005200 | BIT(8)},
     {"XUSBXTI_CONFIGURATION", XUSBXTI_CONFIGURATION, 0x00000001},
     {"XUSBXTI_STATUS", XUSBXTI_STATUS, 0x00000001},
     {"XUSBXTI_DURATION", XUSBXTI_DURATION, 0xFFF00000},
@@ -397,6 +402,12 @@ typedef struct Exynos4210PmuState {
     uint32_t reg[PMU_NUM_OF_REGISTERS];
 } Exynos4210PmuState;
 
+static void exynos4210_pmu_poweroff(void)
+{
+    PRINT_DEBUG("QEMU PMU: PS_HOLD bit down, powering off\n");
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
 static uint64_t exynos4210_pmu_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
@@ -428,6 +439,13 @@ static void exynos4210_pmu_write(void *opaque, hwaddr offset,
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
2.7.4
