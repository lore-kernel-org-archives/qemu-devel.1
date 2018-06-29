Received: from eggs.gnu.org ([2001:4830:134:3::10]:49746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxag-0000JD-FE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxab-0008UT-FY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxab-0008Tl-AP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:25 +0100
Message-Id: <20180629175330.19391-7-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/11] hw/input/tsc2005: Convert a fprintf()
 call to trace events
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
 hw/input/tsc2005.c    | 7 +++----
 hw/input/trace-events | 3 +++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 4dd95596ab..2b9108a193 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -24,6 +24,7 @@
 #include "qemu/timer.h"
 #include "ui/console.h"
 #include "hw/devices.h"
+#include "trace.h"
=20
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
=20
@@ -201,8 +202,7 @@ static void tsc2005_write(TSC2005State *s, int reg, u=
int16_t data)
         s->host_mode =3D (data >> 15) !=3D 0;
         if (s->enabled !=3D !(data & 0x4000)) {
             s->enabled =3D !(data & 0x4000);
-            fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                            __func__, s->enabled ? "en" : "dis");
+            trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
             if (s->busy && !s->enabled)
                 timer_del(s->timer);
             s->busy =3D s->busy && s->enabled;
@@ -340,8 +340,7 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_=
t value)
                 s->nextprecision =3D (value >> 2) & 1;
                 if (s->enabled !=3D !(value & 1)) {
                     s->enabled =3D !(value & 1);
-                    fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                                    __func__, s->enabled ? "en" : "dis")=
;
+                    trace_tsc2005_sense(s->enabled ? "enabled" : "disabl=
ed");
                     if (s->busy && !s->enabled)
                         timer_del(s->timer);
                     s->busy =3D s->busy && s->enabled;
diff --git a/hw/input/trace-events b/hw/input/trace-events
index db72484a25..3965a842ae 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -41,5 +41,8 @@ milkymist_softusb_pulse_irq(void) "Pulse IRQ"
 hid_kbd_queue_full(void) "queue full"
 hid_kbd_queue_empty(void) "queue empty"
=20
+# hw/input/tsc2005.c
+tsc2005_sense(const char *state) "touchscreen sense %s"
+
 # hw/input/virtio
 virtio_input_queue_full(void) "queue full"
--=20
2.17.1
