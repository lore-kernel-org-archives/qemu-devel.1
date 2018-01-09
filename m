Received: from eggs.gnu.org ([2001:4830:134:3::10]:34426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYuTe-00077B-Pf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYuTe-0001BY-1B
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:02:06 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Jan 2018 14:01:51 +0000
Message-Id: <1515506513-31961-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] hw/sd/milkymist-memcard: Reset SD card on
 controller reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-stable@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Since pl181 is still using the legacy SD card API, the SD
card created by sd_init() is not plugged into any bus. This
means that the controller has to reset it manually.

Failing to do this mostly didn't affect the guest since the
guest typically does a programmed SD card reset as part of
its SD controller driver initialization, but meant that
migration failed because it's only in sd_reset() that we
set up the wpgrps_size field.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/milkymist-memcard.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 4008c81..341da88 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -248,6 +248,10 @@ static void milkymist_memcard_reset(DeviceState *d)
     for (i = 0; i < R_MAX; i++) {
         s->regs[i] = 0;
     }
+    /* Since we're still using the legacy SD API the card is not plugged
+     * into any bus, and we must reset it manually.
+     */
+    device_reset(DEVICE(s->card));
 }
 
 static int milkymist_memcard_init(SysBusDevice *dev)
-- 
2.7.4
