Received: from eggs.gnu.org ([2001:4830:134:3::10]:40073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQdwl-0007bm-5D
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQdwh-0005fe-Vd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:18:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 16:18:01 -0300
Message-Id: <20180606191801.6331-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/i2c: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
$ qemu-system ... -d trace:i2c_recv,trace:i2c_send

4486@1528311614.709959:i2c_recv recv(addr:0x50) data:0x00
4486@1528311614.709994:i2c_send send(addr:0x50) data:0x05
4486@1528311614.710060:i2c_recv recv(addr:0x50) data:0x02
4486@1528311614.710161:i2c_recv recv(addr:0x50) data:0x40
4486@1528311614.710185:i2c_send send(addr:0x50) data:0x02
4486@1528311614.710233:i2c_recv recv(addr:0x50) data:0x08
4486@1528311614.710380:i2c_recv recv(addr:0x50) data:0x0d
4486@1528311614.710396:i2c_send send(addr:0x50) data:0x1f
4486@1528311614.710437:i2c_recv recv(addr:0x50) data:0x40

or

$ qemu-system ... -d trace:i2c\*

4486@1528311614.698315:i2c_event start(addr:0x50)
4486@1528311614.698338:i2c_recv recv(addr:0x50) data:0x82
4486@1528311614.698349:i2c_event finish(addr:0x50)
4486@1528311614.698354:i2c_event start(addr:0x50)
4486@1528311614.698357:i2c_send send(addr:0x50) data:0x11
4486@1528311614.698377:i2c_event finish(addr:0x50)
4486@1528311614.698380:i2c_event start(addr:0x50)
4486@1528311614.698402:i2c_recv recv(addr:0x50) data:0x04
4486@1528311614.698485:i2c_event finish(addr:0x50)

 Makefile.objs       |  1 +
 hw/i2c/core.c       | 25 ++++++++++++++++++-------
 hw/i2c/trace-events |  7 +++++++
 3 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100644 hw/i2c/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 2c8cb72407..7a9828da28 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -213,6 +213,7 @@ trace-events-subdirs += hw/char
 trace-events-subdirs += hw/display
 trace-events-subdirs += hw/dma
 trace-events-subdirs += hw/hppa
+trace-events-subdirs += hw/i2c
 trace-events-subdirs += hw/i386
 trace-events-subdirs += hw/i386/xen
 trace-events-subdirs += hw/ide
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index ab72d5bf2b..b54725985a 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "trace.h"
 
 #define I2C_BROADCAST 0x00
 
@@ -130,14 +131,16 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
     }
 
     QLIST_FOREACH(node, &bus->current_devs, next) {
+        I2CSlave *s = node->elt;
         int rv;
 
-        sc = I2C_SLAVE_GET_CLASS(node->elt);
+        sc = I2C_SLAVE_GET_CLASS(s);
         /* If the bus is already busy, assume this is a repeated
            start condition.  */
 
         if (sc->event) {
-            rv = sc->event(node->elt, recv ? I2C_START_RECV : I2C_START_SEND);
+            trace_i2c_event("start", s->address);
+            rv = sc->event(s, recv ? I2C_START_RECV : I2C_START_SEND);
             if (rv && !bus->broadcast) {
                 if (bus_scanned) {
                     /* First call, terminate the transfer. */
@@ -156,9 +159,11 @@ void i2c_end_transfer(I2CBus *bus)
     I2CNode *node, *next;
 
     QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
-        sc = I2C_SLAVE_GET_CLASS(node->elt);
+        I2CSlave *s = node->elt;
+        sc = I2C_SLAVE_GET_CLASS(s);
         if (sc->event) {
-            sc->event(node->elt, I2C_FINISH);
+            trace_i2c_event("finish", s->address);
+            sc->event(s, I2C_FINISH);
         }
         QLIST_REMOVE(node, next);
         g_free(node);
@@ -169,14 +174,17 @@ void i2c_end_transfer(I2CBus *bus)
 int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
 {
     I2CSlaveClass *sc;
+    I2CSlave *s;
     I2CNode *node;
     int ret = 0;
 
     if (send) {
         QLIST_FOREACH(node, &bus->current_devs, next) {
-            sc = I2C_SLAVE_GET_CLASS(node->elt);
+            s = node->elt;
+            sc = I2C_SLAVE_GET_CLASS(s);
             if (sc->send) {
-                ret = ret || sc->send(node->elt, *data);
+                trace_i2c_send(s->address, *data);
+                ret = ret || sc->send(s, *data);
             } else {
                 ret = -1;
             }
@@ -189,7 +197,9 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
 
         sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
         if (sc->recv) {
-            ret = sc->recv(QLIST_FIRST(&bus->current_devs)->elt);
+            s = QLIST_FIRST(&bus->current_devs)->elt;
+            ret = sc->recv(s);
+            trace_i2c_recv(s->address, ret);
             if (ret < 0) {
                 return ret;
             } else {
@@ -226,6 +236,7 @@ void i2c_nack(I2CBus *bus)
     QLIST_FOREACH(node, &bus->current_devs, next) {
         sc = I2C_SLAVE_GET_CLASS(node->elt);
         if (sc->event) {
+            trace_i2c_event("nack", node->elt->address);
             sc->event(node->elt, I2C_NACK);
         }
     }
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
new file mode 100644
index 0000000000..d339b61202
--- /dev/null
+++ b/hw/i2c/trace-events
@@ -0,0 +1,7 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/i2c/core.c
+
+i2c_event(const char *event, uint8_t address) "%s(addr:0x%02x)"
+i2c_send(uint8_t address, uint8_t data) "send(addr:0x%02x) data:0x%02x"
+i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data:0x%02x"
-- 
2.17.1
