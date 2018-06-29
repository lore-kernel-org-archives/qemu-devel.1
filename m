Received: from eggs.gnu.org ([2001:4830:134:3::10]:49689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaZ-0000FF-Vv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaZ-0008RQ-4I
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxaZ-0008QV-0G
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:23 +0100
Message-Id: <20180629175330.19391-5-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/11] hw/char/serial: Convert from DPRINTF
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
=20
 //#define DEBUG_SERIAL
=20
@@ -335,7 +336,7 @@ static void serial_ioport_write(void *opaque, hwaddr =
addr, uint64_t val,
     SerialState *s =3D opaque;
=20
     addr &=3D 7;
-    DPRINTF("write addr=3D0x%" HWADDR_PRIx " val=3D0x%" PRIx64 "\n", add=
r, val);
+    trace_serial_ioport_write(addr, val);
     switch(addr) {
     default:
     case 0:
@@ -548,7 +549,7 @@ static uint64_t serial_ioport_read(void *opaque, hwad=
dr addr, unsigned size)
         ret =3D s->scr;
         break;
     }
-    DPRINTF("read addr=3D0x%" HWADDR_PRIx " val=3D0x%02x\n", addr, ret);
+    trace_serial_ioport_read(addr, ret);
     return ret;
 }
=20
diff --git a/hw/char/trace-events b/hw/char/trace-events
index ebd8a92450..158957627e 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
+# hw/char/serial.c
+serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0=
x%02x"
+serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val=
 0x%02x"
+
 # hw/char/virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint=
16_t value) "port %u, event %u, value %u"
 virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, =
throttle %d"
--=20
2.17.1
