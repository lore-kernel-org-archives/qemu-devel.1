Received: from eggs.gnu.org ([2001:4830:134:3::10]:55162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtK-000611-T3
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtG-0001PT-Sk
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:58 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Sat, 11 Aug 2018 11:08:36 +0200
Message-Id: <20180811090836.4024-8-contrib@steffen-goertz.de>
In-Reply-To: <20180811090836.4024-1-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/7] arm: Instantiate Microbit board-level
 devices
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

Instantiate the LED matrix and set board-level
pull-up default values to buttons A and B.
This is necessary to calm down the microsoft pxt
javascript runtime available for the micro:bit.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/microbit.c         | 52 ++++++++++++++++++++++++++++++++++-----
 include/hw/arm/microbit.h |  1 +
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index bb6ddb6a79..6fad0de2cd 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -13,34 +13,74 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
+#include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
=20
 #include "hw/arm/microbit.h"
=20
+#define BUTTON_A_PIN 17
+#define BUTTON_B_PIN 26
+
 static void microbit_init(MachineState *machine)
 {
     MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
     MemoryRegion *system_memory =3D get_system_memory();
-    Object *soc;
+    DeviceState *soc, *matrix;
=20
     object_initialize(&s->nrf51, sizeof(s->nrf51), TYPE_NRF51_SOC);
-    soc =3D OBJECT(&s->nrf51);
-    object_property_add_child(OBJECT(machine), "nrf51", soc, &error_fata=
l);
-    object_property_set_link(soc, OBJECT(system_memory),
+    soc =3D DEVICE(&s->nrf51);
+    object_property_add_child(OBJECT(machine), "nrf51", OBJECT(soc),
+                              &error_fatal);
+    object_property_set_link(OBJECT(soc), OBJECT(system_memory),
                              "memory", &error_abort);
-    qdev_prop_set_uint32(DEVICE(soc), "variant", NRF51_VARIANT_AA);
+    qdev_prop_set_uint32(soc, "variant", NRF51_VARIANT_AA);
=20
-    object_property_set_bool(soc, true, "realized", &error_abort);
+    object_property_set_bool(OBJECT(soc), true, "realized", &error_abort=
);
+
+    object_initialize(&s->matrix, sizeof(s->matrix), TYPE_LED_MATRIX);
+    matrix =3D DEVICE(&s->matrix);
+    qdev_prop_set_uint16(matrix, "rows", 3);
+    qdev_prop_set_uint16(matrix, "cols", 9);
+    object_property_set_bool(OBJECT(matrix), true, "realized", &error_fa=
tal);
+
+    qdev_connect_gpio_out(soc, 4, qdev_get_gpio_in_named(matrix, "col", =
0));
+    qdev_connect_gpio_out(soc, 5, qdev_get_gpio_in_named(matrix, "col", =
1));
+    qdev_connect_gpio_out(soc, 6, qdev_get_gpio_in_named(matrix, "col", =
2));
+    qdev_connect_gpio_out(soc, 7, qdev_get_gpio_in_named(matrix, "col", =
3));
+    qdev_connect_gpio_out(soc, 8, qdev_get_gpio_in_named(matrix, "col", =
4));
+    qdev_connect_gpio_out(soc, 9, qdev_get_gpio_in_named(matrix, "col", =
5));
+    qdev_connect_gpio_out(soc, 10, qdev_get_gpio_in_named(matrix, "col",=
 6));
+    qdev_connect_gpio_out(soc, 11, qdev_get_gpio_in_named(matrix, "col",=
 7));
+    qdev_connect_gpio_out(soc, 12, qdev_get_gpio_in_named(matrix, "col",=
 8));
+
+    qdev_connect_gpio_out(soc, 13, qdev_get_gpio_in_named(matrix, "row",=
 0));
+    qdev_connect_gpio_out(soc, 14, qdev_get_gpio_in_named(matrix, "row",=
 1));
+    qdev_connect_gpio_out(soc, 15, qdev_get_gpio_in_named(matrix, "row",=
 2));
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x0=
0);
 }
=20
+static void microbit_reset(void)
+{
+    MachineState *machine =3D MACHINE(qdev_get_machine());
+    MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
+
+    qemu_devices_reset();
+
+    /* Board level pull-up */
+    if (!qtest_enabled()) {
+        qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->nrf51), BUTTON_A_PIN), =
1);
+        qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->nrf51), BUTTON_B_PIN), =
1);
+    }
+}
+
=20
 static void microbit_machine_init(MachineClass *mc)
 {
     mc->desc =3D "BBC micro:bit";
     mc->init =3D microbit_init;
     mc->max_cpus =3D 1;
+    mc->reset =3D microbit_reset;
 }
=20
 static void microbit_machine_init_class_init(ObjectClass *oc, void *data=
)
diff --git a/include/hw/arm/microbit.h b/include/hw/arm/microbit.h
index 89f0c6bc07..094326b4ae 100644
--- a/include/hw/arm/microbit.h
+++ b/include/hw/arm/microbit.h
@@ -24,6 +24,7 @@ typedef struct MicrobitMachineState {
     MachineState parent_obj;
=20
     NRF51State nrf51;
+    LEDMatrixState matrix;
 } MicrobitMachineState;
=20
 #endif
--=20
2.18.0
