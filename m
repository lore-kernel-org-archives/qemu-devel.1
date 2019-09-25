Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD6C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9C121D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9C121D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8sY-0005Zq-VN
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD8OH-0005VZ-CY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD8OF-0001op-LT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:37 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:55741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD8OF-0001mi-EI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:35 -0400
Received: from player786.ha.ovh.net (unknown [10.109.159.157])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id D512A1429C5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:35:33 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 0F008A4D43E6;
 Wed, 25 Sep 2019 14:35:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 22/23] aspeed: add support for the Aspeed MII controller of
 the AST2600
Date: Wed, 25 Sep 2019 16:32:47 +0200
Message-Id: <20190925143248.10000-23-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925143248.10000-1-clg@kaod.org>
References: <20190925143248.10000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8878002244656597777
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.79.46
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AST2600 SoC has an extra controller to set the PHY registers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/arm/aspeed_soc.h |   5 ++
 include/hw/net/ftgmac100.h  |  17 ++++
 hw/arm/aspeed_ast2600.c     |  20 +++++
 hw/net/ftgmac100.c          | 162 ++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 088a5d108185..43478f617879 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -52,6 +52,7 @@ typedef struct AspeedSoCState {
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
+    AspeedMiiState mii[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
     AspeedSDHCIState sdhci;
@@ -117,6 +118,10 @@ enum {
     ASPEED_ETH2,
     ASPEED_ETH3,
     ASPEED_ETH4,
+    ASPEED_MII1,
+    ASPEED_MII2,
+    ASPEED_MII3,
+    ASPEED_MII4,
     ASPEED_SDRAM,
     ASPEED_XDMA,
 };
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 94cfe0533297..ab37e7b2b8ae 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -66,4 +66,21 @@ typedef struct FTGMAC100State {
     uint32_t rxdes0_edorr;
 } FTGMAC100State;
=20
+#define TYPE_ASPEED_MII "aspeed-mmi"
+#define ASPEED_MII(obj) OBJECT_CHECK(AspeedMiiState, (obj), TYPE_ASPEED_=
MII)
+
+/*
+ * AST2600 MII controller
+ */
+typedef struct AspeedMiiState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    FTGMAC100State *nic;
+
+    MemoryRegion iomem;
+    uint32_t phycr;
+    uint32_t phydata;
+} AspeedMiiState;
+
 #endif
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 25d2c2d05d63..af047463a355 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -31,6 +31,10 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
     [ASPEED_FMC]       =3D 0x1E620000,
     [ASPEED_SPI1]      =3D 0x1E630000,
     [ASPEED_SPI2]      =3D 0x1E641000,
+    [ASPEED_MII1]      =3D 0x1E650000,
+    [ASPEED_MII2]      =3D 0x1E650008,
+    [ASPEED_MII3]      =3D 0x1E650010,
+    [ASPEED_MII4]      =3D 0x1E650018,
     [ASPEED_ETH1]      =3D 0x1E660000,
     [ASPEED_ETH3]      =3D 0x1E670000,
     [ASPEED_ETH2]      =3D 0x1E680000,
@@ -181,6 +185,12 @@ static void aspeed_soc_ast2600_init(Object *obj)
     for (i =3D 0; i < sc->macs_num; i++) {
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[=
i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
+
+        sysbus_init_child_obj(obj, "mii[*]", &s->mii[i], sizeof(s->mii[i=
]),
+                              TYPE_ASPEED_MII);
+        object_property_add_const_link(OBJECT(&s->mii[i]), "nic",
+                                       OBJECT(&s->ftgmac100[i]),
+                                       &error_abort);
     }
=20
     sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma)=
,
@@ -417,6 +427,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
                         sc->memmap[ASPEED_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
+
+        object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->mii[i]), 0,
+                        sc->memmap[ASPEED_MII1 + i]);
     }
=20
     /* XDMA */
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 04c78e85170b..eb8b441461a1 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/net/ftgmac100.h"
 #include "sysemu/dma.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/checksum.h"
@@ -1087,9 +1088,170 @@ static const TypeInfo ftgmac100_info =3D {
     .class_init =3D ftgmac100_class_init,
 };
=20
+/*
+ * AST2600 MII controller
+ */
+#define ASPEED_MII_PHYCR_FIRE        BIT(31)
+#define ASPEED_MII_PHYCR_ST_22       BIT(28)
+#define ASPEED_MII_PHYCR_OP(x)       ((x) & (ASPEED_MII_PHYCR_OP_WRITE |=
 \
+                                             ASPEED_MII_PHYCR_OP_READ))
+#define ASPEED_MII_PHYCR_OP_WRITE    BIT(26)
+#define ASPEED_MII_PHYCR_OP_READ     BIT(27)
+#define ASPEED_MII_PHYCR_DATA(x)     (x & 0xffff)
+#define ASPEED_MII_PHYCR_PHY(x)      (((x) >> 21) & 0x1f)
+#define ASPEED_MII_PHYCR_REG(x)      (((x) >> 16) & 0x1f)
+
+#define ASPEED_MII_PHYDATA_IDLE      BIT(16)
+
+static void aspeed_mii_transition(AspeedMiiState *s, bool fire)
+{
+    if (fire) {
+        s->phycr |=3D ASPEED_MII_PHYCR_FIRE;
+        s->phydata &=3D ~ASPEED_MII_PHYDATA_IDLE;
+    } else {
+        s->phycr &=3D ~ASPEED_MII_PHYCR_FIRE;
+        s->phydata |=3D ASPEED_MII_PHYDATA_IDLE;
+    }
+}
+
+static void aspeed_mii_do_phy_ctl(AspeedMiiState *s)
+{
+    uint8_t reg;
+    uint16_t data;
+
+    if (!(s->phycr & ASPEED_MII_PHYCR_ST_22)) {
+        aspeed_mii_transition(s, !ASPEED_MII_PHYCR_FIRE);
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported ST code\n", __func__);
+        return;
+    }
+
+    /* Nothing to do */
+    if (!(s->phycr & ASPEED_MII_PHYCR_FIRE)) {
+        return;
+    }
+
+    reg =3D ASPEED_MII_PHYCR_REG(s->phycr);
+    data =3D ASPEED_MII_PHYCR_DATA(s->phycr);
+
+    switch (ASPEED_MII_PHYCR_OP(s->phycr)) {
+    case ASPEED_MII_PHYCR_OP_WRITE:
+        do_phy_write(s->nic, reg, data);
+        break;
+    case ASPEED_MII_PHYCR_OP_READ:
+        s->phydata =3D (s->phydata & ~0xffff) | do_phy_read(s->nic, reg)=
;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid OP code %08x\n",
+                      __func__, s->phycr);
+    }
+
+    aspeed_mii_transition(s, !ASPEED_MII_PHYCR_FIRE);
+}
+
+static uint64_t aspeed_mii_read(void *opaque, hwaddr addr, unsigned size=
)
+{
+    AspeedMiiState *s =3D ASPEED_MII(opaque);
+
+    switch (addr) {
+    case 0x0:
+        return s->phycr;
+    case 0x4:
+        return s->phydata;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void aspeed_mii_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    AspeedMiiState *s =3D ASPEED_MII(opaque);
+
+    switch (addr) {
+    case 0x0:
+        s->phycr =3D value & ~(s->phycr & ASPEED_MII_PHYCR_FIRE);
+        break;
+    case 0x4:
+        s->phydata =3D value & ~(0xffff | ASPEED_MII_PHYDATA_IDLE);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    aspeed_mii_transition(s, !!(s->phycr & ASPEED_MII_PHYCR_FIRE));
+    aspeed_mii_do_phy_ctl(s);
+}
+
+static const MemoryRegionOps aspeed_mii_ops =3D {
+    .read =3D aspeed_mii_read,
+    .write =3D aspeed_mii_write,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
+static void aspeed_mii_reset(DeviceState *dev)
+{
+    AspeedMiiState *s =3D ASPEED_MII(dev);
+
+    s->phycr =3D 0;
+    s->phydata =3D 0;
+
+    aspeed_mii_transition(s, !!(s->phycr & ASPEED_MII_PHYCR_FIRE));
+};
+
+static void aspeed_mii_realize(DeviceState *dev, Error **errp)
+{
+    AspeedMiiState *s =3D ASPEED_MII(dev);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    Object *obj;
+    Error *local_err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), "nic", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'nic' not found: ");
+        return;
+    }
+
+    s->nic =3D FTGMAC100(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &aspeed_mii_ops, s,
+                          TYPE_ASPEED_MII, 0x8);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_aspeed_mii =3D {
+    .name =3D TYPE_ASPEED_MII,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(phycr, FTGMAC100State),
+        VMSTATE_UINT32(phydata, FTGMAC100State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+static void aspeed_mii_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_aspeed_mii;
+    dc->reset =3D aspeed_mii_reset;
+    dc->realize =3D aspeed_mii_realize;
+    dc->desc =3D "Aspeed MII controller";
+}
+
+static const TypeInfo aspeed_mii_info =3D {
+    .name =3D TYPE_ASPEED_MII,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(AspeedMiiState),
+    .class_init =3D aspeed_mii_class_init,
+};
+
 static void ftgmac100_register_types(void)
 {
     type_register_static(&ftgmac100_info);
+    type_register_static(&aspeed_mii_info);
 }
=20
 type_init(ftgmac100_register_types)
--=20
2.21.0


