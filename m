Received: from eggs.gnu.org ([2001:4830:134:3::10]:34859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuo1-0002fy-Gf
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNunx-0001Go-I4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:57 -0400
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:42178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNunx-0001G1-8C
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:41:53 -0400
Received: from player159.ha.ovh.net (unknown [10.109.122.51])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id B8308AD298
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:41:51 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:40:48 +0200
Message-Id: <20180530064049.27976-7-clg@kaod.org>
In-Reply-To: <20180530064049.27976-1-clg@kaod.org>
References: <20180530064049.27976-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 6/7] misc: add pca9552 LED blinker model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Specs are available here :

    https://www.nxp.com/docs/en/application-note/AN264.pdf

This is a simple model supporting the basic registers for led and GPIO
mode. The device also supports two blinking rates but not the model
yet.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 Changes since v6:

 - removed code duplication in the pca9552 test

 default-configs/arm-softmmu.mak |   1 +
 include/hw/misc/pca9552.h       |  32 ++++++
 include/hw/misc/pca9552_regs.h  |  32 ++++++
 tests/libqos/i2c.h              |   2 +
 hw/misc/pca9552.c               | 240 ++++++++++++++++++++++++++++++++++=
++++++
 tests/pca9552-test.c            | 116 +++++++++++++++++++
 tests/tmp105-test.c             |   2 -
 hw/misc/Makefile.objs           |   1 +
 tests/Makefile.include          |   2 +
 9 files changed, 426 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/misc/pca9552.h
 create mode 100644 include/hw/misc/pca9552_regs.h
 create mode 100644 hw/misc/pca9552.c
 create mode 100644 tests/pca9552-test.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index dd29e741c221..7f8414a22c37 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -16,6 +16,7 @@ CONFIG_TSC2005=3Dy
 CONFIG_LM832X=3Dy
 CONFIG_TMP105=3Dy
 CONFIG_TMP421=3Dy
+CONFIG_PCA9552=3Dy
 CONFIG_STELLARIS=3Dy
 CONFIG_STELLARIS_INPUT=3Dy
 CONFIG_STELLARIS_ENET=3Dy
diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
new file mode 100644
index 000000000000..ebb43c63fe11
--- /dev/null
+++ b/include/hw/misc/pca9552.h
@@ -0,0 +1,32 @@
+/*
+ * PCA9552 I2C LED blinker
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+#ifndef PCA9552_H
+#define PCA9552_H
+
+#include "hw/i2c/i2c.h"
+
+#define TYPE_PCA9552 "pca9552"
+#define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
+
+#define PCA9552_NR_REGS 10
+
+typedef struct PCA9552State {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+
+    uint8_t len;
+    uint8_t pointer;
+
+    uint8_t regs[PCA9552_NR_REGS];
+    uint8_t max_reg;
+    uint8_t nr_leds;
+} PCA9552State;
+
+#endif
diff --git a/include/hw/misc/pca9552_regs.h b/include/hw/misc/pca9552_reg=
s.h
new file mode 100644
index 000000000000..d8051cfbd69b
--- /dev/null
+++ b/include/hw/misc/pca9552_regs.h
@@ -0,0 +1,32 @@
+/*
+ * PCA9552 I2C LED blinker registers
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+#ifndef PCA9552_REGS_H
+#define PCA9552_REGS_H
+
+/*
+ * Bits [0:3] are used to address a specific register.
+ */
+#define PCA9552_INPUT0   0 /* read only input register 0 */
+#define PCA9552_INPUT1   1 /* read only input register 1  */
+#define PCA9552_PSC0     2 /* read/write frequency prescaler 0 */
+#define PCA9552_PWM0     3 /* read/write PWM register 0 */
+#define PCA9552_PSC1     4 /* read/write frequency prescaler 1 */
+#define PCA9552_PWM1     5 /* read/write PWM register 1 */
+#define PCA9552_LS0      6 /* read/write LED0 to LED3 selector */
+#define PCA9552_LS1      7 /* read/write LED4 to LED7 selector */
+#define PCA9552_LS2      8 /* read/write LED8 to LED11 selector */
+#define PCA9552_LS3      9 /* read/write LED12 to LED15 selector */
+
+/*
+ * Bit [4] is used to activate the Auto-Increment option of the
+ * register address
+ */
+#define PCA9552_AUTOINC  (1 << 4)
+
+#endif
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index eb40b808bdf3..cc01358a9f68 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -21,6 +21,8 @@ struct I2CAdapter {
     QTestState *qts;
 };
=20
+#define OMAP2_I2C_1_BASE 0x48070000
+
 void i2c_send(I2CAdapter *i2c, uint8_t addr,
               const uint8_t *buf, uint16_t len);
 void i2c_recv(I2CAdapter *i2c, uint8_t addr,
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
new file mode 100644
index 000000000000..9775d5274a05
--- /dev/null
+++ b/hw/misc/pca9552.c
@@ -0,0 +1,240 @@
+/*
+ * PCA9552 I2C LED blinker
+ *
+ *     https://www.nxp.com/docs/en/application-note/AN264.pdf
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/hw.h"
+#include "hw/misc/pca9552.h"
+#include "hw/misc/pca9552_regs.h"
+
+#define PCA9552_LED_ON   0x0
+#define PCA9552_LED_OFF  0x1
+#define PCA9552_LED_PWM0 0x2
+#define PCA9552_LED_PWM1 0x3
+
+static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
+{
+    uint8_t reg   =3D PCA9552_LS0 + (pin / 4);
+    uint8_t shift =3D (pin % 4) << 1;
+
+    return extract32(s->regs[reg], shift, 2);
+}
+
+static void pca9552_update_pin_input(PCA9552State *s)
+{
+    int i;
+
+    for (i =3D 0; i < s->nr_leds; i++) {
+        uint8_t input_reg =3D PCA9552_INPUT0 + (i / 8);
+        uint8_t input_shift =3D (i % 8);
+        uint8_t config =3D pca9552_pin_get_config(s, i);
+
+        switch (config) {
+        case PCA9552_LED_ON:
+            s->regs[input_reg] |=3D 1 << input_shift;
+            break;
+        case PCA9552_LED_OFF:
+            s->regs[input_reg] &=3D ~(1 << input_shift);
+            break;
+        case PCA9552_LED_PWM0:
+        case PCA9552_LED_PWM1:
+            /* TODO */
+        default:
+            break;
+        }
+    }
+}
+
+static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
+{
+    switch (reg) {
+    case PCA9552_INPUT0:
+    case PCA9552_INPUT1:
+    case PCA9552_PSC0:
+    case PCA9552_PWM0:
+    case PCA9552_PSC1:
+    case PCA9552_PWM1:
+    case PCA9552_LS0:
+    case PCA9552_LS1:
+    case PCA9552_LS2:
+    case PCA9552_LS3:
+        return s->regs[reg];
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to register =
%d\n",
+                      __func__, reg);
+        return 0xFF;
+    }
+}
+
+static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
+{
+    switch (reg) {
+    case PCA9552_PSC0:
+    case PCA9552_PWM0:
+    case PCA9552_PSC1:
+    case PCA9552_PWM1:
+        s->regs[reg] =3D data;
+        break;
+
+    case PCA9552_LS0:
+    case PCA9552_LS1:
+    case PCA9552_LS2:
+    case PCA9552_LS3:
+        s->regs[reg] =3D data;
+        pca9552_update_pin_input(s);
+        break;
+
+    case PCA9552_INPUT0:
+    case PCA9552_INPUT1:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to register=
 %d\n",
+                      __func__, reg);
+    }
+}
+
+/*
+ * When Auto-Increment is on, the register address is incremented
+ * after each byte is sent to or received by the device. The index
+ * rollovers to 0 when the maximum register address is reached.
+ */
+static void pca9552_autoinc(PCA9552State *s)
+{
+    if (s->pointer !=3D 0xFF && s->pointer & PCA9552_AUTOINC) {
+        uint8_t reg =3D s->pointer & 0xf;
+
+        reg =3D (reg + 1) % (s->max_reg + 1);
+        s->pointer =3D reg | PCA9552_AUTOINC;
+    }
+}
+
+static int pca9552_recv(I2CSlave *i2c)
+{
+    PCA9552State *s =3D PCA9552(i2c);
+    uint8_t ret;
+
+    ret =3D pca9552_read(s, s->pointer & 0xf);
+
+    /*
+     * From the Specs:
+     *
+     *     Important Note: When a Read sequence is initiated and the
+     *     AI bit is set to Logic Level 1, the Read Sequence MUST
+     *     start by a register different from 0.
+     *
+     * I don't know what should be done in this case, so throw an
+     * error.
+     */
+    if (s->pointer =3D=3D PCA9552_AUTOINC) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Autoincrement read starting with register 0\n=
",
+                      __func__);
+    }
+
+    pca9552_autoinc(s);
+
+    return ret;
+}
+
+static int pca9552_send(I2CSlave *i2c, uint8_t data)
+{
+    PCA9552State *s =3D PCA9552(i2c);
+
+    /* First byte sent by is the register address */
+    if (s->len =3D=3D 0) {
+        s->pointer =3D data;
+        s->len++;
+    } else {
+        pca9552_write(s, s->pointer & 0xf, data);
+
+        pca9552_autoinc(s);
+    }
+
+    return 0;
+}
+
+static int pca9552_event(I2CSlave *i2c, enum i2c_event event)
+{
+    PCA9552State *s =3D PCA9552(i2c);
+
+    s->len =3D 0;
+    return 0;
+}
+
+static const VMStateDescription pca9552_vmstate =3D {
+    .name =3D "PCA9552",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT8(len, PCA9552State),
+        VMSTATE_UINT8(pointer, PCA9552State),
+        VMSTATE_UINT8_ARRAY(regs, PCA9552State, PCA9552_NR_REGS),
+        VMSTATE_I2C_SLAVE(i2c, PCA9552State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pca9552_reset(DeviceState *dev)
+{
+    PCA9552State *s =3D PCA9552(dev);
+
+    s->regs[PCA9552_PSC0] =3D 0xFF;
+    s->regs[PCA9552_PWM0] =3D 0x80;
+    s->regs[PCA9552_PSC1] =3D 0xFF;
+    s->regs[PCA9552_PWM1] =3D 0x80;
+    s->regs[PCA9552_LS0] =3D 0x55; /* all OFF */
+    s->regs[PCA9552_LS1] =3D 0x55;
+    s->regs[PCA9552_LS2] =3D 0x55;
+    s->regs[PCA9552_LS3] =3D 0x55;
+
+    pca9552_update_pin_input(s);
+
+    s->pointer =3D 0xFF;
+    s->len =3D 0;
+}
+
+static void pca9552_initfn(Object *obj)
+{
+    PCA9552State *s =3D PCA9552(obj);
+
+    /* If support for the other PCA955X devices are implemented, these
+     * constant values might be part of class structure describing the
+     * PCA955X device
+     */
+    s->max_reg =3D PCA9552_LS3;
+    s->nr_leds =3D 16;
+}
+
+static void pca9552_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+
+    k->event =3D pca9552_event;
+    k->recv =3D pca9552_recv;
+    k->send =3D pca9552_send;
+    dc->reset =3D pca9552_reset;
+    dc->vmsd =3D &pca9552_vmstate;
+}
+
+static const TypeInfo pca9552_info =3D {
+    .name          =3D TYPE_PCA9552,
+    .parent        =3D TYPE_I2C_SLAVE,
+    .instance_init =3D pca9552_initfn,
+    .instance_size =3D sizeof(PCA9552State),
+    .class_init    =3D pca9552_class_init,
+};
+
+static void pca9552_register_types(void)
+{
+    type_register_static(&pca9552_info);
+}
+
+type_init(pca9552_register_types)
diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
new file mode 100644
index 000000000000..5466a67ed700
--- /dev/null
+++ b/tests/pca9552-test.c
@@ -0,0 +1,116 @@
+/*
+ * QTest testcase for the PCA9552 LED blinker
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "libqos/i2c.h"
+#include "hw/misc/pca9552_regs.h"
+
+#define PCA9552_TEST_ID   "pca9552-test"
+#define PCA9552_TEST_ADDR 0x60
+
+static I2CAdapter *i2c;
+
+static uint8_t pca9552_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
+{
+    uint8_t resp[1];
+    i2c_send(i2c, addr, &reg, 1);
+    i2c_recv(i2c, addr, resp, 1);
+    return resp[0];
+}
+
+static void pca9552_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
+                         uint8_t value)
+{
+    uint8_t cmd[2];
+    uint8_t resp[1];
+
+    cmd[0] =3D reg;
+    cmd[1] =3D value;
+    i2c_send(i2c, addr, cmd, 2);
+    i2c_recv(i2c, addr, resp, 1);
+    g_assert_cmphex(resp[0], =3D=3D, cmd[1]);
+}
+
+static void receive_autoinc(void)
+{
+    uint8_t resp;
+    uint8_t reg =3D PCA9552_LS0 | PCA9552_AUTOINC;
+
+    i2c_send(i2c, PCA9552_TEST_ADDR, &reg, 1);
+
+    /* PCA9552_LS0 */
+    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    g_assert_cmphex(resp, =3D=3D, 0x54);
+
+    /* PCA9552_LS1 */
+    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    g_assert_cmphex(resp, =3D=3D, 0x55);
+
+    /* PCA9552_LS2 */
+    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    g_assert_cmphex(resp, =3D=3D, 0x55);
+
+    /* PCA9552_LS3 */
+    i2c_recv(i2c, PCA9552_TEST_ADDR, &resp, 1);
+    g_assert_cmphex(resp, =3D=3D, 0x54);
+}
+
+static void send_and_receive(void)
+{
+    uint8_t value;
+
+    value =3D pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
+    g_assert_cmphex(value, =3D=3D, 0x55);
+
+    value =3D pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
+    g_assert_cmphex(value, =3D=3D, 0x0);
+
+    /* Switch on LED 0 */
+    pca9552_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0, 0x54);
+    value =3D pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS0);
+    g_assert_cmphex(value, =3D=3D, 0x54);
+
+    value =3D pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT0);
+    g_assert_cmphex(value, =3D=3D, 0x01);
+
+    /* Switch on LED 12 */
+    pca9552_set8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3, 0x54);
+    value =3D pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_LS3);
+    g_assert_cmphex(value, =3D=3D, 0x54);
+
+    value =3D pca9552_get8(i2c, PCA9552_TEST_ADDR, PCA9552_INPUT1);
+    g_assert_cmphex(value, =3D=3D, 0x10);
+}
+
+int main(int argc, char **argv)
+{
+    QTestState *s =3D NULL;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    s =3D qtest_start("-machine n800 "
+                    "-device pca9552,bus=3Di2c-bus.0,id=3D" PCA9552_TEST=
_ID
+                    ",address=3D0x60");
+    i2c =3D omap_i2c_create(s, OMAP2_I2C_1_BASE);
+
+    qtest_add_func("/pca9552/tx-rx", send_and_receive);
+    qtest_add_func("/pca9552/rx-autoinc", receive_autoinc);
+
+    ret =3D g_test_run();
+
+    if (s) {
+        qtest_quit(s);
+    }
+    g_free(i2c);
+
+    return ret;
+}
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index d093cffe1e08..34cae7a58248 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -14,8 +14,6 @@
 #include "qapi/qmp/qdict.h"
 #include "hw/misc/tmp105_regs.h"
=20
-#define OMAP2_I2C_1_BASE 0x48070000
-
 #define TMP105_TEST_ID   "tmp105-test"
 #define TMP105_TEST_ADDR 0x49
=20
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 00e834d0f065..ecd8d6109842 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-$(CONFIG_SGA) +=3D sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) +=3D pc-testdev.o
 common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
 common-obj-$(CONFIG_EDU) +=3D edu.o
+common-obj-$(CONFIG_PCA9552) +=3D pca9552.o
=20
 common-obj-y +=3D unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2c2..d45032bf1b4d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -371,6 +371,7 @@ check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESU=
F)
 check-qtest-sparc64-y +=3D tests/boot-serial-test$(EXESUF)
=20
 check-qtest-arm-y =3D tests/tmp105-test$(EXESUF)
+check-qtest-arm-y +=3D tests/pca9552-test$(EXESUF)
 check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
 check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
 gcov-files-arm-y +=3D hw/misc/tmp105.c
@@ -771,6 +772,7 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-te=
st.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-o=
bj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
+tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
--=20
2.13.6
