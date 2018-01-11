Received: from eggs.gnu.org ([2001:4830:134:3::10]:59756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjva-00073T-6f
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjvZ-0003Pl-AO
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:58:22 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:24 -0300
Message-Id: <20180111205626.23291-20-f4bug@amsat.org>
In-Reply-To: <20180111205626.23291-1-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 19/21] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index 0a121156a3..c0f51f11d4 100644
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
2.15.1
