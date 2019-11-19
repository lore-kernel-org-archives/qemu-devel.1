Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01814C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B966C2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B966C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4Gn-00075s-B6
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4F7-00059H-Db
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4F5-00052R-77
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:33 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:36584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4F4-00050p-U9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:31 -0500
Received: from player795.ha.ovh.net (unknown [10.109.146.5])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id EE70D1B0076
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:12:28 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 8B653C18A732;
 Tue, 19 Nov 2019 14:12:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 01/17] aspeed/i2c: Add support for pool buffer transfers
Date: Tue, 19 Nov 2019 15:11:55 +0100
Message-Id: <20191119141211.25716-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17891675422178380561
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.75
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
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Aspeed I2C controller can operate in different transfer modes :

  - Byte Buffer mode, using a dedicated register to transfer a
    byte. This is what the model supports today.

  - Pool Buffer mode, using an internal SRAM to transfer multiple
    bytes in the same command sequence.

Each SoC has different SRAM characteristics. On the AST2400, 2048
bytes of SRAM are available at offset 0x800 of the controller AHB
window. The pool buffer can be configured from 1 to 256 bytes per bus.

On the AST2500, the SRAM is at offset 0x200 and the pool buffer is of
16 bytes per bus.

On the AST2600, the SRAM is at offset 0xC00 and the pool buffer is of
32 bytes per bus. It can be splitted in two for TX and RX but the
current model does not add support for it as it it unused by known
drivers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/i2c/aspeed_i2c.h |   8 ++
 hw/i2c/aspeed_i2c.c         | 197 ++++++++++++++++++++++++++++++++----
 2 files changed, 186 insertions(+), 19 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 13e01059189f..5313d07aa72f 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -32,6 +32,7 @@
     OBJECT_CHECK(AspeedI2CState, (obj), TYPE_ASPEED_I2C)
=20
 #define ASPEED_I2C_NR_BUSSES 16
+#define ASPEED_I2C_MAX_POOL_SIZE 0x800
=20
 struct AspeedI2CState;
=20
@@ -50,6 +51,7 @@ typedef struct AspeedI2CBus {
     uint32_t intr_status;
     uint32_t cmd;
     uint32_t buf;
+    uint32_t pool_ctrl;
 } AspeedI2CBus;
=20
 typedef struct AspeedI2CState {
@@ -59,6 +61,8 @@ typedef struct AspeedI2CState {
     qemu_irq irq;
=20
     uint32_t intr_status;
+    MemoryRegion pool_iomem;
+    uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
=20
     AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
 } AspeedI2CState;
@@ -75,6 +79,10 @@ typedef struct AspeedI2CClass {
     uint8_t reg_size;
     uint8_t gap;
     qemu_irq (*bus_get_irq)(AspeedI2CBus *);
+
+    uint64_t pool_size;
+    hwaddr pool_base;
+    uint8_t *(*bus_pool_base)(AspeedI2CBus *);
 } AspeedI2CClass;
=20
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 06c119f385b8..e21f45d96868 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -35,8 +35,7 @@
 /* I2C Device (Bus) Register */
=20
 #define I2CD_FUN_CTRL_REG       0x00       /* I2CD Function Control  */
-#define   I2CD_BUFF_SEL_MASK               (0x7 << 20)
-#define   I2CD_BUFF_SEL(x)                 (x << 20)
+#define   I2CD_POOL_PAGE_SEL(x)            (((x) >> 20) & 0x7)  /* AST24=
00 */
 #define   I2CD_M_SDA_LOCK_EN               (0x1 << 16)
 #define   I2CD_MULTI_MASTER_DIS            (0x1 << 15)
 #define   I2CD_M_SCL_DRIVE_EN              (0x1 << 14)
@@ -113,10 +112,12 @@
 #define   I2CD_SCL_O_OUT_DIR               (0x1 << 12)
 #define   I2CD_BUS_RECOVER_CMD_EN          (0x1 << 11)
 #define   I2CD_S_ALT_EN                    (0x1 << 10)
-#define   I2CD_RX_DMA_ENABLE               (0x1 << 9)
-#define   I2CD_TX_DMA_ENABLE               (0x1 << 8)
=20
 /* Command Bit */
+#define   I2CD_RX_DMA_ENABLE               (0x1 << 9)
+#define   I2CD_TX_DMA_ENABLE               (0x1 << 8)
+#define   I2CD_RX_BUFF_ENABLE              (0x1 << 7)
+#define   I2CD_TX_BUFF_ENABLE              (0x1 << 6)
 #define   I2CD_M_STOP_CMD                  (0x1 << 5)
 #define   I2CD_M_S_RX_CMD_LAST             (0x1 << 4)
 #define   I2CD_M_RX_CMD                    (0x1 << 3)
@@ -125,7 +126,11 @@
 #define   I2CD_M_START_CMD                 (0x1)
=20
 #define I2CD_DEV_ADDR_REG       0x18       /* Slave Device Address */
-#define I2CD_BUF_CTRL_REG       0x1c       /* Pool Buffer Control */
+#define I2CD_POOL_CTRL_REG      0x1c       /* Pool Buffer Control */
+#define   I2CD_POOL_RX_COUNT(x)            (((x) >> 24) & 0xff)
+#define   I2CD_POOL_RX_SIZE(x)             ((((x) >> 16) & 0xff) + 1)
+#define   I2CD_POOL_TX_COUNT(x)            ((((x) >> 8) & 0xff) + 1)
+#define   I2CD_POOL_OFFSET(x)              (((x) & 0x3f) << 2)  /* AST24=
00 */
 #define I2CD_BYTE_BUF_REG       0x20       /* Transmit/Receive Byte Buff=
er */
 #define   I2CD_BYTE_BUF_TX_SHIFT           0
 #define   I2CD_BYTE_BUF_TX_MASK            0xff
@@ -170,6 +175,8 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwa=
ddr offset,
         return bus->intr_ctrl;
     case I2CD_INTR_STS_REG:
         return bus->intr_status;
+    case I2CD_POOL_CTRL_REG:
+        return bus->pool_ctrl;
     case I2CD_BYTE_BUF_REG:
         return bus->buf;
     case I2CD_CMD_REG:
@@ -192,14 +199,58 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *b=
us)
     return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
 }
=20
-static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
+static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
+{
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
+    int ret =3D -1;
+    int i;
+
+    if (bus->cmd & I2CD_TX_BUFF_ENABLE) {
+        for (i =3D pool_start; i < I2CD_POOL_TX_COUNT(bus->pool_ctrl); i=
++) {
+            uint8_t *pool_base =3D aic->bus_pool_base(bus);
+
+            ret =3D i2c_send(bus->bus, pool_base[i]);
+            if (ret) {
+                break;
+            }
+        }
+        bus->cmd &=3D ~I2CD_TX_BUFF_ENABLE;
+    } else {
+        ret =3D i2c_send(bus->bus, bus->buf);
+    }
+
+    return ret;
+}
+
+static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
 {
-    uint8_t ret;
+    AspeedI2CState *s =3D bus->controller;
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s);
+    uint8_t data;
+    int i;
+
+    if (bus->cmd & I2CD_RX_BUFF_ENABLE) {
+        uint8_t *pool_base =3D aic->bus_pool_base(bus);
=20
+        for (i =3D 0; i < I2CD_POOL_RX_SIZE(bus->pool_ctrl); i++) {
+            pool_base[i] =3D i2c_recv(bus->bus);
+        }
+
+        /* Update RX count */
+        bus->pool_ctrl &=3D ~(0xff << 24);
+        bus->pool_ctrl |=3D (i & 0xff) << 24;
+        bus->cmd &=3D ~I2CD_RX_BUFF_ENABLE;
+    } else {
+        data =3D i2c_recv(bus->bus);
+        bus->buf =3D (data & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_=
SHIFT;
+    }
+}
+
+static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
+{
     aspeed_i2c_set_state(bus, I2CD_MRXD);
-    ret =3D i2c_recv(bus->bus);
+    aspeed_i2c_bus_recv(bus);
     bus->intr_status |=3D I2CD_INTR_RX_DONE;
-    bus->buf =3D (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT=
;
     if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
         i2c_nack(bus->bus);
     }
@@ -207,31 +258,66 @@ static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *=
bus)
     aspeed_i2c_set_state(bus, I2CD_MACTIVE);
 }
=20
+static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)
+{
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
+
+    if (bus->cmd & I2CD_TX_BUFF_ENABLE) {
+        uint8_t *pool_base =3D aic->bus_pool_base(bus);
+
+        return pool_base[0];
+    } else {
+        return bus->buf;
+    }
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
  */
 static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 {
+    uint8_t pool_start =3D 0;
+
     bus->cmd &=3D ~0xFFFF;
     bus->cmd |=3D value & 0xFFFF;
=20
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state =3D aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
+        uint8_t addr;
=20
         aspeed_i2c_set_state(bus, state);
=20
-        if (i2c_start_transfer(bus->bus, extract32(bus->buf, 1, 7),
-                               extract32(bus->buf, 0, 1))) {
+        addr =3D aspeed_i2c_get_addr(bus);
+
+        if (i2c_start_transfer(bus->bus, extract32(addr, 1, 7),
+                               extract32(addr, 0, 1))) {
             bus->intr_status |=3D I2CD_INTR_TX_NAK;
         } else {
             bus->intr_status |=3D I2CD_INTR_TX_ACK;
         }
=20
-        /* START command is also a TX command, as the slave address is
-         * sent on the bus */
-        bus->cmd &=3D ~(I2CD_M_START_CMD | I2CD_M_TX_CMD);
+        bus->cmd &=3D ~I2CD_M_START_CMD;
+
+        /*
+         * The START command is also a TX command, as the slave
+         * address is sent on the bus. Drop the TX flag if nothing
+         * else needs to be sent in this sequence.
+         */
+        if (bus->cmd & I2CD_TX_BUFF_ENABLE) {
+            if (I2CD_POOL_TX_COUNT(bus->pool_ctrl) =3D=3D 1) {
+                bus->cmd &=3D ~I2CD_M_TX_CMD;
+            } else {
+                /*
+                 * Increase the start index in the TX pool buffer to
+                 * skip the address byte.
+                 */
+                pool_start++;
+            }
+        } else {
+            bus->cmd &=3D ~I2CD_M_TX_CMD;
+        }
=20
         /* No slave found */
         if (!i2c_bus_busy(bus->bus)) {
@@ -242,7 +328,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *b=
us, uint64_t value)
=20
     if (bus->cmd & I2CD_M_TX_CMD) {
         aspeed_i2c_set_state(bus, I2CD_MTXD);
-        if (i2c_send(bus->bus, bus->buf)) {
+        if (aspeed_i2c_bus_send(bus, pool_start)) {
             bus->intr_status |=3D (I2CD_INTR_TX_NAK);
             i2c_end_transfer(bus->bus);
         } else {
@@ -313,6 +399,11 @@ static void aspeed_i2c_bus_write(void *opaque, hwadd=
r offset,
         qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
                       __func__);
         break;
+    case I2CD_POOL_CTRL_REG:
+        bus->pool_ctrl &=3D ~0xffffff;
+        bus->pool_ctrl |=3D (value & 0xffffff);
+        break;
+
     case I2CD_BYTE_BUF_REG:
         bus->buf =3D (value & I2CD_BYTE_BUF_TX_MASK) << I2CD_BYTE_BUF_TX=
_SHIFT;
         break;
@@ -378,10 +469,45 @@ static const MemoryRegionOps aspeed_i2c_ctrl_ops =3D=
 {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
+static uint64_t aspeed_i2c_pool_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    AspeedI2CState *s =3D opaque;
+    uint64_t ret =3D 0;
+    int i;
+
+    for (i =3D 0; i < size; i++) {
+        ret |=3D (uint64_t) s->pool[offset + i] << (8 * i);
+    }
+
+    return ret;
+}
+
+static void aspeed_i2c_pool_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+    AspeedI2CState *s =3D opaque;
+    int i;
+
+    for (i =3D 0; i < size; i++) {
+        s->pool[offset + i] =3D (value >> (8 * i)) & 0xFF;
+    }
+}
+
+static const MemoryRegionOps aspeed_i2c_pool_ops =3D {
+    .read =3D aspeed_i2c_pool_read,
+    .write =3D aspeed_i2c_pool_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+    },
+};
+
 static const VMStateDescription aspeed_i2c_bus_vmstate =3D {
     .name =3D TYPE_ASPEED_I2C,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT8(id, AspeedI2CBus),
         VMSTATE_UINT32(ctrl, AspeedI2CBus),
@@ -390,19 +516,21 @@ static const VMStateDescription aspeed_i2c_bus_vmst=
ate =3D {
         VMSTATE_UINT32(intr_status, AspeedI2CBus),
         VMSTATE_UINT32(cmd, AspeedI2CBus),
         VMSTATE_UINT32(buf, AspeedI2CBus),
+        VMSTATE_UINT32(pool_ctrl, AspeedI2CBus),
         VMSTATE_END_OF_LIST()
     }
 };
=20
 static const VMStateDescription aspeed_i2c_vmstate =3D {
     .name =3D TYPE_ASPEED_I2C,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(intr_status, AspeedI2CState),
         VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,
                              ASPEED_I2C_NR_BUSSES, 1, aspeed_i2c_bus_vms=
tate,
                              AspeedI2CBus),
+        VMSTATE_UINT8_ARRAY(pool, AspeedI2CState, ASPEED_I2C_MAX_POOL_SI=
ZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -472,6 +600,10 @@ static void aspeed_i2c_realize(DeviceState *dev, Err=
or **errp)
         memory_region_add_subregion(&s->iomem, aic->reg_size * (i + offs=
et),
                                     &s->busses[i].mr);
     }
+
+    memory_region_init_io(&s->pool_iomem, OBJECT(s), &aspeed_i2c_pool_op=
s, s,
+                          "aspeed.i2c-pool", aic->pool_size);
+    memory_region_add_subregion(&s->iomem, aic->pool_base, &s->pool_iome=
m);
 }
=20
 static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
@@ -498,6 +630,14 @@ static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2=
CBus *bus)
     return bus->controller->irq;
 }
=20
+static uint8_t *aspeed_2400_i2c_bus_pool_base(AspeedI2CBus *bus)
+{
+    uint8_t *pool_page =3D
+        &bus->controller->pool[I2CD_POOL_PAGE_SEL(bus->ctrl) * 0x100];
+
+    return &pool_page[I2CD_POOL_OFFSET(bus->pool_ctrl)];
+}
+
 static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -509,6 +649,9 @@ static void aspeed_2400_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->reg_size =3D 0x40;
     aic->gap =3D 7;
     aic->bus_get_irq =3D aspeed_2400_i2c_bus_get_irq;
+    aic->pool_size =3D 0x800;
+    aic->pool_base =3D 0x800;
+    aic->bus_pool_base =3D aspeed_2400_i2c_bus_pool_base;
 }
=20
 static const TypeInfo aspeed_2400_i2c_info =3D {
@@ -522,6 +665,11 @@ static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2=
CBus *bus)
     return bus->controller->irq;
 }
=20
+static uint8_t *aspeed_2500_i2c_bus_pool_base(AspeedI2CBus *bus)
+{
+    return &bus->controller->pool[bus->id * 0x10];
+}
+
 static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -533,6 +681,9 @@ static void aspeed_2500_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->reg_size =3D 0x40;
     aic->gap =3D 7;
     aic->bus_get_irq =3D aspeed_2500_i2c_bus_get_irq;
+    aic->pool_size =3D 0x100;
+    aic->pool_base =3D 0x200;
+    aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;
 }
=20
 static const TypeInfo aspeed_2500_i2c_info =3D {
@@ -546,6 +697,11 @@ static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2=
CBus *bus)
     return bus->irq;
 }
=20
+static uint8_t *aspeed_2600_i2c_bus_pool_base(AspeedI2CBus *bus)
+{
+   return &bus->controller->pool[bus->id * 0x20];
+}
+
 static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -557,6 +713,9 @@ static void aspeed_2600_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->reg_size =3D 0x80;
     aic->gap =3D -1; /* no gap */
     aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;
+    aic->pool_size =3D 0x200;
+    aic->pool_base =3D 0xC00;
+    aic->bus_pool_base =3D aspeed_2600_i2c_bus_pool_base;
 }
=20
 static const TypeInfo aspeed_2600_i2c_info =3D {
--=20
2.21.0


