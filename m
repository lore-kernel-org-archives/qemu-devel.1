Received: from eggs.gnu.org ([2001:4830:134:3::10]:49713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEX-0005J8-S0
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEW-0003yI-FF
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:01 +1000
Message-Id: <20180618035324.19907-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/28] ppc: introduce Core99MachinesState for
 the mac99 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is in preparation for adding configuration controlled via machine
options.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac.h          | 11 +++++++++++
 hw/ppc/mac_newworld.c |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 89fa8bbed7..8046cd8a2f 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -27,6 +27,7 @@
 #define PPC_MAC_H
 
 #include "exec/memory.h"
+#include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/ide/internal.h"
 #include "hw/input/adb.h"
@@ -65,6 +66,16 @@
 #define NEWWORLD_IDE1_IRQ      0xe
 #define NEWWORLD_IDE1_DMA_IRQ  0x3
 
+/* Core99 machine */
+#define TYPE_CORE99_MACHINE MACHINE_TYPE_NAME("mac99")
+#define CORE99_MACHINE(obj) OBJECT_CHECK(Core99MachineState, (obj), \
+                                         TYPE_CORE99_MACHINE)
+
+typedef struct Core99MachineState {
+    /*< private >*/
+    MachineState parent;
+} Core99MachineState;
+
 /* MacIO */
 #define TYPE_MACIO_IDE "macio-ide"
 #define MACIO_IDE(obj) OBJECT_CHECK(MACIOIDEState, (obj), TYPE_MACIO_IDE)
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 744acdfd2e..5331aa002c 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -515,10 +515,17 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
 #endif
 }
 
+static void core99_instance_init(Object *obj)
+{
+    return;
+}
+
 static const TypeInfo core99_machine_info = {
     .name          = MACHINE_TYPE_NAME("mac99"),
     .parent        = TYPE_MACHINE,
     .class_init    = core99_machine_class_init,
+    .instance_init = core99_instance_init,
+    .instance_size = sizeof(Core99MachineState)
 };
 
 static void mac_machine_register_types(void)
-- 
2.17.1
