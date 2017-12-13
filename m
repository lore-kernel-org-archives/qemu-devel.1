Received: from eggs.gnu.org ([2001:4830:134:3::10]:39378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtl-000457-8Z
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtk-0006Nc-8P
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:01 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:40046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtk-0006N8-3o
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:00 -0500
Received: by mail-qk0-x242.google.com with SMTP id b123so3681954qkg.7
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:45:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:28 -0300
Message-Id: <20171213204436.5379-4-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/11] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/core.c       | 25 +++++++++++++++++++++----
 hw/sd/trace-events |  6 ++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index bd9350d21c..eda595973b 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -21,7 +21,14 @@
 
 #include "qemu/osdep.h"
 #include "hw/sd/sd.h"
+#include "qemu/cutils.h"
 #include "sd-internal.h"
+#include "trace.h"
+
+static inline const char *sdbus_name(SDBus *sdbus)
+{
+    return sdbus->qbus.name;
+}
 
 static SDState *get_card(SDBus *sdbus)
 {
@@ -37,20 +44,28 @@ static SDState *get_card(SDBus *sdbus)
 int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
 {
     SDState *card = get_card(sdbus);
+    int sz = 0;
+    char *hexbuf;
 
+    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc);
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
-        return sc->do_command(card, req, response);
+        sz = sc->do_command(card, req, response);
+        hexbuf = qemu_hexbuf_strdup(response, sz, NULL, "resp: ");
+        trace_sdbus_command_response(sdbus_name(sdbus),
+                                     req->cmd, req->arg, hexbuf);
+        g_free(hexbuf);
     }
 
-    return 0;
+    return sz;
 }
 
 void sdbus_write_data(SDBus *sdbus, uint8_t value)
 {
     SDState *card = get_card(sdbus);
 
+    trace_sdbus_write(sdbus_name(sdbus), value);
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
@@ -61,14 +76,16 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
 uint8_t sdbus_read_data(SDBus *sdbus)
 {
     SDState *card = get_card(sdbus);
+    uint8_t value = 0;
 
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
-        return sc->read_data(card);
+        value = sc->read_data(card);
     }
+    trace_sdbus_read(sdbus_name(sdbus), value);
 
-    return 0;
+    return value;
 }
 
 bool sdbus_data_ready(SDBus *sdbus)
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 11f8fa4fc1..6b1dc7380f 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,11 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/sd/core.c
+sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t crc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
+sdbus_command_response(const char *bus_name, uint8_t cmd, uint32_t arg, const char *hexdump) "@%s CMD%02d arg 0x%08x %s"
+sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
+sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
+
 # hw/sd/sdhci.c
 sdhci_set_inserted(const char *level) "card state changed: %s"
 sdhci_send_command(uint8_t cmd, uint32_t arg) "sending CMD%02u ARG[0x%08x]"
-- 
2.15.1
