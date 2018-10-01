Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XV-00041R-N5
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OD-0007HF-HU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:43518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OD-0007Gg-93
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id n1-v6so5502285wrt.10
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:29 +0200
Message-Id: <20181001220942.2382-3-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/15] hw/timer/sun4v-rtc: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/sun4v-rtc.c  | 13 +++----------
 hw/timer/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 310523225f..13be94f8da 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -14,15 +14,8 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/timer/sun4v-rtc.h"
+#include "trace.h"
 
-//#define DEBUG_SUN4V_RTC
-
-#ifdef DEBUG_SUN4V_RTC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
 
 #define TYPE_SUN4V_RTC "sun4v_rtc"
 #define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
@@ -41,14 +34,14 @@ static uint64_t sun4v_rtc_read(void *opaque, hwaddr addr,
         /* accessing the high 32 bits */
         val >>= 32;
     }
-    DPRINTF("read from " TARGET_FMT_plx " val %lx\n", addr, val);
+    trace_sun4v_rtc_read(addr, val);
     return val;
 }
 
 static void sun4v_rtc_write(void *opaque, hwaddr addr,
                              uint64_t val, unsigned size)
 {
-    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
+    trace_sun4v_rtc_read(addr, val);
 }
 
 static const MemoryRegionOps sun4v_rtc_ops = {
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index ca9ad6321a..75bd3b1042 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -66,5 +66,9 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
+# hw/timer/sun4v-rtc.c
+sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
+sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
+
 # hw/timer/xlnx-zynqmp-rtc.c
 xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
-- 
2.19.0
