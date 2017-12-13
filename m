Received: from eggs.gnu.org ([2001:4830:134:3::10]:60525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLw-0005Si-4B
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLr-0007d6-3X
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:16 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:43003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLq-0007ch-Vo
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:11 -0500
Received: by mail-qk0-x242.google.com with SMTP id a71so4148448qkc.9
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:06 -0300
Message-Id: <20171213232025.24503-8-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/26] sdcard: add sdcard_set_mode() trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Use sd_mode_name() to pretty-print the SDCardMode.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 16 +++++++++++++++-
 hw/sd/trace-events |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2c0f8a7dbd..465d254f2e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -40,6 +40,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "sd-internal.h"
+#include "trace.h"
 
 //#define DEBUG_SD 1
 
@@ -128,9 +129,22 @@ struct SDState {
     bool enable;
 };
 
+static const char *sd_mode_name(enum SDCardModes mode)
+{
+    static const char *mode_name[] = {
+        [sd_inactive]                   = "inactive",
+        [sd_card_identification_mode]   = "card_identification",
+        [sd_data_transfer_mode]         = "data_transfer",
+    };
+    return mode_name[mode];
+}
+
 static void sd_set_mode(SDState *sd, enum SDCardModes mode)
 {
-    sd->mode = mode;
+    if (sd->mode != mode) {
+        trace_sdcard_set_mode(sd_mode_name(sd->mode), sd_mode_name(mode));
+        sd->mode = mode;
+    }
 }
 
 static void sd_update_mode(SDState *sd)
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 6b1dc7380f..369d258d10 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -21,6 +21,9 @@ sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been read fr
 sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of data"
 sdhci_led(bool state) "LED: %u"
 
+# hw/sd/sd.c
+sdcard_set_mode(const char *current_mode, const char *new_mode) "%s -> %s"
+
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
