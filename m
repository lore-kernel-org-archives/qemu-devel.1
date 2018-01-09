Received: from eggs.gnu.org ([2001:4830:134:3::10]:43279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYuri-0003hH-CZ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYurh-0001cf-BW
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:26:58 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Jan 2018 14:01:50 +0000
Message-Id: <1515506513-31961-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] hw/sd/pl181: Reset SD card on controller
 reset
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
Fixes: https://bugs.launchpad.net/qemu/+bug/1739378
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/pl181.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 55c8098..3ba1f7d 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -480,6 +480,10 @@ static void pl181_reset(DeviceState *d)
 
     /* We can assume our GPIO outputs have been wired up now */
     sd_set_cb(s->card, s->cardstatus[0], s->cardstatus[1]);
+    /* Since we're still using the legacy SD API the card is not plugged
+     * into any bus, and we must reset it manually.
+     */
+    device_reset(DEVICE(s->card));
 }
 
 static void pl181_init(Object *obj)
-- 
2.7.4
