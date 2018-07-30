Received: from eggs.gnu.org ([2001:4830:134:3::10]:51994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkAFj-0007vW-7A
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkAFf-0004x5-VW
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:38:31 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fkAFf-0004wC-G7
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:38:27 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Mon, 30 Jul 2018 17:38:22 +0200
Message-Id: <3742959f9b28d8559e4eacf3ecee8901ab6f295d.1532963204.git.jcd@tribudubois.net>
In-Reply-To: <cover.1532963204.git.jcd@tribudubois.net>
References: <cover.1532963204.git.jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH v2 2/3] i.MX6UL: Add i.MX6UL SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---

Changes in V2:
 * use object_initialize_child instead of several funcions
 * use sysbus_init_child_obj instead for several functions

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/fsl-imx6ul.c             | 618 ++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6ul.h     | 339 ++++++++++++++++++
 4 files changed, 959 insertions(+)
 create mode 100644 hw/arm/fsl-imx6ul.c
 create mode 100644 include/hw/arm/fsl-imx6ul.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 834d45cfaf..311584fd74 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -133,6 +133,7 @@ CONFIG_FSL_IMX6=y
 CONFIG_FSL_IMX31=y
 CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
+CONFIG_FSL_IMX6UL=y
 
 CONFIG_IMX_I2C=y
 
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index d51fcecaf2..e419ad040b 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -36,3 +36,4 @@ obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
 obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
+obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
new file mode 100644
index 0000000000..e514216d09
--- /dev/null
+++ b/hw/arm/fsl-imx6ul.c
@@ -0,0 +1,618 @@
+/*
+ * Copyright (c) 2018 Jean-Christophe Dubois <jcd@tribudubois.net>
+ *
+ * i.MX6UL SOC emulation.
+ *
+ * Based on hw/arm/fsl-imx7.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "hw/arm/fsl-imx6ul.h"
+#include "hw/misc/unimp.h"
+#include "sysemu/sysemu.h"
+#include "qemu/error-report.h"
+
+#define NAME_SIZE 20
+
+static void fsl_imx6ul_init(Object *obj)
+{
+    FslIMX6ULState *s = FSL_IMX6UL(obj);
+    char name[NAME_SIZE];
+    int i;
+
+    for (i = 0; i < MIN(smp_cpus, FSL_IMX6UL_NUM_CPUS); i++) {
+        snprintf(name, NAME_SIZE, "cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
+                                "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
+    }
+
+    /*
+     * A7MPCORE
+     */
+    sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore, sizeof(s->a7mpcore),
+                          TYPE_A15MPCORE_PRIV);
+
+    /*
+     * CCM
+     */
+    sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX6UL_CCM);
+
+    /*
+     * SRC
+     */
+    sysbus_init_child_obj(obj, "src", &s->src, sizeof(s->src), TYPE_IMX6_SRC);
+
+    /*
+     * GPCv2
+     */
+    sysbus_init_child_obj(obj, "gpcv2", &s->gpcv2, sizeof(s->gpcv2),
+                          TYPE_IMX_GPCV2);
+
+    /*
+     * SNVS
+     */
+    sysbus_init_child_obj(obj, "snvs", &s->snvs, sizeof(s->snvs),
+                          TYPE_IMX7_SNVS);
+
+    /*
+     * GPR
+     */
+    sysbus_init_child_obj(obj, "gpr", &s->gpr, sizeof(s->gpr),
+                          TYPE_IMX7_GPR);
+
+    /*
+     * GPIOs 1 to 5
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_GPIOS; i++) {
+       snprintf(name, NAME_SIZE, "gpio%d", i);
+       sysbus_init_child_obj(obj, name, &s->gpio[i], sizeof(s->gpio[i]),
+                             TYPE_IMX_GPIO);
+    }
+
+    /*
+     * GPT 1, 2
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_GPTS; i++) {
+       snprintf(name, NAME_SIZE, "gpt%d", i);
+       sysbus_init_child_obj(obj, name, &s->gpt[i], sizeof(s->gpt[i]),
+                             TYPE_IMX7_GPT);
+    }
+
+    /*
+     * EPIT 1, 2
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_EPITS; i++) {
+       snprintf(name, NAME_SIZE, "epit%d", i + 1);
+       sysbus_init_child_obj(obj, name, &s->epit[i], sizeof(s->epit[i]),
+                             TYPE_IMX_EPIT);
+    }
+
+    /*
+     * eCSPI
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_ECSPIS; i++) {
+       snprintf(name, NAME_SIZE, "spi%d", i + 1);
+       sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
+                             TYPE_IMX_SPI);
+    }
+
+    /*
+     * I2C
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_I2CS; i++) {
+       snprintf(name, NAME_SIZE, "i2c%d", i + 1);
+       sysbus_init_child_obj(obj, name, &s->i2c[i], sizeof(s->i2c[i]),
+                             TYPE_IMX_I2C);
+    }
+
+    /*
+     * UART
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_UARTS; i++) {
+       snprintf(name, NAME_SIZE, "uart%d", i);
+       sysbus_init_child_obj(obj, name, &s->uart[i], sizeof(s->uart[i]),
+                             TYPE_IMX_SERIAL);
+    }
+
+    /*
+     * Ethernet
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_ETHS; i++) {
+       snprintf(name, NAME_SIZE, "eth%d", i);
+       sysbus_init_child_obj(obj, name, &s->eth[i], sizeof(s->eth[i]),
+                             TYPE_IMX_ENET);
+    }
+
+    /*
+     * SDHCI
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
+       snprintf(name, NAME_SIZE, "usdhc%d", i);
+       sysbus_init_child_obj(obj, name, &s->usdhc[i], sizeof(s->usdhc[i]),
+                             TYPE_IMX_USDHC);
+    }
+
+    /*
+     * Watchdog
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_WDTS; i++) {
+       snprintf(name, NAME_SIZE, "wdt%d", i);
+       sysbus_init_child_obj(obj, name, &s->wdt[i], sizeof(s->wdt[i]),
+                             TYPE_IMX2_WDT);
+    }
+}
+
+static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
+{
+    FslIMX6ULState *s = FSL_IMX6UL(dev);
+    Object *o;
+    int i;
+    qemu_irq irq;
+    char name[NAME_SIZE];
+
+    if (smp_cpus > FSL_IMX6UL_NUM_CPUS) {
+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
+                   TYPE_FSL_IMX6UL, FSL_IMX6UL_NUM_CPUS, smp_cpus);
+        return;
+    }
+
+    for (i = 0; i < smp_cpus; i++) {
+        o = OBJECT(&s->cpu[i]);
+
+        object_property_set_int(o, QEMU_PSCI_CONDUIT_SMC,
+                                "psci-conduit", &error_abort);
+
+        /* On uniprocessor, the CBAR is set to 0 */
+        if (smp_cpus > 1) {
+            object_property_set_int(o, FSL_IMX6UL_A7MPCORE_ADDR,
+                                    "reset-cbar", &error_abort);
+        }
+
+        if (i) {
+            /* Secondary CPUs start in PSCI powered-down state */
+            object_property_set_bool(o, true,
+                                     "start-powered-off", &error_abort);
+        }
+
+        object_property_set_bool(o, true, "realized", &error_abort);
+    }
+
+    /*
+     * A7MPCORE
+     */
+    object_property_set_int(OBJECT(&s->a7mpcore), smp_cpus, "num-cpu",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->a7mpcore),
+                            FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL,
+                            "num-irq", &error_abort);
+    object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
+                             &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
+
+    for (i = 0; i < smp_cpus; i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
+        DeviceState  *d   = DEVICE(qemu_get_cpu(i));
+
+        irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
+        sysbus_connect_irq(sbd, i, irq);
+        sysbus_connect_irq(sbd, i + smp_cpus, qdev_get_gpio_in(d, ARM_CPU_FIQ));
+    }
+
+    /*
+     * A7MPCORE DAP
+     */
+    create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
+                                0x100000);
+
+    /*
+     * GPT 1, 2
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_GPTS; i++) {
+        static const hwaddr FSL_IMX6UL_GPTn_ADDR[FSL_IMX6UL_NUM_GPTS] = {
+            FSL_IMX6UL_GPT1_ADDR,
+            FSL_IMX6UL_GPT2_ADDR,
+        };
+
+        static const int FSL_IMX6UL_GPTn_IRQ[FSL_IMX6UL_NUM_GPTS] = {
+            FSL_IMX6UL_GPT1_IRQ,
+            FSL_IMX6UL_GPT2_IRQ,
+        };
+
+        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                        FSL_IMX6UL_GPTn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_GPTn_IRQ[i]));
+    }
+
+    /*
+     * EPIT 1, 2
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_EPITS; i++) {
+        static const hwaddr FSL_IMX6UL_EPITn_ADDR[FSL_IMX6UL_NUM_EPITS] = {
+            FSL_IMX6UL_EPIT1_ADDR,
+            FSL_IMX6UL_EPIT2_ADDR,
+        };
+
+        static const int FSL_IMX6UL_EPITn_IRQ[FSL_IMX6UL_NUM_EPITS] = {
+            FSL_IMX6UL_EPIT1_IRQ,
+            FSL_IMX6UL_EPIT2_IRQ,
+        };
+
+        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0,
+                        FSL_IMX6UL_EPITn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->epit[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_EPITn_IRQ[i]));
+    }
+
+    /*
+     * GPIO
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_GPIOS; i++) {
+        static const hwaddr FSL_IMX6UL_GPIOn_ADDR[FSL_IMX6UL_NUM_GPIOS] = {
+            FSL_IMX6UL_GPIO1_ADDR,
+            FSL_IMX6UL_GPIO2_ADDR,
+            FSL_IMX6UL_GPIO3_ADDR,
+            FSL_IMX6UL_GPIO4_ADDR,
+            FSL_IMX6UL_GPIO5_ADDR,
+        };
+
+        static const int FSL_IMX6UL_GPIOn_LOW_IRQ[FSL_IMX6UL_NUM_GPIOS] = {
+            FSL_IMX6UL_GPIO1_LOW_IRQ,
+            FSL_IMX6UL_GPIO2_LOW_IRQ,
+            FSL_IMX6UL_GPIO3_LOW_IRQ,
+            FSL_IMX6UL_GPIO4_LOW_IRQ,
+            FSL_IMX6UL_GPIO5_LOW_IRQ,
+        };
+
+        static const int FSL_IMX6UL_GPIOn_HIGH_IRQ[FSL_IMX6UL_NUM_GPIOS] = {
+            FSL_IMX6UL_GPIO1_HIGH_IRQ,
+            FSL_IMX6UL_GPIO2_HIGH_IRQ,
+            FSL_IMX6UL_GPIO3_HIGH_IRQ,
+            FSL_IMX6UL_GPIO4_HIGH_IRQ,
+            FSL_IMX6UL_GPIO5_HIGH_IRQ,
+        };
+
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+                        FSL_IMX6UL_GPIOn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_GPIOn_LOW_IRQ[i]));
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_GPIOn_HIGH_IRQ[i]));
+    }
+
+    /*
+     * IOMUXC and IOMUXC_GPR
+     */
+    for (i = 0; i < 1; i++) {
+        static const hwaddr FSL_IMX6UL_IOMUXCn_ADDR[FSL_IMX6UL_NUM_IOMUXCS] = {
+            FSL_IMX6UL_IOMUXC_ADDR,
+            FSL_IMX6UL_IOMUXC_GPR_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "iomuxc%d", i);
+        create_unimplemented_device(name, FSL_IMX6UL_IOMUXCn_ADDR[i], 0x4000);
+    }
+
+    /*
+     * CCM
+     */
+    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6UL_CCM_ADDR);
+
+    /*
+     * SRC
+     */
+    object_property_set_bool(OBJECT(&s->src), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX6UL_SRC_ADDR);
+
+    /*
+     * GPCv2
+     */
+    object_property_set_bool(OBJECT(&s->gpcv2), true,
+                             "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpcv2), 0, FSL_IMX6UL_GPC_ADDR);
+
+    /* Initialize all ECSPI */
+    for (i = 0; i < FSL_IMX6UL_NUM_ECSPIS; i++) {
+        static const hwaddr FSL_IMX6UL_SPIn_ADDR[FSL_IMX6UL_NUM_ECSPIS] = {
+            FSL_IMX6UL_ECSPI1_ADDR,
+            FSL_IMX6UL_ECSPI2_ADDR,
+            FSL_IMX6UL_ECSPI3_ADDR,
+            FSL_IMX6UL_ECSPI4_ADDR,
+        };
+
+        static const int FSL_IMX6UL_SPIn_IRQ[FSL_IMX6UL_NUM_ECSPIS] = {
+            FSL_IMX6UL_ECSPI1_IRQ,
+            FSL_IMX6UL_ECSPI2_IRQ,
+            FSL_IMX6UL_ECSPI3_IRQ,
+            FSL_IMX6UL_ECSPI4_IRQ,
+        };
+
+        /* Initialize the SPI */
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                        FSL_IMX6UL_SPIn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_SPIn_IRQ[i]));
+    }
+
+    /*
+     * I2C
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_I2CS; i++) {
+        static const hwaddr FSL_IMX6UL_I2Cn_ADDR[FSL_IMX6UL_NUM_I2CS] = {
+            FSL_IMX6UL_I2C1_ADDR,
+            FSL_IMX6UL_I2C2_ADDR,
+            FSL_IMX6UL_I2C3_ADDR,
+            FSL_IMX6UL_I2C4_ADDR,
+        };
+
+        static const int FSL_IMX6UL_I2Cn_IRQ[FSL_IMX6UL_NUM_I2CS] = {
+            FSL_IMX6UL_I2C1_IRQ,
+            FSL_IMX6UL_I2C2_IRQ,
+            FSL_IMX6UL_I2C3_IRQ,
+            FSL_IMX6UL_I2C4_IRQ,
+        };
+
+        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, FSL_IMX6UL_I2Cn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_I2Cn_IRQ[i]));
+    }
+
+    /*
+     * UART
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_UARTS; i++) {
+        static const hwaddr FSL_IMX6UL_UARTn_ADDR[FSL_IMX6UL_NUM_UARTS] = {
+            FSL_IMX6UL_UART1_ADDR,
+            FSL_IMX6UL_UART2_ADDR,
+            FSL_IMX6UL_UART3_ADDR,
+            FSL_IMX6UL_UART4_ADDR,
+            FSL_IMX6UL_UART5_ADDR,
+            FSL_IMX6UL_UART6_ADDR,
+            FSL_IMX6UL_UART7_ADDR,
+            FSL_IMX6UL_UART8_ADDR,
+        };
+
+        static const int FSL_IMX6UL_UARTn_IRQ[FSL_IMX6UL_NUM_UARTS] = {
+            FSL_IMX6UL_UART1_IRQ,
+            FSL_IMX6UL_UART2_IRQ,
+            FSL_IMX6UL_UART3_IRQ,
+            FSL_IMX6UL_UART4_IRQ,
+            FSL_IMX6UL_UART5_IRQ,
+            FSL_IMX6UL_UART6_IRQ,
+            FSL_IMX6UL_UART7_IRQ,
+            FSL_IMX6UL_UART8_IRQ,
+        };
+
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                        FSL_IMX6UL_UARTn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_UARTn_IRQ[i]));
+    }
+
+    /*
+     * Ethernet
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_ETHS; i++) {
+        static const hwaddr FSL_IMX6UL_ENETn_ADDR[FSL_IMX6UL_NUM_ETHS] = {
+            FSL_IMX6UL_ENET1_ADDR,
+            FSL_IMX6UL_ENET2_ADDR,
+        };
+
+        static const int FSL_IMX6UL_ENETn_IRQ[FSL_IMX6UL_NUM_ETHS] = {
+            FSL_IMX6UL_ENET1_IRQ,
+            FSL_IMX6UL_ENET2_IRQ,
+        };
+
+        static const int FSL_IMX6UL_ENETn_TIMER_IRQ[FSL_IMX6UL_NUM_ETHS] = {
+            FSL_IMX6UL_ENET1_TIMER_IRQ,
+            FSL_IMX6UL_ENET2_TIMER_IRQ,
+        };
+
+        object_property_set_uint(OBJECT(&s->eth[i]),
+                                 FSL_IMX6UL_ETH_NUM_TX_RINGS,
+                                 "tx-ring-num", &error_abort);
+        qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
+        object_property_set_bool(OBJECT(&s->eth[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0,
+                        FSL_IMX6UL_ENETn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_ENETn_IRQ[i]));
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 1,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
+    }
+
+    /*
+     * USDHC
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
+        static const hwaddr FSL_IMX6UL_USDHCn_ADDR[FSL_IMX6UL_NUM_USDHCS] = {
+            FSL_IMX6UL_USDHC1_ADDR,
+            FSL_IMX6UL_USDHC2_ADDR,
+        };
+
+        static const int FSL_IMX6UL_USDHCn_IRQ[FSL_IMX6UL_NUM_USDHCS] = {
+            FSL_IMX6UL_USDHC1_IRQ,
+            FSL_IMX6UL_USDHC2_IRQ,
+        };
+
+        object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
+                        FSL_IMX6UL_USDHCn_ADDR[i]);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_USDHCn_IRQ[i]));
+    }
+
+    /*
+     * SNVS
+     */
+    object_property_set_bool(OBJECT(&s->snvs), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0, FSL_IMX6UL_SNVS_HP_ADDR);
+
+    /*
+     * Watchdog
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_WDTS; i++) {
+        static const hwaddr FSL_IMX6UL_WDOGn_ADDR[FSL_IMX6UL_NUM_WDTS] = {
+            FSL_IMX6UL_WDOG1_ADDR,
+            FSL_IMX6UL_WDOG2_ADDR,
+            FSL_IMX6UL_WDOG3_ADDR,
+        };
+
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                        FSL_IMX6UL_WDOGn_ADDR[i]);
+    }
+
+    /*
+     * GPR
+     */
+    object_property_set_bool(OBJECT(&s->gpr), true, "realized",
+                             &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX6UL_IOMUXC_GPR_ADDR);
+
+    /*
+     * SDMA
+     */
+    create_unimplemented_device("sdma", FSL_IMX6UL_SDMA_ADDR, 0x4000);
+
+    /*
+     * APHB_DMA
+     */
+    create_unimplemented_device("aphb_dma", FSL_IMX6UL_APBH_DMA_ADDR,
+                                FSL_IMX6UL_APBH_DMA_SIZE);
+
+    /*
+     * ADCs
+     */
+    for (i = 0; i < FSL_IMX6UL_NUM_ADCS; i++) {
+        static const hwaddr FSL_IMX6UL_ADCn_ADDR[FSL_IMX6UL_NUM_ADCS] = {
+            FSL_IMX6UL_ADC1_ADDR,
+            FSL_IMX6UL_ADC2_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "adc%d", i);
+        create_unimplemented_device(name, FSL_IMX6UL_ADCn_ADDR[i], 0x4000);
+    }
+
+    /*
+     * LCD
+     */
+    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR, 0x4000);
+
+    /*
+     * ROM memory
+     */
+    memory_region_init_rom(&s->rom, NULL, "imx6ul.rom",
+                           FSL_IMX6UL_ROM_SIZE, &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_ROM_ADDR,
+                                &s->rom);
+
+    /*
+     * CAAM memory
+     */
+    memory_region_init_rom(&s->caam, NULL, "imx6ul.caam",
+                           FSL_IMX6UL_CAAM_MEM_SIZE, &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_CAAM_MEM_ADDR,
+                                &s->caam);
+
+    /*
+     * OCRAM memory
+     */
+    memory_region_init_ram(&s->ocram, NULL, "imx6ul.ocram",
+                           FSL_IMX6UL_OCRAM_MEM_SIZE,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_OCRAM_MEM_ADDR,
+                                &s->ocram);
+
+    /*
+     * internal OCRAM (128 KB) is aliased over 512 KB
+     */
+    memory_region_init_alias(&s->ocram_alias, NULL, "imx6ul.ocram_alias",
+                             &s->ocram, 0, FSL_IMX6UL_OCRAM_ALIAS_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX6UL_OCRAM_ALIAS_ADDR, &s->ocram_alias);
+}
+
+static void fsl_imx6ul_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = fsl_imx6ul_realize;
+    dc->desc = "i.MX6UL SOC";
+    /* Reason: Uses serial_hds and nd_table in realize() directly */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo fsl_imx6ul_type_info = {
+    .name = TYPE_FSL_IMX6UL,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(FslIMX6ULState),
+    .instance_init = fsl_imx6ul_init,
+    .class_init = fsl_imx6ul_class_init,
+};
+
+static void fsl_imx6ul_register_types(void)
+{
+    type_register_static(&fsl_imx6ul_type_info);
+}
+type_init(fsl_imx6ul_register_types)
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
new file mode 100644
index 0000000000..5897217194
--- /dev/null
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -0,0 +1,339 @@
+/*
+ * Copyright (c) 2018 Jean-Christophe Dubois <jcd@tribudubois.net>
+ *
+ * i.MX6ul SoC definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef FSL_IMX6UL_H
+#define FSL_IMX6UL_H
+
+#include "hw/arm/arm.h"
+#include "hw/cpu/a15mpcore.h"
+#include "hw/misc/imx6ul_ccm.h"
+#include "hw/misc/imx6_src.h"
+#include "hw/misc/imx7_snvs.h"
+#include "hw/misc/imx7_gpr.h"
+#include "hw/intc/imx_gpcv2.h"
+#include "hw/misc/imx2_wdt.h"
+#include "hw/gpio/imx_gpio.h"
+#include "hw/char/imx_serial.h"
+#include "hw/timer/imx_gpt.h"
+#include "hw/timer/imx_epit.h"
+#include "hw/i2c/imx_i2c.h"
+#include "hw/gpio/imx_gpio.h"
+#include "hw/sd/sdhci.h"
+#include "hw/ssi/imx_spi.h"
+#include "hw/net/imx_fec.h"
+#include "exec/memory.h"
+#include "cpu.h"
+
+#define TYPE_FSL_IMX6UL "fsl,imx6ul"
+#define FSL_IMX6UL(obj) OBJECT_CHECK(FslIMX6ULState, (obj), TYPE_FSL_IMX6UL)
+
+enum FslIMX6ULConfiguration {
+    FSL_IMX6UL_NUM_CPUS         = 1,
+    FSL_IMX6UL_NUM_UARTS        = 8,
+    FSL_IMX6UL_NUM_ETHS         = 2,
+    FSL_IMX6UL_ETH_NUM_TX_RINGS = 2,
+    FSL_IMX6UL_NUM_USDHCS       = 2,
+    FSL_IMX6UL_NUM_WDTS         = 3,
+    FSL_IMX6UL_NUM_GPTS         = 2,
+    FSL_IMX6UL_NUM_EPITS        = 2,
+    FSL_IMX6UL_NUM_IOMUXCS      = 2,
+    FSL_IMX6UL_NUM_GPIOS        = 5,
+    FSL_IMX6UL_NUM_I2CS         = 4,
+    FSL_IMX6UL_NUM_ECSPIS       = 4,
+    FSL_IMX6UL_NUM_ADCS         = 2,
+};
+
+typedef struct FslIMX6ULState {
+    /*< private >*/
+    DeviceState    parent_obj;
+
+    /*< public >*/
+    ARMCPU             cpu[FSL_IMX6UL_NUM_CPUS];
+    A15MPPrivState     a7mpcore;
+    IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
+    IMXEPITState       epit[FSL_IMX6UL_NUM_EPITS];
+    IMXGPIOState       gpio[FSL_IMX6UL_NUM_GPIOS];
+    IMX6ULCCMState     ccm;
+    IMX6SRCState       src;
+    IMX7SNVSState      snvs;
+    IMXGPCv2State      gpcv2;
+    IMX7GPRState       gpr;
+    IMXSPIState        spi[FSL_IMX6UL_NUM_ECSPIS];
+    IMXI2CState        i2c[FSL_IMX6UL_NUM_I2CS];
+    IMXSerialState     uart[FSL_IMX6UL_NUM_UARTS];
+    IMXFECState        eth[FSL_IMX6UL_NUM_ETHS];
+    SDHCIState         usdhc[FSL_IMX6UL_NUM_USDHCS];
+    IMX2WdtState       wdt[FSL_IMX6UL_NUM_WDTS];
+    MemoryRegion       rom;
+    MemoryRegion       caam;
+    MemoryRegion       ocram;
+    MemoryRegion       ocram_alias;
+} FslIMX6ULState;
+
+enum FslIMX6ULMemoryMap {
+    FSL_IMX6UL_MMDC_ADDR            = 0x80000000,
+    FSL_IMX6UL_MMDC_SIZE            = 2 * 1024 * 1024 * 1024UL,
+
+    FSL_IMX6UL_QSPI1_MEM_ADDR       = 0x60000000,
+    FSL_IMX6UL_EIM_ALIAS_ADDR       = 0x58000000,
+    FSL_IMX6UL_EIM_CS_ADDR          = 0x50000000,
+    FSL_IMX6UL_AES_ENCRYPT_ADDR     = 0x10000000,
+    FSL_IMX6UL_QSPI1_RX_ADDR        = 0x0C000000,
+
+    /* AIPS-2 */
+    FSL_IMX6UL_UART6_ADDR           = 0x021FC000,
+    FSL_IMX6UL_I2C4_ADDR            = 0x021F8000,
+    FSL_IMX6UL_UART5_ADDR           = 0x021F4000,
+    FSL_IMX6UL_UART4_ADDR           = 0x021F0000,
+    FSL_IMX6UL_UART3_ADDR           = 0x021EC000,
+    FSL_IMX6UL_UART2_ADDR           = 0x021E8000,
+    FSL_IMX6UL_WDOG3_ADDR           = 0x021E4000,
+    FSL_IMX6UL_QSPI_ADDR            = 0x021E0000,
+    FSL_IMX6UL_SYS_CNT_CTRL_ADDR    = 0x021DC000,
+    FSL_IMX6UL_SYS_CNT_CMP_ADDR     = 0x021D8000,
+    FSL_IMX6UL_SYS_CNT_RD_ADDR      = 0x021D4000,
+    FSL_IMX6UL_TZASC_ADDR           = 0x021D0000,
+    FSL_IMX6UL_PXP_ADDR             = 0x021CC000,
+    FSL_IMX6UL_LCDIF_ADDR           = 0x021C8000,
+    FSL_IMX6UL_CSI_ADDR             = 0x021C4000,
+    FSL_IMX6UL_CSU_ADDR             = 0x021C0000,
+    FSL_IMX6UL_OCOTP_CTRL_ADDR      = 0x021BC000,
+    FSL_IMX6UL_EIM_ADDR             = 0x021B8000,
+    FSL_IMX6UL_SIM2_ADDR            = 0x021B4000,
+    FSL_IMX6UL_MMDC_CFG_ADDR        = 0x021B0000,
+    FSL_IMX6UL_ROMCP_ADDR           = 0x021AC000,
+    FSL_IMX6UL_I2C3_ADDR            = 0x021A8000,
+    FSL_IMX6UL_I2C2_ADDR            = 0x021A4000,
+    FSL_IMX6UL_I2C1_ADDR            = 0x021A0000,
+    FSL_IMX6UL_ADC2_ADDR            = 0x0219C000,
+    FSL_IMX6UL_ADC1_ADDR            = 0x02198000,
+    FSL_IMX6UL_USDHC2_ADDR          = 0x02194000,
+    FSL_IMX6UL_USDHC1_ADDR          = 0x02190000,
+    FSL_IMX6UL_SIM1_ADDR            = 0x0218C000,
+    FSL_IMX6UL_ENET1_ADDR           = 0x02188000,
+    FSL_IMX6UL_USBO2_USBMISC_ADDR   = 0x02184800,
+    FSL_IMX6UL_USBO2_USB_ADDR       = 0x02184000,
+    FSL_IMX6UL_USBO2_PL301_ADDR     = 0x02180000,
+    FSL_IMX6UL_AIPS2_CFG_ADDR       = 0x0217C000,
+    FSL_IMX6UL_CAAM_ADDR            = 0x02140000,
+    FSL_IMX6UL_A7MPCORE_DAP_ADDR    = 0x02100000,
+
+    /* AIPS-1 */
+    FSL_IMX6UL_PWM8_ADDR            = 0x020FC000,
+    FSL_IMX6UL_PWM7_ADDR            = 0x020F8000,
+    FSL_IMX6UL_PWM6_ADDR            = 0x020F4000,
+    FSL_IMX6UL_PWM5_ADDR            = 0x020F0000,
+    FSL_IMX6UL_SDMA_ADDR            = 0x020EC000,
+    FSL_IMX6UL_GPT2_ADDR            = 0x020E8000,
+    FSL_IMX6UL_IOMUXC_GPR_ADDR      = 0x020E4000,
+    FSL_IMX6UL_IOMUXC_ADDR          = 0x020E0000,
+    FSL_IMX6UL_GPC_ADDR             = 0x020DC000,
+    FSL_IMX6UL_SRC_ADDR             = 0x020D8000,
+    FSL_IMX6UL_EPIT2_ADDR           = 0x020D4000,
+    FSL_IMX6UL_EPIT1_ADDR           = 0x020D0000,
+    FSL_IMX6UL_SNVS_HP_ADDR         = 0x020CC000,
+    FSL_IMX6UL_ANALOG_ADDR          = 0x020C8000,
+    FSL_IMX6UL_CCM_ADDR             = 0x020C4000,
+    FSL_IMX6UL_WDOG2_ADDR           = 0x020C0000,
+    FSL_IMX6UL_WDOG1_ADDR           = 0x020BC000,
+    FSL_IMX6UL_KPP_ADDR             = 0x020B8000,
+    FSL_IMX6UL_ENET2_ADDR           = 0x020B4000,
+    FSL_IMX6UL_SNVS_LP_ADDR         = 0x020B0000,
+    FSL_IMX6UL_GPIO5_ADDR           = 0x020AC000,
+    FSL_IMX6UL_GPIO4_ADDR           = 0x020A8000,
+    FSL_IMX6UL_GPIO3_ADDR           = 0x020A4000,
+    FSL_IMX6UL_GPIO2_ADDR           = 0x020A0000,
+    FSL_IMX6UL_GPIO1_ADDR           = 0x0209C000,
+    FSL_IMX6UL_GPT1_ADDR            = 0x02098000,
+    FSL_IMX6UL_CAN2_ADDR            = 0x02094000,
+    FSL_IMX6UL_CAN1_ADDR            = 0x02090000,
+    FSL_IMX6UL_PWM4_ADDR            = 0x0208C000,
+    FSL_IMX6UL_PWM3_ADDR            = 0x02088000,
+    FSL_IMX6UL_PWM2_ADDR            = 0x02084000,
+    FSL_IMX6UL_PWM1_ADDR            = 0x02080000,
+    FSL_IMX6UL_AIPS1_CFG_ADDR       = 0x0207C000,
+    FSL_IMX6UL_BEE_ADDR             = 0x02044000,
+    FSL_IMX6UL_TOUCH_CTRL_ADDR      = 0x02040000,
+    FSL_IMX6UL_SPBA_ADDR            = 0x0203C000,
+    FSL_IMX6UL_ASRC_ADDR            = 0x02034000,
+    FSL_IMX6UL_SAI3_ADDR            = 0x02030000,
+    FSL_IMX6UL_SAI2_ADDR            = 0x0202C000,
+    FSL_IMX6UL_SAI1_ADDR            = 0x02028000,
+    FSL_IMX6UL_UART8_ADDR           = 0x02024000,
+    FSL_IMX6UL_UART1_ADDR           = 0x02020000,
+    FSL_IMX6UL_UART7_ADDR           = 0x02018000,
+    FSL_IMX6UL_ECSPI4_ADDR          = 0x02014000,
+    FSL_IMX6UL_ECSPI3_ADDR          = 0x02010000,
+    FSL_IMX6UL_ECSPI2_ADDR          = 0x0200C000,
+    FSL_IMX6UL_ECSPI1_ADDR          = 0x02008000,
+    FSL_IMX6UL_SPDIF_ADDR           = 0x02004000,
+
+    FSL_IMX6UL_APBH_DMA_ADDR        = 0x01804000,
+    FSL_IMX6UL_APBH_DMA_SIZE        = (32 * 1024),
+
+    FSL_IMX6UL_A7MPCORE_ADDR        = 0x00A00000,
+
+    FSL_IMX6UL_OCRAM_ALIAS_ADDR     = 0x00920000,
+    FSL_IMX6UL_OCRAM_ALIAS_SIZE     = 0x00060000,
+    FSL_IMX6UL_OCRAM_MEM_ADDR       = 0x00900000,
+    FSL_IMX6UL_OCRAM_MEM_SIZE       = 0x00020000,
+    FSL_IMX6UL_CAAM_MEM_ADDR        = 0x00100000,
+    FSL_IMX6UL_CAAM_MEM_SIZE        = 0x00008000,
+    FSL_IMX6UL_ROM_ADDR             = 0x00000000,
+    FSL_IMX6UL_ROM_SIZE             = 0x00018000,
+};
+
+enum FslIMX6ULIRQs {
+    FSL_IMX6UL_IOMUXC_IRQ   = 0,
+    FSL_IMX6UL_DAP_IRQ      = 1,
+    FSL_IMX6UL_SDMA_IRQ     = 2,
+    FSL_IMX6UL_TSC_IRQ      = 3,
+    FSL_IMX6UL_SNVS_IRQ     = 4,
+    FSL_IMX6UL_LCDIF_IRQ    = 5,
+    FSL_IMX6UL_BEE_IRQ      = 6,
+    FSL_IMX6UL_CSI_IRQ      = 7,
+    FSL_IMX6UL_PXP_IRQ      = 8,
+    FSL_IMX6UL_SCTR1_IRQ    = 9,
+    FSL_IMX6UL_SCTR2_IRQ    = 10,
+    FSL_IMX6UL_WDOG3_IRQ    = 11,
+    FSL_IMX6UL_APBH_DMA_IRQ = 13,
+    FSL_IMX6UL_WEIM_IRQ     = 14,
+    FSL_IMX6UL_RAWNAND1_IRQ = 15,
+    FSL_IMX6UL_RAWNAND2_IRQ = 16,
+    FSL_IMX6UL_UART6_IRQ    = 17,
+    FSL_IMX6UL_SRTC_IRQ     = 19,
+    FSL_IMX6UL_SRTC_SEC_IRQ = 20,
+    FSL_IMX6UL_CSU_IRQ      = 21,
+    FSL_IMX6UL_USDHC1_IRQ   = 22,
+    FSL_IMX6UL_USDHC2_IRQ   = 23,
+    FSL_IMX6UL_SAI3_IRQ     = 24,
+    FSL_IMX6UL_SAI32_IRQ    = 25,
+
+    FSL_IMX6UL_UART1_IRQ    = 26,
+    FSL_IMX6UL_UART2_IRQ    = 27,
+    FSL_IMX6UL_UART3_IRQ    = 28,
+    FSL_IMX6UL_UART4_IRQ    = 29,
+    FSL_IMX6UL_UART5_IRQ    = 30,
+
+    FSL_IMX6UL_ECSPI1_IRQ   = 31,
+    FSL_IMX6UL_ECSPI2_IRQ   = 32,
+    FSL_IMX6UL_ECSPI3_IRQ   = 33,
+    FSL_IMX6UL_ECSPI4_IRQ   = 34,
+
+    FSL_IMX6UL_I2C4_IRQ     = 35,
+    FSL_IMX6UL_I2C1_IRQ     = 36,
+    FSL_IMX6UL_I2C2_IRQ     = 37,
+    FSL_IMX6UL_I2C3_IRQ     = 38,
+
+    FSL_IMX6UL_UART7_IRQ    = 39,
+    FSL_IMX6UL_UART8_IRQ    = 40,
+
+    FSL_IMX6UL_USB1_IRQ     = 42,
+    FSL_IMX6UL_USB2_IRQ     = 43,
+    FSL_IMX6UL_USB_PHY1_IRQ = 44,
+    FSL_IMX6UL_USB_PHY2_IRQ = 44,
+
+    FSL_IMX6UL_CAAM_JQ2_IRQ = 46,
+    FSL_IMX6UL_CAAM_ERR_IRQ = 47,
+    FSL_IMX6UL_CAAM_RTIC_IRQ = 48,
+    FSL_IMX6UL_TEMP_IRQ     = 49,
+    FSL_IMX6UL_ASRC_IRQ     = 50,
+    FSL_IMX6UL_SPDIF_IRQ    = 52,
+    FSL_IMX6UL_PMU_REG_IRQ  = 54,
+    FSL_IMX6UL_GPT1_IRQ     = 55,
+
+    FSL_IMX6UL_EPIT1_IRQ    = 56,
+    FSL_IMX6UL_EPIT2_IRQ    = 57,
+
+    FSL_IMX6UL_GPIO1_INT7_IRQ = 58,
+    FSL_IMX6UL_GPIO1_INT6_IRQ = 59,
+    FSL_IMX6UL_GPIO1_INT5_IRQ = 60,
+    FSL_IMX6UL_GPIO1_INT4_IRQ = 61,
+    FSL_IMX6UL_GPIO1_INT3_IRQ = 62,
+    FSL_IMX6UL_GPIO1_INT2_IRQ = 63,
+    FSL_IMX6UL_GPIO1_INT1_IRQ = 64,
+    FSL_IMX6UL_GPIO1_INT0_IRQ = 65,
+    FSL_IMX6UL_GPIO1_LOW_IRQ  = 66,
+    FSL_IMX6UL_GPIO1_HIGH_IRQ = 67,
+    FSL_IMX6UL_GPIO2_LOW_IRQ  = 68,
+    FSL_IMX6UL_GPIO2_HIGH_IRQ = 69,
+    FSL_IMX6UL_GPIO3_LOW_IRQ  = 70,
+    FSL_IMX6UL_GPIO3_HIGH_IRQ = 71,
+    FSL_IMX6UL_GPIO4_LOW_IRQ  = 72,
+    FSL_IMX6UL_GPIO4_HIGH_IRQ = 73,
+    FSL_IMX6UL_GPIO5_LOW_IRQ  = 74,
+    FSL_IMX6UL_GPIO5_HIGH_IRQ = 75,
+
+    FSL_IMX6UL_WDOG1_IRQ    = 80,
+    FSL_IMX6UL_WDOG2_IRQ    = 81,
+
+    FSL_IMX6UL_KPP_IRQ      = 82,
+
+    FSL_IMX6UL_PWM1_IRQ     = 83,
+    FSL_IMX6UL_PWM2_IRQ     = 84,
+    FSL_IMX6UL_PWM3_IRQ     = 85,
+    FSL_IMX6UL_PWM4_IRQ     = 86,
+
+    FSL_IMX6UL_CCM1_IRQ     = 87,
+    FSL_IMX6UL_CCM2_IRQ     = 88,
+
+    FSL_IMX6UL_GPC_IRQ      = 89,
+
+    FSL_IMX6UL_SRC_IRQ      = 91,
+
+    FSL_IMX6UL_CPU_PERF_IRQ = 94,
+    FSL_IMX6UL_CPU_CTI_IRQ  = 95,
+
+    FSL_IMX6UL_SRC_WDOG_IRQ = 96,
+
+    FSL_IMX6UL_SAI1_IRQ     = 97,
+    FSL_IMX6UL_SAI2_IRQ     = 98,
+
+    FSL_IMX6UL_ADC1_IRQ     = 100,
+    FSL_IMX6UL_ADC2_IRQ     = 101,
+
+    FSL_IMX6UL_SJC_IRQ      = 104,
+
+    FSL_IMX6UL_CAAM_RING0_IRQ = 105,
+    FSL_IMX6UL_CAAM_RING1_IRQ = 106,
+
+    FSL_IMX6UL_QSPI_IRQ     = 107,
+
+    FSL_IMX6UL_TZASC_IRQ    = 108,
+
+    FSL_IMX6UL_GPT2_IRQ     = 109,
+
+    FSL_IMX6UL_CAN1_IRQ     = 110,
+    FSL_IMX6UL_CAN2_IRQ     = 111,
+
+    FSL_IMX6UL_SIM1_IRQ     = 112,
+    FSL_IMX6UL_SIM2_IRQ     = 113,
+
+    FSL_IMX6UL_PWM5_IRQ     = 114,
+    FSL_IMX6UL_PWM6_IRQ     = 115,
+    FSL_IMX6UL_PWM7_IRQ     = 116,
+    FSL_IMX6UL_PWM8_IRQ     = 117,
+
+    FSL_IMX6UL_ENET1_IRQ    = 118,
+    FSL_IMX6UL_ENET1_TIMER_IRQ = 119,
+    FSL_IMX6UL_ENET2_IRQ    = 120,
+    FSL_IMX6UL_ENET2_TIMER_IRQ = 121,
+
+    FSL_IMX6UL_PMU_CORE_IRQ = 127,
+    FSL_IMX6UL_MAX_IRQ      = 128,
+};
+
+#endif /* FSL_IMX6UL_H */
-- 
2.17.1
