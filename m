Received: from eggs.gnu.org ([209.51.188.92]:45173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQM-0002A4-OH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtYQK-0006Qy-H5
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:48:34 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Feb 2019 13:47:55 +0000
Message-Id: <20190212134758.10514-2-dgilbert@redhat.com>
In-Reply-To: <20190212134758.10514-1-dgilbert@redhat.com>
References: <20190212134758.10514-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] pckbd: Convert DPRINTF->trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com
Cc: qemu-trivial@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/input/pckbd.c      | 19 ++++++-------------
 hw/input/trace-events |  7 +++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 72e7d5f6cc..47a606f5e3 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -30,14 +30,7 @@
 #include "hw/input/i8042.h"
 #include "sysemu/sysemu.h"
=20
-/* debug PC keyboard */
-//#define DEBUG_KBD
-#ifdef DEBUG_KBD
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("KBD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
=20
 /*	Keyboard Controller Commands */
 #define KBD_CCMD_READ_MODE	0x20	/* Read mode bits */
@@ -210,7 +203,7 @@ static uint64_t kbd_read_status(void *opaque, hwaddr =
addr,
     KBDState *s =3D opaque;
     int val;
     val =3D s->status;
-    DPRINTF("kbd: read status=3D0x%02x\n", val);
+    trace_pckbd_kbd_read_status(val);
     return val;
 }
=20
@@ -224,7 +217,7 @@ static void kbd_queue(KBDState *s, int b, int aux)
=20
 static void outport_write(KBDState *s, uint32_t val)
 {
-    DPRINTF("kbd: write outport=3D0x%02x\n", val);
+    trace_pckbd_outport_write(val);
     s->outport =3D val;
     qemu_set_irq(s->a20_out, (val >> 1) & 1);
     if (!(val & 1)) {
@@ -237,7 +230,7 @@ static void kbd_write_command(void *opaque, hwaddr ad=
dr,
 {
     KBDState *s =3D opaque;
=20
-    DPRINTF("kbd: write cmd=3D0x%02" PRIx64 "\n", val);
+    trace_pckbd_kbd_write_command(val);
=20
     /* Bits 3-0 of the output port P2 of the keyboard controller may be =
pulsed
      * low for approximately 6 micro seconds. Bits 3-0 of the KBD_CCMD_P=
ULSE
@@ -326,7 +319,7 @@ static uint64_t kbd_read_data(void *opaque, hwaddr ad=
dr,
     else
         val =3D ps2_read_data(s->kbd);
=20
-    DPRINTF("kbd: read data=3D0x%02x\n", val);
+    trace_pckbd_kbd_read_data(val);
     return val;
 }
=20
@@ -335,7 +328,7 @@ static void kbd_write_data(void *opaque, hwaddr addr,
 {
     KBDState *s =3D opaque;
=20
-    DPRINTF("kbd: write data=3D0x%02" PRIx64 "\n", val);
+    trace_pckbd_kbd_write_data(val);
=20
     switch(s->write_cmd) {
     case 0:
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 3965a842ae..8e53ae5bbf 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -14,6 +14,13 @@ adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1)=
 "reg %d obuf[0] 0x%2.2x o
 adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
 adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "cha=
nge addr and handler to 0x%x, 0x%x"
=20
+# hw/input/pckbd.c
+pckbd_kbd_read_data(uint32_t val) "0x%02x"
+pckbd_kbd_read_status(int status) "0x%02x"
+pckbd_outport_write(uint32_t val) "0x%02x"
+pckbd_kbd_write_command(uint64_t val) "0x%02"PRIx64
+pckbd_kbd_write_data(uint64_t val) "0x%02"PRIx64
+
 # hw/input/ps2.c
 ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
 ps2_keyboard_event(void *opaque, int qcode, int down, unsigned int modif=
ier, unsigned int modifiers) "%p qcode %d down %d modifier 0x%x modifiers=
 0x%x"
--=20
2.20.1
