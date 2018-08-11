Received: from eggs.gnu.org ([2001:4830:134:3::10]:55074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtC-0005tX-UW
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtB-0001IF-Qe
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:50 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Sat, 11 Aug 2018 11:08:31 +0200
Message-Id: <20180811090836.4024-3-contrib@steffen-goertz.de>
In-Reply-To: <20180811090836.4024-1-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/7] arm: Move nRF51 machine state to dedicated
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

The machine state will be used to host the SOC
and board level devices like the LED matrix and
devices to handle to pushbuttons A and B.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/microbit.c         | 38 ++++++++++++++++++++++++--------------
 include/hw/arm/microbit.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 14 deletions(-)
 create mode 100644 include/hw/arm/microbit.h

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 467cfbda23..8f3c446f52 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -14,22 +14,11 @@
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
=20
-#include "hw/arm/nrf51_soc.h"
-
-typedef struct {
-    MachineState parent;
-
-    NRF51State nrf51;
-} MICROBITMachineState;
-
-#define TYPE_MICROBIT_MACHINE "microbit"
-
-#define MICROBIT_MACHINE(obj) \
-    OBJECT_CHECK(MICROBITMachineState, obj, TYPE_MICROBIT_MACHINE)
+#include "hw/arm/microbit.h"
=20
 static void microbit_init(MachineState *machine)
 {
-    MICROBITMachineState *s =3D g_new(MICROBITMachineState, 1);
+    MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
     MemoryRegion *system_memory =3D get_system_memory();
     Object *soc;
=20
@@ -45,10 +34,31 @@ static void microbit_init(MachineState *machine)
             NRF51_SOC(soc)->flash_size);
 }
=20
+
 static void microbit_machine_init(MachineClass *mc)
 {
     mc->desc =3D "BBC micro:bit";
     mc->init =3D microbit_init;
     mc->max_cpus =3D 1;
 }
-DEFINE_MACHINE("microbit", microbit_machine_init);
+
+static void microbit_machine_init_class_init(ObjectClass *oc, void *data=
)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    microbit_machine_init(mc);
+}
+
+static const TypeInfo microbit_machine_info =3D {
+    .name       =3D TYPE_MICROBIT_MACHINE,
+    .parent     =3D TYPE_MACHINE,
+    .instance_size =3D sizeof(MicrobitMachineState),
+    .class_init =3D microbit_machine_init_class_init,
+};
+
+static void microbit_machine_types(void)
+{
+    type_register_static(&microbit_machine_info);
+}
+
+type_init(microbit_machine_types)
+
diff --git a/include/hw/arm/microbit.h b/include/hw/arm/microbit.h
new file mode 100644
index 0000000000..89f0c6bc07
--- /dev/null
+++ b/include/hw/arm/microbit.h
@@ -0,0 +1,29 @@
+/*
+ * BBC micro:bit machine
+ *
+ * Copyright 2018 Joel Stanley <joel@jms.id.au>
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef MICROBIT_H
+#define MICROBIT_H
+
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "hw/arm/nrf51_soc.h"
+#include "hw/display/led_matrix.h"
+
+#define TYPE_MICROBIT_MACHINE       MACHINE_TYPE_NAME("microbit")
+#define MICROBIT_MACHINE(obj) \
+    OBJECT_CHECK(MicrobitMachineState, (obj), TYPE_MICROBIT_MACHINE)
+
+typedef struct MicrobitMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+
+    NRF51State nrf51;
+} MicrobitMachineState;
+
+#endif
--=20
2.18.0
