Received: from eggs.gnu.org ([2001:4830:134:3::10]:59878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fSmPd-0002BF-Gl
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fSmPb-00060x-W9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:44:53 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 12 Jun 2018 17:44:01 +0100
Message-Id: <20180612164402.28680-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180612164402.28680-1-mark.cave-ayland@ilande.co.uk>
References: <20180612164402.28680-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 6/7] adb: add property to disable direct reg 3
 writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

MacOS 9 has a bug in its PMU driver whereby after configuring the ADB bus
devices it sends another write to reg 3 on both devices resetting them
both back to the same address.

Add a new disable_direct_reg3_writes property to ADBDevice to disable these
direct writes which can enabled just for the upcoming pmu-adb support.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/input/adb-kbd.c     | 25 ++++++++++++++-----------
 hw/input/adb-mouse.c   | 37 ++++++++++++++++++++-----------------
 hw/input/adb.c         |  7 +++++++
 include/hw/input/adb.h |  1 +
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 0ad384dc89..b026e9d49f 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -261,18 +261,21 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
                 trace_adb_kbd_request_change_addr(d->devaddr);
                 break;
             default:
-                d->devaddr = buf[1] & 0xf;
-                /* we support handlers:
-                 * 1: Apple Standard Keyboard
-                 * 2: Apple Extended Keyboard (LShift = RShift)
-                 * 3: Apple Extended Keyboard (LShift != RShift)
-                 */
-                if (buf[2] == 1 || buf[2] == 2 || buf[2] == 3) {
-                    d->handler = buf[2];
+                if (!d->disable_direct_reg3_writes) {
+                    d->devaddr = buf[1] & 0xf;
+
+                    /* we support handlers:
+                     * 1: Apple Standard Keyboard
+                     * 2: Apple Extended Keyboard (LShift = RShift)
+                     * 3: Apple Extended Keyboard (LShift != RShift)
+                     */
+                    if (buf[2] == 1 || buf[2] == 2 || buf[2] == 3) {
+                        d->handler = buf[2];
+                    }
+
+                    trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
+                                                                  d->handler);
                 }
-
-                trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
-                                                              d->handler);
                 break;
             }
         }
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 473045fbac..83833b0035 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -142,24 +142,27 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
                 trace_adb_mouse_request_change_addr(d->devaddr);
                 break;
             default:
-                d->devaddr = buf[1] & 0xf;
-                /* we support handlers:
-                 * 0x01: Classic Apple Mouse Protocol / 100 cpi operations
-                 * 0x02: Classic Apple Mouse Protocol / 200 cpi operations
-                 * we don't support handlers (at least):
-                 * 0x03: Mouse systems A3 trackball
-                 * 0x04: Extended Apple Mouse Protocol
-                 * 0x2f: Microspeed mouse
-                 * 0x42: Macally
-                 * 0x5f: Microspeed mouse
-                 * 0x66: Microspeed mouse
-                 */
-                if (buf[2] == 1 || buf[2] == 2) {
-                    d->handler = buf[2];
+                if (!d->disable_direct_reg3_writes) {
+                    d->devaddr = buf[1] & 0xf;
+
+                    /* we support handlers:
+                     * 0x01: Classic Apple Mouse Protocol / 100 cpi operations
+                     * 0x02: Classic Apple Mouse Protocol / 200 cpi operations
+                     * we don't support handlers (at least):
+                     * 0x03: Mouse systems A3 trackball
+                     * 0x04: Extended Apple Mouse Protocol
+                     * 0x2f: Microspeed mouse
+                     * 0x42: Macally
+                     * 0x5f: Microspeed mouse
+                     * 0x66: Microspeed mouse
+                     */
+                    if (buf[2] == 1 || buf[2] == 2) {
+                        d->handler = buf[2];
+                    }
+
+                    trace_adb_mouse_request_change_addr_and_handler(
+                        d->devaddr, d->handler);
                 }
-
-                trace_adb_mouse_request_change_addr_and_handler(d->devaddr,
-                                                                d->handler);
                 break;
             }
         }
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 23ae6f0d75..bbb40aeef1 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -113,11 +113,18 @@ static void adb_device_realizefn(DeviceState *dev, Error **errp)
     bus->devices[bus->nb_devices++] = d;
 }
 
+static Property adb_device_properties[] = {
+    DEFINE_PROP_BOOL("disable-direct-reg3-writes", ADBDevice,
+                     disable_direct_reg3_writes, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void adb_device_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = adb_device_realizefn;
+    dc->props = adb_device_properties;
     dc->bus_type = TYPE_ADB_BUS;
 }
 
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index 3ae8445e95..f99d478252 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -49,6 +49,7 @@ struct ADBDevice {
 
     int devaddr;
     int handler;
+    bool disable_direct_reg3_writes;
 };
 
 #define ADB_DEVICE_CLASS(cls) \
-- 
2.11.0
