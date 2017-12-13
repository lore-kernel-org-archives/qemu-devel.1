Received: from eggs.gnu.org ([2001:4830:134:3::10]:60931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMX-00061M-Ja
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMS-0008G8-Iw
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:53 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMS-0008Fm-F0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:48 -0500
Received: by mail-qt0-x243.google.com with SMTP id e2so5921792qti.0
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:13 -0300
Message-Id: <20171213232025.24503-15-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 14/26] sdcard: use qemu_hexbuf_strdup() to
 trace command response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Isaac Lozano <109lozanoi@gmail.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 26 +++++++-------------------
 hw/sd/trace-events |  1 +
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 84e02745f1..2a249b1612 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -35,6 +35,7 @@
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
+#include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -42,15 +43,6 @@
 #include "sd-internal.h"
 #include "trace.h"
 
-//#define DEBUG_SD 1
-
-#ifdef DEBUG_SD
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
-
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
@@ -1595,17 +1587,13 @@ send_response:
         sd->card_status &= ~CARD_STATUS_B;
     }
 
-#ifdef DEBUG_SD
-    if (rsplen) {
-        int i;
-        DPRINTF("Response:");
-        for (i = 0; i < rsplen; i++)
-            fprintf(stderr, " %02x", response[i]);
-        fprintf(stderr, " state %d\n", sd->state);
-    } else {
-        DPRINTF("No response %d\n", sd->state);
+    if (trace_event_get_state_backends(TRACE_SDCARD_COMMAND_RESPONSE)) {
+        char *hexbuf;
+
+        hexbuf = qemu_hexbuf_strdup(response, rsplen, NULL, "(no response)");
+        trace_sdcard_command_response(hexbuf, sd_state_name(sd->state));
+        g_free(hexbuf);
     }
-#endif
 
     return rsplen;
 }
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 0e78f980de..01f94c4b54 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -26,6 +26,7 @@ sdcard_set_mode(const char *current_mode, const char *new_mode, const char *stat
 sdcard_set_state(const char *current_state, const char *new_state, const char *mode) "%s -> %s (mode: %s)"
 sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
 sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_command_response(const char *hexdump, const char *state) "%s (state %s)"
 sdcard_reset(void) ""
 sdcard_inserted(bool readonly) "read_only: %d"
 sdcard_ejected(void) ""
-- 
2.15.1
