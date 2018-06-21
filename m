Received: from eggs.gnu.org ([2001:4830:134:3::10]:50292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39B-0004nE-77
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39A-00027y-8Y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:52 -0300
Message-Id: <20180621171257.14897-7-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] hw/input/tsc2005: Convert a fprintf()
 call to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/input/tsc2005.c    | 7 +++----
 hw/input/trace-events | 3 +++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 7990954b6c..4e1ee756ed 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "ui/console.h"
 #include "hw/devices.h"
+#include "trace.h"
 
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
 
@@ -200,8 +201,7 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         s->host_mode = (data >> 15) != 0;
         if (s->enabled != !(data & 0x4000)) {
             s->enabled = !(data & 0x4000);
-            fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                            __func__, s->enabled ? "en" : "dis");
+            trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
             if (s->busy && !s->enabled)
                 timer_del(s->timer);
             s->busy = s->busy && s->enabled;
@@ -337,8 +337,7 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)
                 s->nextprecision = (value >> 2) & 1;
                 if (s->enabled != !(value & 1)) {
                     s->enabled = !(value & 1);
-                    fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                                    __func__, s->enabled ? "en" : "dis");
+                    trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
                     if (s->busy && !s->enabled)
                         timer_del(s->timer);
                     s->busy = s->busy && s->enabled;
diff --git a/hw/input/trace-events b/hw/input/trace-events
index db72484a25..3965a842ae 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -41,5 +41,8 @@ milkymist_softusb_pulse_irq(void) "Pulse IRQ"
 hid_kbd_queue_full(void) "queue full"
 hid_kbd_queue_empty(void) "queue empty"
 
+# hw/input/tsc2005.c
+tsc2005_sense(const char *state) "touchscreen sense %s"
+
 # hw/input/virtio
 virtio_input_queue_full(void) "queue full"
-- 
2.18.0.rc2
