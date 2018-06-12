Received: from eggs.gnu.org ([2001:4830:134:3::10]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fSmPb-00027u-L7
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fSmPZ-0005yZ-1q
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:44:51 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 12 Jun 2018 17:43:59 +0100
Message-Id: <20180612164402.28680-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180612164402.28680-1-mark.cave-ayland@ilande.co.uk>
References: <20180612164402.28680-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/7] mac_newworld: wire up programmer switch to
 NMI handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The programmer switch is wired up via an external GPIO pin and can be used
to aid debugging Mac guests.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/gpio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 5630afdf18..9317df759c 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -28,6 +28,7 @@
 #include "hw/ppc/mac.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/misc/macio/gpio.h"
+#include "hw/nmi.h"
 #include "qemu/log.h"
 #include "trace.h"
 
@@ -193,13 +194,21 @@ static void macio_gpio_reset(DeviceState *dev)
     macio_set_gpio(s, 1, true);
 }
 
+static void macio_gpio_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    macio_set_gpio(MACIO_GPIO(n), 9, true);
+    macio_set_gpio(MACIO_GPIO(n), 9, false);
+}
+
 static void macio_gpio_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    NMIClass *nc = NMI_CLASS(oc);
 
     dc->realize = macio_gpio_realize;
     dc->reset = macio_gpio_reset;
     dc->vmsd = &vmstate_macio_gpio;
+    nc->nmi_monitor_handler = macio_gpio_nmi;
 }
 
 static const TypeInfo macio_gpio_init_info = {
@@ -208,6 +217,10 @@ static const TypeInfo macio_gpio_init_info = {
     .instance_size = sizeof(MacIOGPIOState),
     .instance_init = macio_gpio_init,
     .class_init    = macio_gpio_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_NMI },
+        { }
+    },
 };
 
 static void macio_gpio_register_types(void)
-- 
2.11.0
