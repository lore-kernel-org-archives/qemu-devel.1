Received: from eggs.gnu.org ([2001:4830:134:3::10]:49714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEX-0005J9-S2
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEW-0003yY-JI
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:05 +1000
Message-Id: <20180618035324.19907-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/28] adb: fix read reg 3 byte ordering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

According to the Apple ADB documentation, register 3 is a 2-byte register
with the device address in the first byte, and the handler ID in the second
byte.

This is currently the opposite away to which QEMU returns them so switch the
order around.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/input/adb-kbd.c   | 4 ++--
 hw/input/adb-mouse.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 50b62712c8..0ad384dc89 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -290,8 +290,8 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
             olen = 2;
             break;
         case 3:
-            obuf[0] = d->handler;
-            obuf[1] = d->devaddr;
+            obuf[0] = d->devaddr;
+            obuf[1] = d->handler;
             olen = 2;
             break;
         }
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 3ba6027d33..473045fbac 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -172,8 +172,8 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
         case 1:
             break;
         case 3:
-            obuf[0] = d->handler;
-            obuf[1] = d->devaddr;
+            obuf[0] = d->devaddr;
+            obuf[1] = d->handler;
             olen = 2;
             break;
         }
-- 
2.17.1
