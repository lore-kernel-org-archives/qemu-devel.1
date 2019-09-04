Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFFC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370B52087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370B52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5POo-0003Lm-Hi
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 03:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5PMN-0001Oi-9y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5PMJ-0006EW-1E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:43 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:33939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5PMG-00064L-VF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:37 -0400
Received: from player690.ha.ovh.net (unknown [10.109.146.19])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 965D3130D3A
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 09:05:27 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id A795194DC717;
 Wed,  4 Sep 2019 07:05:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 09:04:57 +0200
Message-Id: <20190904070506.1052-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904070506.1052-1-clg@kaod.org>
References: <20190904070506.1052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 7077125342490037009
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejgedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.19
Subject: [Qemu-devel] [PATCH 01/10] hw/gpio: Add basic Aspeed GPIO model for
 AST2400 and AST2500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Rashmica Gupta <rashmica.g@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rashmica Gupta <rashmica.g@gmail.com>

GPIO pins are arranged in groups of 8 pins labeled A,B,..,Y,Z,AA,AB,AC.
(Note that the ast2400 controller only goes up to group AB).
A set has four groups (except set AC which only has one) and is
referred to by the groups it is composed of (eg ABCD,EFGH,...,YZAAAB).
Each set is accessed and controlled by a bank of 14 registers.

These registers operate on a per pin level where each bit in the register
corresponds to a pin, except for the command source registers. The comman=
d
source registers operate on a per group level where bits 24, 16, 8 and 0
correspond to each group in the set.

 eg. registers for set ABCD:
 |D7...D0|C7...C0|B7...B0|A7...A0| <- GPIOs
 |31...24|23...16|15....8|7.....0| <- bit position

Note that there are a couple of groups that only have 4 pins.

There are two ways that this model deviates from the behaviour of the
actual controller:
(1) The only control source driving the GPIO pins in the model is the ARM
model (as there currently aren't models for the LPC or Coprocessor).

(2) None of the registers in the model are reset tolerant (needs
integration with the watchdog).

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
Tested-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
[clg: fixed missing header files
      made use of HWADDR_PRIx to fix compilation on windows ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/gpio/aspeed_gpio.h | 100 ++++
 hw/gpio/aspeed_gpio.c         | 884 ++++++++++++++++++++++++++++++++++
 hw/gpio/Makefile.objs         |   1 +
 3 files changed, 985 insertions(+)
 create mode 100644 include/hw/gpio/aspeed_gpio.h
 create mode 100644 hw/gpio/aspeed_gpio.c

diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.=
h
new file mode 100644
index 000000000000..a2deac046af6
--- /dev/null
+++ b/include/hw/gpio/aspeed_gpio.h
@@ -0,0 +1,100 @@
+/*
+ *  ASPEED GPIO Controller
+ *
+ *  Copyright (C) 2017-2018 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef ASPEED_GPIO_H
+#define ASPEED_GPIO_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_GPIO "aspeed.gpio"
+#define ASPEED_GPIO(obj) OBJECT_CHECK(AspeedGPIOState, (obj), TYPE_ASPEE=
D_GPIO)
+#define ASPEED_GPIO_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedGPIOClass, (klass), TYPE_ASPEED_GPIO)
+#define ASPEED_GPIO_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedGPIOClass, (obj), TYPE_ASPEED_GPIO)
+
+#define ASPEED_GPIO_MAX_NR_SETS 8
+#define ASPEED_REGS_PER_BANK 14
+#define ASPEED_GPIO_MAX_NR_REGS (ASPEED_REGS_PER_BANK * ASPEED_GPIO_MAX_=
NR_SETS)
+#define ASPEED_GPIO_NR_PINS 228
+#define ASPEED_GROUPS_PER_SET 4
+#define ASPEED_GPIO_NR_DEBOUNCE_REGS 3
+#define ASPEED_CHARS_PER_GROUP_LABEL 4
+
+typedef struct GPIOSets GPIOSets;
+
+typedef struct GPIOSetProperties {
+    uint32_t input;
+    uint32_t output;
+    char group_label[ASPEED_GROUPS_PER_SET][ASPEED_CHARS_PER_GROUP_LABEL=
];
+} GPIOSetProperties;
+
+enum GPIORegType {
+    gpio_not_a_reg,
+    gpio_reg_data_value,
+    gpio_reg_direction,
+    gpio_reg_int_enable,
+    gpio_reg_int_sens_0,
+    gpio_reg_int_sens_1,
+    gpio_reg_int_sens_2,
+    gpio_reg_int_status,
+    gpio_reg_reset_tolerant,
+    gpio_reg_debounce_1,
+    gpio_reg_debounce_2,
+    gpio_reg_cmd_source_0,
+    gpio_reg_cmd_source_1,
+    gpio_reg_data_read,
+    gpio_reg_input_mask,
+};
+
+typedef struct AspeedGPIOReg {
+    uint16_t set_idx;
+    enum GPIORegType type;
+ } AspeedGPIOReg;
+
+typedef struct  AspeedGPIOClass {
+    SysBusDevice parent_obj;
+    const GPIOSetProperties *props;
+    uint32_t nr_gpio_pins;
+    uint32_t nr_gpio_sets;
+    uint32_t gap;
+    const AspeedGPIOReg *reg_table;
+}  AspeedGPIOClass;
+
+typedef struct AspeedGPIOState {
+    /* <private> */
+    SysBusDevice parent;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    int pending;
+    qemu_irq irq;
+    qemu_irq gpios[ASPEED_GPIO_NR_PINS];
+
+/* Parallel GPIO Registers */
+    uint32_t debounce_regs[ASPEED_GPIO_NR_DEBOUNCE_REGS];
+    struct GPIOSets {
+        uint32_t data_value; /* Reflects pin values */
+        uint32_t data_read; /* Contains last value written to data value=
 */
+        uint32_t direction;
+        uint32_t int_enable;
+        uint32_t int_sens_0;
+        uint32_t int_sens_1;
+        uint32_t int_sens_2;
+        uint32_t int_status;
+        uint32_t reset_tol;
+        uint32_t cmd_source_0;
+        uint32_t cmd_source_1;
+        uint32_t debounce_1;
+        uint32_t debounce_2;
+        uint32_t input_mask;
+    } sets[ASPEED_GPIO_MAX_NR_SETS];
+} AspeedGPIOState;
+
+#endif /* _ASPEED_GPIO_H_ */
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
new file mode 100644
index 000000000000..25fbfec3b84e
--- /dev/null
+++ b/hw/gpio/aspeed_gpio.c
@@ -0,0 +1,884 @@
+/*
+ *  ASPEED GPIO Controller
+ *
+ *  Copyright (C) 2017-2019 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "qemu/log.h"
+#include "hw/gpio/aspeed_gpio.h"
+#include "include/hw/misc/aspeed_scu.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+
+#define GPIOS_PER_REG 32
+#define GPIOS_PER_SET GPIOS_PER_REG
+#define GPIO_PIN_GAP_SIZE 4
+#define GPIOS_PER_GROUP 8
+#define GPIO_GROUP_SHIFT 3
+
+/* GPIO Source Types */
+#define ASPEED_CMD_SRC_MASK         0x01010101
+#define ASPEED_SOURCE_ARM           0
+#define ASPEED_SOURCE_LPC           1
+#define ASPEED_SOURCE_COPROCESSOR   2
+#define ASPEED_SOURCE_RESERVED      3
+
+/* GPIO Interrupt Triggers */
+/*
+ *  For each set of gpios there are three sensitivity registers that con=
trol
+ *  the interrupt trigger mode.
+ *
+ *  | 2 | 1 | 0 | trigger mode
+ *  -----------------------------
+ *  | 0 | 0 | 0 | falling-edge
+ *  | 0 | 0 | 1 | rising-edge
+ *  | 0 | 1 | 0 | level-low
+ *  | 0 | 1 | 1 | level-high
+ *  | 1 | X | X | dual-edge
+ */
+#define ASPEED_FALLING_EDGE 0
+#define ASPEED_RISING_EDGE  1
+#define ASPEED_LEVEL_LOW    2
+#define ASPEED_LEVEL_HIGH   3
+#define ASPEED_DUAL_EDGE    4
+
+/* GPIO Register Address Offsets */
+#define GPIO_ABCD_DATA_VALUE       (0x000 >> 2)
+#define GPIO_ABCD_DIRECTION        (0x004 >> 2)
+#define GPIO_ABCD_INT_ENABLE       (0x008 >> 2)
+#define GPIO_ABCD_INT_SENS_0       (0x00C >> 2)
+#define GPIO_ABCD_INT_SENS_1       (0x010 >> 2)
+#define GPIO_ABCD_INT_SENS_2       (0x014 >> 2)
+#define GPIO_ABCD_INT_STATUS       (0x018 >> 2)
+#define GPIO_ABCD_RESET_TOLERANT   (0x01C >> 2)
+#define GPIO_EFGH_DATA_VALUE       (0x020 >> 2)
+#define GPIO_EFGH_DIRECTION        (0x024 >> 2)
+#define GPIO_EFGH_INT_ENABLE       (0x028 >> 2)
+#define GPIO_EFGH_INT_SENS_0       (0x02C >> 2)
+#define GPIO_EFGH_INT_SENS_1       (0x030 >> 2)
+#define GPIO_EFGH_INT_SENS_2       (0x034 >> 2)
+#define GPIO_EFGH_INT_STATUS       (0x038 >> 2)
+#define GPIO_EFGH_RESET_TOLERANT   (0x03C >> 2)
+#define GPIO_ABCD_DEBOUNCE_1       (0x040 >> 2)
+#define GPIO_ABCD_DEBOUNCE_2       (0x044 >> 2)
+#define GPIO_EFGH_DEBOUNCE_1       (0x048 >> 2)
+#define GPIO_EFGH_DEBOUNCE_2       (0x04C >> 2)
+#define GPIO_DEBOUNCE_TIME_1       (0x050 >> 2)
+#define GPIO_DEBOUNCE_TIME_2       (0x054 >> 2)
+#define GPIO_DEBOUNCE_TIME_3       (0x058 >> 2)
+#define GPIO_ABCD_COMMAND_SRC_0    (0x060 >> 2)
+#define GPIO_ABCD_COMMAND_SRC_1    (0x064 >> 2)
+#define GPIO_EFGH_COMMAND_SRC_0    (0x068 >> 2)
+#define GPIO_EFGH_COMMAND_SRC_1    (0x06C >> 2)
+#define GPIO_IJKL_DATA_VALUE       (0x070 >> 2)
+#define GPIO_IJKL_DIRECTION        (0x074 >> 2)
+#define GPIO_MNOP_DATA_VALUE       (0x078 >> 2)
+#define GPIO_MNOP_DIRECTION        (0x07C >> 2)
+#define GPIO_QRST_DATA_VALUE       (0x080 >> 2)
+#define GPIO_QRST_DIRECTION        (0x084 >> 2)
+#define GPIO_UVWX_DATA_VALUE       (0x088 >> 2)
+#define GPIO_UVWX_DIRECTION        (0x08C >> 2)
+#define GPIO_IJKL_COMMAND_SRC_0    (0x090 >> 2)
+#define GPIO_IJKL_COMMAND_SRC_1    (0x094 >> 2)
+#define GPIO_IJKL_INT_ENABLE       (0x098 >> 2)
+#define GPIO_IJKL_INT_SENS_0       (0x09C >> 2)
+#define GPIO_IJKL_INT_SENS_1       (0x0A0 >> 2)
+#define GPIO_IJKL_INT_SENS_2       (0x0A4 >> 2)
+#define GPIO_IJKL_INT_STATUS       (0x0A8 >> 2)
+#define GPIO_IJKL_RESET_TOLERANT   (0x0AC >> 2)
+#define GPIO_IJKL_DEBOUNCE_1       (0x0B0 >> 2)
+#define GPIO_IJKL_DEBOUNCE_2       (0x0B4 >> 2)
+#define GPIO_IJKL_INPUT_MASK       (0x0B8 >> 2)
+#define GPIO_ABCD_DATA_READ        (0x0C0 >> 2)
+#define GPIO_EFGH_DATA_READ        (0x0C4 >> 2)
+#define GPIO_IJKL_DATA_READ        (0x0C8 >> 2)
+#define GPIO_MNOP_DATA_READ        (0x0CC >> 2)
+#define GPIO_QRST_DATA_READ        (0x0D0 >> 2)
+#define GPIO_UVWX_DATA_READ        (0x0D4 >> 2)
+#define GPIO_YZAAAB_DATA_READ      (0x0D8 >> 2)
+#define GPIO_AC_DATA_READ          (0x0DC >> 2)
+#define GPIO_MNOP_COMMAND_SRC_0    (0x0E0 >> 2)
+#define GPIO_MNOP_COMMAND_SRC_1    (0x0E4 >> 2)
+#define GPIO_MNOP_INT_ENABLE       (0x0E8 >> 2)
+#define GPIO_MNOP_INT_SENS_0       (0x0EC >> 2)
+#define GPIO_MNOP_INT_SENS_1       (0x0F0 >> 2)
+#define GPIO_MNOP_INT_SENS_2       (0x0F4 >> 2)
+#define GPIO_MNOP_INT_STATUS       (0x0F8 >> 2)
+#define GPIO_MNOP_RESET_TOLERANT   (0x0FC >> 2)
+#define GPIO_MNOP_DEBOUNCE_1       (0x100 >> 2)
+#define GPIO_MNOP_DEBOUNCE_2       (0x104 >> 2)
+#define GPIO_MNOP_INPUT_MASK       (0x108 >> 2)
+#define GPIO_QRST_COMMAND_SRC_0    (0x110 >> 2)
+#define GPIO_QRST_COMMAND_SRC_1    (0x114 >> 2)
+#define GPIO_QRST_INT_ENABLE       (0x118 >> 2)
+#define GPIO_QRST_INT_SENS_0       (0x11C >> 2)
+#define GPIO_QRST_INT_SENS_1       (0x120 >> 2)
+#define GPIO_QRST_INT_SENS_2       (0x124 >> 2)
+#define GPIO_QRST_INT_STATUS       (0x128 >> 2)
+#define GPIO_QRST_RESET_TOLERANT   (0x12C >> 2)
+#define GPIO_QRST_DEBOUNCE_1       (0x130 >> 2)
+#define GPIO_QRST_DEBOUNCE_2       (0x134 >> 2)
+#define GPIO_QRST_INPUT_MASK       (0x138 >> 2)
+#define GPIO_UVWX_COMMAND_SRC_0    (0x140 >> 2)
+#define GPIO_UVWX_COMMAND_SRC_1    (0x144 >> 2)
+#define GPIO_UVWX_INT_ENABLE       (0x148 >> 2)
+#define GPIO_UVWX_INT_SENS_0       (0x14C >> 2)
+#define GPIO_UVWX_INT_SENS_1       (0x150 >> 2)
+#define GPIO_UVWX_INT_SENS_2       (0x154 >> 2)
+#define GPIO_UVWX_INT_STATUS       (0x158 >> 2)
+#define GPIO_UVWX_RESET_TOLERANT   (0x15C >> 2)
+#define GPIO_UVWX_DEBOUNCE_1       (0x160 >> 2)
+#define GPIO_UVWX_DEBOUNCE_2       (0x164 >> 2)
+#define GPIO_UVWX_INPUT_MASK       (0x168 >> 2)
+#define GPIO_YZAAAB_COMMAND_SRC_0  (0x170 >> 2)
+#define GPIO_YZAAAB_COMMAND_SRC_1  (0x174 >> 2)
+#define GPIO_YZAAAB_INT_ENABLE     (0x178 >> 2)
+#define GPIO_YZAAAB_INT_SENS_0     (0x17C >> 2)
+#define GPIO_YZAAAB_INT_SENS_1     (0x180 >> 2)
+#define GPIO_YZAAAB_INT_SENS_2     (0x184 >> 2)
+#define GPIO_YZAAAB_INT_STATUS     (0x188 >> 2)
+#define GPIO_YZAAAB_RESET_TOLERANT (0x18C >> 2)
+#define GPIO_YZAAAB_DEBOUNCE_1     (0x190 >> 2)
+#define GPIO_YZAAAB_DEBOUNCE_2     (0x194 >> 2)
+#define GPIO_YZAAAB_INPUT_MASK     (0x198 >> 2)
+#define GPIO_AC_COMMAND_SRC_0      (0x1A0 >> 2)
+#define GPIO_AC_COMMAND_SRC_1      (0x1A4 >> 2)
+#define GPIO_AC_INT_ENABLE         (0x1A8 >> 2)
+#define GPIO_AC_INT_SENS_0         (0x1AC >> 2)
+#define GPIO_AC_INT_SENS_1         (0x1B0 >> 2)
+#define GPIO_AC_INT_SENS_2         (0x1B4 >> 2)
+#define GPIO_AC_INT_STATUS         (0x1B8 >> 2)
+#define GPIO_AC_RESET_TOLERANT     (0x1BC >> 2)
+#define GPIO_AC_DEBOUNCE_1         (0x1C0 >> 2)
+#define GPIO_AC_DEBOUNCE_2         (0x1C4 >> 2)
+#define GPIO_AC_INPUT_MASK         (0x1C8 >> 2)
+#define GPIO_ABCD_INPUT_MASK       (0x1D0 >> 2)
+#define GPIO_EFGH_INPUT_MASK       (0x1D4 >> 2)
+#define GPIO_YZAAAB_DATA_VALUE     (0x1E0 >> 2)
+#define GPIO_YZAAAB_DIRECTION      (0x1E4 >> 2)
+#define GPIO_AC_DATA_VALUE         (0x1E8 >> 2)
+#define GPIO_AC_DIRECTION          (0x1EC >> 2)
+#define GPIO_3_6V_MEM_SIZE         0x1F0
+#define GPIO_3_6V_REG_ARRAY_SIZE   (GPIO_3_6V_MEM_SIZE >> 2)
+
+static int aspeed_evaluate_irq(GPIOSets *regs, int gpio_prev_high, int g=
pio)
+{
+    uint32_t falling_edge =3D 0, rising_edge =3D 0;
+    uint32_t int_trigger =3D extract32(regs->int_sens_0, gpio, 1)
+                           | extract32(regs->int_sens_1, gpio, 1) << 1
+                           | extract32(regs->int_sens_2, gpio, 1) << 2;
+    uint32_t gpio_curr_high =3D extract32(regs->data_value, gpio, 1);
+    uint32_t gpio_int_enabled =3D extract32(regs->int_enable, gpio, 1);
+
+    if (!gpio_int_enabled) {
+        return 0;
+    }
+
+    /* Detect edges */
+    if (gpio_curr_high && !gpio_prev_high) {
+        rising_edge =3D 1;
+    } else if (!gpio_curr_high && gpio_prev_high) {
+        falling_edge =3D 1;
+    }
+
+    if (((int_trigger =3D=3D ASPEED_FALLING_EDGE)  && falling_edge)  ||
+        ((int_trigger =3D=3D ASPEED_RISING_EDGE)  && rising_edge)    ||
+        ((int_trigger =3D=3D ASPEED_LEVEL_LOW)  && !gpio_curr_high)  ||
+        ((int_trigger =3D=3D ASPEED_LEVEL_HIGH)  && gpio_curr_high)  ||
+        ((int_trigger >=3D ASPEED_DUAL_EDGE)  && (rising_edge || falling=
_edge)))
+    {
+        regs->int_status =3D deposit32(regs->int_status, gpio, 1, 1);
+        return 1;
+    }
+    return 0;
+}
+
+#define nested_struct_index(ta, pa, m, tb, pb) \
+        (pb - ((tb *)(((char *)pa) + offsetof(ta, m))))
+
+static ptrdiff_t aspeed_gpio_set_idx(AspeedGPIOState *s, GPIOSets *regs)
+{
+    return nested_struct_index(AspeedGPIOState, s, sets, GPIOSets, regs)=
;
+}
+
+static void aspeed_gpio_update(AspeedGPIOState *s, GPIOSets *regs,
+                               uint32_t value)
+{
+    uint32_t input_mask =3D regs->input_mask;
+    uint32_t direction =3D regs->direction;
+    uint32_t old =3D regs->data_value;
+    uint32_t new =3D value;
+    uint32_t diff;
+    int gpio;
+
+    diff =3D old ^ new;
+    if (diff) {
+        for (gpio =3D 0; gpio < GPIOS_PER_REG; gpio++) {
+            uint32_t mask =3D 1 << gpio;
+
+            /* If the gpio needs to be updated... */
+            if (!(diff & mask)) {
+                continue;
+            }
+
+            /* ...and we're output or not input-masked... */
+            if (!(direction & mask) && (input_mask & mask)) {
+                continue;
+            }
+
+            /* ...then update the state. */
+            if (mask & new) {
+                regs->data_value |=3D mask;
+            } else {
+                regs->data_value &=3D ~mask;
+            }
+
+            /* If the gpio is set to output... */
+            if (direction & mask) {
+                /* ...trigger the line-state IRQ */
+                ptrdiff_t set =3D aspeed_gpio_set_idx(s, regs);
+                size_t offset =3D set * GPIOS_PER_SET + gpio;
+                qemu_set_irq(s->gpios[offset], !!(new & mask));
+            } else {
+                /* ...otherwise if we meet the line's current IRQ policy=
... */
+                if (aspeed_evaluate_irq(regs, old & mask, gpio)) {
+                    /* ...trigger the VIC IRQ */
+                    s->pending++;
+                }
+            }
+        }
+    }
+    qemu_set_irq(s->irq, !!(s->pending));
+}
+
+static uint32_t aspeed_adjust_pin(AspeedGPIOState *s, uint32_t pin)
+{
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
+    /*
+     * The 2500 has a 4 pin gap in group AB and the 2400 has a 4 pin
+     * gap in group Y (and only four pins in AB but this is the last gro=
up so
+     * it doesn't matter).
+     */
+    if (agc->gap && pin >=3D agc->gap) {
+        pin +=3D GPIO_PIN_GAP_SIZE;
+    }
+
+    return pin;
+}
+
+static bool aspeed_gpio_get_pin_level(AspeedGPIOState *s, uint32_t set_i=
dx,
+                                      uint32_t pin)
+{
+    uint32_t reg_val;
+    uint32_t pin_mask =3D 1 << pin;
+
+    reg_val =3D s->sets[set_idx].data_value;
+
+    return !!(reg_val & pin_mask);
+}
+
+static void aspeed_gpio_set_pin_level(AspeedGPIOState *s, uint32_t set_i=
dx,
+                                      uint32_t pin, bool level)
+{
+    uint32_t value =3D s->sets[set_idx].data_value;
+    uint32_t pin_mask =3D 1 << pin;
+
+    if (level) {
+        value |=3D pin_mask;
+    } else {
+        value &=3D !pin_mask;
+    }
+
+    aspeed_gpio_update(s, &s->sets[set_idx], value);
+}
+
+/*
+ *  | src_1 | src_2 |  source     |
+ *  |-----------------------------|
+ *  |   0   |   0   |  ARM        |
+ *  |   0   |   1   |  LPC        |
+ *  |   1   |   0   |  Coprocessor|
+ *  |   1   |   1   |  Reserved   |
+ *
+ *  Once the source of a set is programmed, corresponding bits in the
+ *  data_value, direction, interrupt [enable, sens[0-2]], reset_tol and
+ *  debounce registers can only be written by the source.
+ *
+ *  Source is ARM by default
+ *  only bits 24, 16, 8, and 0 can be set
+ *
+ *  we don't currently have a model for the LPC or Coprocessor
+ */
+static uint32_t update_value_control_source(GPIOSets *regs, uint32_t old=
_value,
+                                            uint32_t value)
+{
+    int i;
+    int cmd_source;
+
+    /* assume the source is always ARM for now */
+    int source =3D ASPEED_SOURCE_ARM;
+
+    uint32_t new_value =3D 0;
+
+    /* for each group in set */
+    for (i =3D 0; i < GPIOS_PER_REG; i +=3D GPIOS_PER_GROUP) {
+        cmd_source =3D extract32(regs->cmd_source_0, i, 1)
+                | (extract32(regs->cmd_source_1, i, 1) << 1);
+
+        if (source =3D=3D cmd_source) {
+            new_value |=3D (0xff << i) & value;
+        } else {
+            new_value |=3D (0xff << i) & old_value;
+        }
+    }
+    return new_value;
+}
+
+static const AspeedGPIOReg aspeed_3_6v_gpios[GPIO_3_6V_REG_ARRAY_SIZE] =3D=
 {
+    /* Set ABCD */
+    [GPIO_ABCD_DATA_VALUE] =3D     { 0, gpio_reg_data_value },
+    [GPIO_ABCD_DIRECTION] =3D      { 0, gpio_reg_direction },
+    [GPIO_ABCD_INT_ENABLE] =3D     { 0, gpio_reg_int_enable },
+    [GPIO_ABCD_INT_SENS_0] =3D     { 0, gpio_reg_int_sens_0 },
+    [GPIO_ABCD_INT_SENS_1] =3D     { 0, gpio_reg_int_sens_1 },
+    [GPIO_ABCD_INT_SENS_2] =3D     { 0, gpio_reg_int_sens_2 },
+    [GPIO_ABCD_INT_STATUS] =3D     { 0, gpio_reg_int_status },
+    [GPIO_ABCD_RESET_TOLERANT] =3D { 0, gpio_reg_reset_tolerant },
+    [GPIO_ABCD_DEBOUNCE_1] =3D     { 0, gpio_reg_debounce_1 },
+    [GPIO_ABCD_DEBOUNCE_2] =3D     { 0, gpio_reg_debounce_2 },
+    [GPIO_ABCD_COMMAND_SRC_0] =3D  { 0, gpio_reg_cmd_source_0 },
+    [GPIO_ABCD_COMMAND_SRC_1] =3D  { 0, gpio_reg_cmd_source_1 },
+    [GPIO_ABCD_DATA_READ] =3D      { 0, gpio_reg_data_read },
+    [GPIO_ABCD_INPUT_MASK] =3D     { 0, gpio_reg_input_mask },
+    /* Set EFGH */
+    [GPIO_EFGH_DATA_VALUE] =3D     { 1, gpio_reg_data_value },
+    [GPIO_EFGH_DIRECTION] =3D      { 1, gpio_reg_direction },
+    [GPIO_EFGH_INT_ENABLE] =3D     { 1, gpio_reg_int_enable },
+    [GPIO_EFGH_INT_SENS_0] =3D     { 1, gpio_reg_int_sens_0 },
+    [GPIO_EFGH_INT_SENS_1] =3D     { 1, gpio_reg_int_sens_1 },
+    [GPIO_EFGH_INT_SENS_2] =3D     { 1, gpio_reg_int_sens_2 },
+    [GPIO_EFGH_INT_STATUS] =3D     { 1, gpio_reg_int_status },
+    [GPIO_EFGH_RESET_TOLERANT] =3D { 1, gpio_reg_reset_tolerant },
+    [GPIO_EFGH_DEBOUNCE_1] =3D     { 1, gpio_reg_debounce_1 },
+    [GPIO_EFGH_DEBOUNCE_2] =3D     { 1, gpio_reg_debounce_2 },
+    [GPIO_EFGH_COMMAND_SRC_0] =3D  { 1, gpio_reg_cmd_source_0 },
+    [GPIO_EFGH_COMMAND_SRC_1] =3D  { 1, gpio_reg_cmd_source_1 },
+    [GPIO_EFGH_DATA_READ] =3D      { 1, gpio_reg_data_read },
+    [GPIO_EFGH_INPUT_MASK] =3D     { 1, gpio_reg_input_mask },
+    /* Set IJKL */
+    [GPIO_IJKL_DATA_VALUE] =3D     { 2, gpio_reg_data_value },
+    [GPIO_IJKL_DIRECTION] =3D      { 2, gpio_reg_direction },
+    [GPIO_IJKL_INT_ENABLE] =3D     { 2, gpio_reg_int_enable },
+    [GPIO_IJKL_INT_SENS_0] =3D     { 2, gpio_reg_int_sens_0 },
+    [GPIO_IJKL_INT_SENS_1] =3D     { 2, gpio_reg_int_sens_1 },
+    [GPIO_IJKL_INT_SENS_2] =3D     { 2, gpio_reg_int_sens_2 },
+    [GPIO_IJKL_INT_STATUS] =3D     { 2, gpio_reg_int_status },
+    [GPIO_IJKL_RESET_TOLERANT] =3D { 2, gpio_reg_reset_tolerant },
+    [GPIO_IJKL_DEBOUNCE_1] =3D     { 2, gpio_reg_debounce_1 },
+    [GPIO_IJKL_DEBOUNCE_2] =3D     { 2, gpio_reg_debounce_2 },
+    [GPIO_IJKL_COMMAND_SRC_0] =3D  { 2, gpio_reg_cmd_source_0 },
+    [GPIO_IJKL_COMMAND_SRC_1] =3D  { 2, gpio_reg_cmd_source_1 },
+    [GPIO_IJKL_DATA_READ] =3D      { 2, gpio_reg_data_read },
+    [GPIO_IJKL_INPUT_MASK] =3D     { 2, gpio_reg_input_mask },
+    /* Set MNOP */
+    [GPIO_MNOP_DATA_VALUE] =3D     { 3, gpio_reg_data_value },
+    [GPIO_MNOP_DIRECTION] =3D      { 3, gpio_reg_direction },
+    [GPIO_MNOP_INT_ENABLE] =3D     { 3, gpio_reg_int_enable },
+    [GPIO_MNOP_INT_SENS_0] =3D     { 3, gpio_reg_int_sens_0 },
+    [GPIO_MNOP_INT_SENS_1] =3D     { 3, gpio_reg_int_sens_1 },
+    [GPIO_MNOP_INT_SENS_2] =3D     { 3, gpio_reg_int_sens_2 },
+    [GPIO_MNOP_INT_STATUS] =3D     { 3, gpio_reg_int_status },
+    [GPIO_MNOP_RESET_TOLERANT] =3D { 3, gpio_reg_reset_tolerant },
+    [GPIO_MNOP_DEBOUNCE_1] =3D     { 3, gpio_reg_debounce_1 },
+    [GPIO_MNOP_DEBOUNCE_2] =3D     { 3, gpio_reg_debounce_2 },
+    [GPIO_MNOP_COMMAND_SRC_0] =3D  { 3, gpio_reg_cmd_source_0 },
+    [GPIO_MNOP_COMMAND_SRC_1] =3D  { 3, gpio_reg_cmd_source_1 },
+    [GPIO_MNOP_DATA_READ] =3D      { 3, gpio_reg_data_read },
+    [GPIO_MNOP_INPUT_MASK] =3D     { 3, gpio_reg_input_mask },
+    /* Set QRST */
+    [GPIO_QRST_DATA_VALUE] =3D     { 4, gpio_reg_data_value },
+    [GPIO_QRST_DIRECTION] =3D      { 4, gpio_reg_direction },
+    [GPIO_QRST_INT_ENABLE] =3D     { 4, gpio_reg_int_enable },
+    [GPIO_QRST_INT_SENS_0] =3D     { 4, gpio_reg_int_sens_0 },
+    [GPIO_QRST_INT_SENS_1] =3D     { 4, gpio_reg_int_sens_1 },
+    [GPIO_QRST_INT_SENS_2] =3D     { 4, gpio_reg_int_sens_2 },
+    [GPIO_QRST_INT_STATUS] =3D     { 4, gpio_reg_int_status },
+    [GPIO_QRST_RESET_TOLERANT] =3D { 4, gpio_reg_reset_tolerant },
+    [GPIO_QRST_DEBOUNCE_1] =3D     { 4, gpio_reg_debounce_1 },
+    [GPIO_QRST_DEBOUNCE_2] =3D     { 4, gpio_reg_debounce_2 },
+    [GPIO_QRST_COMMAND_SRC_0] =3D  { 4, gpio_reg_cmd_source_0 },
+    [GPIO_QRST_COMMAND_SRC_1] =3D  { 4, gpio_reg_cmd_source_1 },
+    [GPIO_QRST_DATA_READ] =3D      { 4, gpio_reg_data_read },
+    [GPIO_QRST_INPUT_MASK] =3D     { 4, gpio_reg_input_mask },
+    /* Set UVWX */
+    [GPIO_UVWX_DATA_VALUE] =3D     { 5, gpio_reg_data_value },
+    [GPIO_UVWX_DIRECTION] =3D      { 5, gpio_reg_direction },
+    [GPIO_UVWX_INT_ENABLE] =3D     { 5, gpio_reg_int_enable },
+    [GPIO_UVWX_INT_SENS_0] =3D     { 5, gpio_reg_int_sens_0 },
+    [GPIO_UVWX_INT_SENS_1] =3D     { 5, gpio_reg_int_sens_1 },
+    [GPIO_UVWX_INT_SENS_2] =3D     { 5, gpio_reg_int_sens_2 },
+    [GPIO_UVWX_INT_STATUS] =3D     { 5, gpio_reg_int_status },
+    [GPIO_UVWX_RESET_TOLERANT] =3D { 5, gpio_reg_reset_tolerant },
+    [GPIO_UVWX_DEBOUNCE_1] =3D     { 5, gpio_reg_debounce_1 },
+    [GPIO_UVWX_DEBOUNCE_2] =3D     { 5, gpio_reg_debounce_2 },
+    [GPIO_UVWX_COMMAND_SRC_0] =3D  { 5, gpio_reg_cmd_source_0 },
+    [GPIO_UVWX_COMMAND_SRC_1] =3D  { 5, gpio_reg_cmd_source_1 },
+    [GPIO_UVWX_DATA_READ] =3D      { 5, gpio_reg_data_read },
+    [GPIO_UVWX_INPUT_MASK] =3D     { 5, gpio_reg_input_mask },
+    /* Set YZAAAB */
+    [GPIO_YZAAAB_DATA_VALUE] =3D     { 6, gpio_reg_data_value },
+    [GPIO_YZAAAB_DIRECTION] =3D      { 6, gpio_reg_direction },
+    [GPIO_YZAAAB_INT_ENABLE] =3D     { 6, gpio_reg_int_enable },
+    [GPIO_YZAAAB_INT_SENS_0] =3D     { 6, gpio_reg_int_sens_0 },
+    [GPIO_YZAAAB_INT_SENS_1] =3D     { 6, gpio_reg_int_sens_1 },
+    [GPIO_YZAAAB_INT_SENS_2] =3D     { 6, gpio_reg_int_sens_2 },
+    [GPIO_YZAAAB_INT_STATUS] =3D     { 6, gpio_reg_int_status },
+    [GPIO_YZAAAB_RESET_TOLERANT] =3D { 6, gpio_reg_reset_tolerant },
+    [GPIO_YZAAAB_DEBOUNCE_1] =3D     { 6, gpio_reg_debounce_1 },
+    [GPIO_YZAAAB_DEBOUNCE_2] =3D     { 6, gpio_reg_debounce_2 },
+    [GPIO_YZAAAB_COMMAND_SRC_0] =3D  { 6, gpio_reg_cmd_source_0 },
+    [GPIO_YZAAAB_COMMAND_SRC_1] =3D  { 6, gpio_reg_cmd_source_1 },
+    [GPIO_YZAAAB_DATA_READ] =3D      { 6, gpio_reg_data_read },
+    [GPIO_YZAAAB_INPUT_MASK] =3D     { 6, gpio_reg_input_mask },
+    /* Set AC  (ast2500 only) */
+    [GPIO_AC_DATA_VALUE] =3D         { 7, gpio_reg_data_value },
+    [GPIO_AC_DIRECTION] =3D          { 7, gpio_reg_direction },
+    [GPIO_AC_INT_ENABLE] =3D         { 7, gpio_reg_int_enable },
+    [GPIO_AC_INT_SENS_0] =3D         { 7, gpio_reg_int_sens_0 },
+    [GPIO_AC_INT_SENS_1] =3D         { 7, gpio_reg_int_sens_1 },
+    [GPIO_AC_INT_SENS_2] =3D         { 7, gpio_reg_int_sens_2 },
+    [GPIO_AC_INT_STATUS] =3D         { 7, gpio_reg_int_status },
+    [GPIO_AC_RESET_TOLERANT] =3D     { 7, gpio_reg_reset_tolerant },
+    [GPIO_AC_DEBOUNCE_1] =3D         { 7, gpio_reg_debounce_1 },
+    [GPIO_AC_DEBOUNCE_2] =3D         { 7, gpio_reg_debounce_2 },
+    [GPIO_AC_COMMAND_SRC_0] =3D      { 7, gpio_reg_cmd_source_0 },
+    [GPIO_AC_COMMAND_SRC_1] =3D      { 7, gpio_reg_cmd_source_1 },
+    [GPIO_AC_DATA_READ] =3D          { 7, gpio_reg_data_read },
+    [GPIO_AC_INPUT_MASK] =3D         { 7, gpio_reg_input_mask },
+};
+
+static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset, uint32_t s=
ize)
+{
+    AspeedGPIOState *s =3D ASPEED_GPIO(opaque);
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
+    uint64_t idx =3D -1;
+    const AspeedGPIOReg *reg;
+    GPIOSets *set;
+
+    idx =3D offset >> 2;
+    if (idx >=3D GPIO_DEBOUNCE_TIME_1 && idx <=3D GPIO_DEBOUNCE_TIME_3) =
{
+        idx -=3D GPIO_DEBOUNCE_TIME_1;
+        return (uint64_t) s->debounce_regs[idx];
+    }
+
+    reg =3D &agc->reg_table[idx];
+    if (reg->set_idx >=3D agc->nr_gpio_sets) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
+                      HWADDR_PRIx"\n", __func__, offset);
+        return 0;
+    }
+
+    set =3D &s->sets[reg->set_idx];
+    switch (reg->type) {
+    case gpio_reg_data_value:
+        return set->data_value;
+    case gpio_reg_direction:
+        return set->direction;
+    case gpio_reg_int_enable:
+        return set->int_enable;
+    case gpio_reg_int_sens_0:
+        return set->int_sens_0;
+    case gpio_reg_int_sens_1:
+        return set->int_sens_1;
+    case gpio_reg_int_sens_2:
+        return set->int_sens_2;
+    case gpio_reg_int_status:
+        return set->int_status;
+    case gpio_reg_reset_tolerant:
+        return set->reset_tol;
+    case gpio_reg_debounce_1:
+        return set->debounce_1;
+    case gpio_reg_debounce_2:
+        return set->debounce_2;
+    case gpio_reg_cmd_source_0:
+        return set->cmd_source_0;
+    case gpio_reg_cmd_source_1:
+        return set->cmd_source_1;
+    case gpio_reg_data_read:
+        return set->data_read;
+    case gpio_reg_input_mask:
+        return set->input_mask;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
+                      HWADDR_PRIx"\n", __func__, offset);
+        return 0;
+    };
+}
+
+static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data=
,
+                              uint32_t size)
+{
+    AspeedGPIOState *s =3D ASPEED_GPIO(opaque);
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
+    const GPIOSetProperties *props;
+    uint64_t idx =3D -1;
+    const AspeedGPIOReg *reg;
+    GPIOSets *set;
+    uint32_t cleared;
+
+    idx =3D offset >> 2;
+    if (idx >=3D GPIO_DEBOUNCE_TIME_1 && idx <=3D GPIO_DEBOUNCE_TIME_3) =
{
+        idx -=3D GPIO_DEBOUNCE_TIME_1;
+        s->debounce_regs[idx] =3D (uint32_t) data;
+        return;
+    }
+
+    reg =3D &agc->reg_table[idx];
+    if (reg->set_idx >=3D agc->nr_gpio_sets) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
+                      HWADDR_PRIx"\n", __func__, offset);
+        return;
+    }
+
+    set =3D &s->sets[reg->set_idx];
+    props =3D &agc->props[reg->set_idx];
+
+    switch (reg->type) {
+    case gpio_reg_data_value:
+        data &=3D props->output;
+        data =3D update_value_control_source(set, set->data_value, data)=
;
+        set->data_read =3D data;
+        aspeed_gpio_update(s, set, data);
+        return;
+    case gpio_reg_direction:
+        /*
+         *   where data is the value attempted to be written to the pin:
+         *    pin type      | input mask | output mask | expected value
+         *    ----------------------------------------------------------=
--
+         *   bidirectional  |   1       |   1        |  data
+         *   input only     |   1       |   0        |   0
+         *   output only    |   0       |   1        |   1
+         *   no pin / gap   |   0       |   0        |   0
+         *
+         *  which is captured by:
+         *  data =3D ( data | ~input) & output;
+         */
+        data =3D (data | ~props->input) & props->output;
+        set->direction =3D update_value_control_source(set, set->directi=
on, data);
+        break;
+    case gpio_reg_int_enable:
+        set->int_enable =3D update_value_control_source(set, set->int_en=
able,
+                                                      data);
+        break;
+    case gpio_reg_int_sens_0:
+        set->int_sens_0 =3D update_value_control_source(set, set->int_se=
ns_0,
+                                                      data);
+        break;
+    case gpio_reg_int_sens_1:
+        set->int_sens_1 =3D update_value_control_source(set, set->int_se=
ns_1,
+                                                      data);
+        break;
+    case gpio_reg_int_sens_2:
+        set->int_sens_2 =3D update_value_control_source(set, set->int_se=
ns_2,
+                                                      data);
+        break;
+    case gpio_reg_int_status:
+        cleared =3D ctpop32(data & set->int_status);
+        if (s->pending && cleared) {
+            assert(s->pending >=3D cleared);
+            s->pending -=3D cleared;
+        }
+        set->int_status &=3D ~data;
+        break;
+    case gpio_reg_reset_tolerant:
+        set->reset_tol =3D update_value_control_source(set, set->reset_t=
ol,
+                                                     data);
+        return;
+    case gpio_reg_debounce_1:
+        set->debounce_1 =3D update_value_control_source(set, set->deboun=
ce_1,
+                                                      data);
+        return;
+    case gpio_reg_debounce_2:
+        set->debounce_2 =3D update_value_control_source(set, set->deboun=
ce_2,
+                                                      data);
+        return;
+    case gpio_reg_cmd_source_0:
+        set->cmd_source_0 =3D data & ASPEED_CMD_SRC_MASK;
+        return;
+    case gpio_reg_cmd_source_1:
+        set->cmd_source_1 =3D data & ASPEED_CMD_SRC_MASK;
+        return;
+    case gpio_reg_data_read:
+        /* Read only register */
+        return;
+    case gpio_reg_input_mask:
+        /*
+         * feeds into interrupt generation
+         * 0: read from data value reg will be updated
+         * 1: read from data value reg will not be updated
+         */
+         set->input_mask =3D data & props->input;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
+                      HWADDR_PRIx"\n", __func__, offset);
+        return;
+    }
+    aspeed_gpio_update(s, set, set->data_value);
+    return;
+}
+
+static int get_set_idx(AspeedGPIOState *s, const char *group, int *group=
_idx)
+{
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
+    int set_idx, g_idx =3D *group_idx;
+
+    for (set_idx =3D 0; set_idx < agc->nr_gpio_sets; set_idx++) {
+        const GPIOSetProperties *set_props =3D &agc->props[set_idx];
+        for (g_idx =3D 0; g_idx < ASPEED_GROUPS_PER_SET; g_idx++) {
+            if (!strncmp(group, set_props->group_label[g_idx], strlen(gr=
oup))) {
+                *group_idx =3D g_idx;
+                return set_idx;
+            }
+        }
+    }
+    return -1;
+}
+
+static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *nam=
e,
+                                void *opaque, Error **errp)
+{
+    int pin =3D 0xfff;
+    bool level =3D true;
+    char group[3];
+    AspeedGPIOState *s =3D ASPEED_GPIO(obj);
+    int set_idx, group_idx =3D 0;
+
+    if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) !=3D 2) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    set_idx =3D get_set_idx(s, group, &group_idx);
+    if (set_idx =3D=3D -1) {
+        error_setg(errp, "%s: invalid group %s", __func__, group);
+        return;
+    }
+    pin =3D  pin + group_idx * GPIOS_PER_GROUP;
+    level =3D aspeed_gpio_get_pin_level(s, set_idx, pin);
+    visit_type_bool(v, name, &level, errp);
+}
+
+static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *nam=
e,
+                               void *opaque, Error **errp)
+{
+    Error *local_err =3D NULL;
+    bool level;
+    int pin =3D 0xfff;
+    char group[3];
+    AspeedGPIOState *s =3D ASPEED_GPIO(obj);
+    int set_idx, group_idx =3D 0;
+
+    visit_type_bool(v, name, &level, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) !=3D 2) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    set_idx =3D get_set_idx(s, group, &group_idx);
+    if (set_idx =3D=3D -1) {
+        error_setg(errp, "%s: invalid group %s", __func__, group);
+        return;
+    }
+    pin =3D  pin + group_idx * GPIOS_PER_GROUP;
+    aspeed_gpio_set_pin_level(s, set_idx, pin, level);
+}
+
+/****************** Setup functions ******************/
+static const GPIOSetProperties ast2400_set_props[] =3D {
+    [0] =3D {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
+    [1] =3D {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
+    [2] =3D {0xffffffff,  0xffffffff,  {"I", "J", "K", "L"} },
+    [3] =3D {0xffffffff,  0xffffffff,  {"M", "N", "O", "P"} },
+    [4] =3D {0xffffffff,  0xffffffff,  {"Q", "R", "S", "T"} },
+    [5] =3D {0xffffffff,  0x0000ffff,  {"U", "V", "W", "X"} },
+    [6] =3D {0x0000000f,  0x0fffff0f,  {"Y", "Z", "AA", "AB"} },
+};
+
+static const GPIOSetProperties ast2500_set_props[] =3D {
+    [0] =3D {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
+    [1] =3D {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
+    [2] =3D {0xffffffff,  0xffffffff,  {"I", "J", "K", "L"} },
+    [3] =3D {0xffffffff,  0xffffffff,  {"M", "N", "O", "P"} },
+    [4] =3D {0xffffffff,  0xffffffff,  {"Q", "R", "S", "T"} },
+    [5] =3D {0xffffffff,  0x0000ffff,  {"U", "V", "W", "X"} },
+    [6] =3D {0xffffff0f,  0x0fffff0f,  {"Y", "Z", "AA", "AB"} },
+    [7] =3D {0x000000ff,  0x000000ff,  {"AC"} },
+};
+
+static const MemoryRegionOps aspeed_gpio_ops =3D {
+    .read       =3D aspeed_gpio_read,
+    .write      =3D aspeed_gpio_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+};
+
+static void aspeed_gpio_reset(DeviceState *dev)
+{
+    AspeedGPIOState *s =3D ASPEED_GPIO(dev);
+
+    /* TODO: respect the reset tolerance registers */
+    memset(s->sets, 0, sizeof(s->sets));
+}
+
+static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
+{
+    AspeedGPIOState *s =3D ASPEED_GPIO(dev);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
+    int pin;
+
+    /* Interrupt parent line */
+    sysbus_init_irq(sbd, &s->irq);
+
+    /* Individual GPIOs */
+    for (pin =3D 0; pin < agc->nr_gpio_pins; pin++) {
+        sysbus_init_irq(sbd, &s->gpios[pin]);
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_gpio_ops, s,
+            TYPE_ASPEED_GPIO, GPIO_3_6V_MEM_SIZE);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_gpio_init(Object *obj)
+{
+    AspeedGPIOState *s =3D ASPEED_GPIO(obj);
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
+    int pin;
+
+    for (pin =3D 0; pin < agc->nr_gpio_pins; pin++) {
+        char *name;
+        int set_idx =3D pin / GPIOS_PER_SET;
+        int pin_idx =3D aspeed_adjust_pin(s, pin) - (set_idx * GPIOS_PER=
_SET);
+        int group_idx =3D pin_idx >> GPIO_GROUP_SHIFT;
+        const GPIOSetProperties *props =3D &agc->props[set_idx];
+
+        name =3D g_strdup_printf("gpio%s%d", props->group_label[group_id=
x],
+                               pin_idx % GPIOS_PER_GROUP);
+        object_property_add(obj, name, "bool", aspeed_gpio_get_pin,
+                            aspeed_gpio_set_pin, NULL, NULL, NULL);
+    }
+}
+
+static const VMStateDescription vmstate_gpio_regs =3D {
+    .name =3D TYPE_ASPEED_GPIO"/regs",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(data_value,   GPIOSets),
+        VMSTATE_UINT32(data_read,    GPIOSets),
+        VMSTATE_UINT32(direction,    GPIOSets),
+        VMSTATE_UINT32(int_enable,   GPIOSets),
+        VMSTATE_UINT32(int_sens_0,   GPIOSets),
+        VMSTATE_UINT32(int_sens_1,   GPIOSets),
+        VMSTATE_UINT32(int_sens_2,   GPIOSets),
+        VMSTATE_UINT32(int_status,   GPIOSets),
+        VMSTATE_UINT32(reset_tol,    GPIOSets),
+        VMSTATE_UINT32(cmd_source_0, GPIOSets),
+        VMSTATE_UINT32(cmd_source_1, GPIOSets),
+        VMSTATE_UINT32(debounce_1,   GPIOSets),
+        VMSTATE_UINT32(debounce_2,   GPIOSets),
+        VMSTATE_UINT32(input_mask,   GPIOSets),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static const VMStateDescription vmstate_aspeed_gpio =3D {
+    .name =3D TYPE_ASPEED_GPIO,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(sets, AspeedGPIOState, ASPEED_GPIO_MAX_NR_S=
ETS,
+                             1, vmstate_gpio_regs, GPIOSets),
+        VMSTATE_UINT32_ARRAY(debounce_regs, AspeedGPIOState,
+                             ASPEED_GPIO_NR_DEBOUNCE_REGS),
+        VMSTATE_END_OF_LIST(),
+   }
+};
+
+static void aspeed_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D aspeed_gpio_realize;
+    dc->reset =3D aspeed_gpio_reset;
+    dc->desc =3D "Aspeed GPIO Controller";
+    dc->vmsd =3D &vmstate_aspeed_gpio;
+}
+
+static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *dat=
a)
+{
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_CLASS(klass);
+
+    agc->props =3D ast2400_set_props;
+    agc->nr_gpio_pins =3D 216;
+    agc->nr_gpio_sets =3D 7;
+    agc->gap =3D 196;
+    agc->reg_table =3D aspeed_3_6v_gpios;
+}
+
+static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
+{
+    AspeedGPIOClass *agc =3D ASPEED_GPIO_CLASS(klass);
+
+    agc->props =3D ast2500_set_props;
+    agc->nr_gpio_pins =3D 228;
+    agc->nr_gpio_sets =3D 8;
+    agc->gap =3D 220;
+    agc->reg_table =3D aspeed_3_6v_gpios;
+}
+
+static const TypeInfo aspeed_gpio_info =3D {
+    .name           =3D TYPE_ASPEED_GPIO,
+    .parent         =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size  =3D sizeof(AspeedGPIOState),
+    .class_size     =3D sizeof(AspeedGPIOClass),
+    .class_init     =3D aspeed_gpio_class_init,
+    .abstract       =3D true,
+};
+
+static const TypeInfo aspeed_gpio_ast2400_info =3D {
+    .name           =3D TYPE_ASPEED_GPIO "-ast2400",
+    .parent         =3D TYPE_ASPEED_GPIO,
+    .class_init     =3D aspeed_gpio_ast2400_class_init,
+    .instance_init  =3D aspeed_gpio_init,
+};
+
+static const TypeInfo aspeed_gpio_ast2500_info =3D {
+    .name           =3D TYPE_ASPEED_GPIO "-ast2500",
+    .parent         =3D TYPE_ASPEED_GPIO,
+    .class_init     =3D aspeed_gpio_2500_class_init,
+    .instance_init  =3D aspeed_gpio_init,
+};
+
+static void aspeed_gpio_register_types(void)
+{
+    type_register_static(&aspeed_gpio_info);
+    type_register_static(&aspeed_gpio_ast2400_info);
+    type_register_static(&aspeed_gpio_ast2500_info);
+}
+
+type_init(aspeed_gpio_register_types);
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
index e5da0cb54feb..d305b3b24b10 100644
--- a/hw/gpio/Makefile.objs
+++ b/hw/gpio/Makefile.objs
@@ -9,3 +9,4 @@ obj-$(CONFIG_OMAP) +=3D omap_gpio.o
 obj-$(CONFIG_IMX) +=3D imx_gpio.o
 obj-$(CONFIG_RASPI) +=3D bcm2835_gpio.o
 obj-$(CONFIG_NRF51_SOC) +=3D nrf51_gpio.o
+obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_gpio.o
--=20
2.21.0


