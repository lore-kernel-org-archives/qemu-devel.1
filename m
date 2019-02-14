Received: from eggs.gnu.org ([209.51.188.92]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYj-0002H2-Er
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYi-0002gj-5S
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:11 +0100
Message-Id: <20190214104717.3543-9-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/14] pckbd: Convert DPRINTF->trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20181016112232.23241-1-dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/input/pckbd.c      | 19 ++++++-------------
 hw/input/trace-events |  7 +++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 72e7d5f6cc50..47a606f5e3a0 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -30,14 +30,7 @@
 #include "hw/input/i8042.h"
 #include "sysemu/sysemu.h"
 
-/* debug PC keyboard */
-//#define DEBUG_KBD
-#ifdef DEBUG_KBD
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("KBD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 /*	Keyboard Controller Commands */
 #define KBD_CCMD_READ_MODE	0x20	/* Read mode bits */
@@ -210,7 +203,7 @@ static uint64_t kbd_read_status(void *opaque, hwaddr addr,
     KBDState *s = opaque;
     int val;
     val = s->status;
-    DPRINTF("kbd: read status=0x%02x\n", val);
+    trace_pckbd_kbd_read_status(val);
     return val;
 }
 
@@ -224,7 +217,7 @@ static void kbd_queue(KBDState *s, int b, int aux)
 
 static void outport_write(KBDState *s, uint32_t val)
 {
-    DPRINTF("kbd: write outport=0x%02x\n", val);
+    trace_pckbd_outport_write(val);
     s->outport = val;
     qemu_set_irq(s->a20_out, (val >> 1) & 1);
     if (!(val & 1)) {
@@ -237,7 +230,7 @@ static void kbd_write_command(void *opaque, hwaddr addr,
 {
     KBDState *s = opaque;
 
-    DPRINTF("kbd: write cmd=0x%02" PRIx64 "\n", val);
+    trace_pckbd_kbd_write_command(val);
 
     /* Bits 3-0 of the output port P2 of the keyboard controller may be pulsed
      * low for approximately 6 micro seconds. Bits 3-0 of the KBD_CCMD_PULSE
@@ -326,7 +319,7 @@ static uint64_t kbd_read_data(void *opaque, hwaddr addr,
     else
         val = ps2_read_data(s->kbd);
 
-    DPRINTF("kbd: read data=0x%02x\n", val);
+    trace_pckbd_kbd_read_data(val);
     return val;
 }
 
@@ -335,7 +328,7 @@ static void kbd_write_data(void *opaque, hwaddr addr,
 {
     KBDState *s = opaque;
 
-    DPRINTF("kbd: write data=0x%02" PRIx64 "\n", val);
+    trace_pckbd_kbd_write_data(val);
 
     switch(s->write_cmd) {
     case 0:
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 3965a842aee5..8e53ae5bbf15 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -14,6 +14,13 @@ adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x o
 adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
 adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
+# hw/input/pckbd.c
+pckbd_kbd_read_data(uint32_t val) "0x%02x"
+pckbd_kbd_read_status(int status) "0x%02x"
+pckbd_outport_write(uint32_t val) "0x%02x"
+pckbd_kbd_write_command(uint64_t val) "0x%02"PRIx64
+pckbd_kbd_write_data(uint64_t val) "0x%02"PRIx64
+
 # hw/input/ps2.c
 ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
 ps2_keyboard_event(void *opaque, int qcode, int down, unsigned int modifier, unsigned int modifiers) "%p qcode %d down %d modifier 0x%x modifiers 0x%x"
-- 
2.20.1
