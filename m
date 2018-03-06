Received: from eggs.gnu.org ([2001:4830:134:3::10]:49624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3o1-0001cR-Vx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nz-0004YQ-Vr
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:53 +1100
Message-Id: <20180306040154.3669-30-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 29/30] adb: add trace-events for monitoring
 keyboard/mouse during bus enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is useful to help diagnose problems related to address clashes during
MacOS 9 boot.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/input/adb-kbd.c    | 4 ++++
 hw/input/adb-mouse.c  | 5 +++++
 hw/input/trace-events | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 266aed1b7b..50b62712c8 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -258,6 +258,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
             case ADB_CMD_CHANGE_ID_AND_ACT:
             case ADB_CMD_CHANGE_ID_AND_ENABLE:
                 d->devaddr = buf[1] & 0xf;
+                trace_adb_kbd_request_change_addr(d->devaddr);
                 break;
             default:
                 d->devaddr = buf[1] & 0xf;
@@ -269,6 +270,9 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
                 if (buf[2] == 1 || buf[2] == 2 || buf[2] == 3) {
                     d->handler = buf[2];
                 }
+
+                trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
+                                                              d->handler);
                 break;
             }
         }
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 47e88faf25..3ba6027d33 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -118,6 +118,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
         s->dx = 0;
         s->dy = 0;
         s->dz = 0;
+        trace_adb_mouse_flush();
         return 0;
     }
 
@@ -138,6 +139,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
             case ADB_CMD_CHANGE_ID_AND_ACT:
             case ADB_CMD_CHANGE_ID_AND_ENABLE:
                 d->devaddr = buf[1] & 0xf;
+                trace_adb_mouse_request_change_addr(d->devaddr);
                 break;
             default:
                 d->devaddr = buf[1] & 0xf;
@@ -155,6 +157,9 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
                 if (buf[2] == 1 || buf[2] == 2) {
                     d->handler = buf[2];
                 }
+
+                trace_adb_mouse_request_change_addr_and_handler(d->devaddr,
+                                                                d->handler);
                 break;
             }
         }
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 5affabc81d..db72484a25 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -4,10 +4,15 @@
 adb_kbd_no_key(void) "Ignoring NO_KEY"
 adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
 adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
+adb_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
+adb_kbd_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
 # hw/input/adb-mouse.c
+adb_mouse_flush(void) "flush"
 adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
 adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
+adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
+adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
 # hw/input/ps2.c
 ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
-- 
2.14.3
