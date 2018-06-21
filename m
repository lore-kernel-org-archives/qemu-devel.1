Received: from eggs.gnu.org ([2001:4830:134:3::10]:50236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW393-0004id-Cr
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW392-00024J-De
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:49 -0300
Message-Id: <20180621171257.14897-4-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/11] hw/char/serial: Convert from DPRINTF
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c     | 5 +++--
 hw/char/trace-events | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 605b0d02f9..26f53ba02f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 //#define DEBUG_SERIAL
 
@@ -335,7 +336,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     SerialState *s = opaque;
 
     addr &= 7;
-    DPRINTF("write addr=0x%" HWADDR_PRIx " val=0x%" PRIx64 "\n", addr, val);
+    trace_serial_ioport_write(addr, val);
     switch(addr) {
     default:
     case 0:
@@ -548,7 +549,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
         ret = s->scr;
         break;
     }
-    DPRINTF("read addr=0x%" HWADDR_PRIx " val=0x%02x\n", addr, ret);
+    trace_serial_ioport_read(addr, ret);
     return ret;
 }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index ebd8a92450..158957627e 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/char/serial.c
+serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
+serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
+
 # hw/char/virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
 virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
-- 
2.18.0.rc2
