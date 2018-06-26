Received: from eggs.gnu.org ([2001:4830:134:3::10]:48672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXsJN-0006Kv-IW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXsJM-0004lM-IX
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:03:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXsJM-0004ks-Bf
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:03:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 19:03:24 +0100
Message-Id: <20180626180324.5537-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] sd: Don't trace SDRequest crc field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We don't actually implement SD command CRC checking, because
for almost all of our SD controllers the CRC generation is
done in hardware, and so modelling CRC generation and checking
would be a bit pointless. (The exception is that milkymist-memcard
makes the guest software compute the CRC.)

As a result almost all of our SD controller models don't bother
to set the SDRequest crc field, and the SD card model doesn't
check it. So the tracing of it in sdbus_do_command() provokes
Coverity warnings about use of uninitialized data.

Drop the CRC field from the trace; we can always add it back
if and when we do anything useful with the CRC.

Fixes Coverity issues 1386072, 1386074, 1386076, 1390571.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We might also want to try to improve our CRC handling
(eg so that the controller can say "I have not set the CRC,
don't bother checking it" or "I have set the CRC, do check
it because it's come from the guest software"), but let's
put in the simple tweak to make Coverity happy for the moment.
---
 hw/sd/core.c       | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index 820345f704b..107e6d71ddb 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -91,7 +91,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
 {
     SDState *card = get_card(sdbus);
 
-    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc);
+    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg);
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index bfd1d62efcb..43cffab8b17 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -7,7 +7,7 @@ bcm2835_sdhost_edm_change(const char *why, uint32_t edm) "(%s) EDM now 0x%x"
 bcm2835_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x\n"
 
 # hw/sd/core.c
-sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t crc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
+sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg) "@%s CMD%02d arg 0x%08x"
 sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
 sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
 sdbus_set_voltage(const char *bus_name, uint16_t millivolts) "@%s %u (mV)"
-- 
2.17.1
