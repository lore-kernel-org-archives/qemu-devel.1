Received: from eggs.gnu.org ([2001:4830:134:3::10]:43920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F97-0008Va-9Y
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F94-0008BV-2n
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F93-0007wI-OT
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8q-0006sf-Bk
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:48 +0100
Message-Id: <1492706470-10921-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/24] hw/arm/exynos: Convert fprintf to
 qemu_log_mask/error_report
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

qemu_log_mask() and error_report() are preferred over fprintf() for
logging errors.  Also remove square brackets [] and additional new line
characters in printed messages.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20170313184750.429-2-krzk@kernel.org
[PMM: wrapped long line]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4_boards.c   |  7 ++++---
 hw/timer/exynos4210_mct.c |  6 ++++--
 hw/timer/exynos4210_pwm.c | 13 +++++++------
 hw/timer/exynos4210_rtc.c | 19 ++++++++++---------
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 0efa194..4853c31 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
@@ -101,9 +102,9 @@ static Exynos4210State *exynos4_boards_init_common(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (smp_cpus != EXYNOS4210_NCPUS && !qtest_enabled()) {
-        fprintf(stderr, "%s board supports only %d CPU cores. Ignoring smp_cpus"
-                " value.\n",
-                mc->name, EXYNOS4210_NCPUS);
+        error_report("%s board supports only %d CPU cores, ignoring smp_cpus"
+                     " value",
+                     mc->name, EXYNOS4210_NCPUS);
     }
 
     exynos4_board_binfo.ram_size = exynos4_board_ram_size[board_type];
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 0c18934..a2ec392 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -53,6 +53,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
@@ -1372,8 +1373,9 @@ break;
     case L0_TCNTO: case L1_TCNTO:
     case L0_ICNTO: case L1_ICNTO:
     case L0_FRCNTO: case L1_FRCNTO:
-        fprintf(stderr, "\n[exynos4210.mct: write to RO register "
-                TARGET_FMT_plx "]\n\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.mct: write to RO register " TARGET_FMT_plx,
+                      offset);
         break;
 
     case L0_INT_CSTAT: case L1_INT_CSTAT:
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index f576507..87f63f0 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu-common.h"
@@ -252,9 +253,9 @@ static uint64_t exynos4210_pwm_read(void *opaque, hwaddr offset,
         break;
 
     default:
-        fprintf(stderr,
-                "[exynos4210.pwm: bad read offset " TARGET_FMT_plx "]\n",
-                offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.pwm: bad read offset " TARGET_FMT_plx,
+                      offset);
         break;
     }
     return value;
@@ -343,9 +344,9 @@ static void exynos4210_pwm_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        fprintf(stderr,
-                "[exynos4210.pwm: bad write offset " TARGET_FMT_plx "]\n",
-                offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.pwm: bad write offset " TARGET_FMT_plx,
+                      offset);
         break;
 
     }
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 1a648c5..4607833 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu-common.h"
@@ -370,9 +371,9 @@ static uint64_t exynos4210_rtc_read(void *opaque, hwaddr offset,
         break;
 
     default:
-        fprintf(stderr,
-                "[exynos4210.rtc: bad read offset " TARGET_FMT_plx "]\n",
-                offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.rtc: bad read offset " TARGET_FMT_plx,
+                      offset);
         break;
     }
     return value;
@@ -433,9 +434,9 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
         if (value > TICNT_THRESHOLD) {
             s->reg_ticcnt = value;
         } else {
-            fprintf(stderr,
-                    "[exynos4210.rtc: bad TICNT value %u ]\n",
-                    (uint32_t)value);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "exynos4210.rtc: bad TICNT value %u",
+                          (uint32_t)value);
         }
         break;
 
@@ -500,9 +501,9 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        fprintf(stderr,
-                "[exynos4210.rtc: bad write offset " TARGET_FMT_plx "]\n",
-                offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.rtc: bad write offset " TARGET_FMT_plx,
+                      offset);
         break;
 
     }
-- 
2.7.4
