Received: from eggs.gnu.org ([2001:4830:134:3::10]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuG-0001PQ-1j
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuF-0008GE-2i
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:24 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:39449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRuE-0008Fr-VV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:09:23 -0500
Received: by mail-qk0-x244.google.com with SMTP id z197so4213758qkb.6
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:09:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:07:59 -0300
Message-Id: <20180213040809.26021-21-f4bug@amsat.org>
In-Reply-To: <20180213040809.26021-1-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 20/30] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/core.c       | 14 ++++++++++++--
 hw/sd/trace-events |  5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index 295dc44ab7..498284f109 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -23,6 +23,12 @@
 #include "hw/qdev-core.h"
 #include "sysemu/block-backend.h"
 #include "hw/sd/sd.h"
+#include "trace.h"
+
+static inline const char *sdbus_name(SDBus *sdbus)
+{
+    return sdbus->qbus.name;
+}
 
 static SDState *get_card(SDBus *sdbus)
 {
@@ -39,6 +45,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
 {
     SDState *card = get_card(sdbus);
 
+    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc);
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
@@ -52,6 +59,7 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
 {
     SDState *card = get_card(sdbus);
 
+    trace_sdbus_write(sdbus_name(sdbus), value);
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
@@ -62,14 +70,16 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
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
index 78d8707669..ea2746c8b7 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/sd/core.c
+sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t crc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
+sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
+sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
+
 # hw/sd/sdhci.c
 sdhci_set_inserted(const char *level) "card state changed: %s"
 sdhci_send_command(uint8_t cmd, uint32_t arg) "CMD%02u ARG[0x%08x]"
-- 
2.16.1
