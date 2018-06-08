Received: from eggs.gnu.org ([2001:4830:134:3::10]:50462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGln-00033L-K6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlm-0004FJ-JY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlm-0004Dg-A9
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlk-0003gN-K0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:28 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:00 +0100
Message-Id: <20180608124517.29475-15-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/31] hw/i2c: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180606191801.6331-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile.objs       |  1 +
 hw/i2c/core.c       | 25 ++++++++++++++++++-------
 hw/i2c/trace-events |  7 +++++++
 3 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100644 hw/i2c/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 2c8cb72407a..7a9828da282 100644
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
index ab72d5bf2bf..b54725985a4 100644
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
index 00000000000..d339b612021
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
