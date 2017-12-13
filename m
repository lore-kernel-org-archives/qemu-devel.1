Received: from eggs.gnu.org ([2001:4830:134:3::10]:60680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGM9-0005cv-0i
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGM5-0007sj-Lt
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:28 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGM5-0007sJ-I9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:25 -0500
Received: by mail-qt0-x243.google.com with SMTP id m59so5831582qte.11
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:08 -0300
Message-Id: <20171213232025.24503-10-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/26] sdcard: add a sdcard_set_state() trace
 event
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

and his sd_state_name() companion to pretty-print the SDCardState.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 24 +++++++++++++++++++++++-
 hw/sd/trace-events |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f67c9ff49c..bd4a896cba 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -139,6 +139,25 @@ static const char *sd_mode_name(enum SDCardModes mode)
     return mode_name[mode];
 }
 
+static const char *sd_state_name(enum SDCardStates state)
+{
+    static const char *state_name[] = {
+        [sd_idle_state]             = "idle",
+        [sd_ready_state]            = "ready",
+        [sd_identification_state]   = "identification",
+        [sd_standby_state]          = "standby",
+        [sd_transfer_state]         = "transfer",
+        [sd_sendingdata_state]      = "sendingdata",
+        [sd_receivingdata_state]    = "receivingdata",
+        [sd_programming_state]      = "programming",
+        [sd_disconnect_state]       = "disconnect",
+    };
+    if (state == sd_inactive_state) {
+        return "inactive";
+    }
+    return state_name[state];
+}
+
 static void sd_set_mode(SDState *sd, enum SDCardModes mode)
 {
     if (sd->mode != mode) {
@@ -173,7 +192,10 @@ static void sd_update_mode(SDState *sd)
 
 static void sd_set_state(SDState *sd, enum SDCardStates state)
 {
-    sd->state = state;
+    if (sd->state != state) {
+        trace_sdcard_set_state(sd_state_name(sd->state), sd_state_name(state));
+        sd->state = state;
+    }
 }
 
 static const sd_cmd_type_t sd_cmd_type[64] = {
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 369d258d10..2677c2195d 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -23,6 +23,7 @@ sdhci_led(bool state) "LED: %u"
 
 # hw/sd/sd.c
 sdcard_set_mode(const char *current_mode, const char *new_mode) "%s -> %s"
+sdcard_set_state(const char *current_state, const char *new_state) "%s -> %s"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
