Received: from eggs.gnu.org ([2001:4830:134:3::10]:60701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMA-0005ga-VG
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMA-0007xB-3R
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:30 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGM9-0007wq-Vx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:30 -0500
Received: by mail-qk0-x241.google.com with SMTP id c13so4150591qke.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:09 -0300
Message-Id: <20171213232025.24503-11-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/26] sdcard: use more detailled state/mode
 trace events
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

sd_set_mode() can now use sd_state_name(),
and sd_set_state() use sd_mode_name().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 6 ++++--
 hw/sd/trace-events | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bd4a896cba..c1ed7b59f1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -161,7 +161,8 @@ static const char *sd_state_name(enum SDCardStates state)
 static void sd_set_mode(SDState *sd, enum SDCardModes mode)
 {
     if (sd->mode != mode) {
-        trace_sdcard_set_mode(sd_mode_name(sd->mode), sd_mode_name(mode));
+        trace_sdcard_set_mode(sd_mode_name(sd->mode), sd_mode_name(mode),
+                              sd_state_name(sd->state));
         sd->mode = mode;
     }
 }
@@ -193,7 +194,8 @@ static void sd_update_mode(SDState *sd)
 static void sd_set_state(SDState *sd, enum SDCardStates state)
 {
     if (sd->state != state) {
-        trace_sdcard_set_state(sd_state_name(sd->state), sd_state_name(state));
+        trace_sdcard_set_state(sd_state_name(sd->state), sd_state_name(state),
+                               sd_mode_name(sd->mode));
         sd->state = state;
     }
 }
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 2677c2195d..db5a5e62f2 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -22,8 +22,8 @@ sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of
 sdhci_led(bool state) "LED: %u"
 
 # hw/sd/sd.c
-sdcard_set_mode(const char *current_mode, const char *new_mode) "%s -> %s"
-sdcard_set_state(const char *current_state, const char *new_state) "%s -> %s"
+sdcard_set_mode(const char *current_mode, const char *new_mode, const char *state) "%s -> %s (state: %s)"
+sdcard_set_state(const char *current_state, const char *new_state, const char *mode) "%s -> %s (mode: %s)"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
