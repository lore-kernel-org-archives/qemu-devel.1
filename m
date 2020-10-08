Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B0C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBA72168B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="e+t/dYKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBA72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQRrs-0000Qq-Ef
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kQRpB-0007P4-Bo
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:02:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:38858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kQRp2-00021X-MB
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:02:56 -0400
Received: by mail-pg1-x531.google.com with SMTP id r21so375560pgj.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=BJmItJbMh+6cz9hyqiqJXu/lc0gtudiYFSoRAz9fLFA=;
 b=e+t/dYKzWWAMLOgiIKGY4fcorHnvS3b3kP+AwZ4UQuwti6fNxH6ZfLSzpx+Uoy8t+/
 U6fiA1T/Fr23RwcpHyn+eKq/9xLzfr61xfwvCkCyr/l3AhTVo1u2fRPx5Sdc/wSXLb9Y
 5X2wicHqsKdXMBTxRIRgtWVwt0JVuCi3zm55uc4jIGoX46d0bIHe5xGBiZm5qHzjTGl+
 n0ftPt1gMEDKEui1Jb7ZIIolEDWHQqfea5XBI083E2sI0aeUxD927sjX6FFyyHrlqCUG
 cJtpAcm//9iZ3mVjUUisHQMwnW/EOxGR06w/t16Zs+hUNlrYQw8/MlZOKFsOCKynQCs6
 1GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BJmItJbMh+6cz9hyqiqJXu/lc0gtudiYFSoRAz9fLFA=;
 b=Px5aI0buun0piMUN4Rw5K6s4isxWroZV6WAuRn22mR0/csJJ2Z1MD7KKOh6aZ4Rcd1
 25oL8uieDCYZXQe9gOr2f5jb213SToQfTRmylC4FFSGvLnZ0nfl9H/HGHnd09XzjzVkU
 F4aKjIGWgEmxNOjBZD8TEH8AsmUuO3eSgsHFNFgvFr6qswS083DrXClp5Fb0IHKCYaV7
 V/9BjMp2PBF4vkpYU1Ac8FFEjov6tprqRDH3MrN0/TbuNRrfQF3167HrVqBhOt+fVSoC
 yRWsgbCa3a+vj5dqsCZWdDSB5opXFrkrWfrSx+07um1tAzLtcJjJuvRjrRU2TngmF90R
 1A+g==
X-Gm-Message-State: AOAM531FrnwdYiCBOIpWz9ZyE9bIbStkMcOX3gSv8BuMtsnGhLFh/Kt9
 RYgSk3RedCqXBB2BJ+U1qN1leQ==
X-Google-Smtp-Source: ABdhPJyUeEiXF5+uzh5BRNur54Jy+hdMWJzySJhSpuYPu7akec5LA12rhPquSiyR28NqF/dEzsZbJg==
X-Received: by 2002:a63:7a55:: with SMTP id j21mr2198152pgn.218.1602147766404; 
 Thu, 08 Oct 2020 02:02:46 -0700 (PDT)
Received: from localhost ([103.136.220.74])
 by smtp.gmail.com with ESMTPSA id s11sm6987531pgm.36.2020.10.08.02.02.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Oct 2020 02:02:45 -0700 (PDT)
From: John Wang <wangzhiqiang.bj@bytedance.com>
To: clg@kaod.org, xuxiaohan@bytednace.com, yulei.sh@bytedance.com,
 joel@jms.id.au
Subject: [PATCH v2 1/2] hw/misc: add an EMC141{3,4} device model
Date: Thu,  8 Oct 2020 09:02:43 +0000
Message-Id: <20201008090244.3770-1-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Largely inspired by the TMP421 temperature sensor, here is a model for
the EMC1413 temperature sensors.

Specs can be found here :
  https://pdf1.alldatasheet.com/datasheet-pdf/view/533713/SMSC/EMC1413.html

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
v2:
  - Remove DeviceInfo
  - commit message: TMP423 -> TMP421
---
 hw/arm/Kconfig      |   1 +
 hw/misc/Kconfig     |   4 +
 hw/misc/emc1413.c   | 305 ++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build |   1 +
 4 files changed, 311 insertions(+)
 create mode 100644 hw/misc/emc1413.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f303c6bead..8801ada145 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -402,6 +402,7 @@ config ASPEED_SOC
     select SSI_M25P80
     select TMP105
     select TMP421
+    select EMC1413
     select UNIMP
 
 config MPS2
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3185456110..91badf2d4d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -13,6 +13,10 @@ config TMP421
     bool
     depends on I2C
 
+config EMC1413
+    bool
+    depends on I2C
+
 config ISA_DEBUG
     bool
     depends on ISA_BUS
diff --git a/hw/misc/emc1413.c b/hw/misc/emc1413.c
new file mode 100644
index 0000000000..160a59495a
--- /dev/null
+++ b/hw/misc/emc1413.c
@@ -0,0 +1,305 @@
+/*
+ * SMSC EMC141X temperature sensor.
+ *
+ * Copyright (c) 2020 Bytedance Corporation
+ * Written by John Wang <wangzhiqiang.bj@bytedance.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+
+#define DEVICE_ID_REG                    0xfd
+#define MANUFACTURER_ID_REG              0xfe
+#define REVISION_REG                     0xff
+#define EMC1413_DEVICE_ID                0x21
+#define EMC1414_DEVICE_ID                0x25
+
+struct EMC141XState {
+    I2CSlave i2c;
+    uint8_t temperature[4];
+    uint8_t min[4];
+    uint8_t max[4];
+    uint8_t len;
+    uint8_t data;
+    uint8_t pointer;
+};
+
+struct EMC141XClass {
+    I2CSlaveClass parent_class;
+    uint8_t model;
+};
+
+#define TYPE_EMC141X "emc141x"
+OBJECT_DECLARE_TYPE(EMC141XState, EMC141XClass, EMC141X)
+
+
+/* the EMC141X registers */
+#define EMC141X_TEMP_HIGH0               0x00
+#define EMC141X_TEMP_HIGH1               0x01
+#define EMC141X_TEMP_HIGH2               0x23
+#define EMC141X_TEMP_HIGH3               0x2a
+#define EMC141X_TEMP_MAX_HIGH0           0x05
+#define EMC141X_TEMP_MIN_HIGH0           0x06
+#define EMC141X_TEMP_MAX_HIGH1           0x07
+#define EMC141X_TEMP_MIN_HIGH1           0x08
+#define EMC141X_TEMP_MAX_HIGH2           0x15
+#define EMC141X_TEMP_MIN_HIGH2           0x16
+#define EMC141X_TEMP_MAX_HIGH3           0x2c
+#define EMC141X_TEMP_MIN_HIGH3           0x2d
+
+static void emc141x_get_temperature(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    EMC141XState *s = EMC141X(obj);
+    int64_t value;
+    int tempid;
+
+    if (sscanf(name, "temperature%d", &tempid) != 1) {
+        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
+        return;
+    }
+
+    if (tempid >= 4 || tempid < 0) {
+        error_setg(errp, "error reading %s", name);
+        return;
+    }
+
+    value = s->temperature[tempid] * 1000;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void emc141x_set_temperature(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    EMC141XState *s = EMC141X(obj);
+    int64_t temp;
+    int tempid;
+
+    if (!visit_type_int(v, name, &temp, errp)) {
+        return;
+    }
+
+    if (sscanf(name, "temperature%d", &tempid) != 1) {
+        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
+        return;
+    }
+
+    if (tempid >= 4 || tempid < 0) {
+        error_setg(errp, "error reading %s", name);
+        return;
+    }
+
+    s->temperature[tempid] = temp / 1000;
+}
+
+struct emc141x_reg {
+    uint8_t addr;
+    uint8_t *data;
+};
+
+static void emc141x_read(EMC141XState *s)
+{
+    EMC141XClass *sc = EMC141X_GET_CLASS(s);
+    uint8_t smsc_manufacturer_id = 0x5d;
+    uint8_t revision = 0x04;
+    struct emc141x_reg emc141x_regs[] = {
+        {DEVICE_ID_REG, &sc->model},
+        {MANUFACTURER_ID_REG, &smsc_manufacturer_id},
+        {REVISION_REG, &revision},
+        {EMC141X_TEMP_HIGH0, &s->temperature[0]},
+        {EMC141X_TEMP_HIGH1, &s->temperature[1]},
+        {EMC141X_TEMP_HIGH2, &s->temperature[2]},
+        {EMC141X_TEMP_HIGH3, &s->temperature[3]},
+        {EMC141X_TEMP_MAX_HIGH0, &s->max[0]},
+        {EMC141X_TEMP_MAX_HIGH1, &s->max[1]},
+        {EMC141X_TEMP_MAX_HIGH2, &s->max[2]},
+        {EMC141X_TEMP_MAX_HIGH3, &s->max[3]},
+        {EMC141X_TEMP_MIN_HIGH0, &s->min[0]},
+        {EMC141X_TEMP_MIN_HIGH1, &s->min[1]},
+        {EMC141X_TEMP_MIN_HIGH2, &s->min[2]},
+        {EMC141X_TEMP_MIN_HIGH3, &s->min[3]},
+    };
+    size_t i;
+    for (i = 0; i < ARRAY_SIZE(emc141x_regs); i++) {
+        if (emc141x_regs[i].addr == s->pointer) {
+            s->data = *(emc141x_regs[i].data);
+            return;
+        }
+    }
+}
+
+static void emc141x_write(EMC141XState *s)
+{
+    struct emc141x_reg emc141x_regs[] = {
+        {EMC141X_TEMP_MAX_HIGH0, &s->max[0]},
+        {EMC141X_TEMP_MAX_HIGH1, &s->max[1]},
+        {EMC141X_TEMP_MAX_HIGH2, &s->max[2]},
+        {EMC141X_TEMP_MAX_HIGH3, &s->max[3]},
+        {EMC141X_TEMP_MIN_HIGH0, &s->min[0]},
+        {EMC141X_TEMP_MIN_HIGH1, &s->min[1]},
+        {EMC141X_TEMP_MIN_HIGH2, &s->min[2]},
+        {EMC141X_TEMP_MIN_HIGH3, &s->min[3]},
+    };
+    size_t i;
+    for (i = 0; i < ARRAY_SIZE(emc141x_regs); i++) {
+        if (emc141x_regs[i].addr == s->pointer) {
+            *(emc141x_regs[i].data) = s->data;
+            return;
+        }
+    }
+}
+
+static uint8_t emc141x_rx(I2CSlave *i2c)
+{
+    EMC141XState *s = EMC141X(i2c);
+
+    if (s->len == 0) {
+        s->len++;
+        return s->data;
+    } else {
+        return 0xff;
+    }
+}
+
+static int emc141x_tx(I2CSlave *i2c, uint8_t data)
+{
+    EMC141XState *s = EMC141X(i2c);
+
+    if (s->len == 0) {
+        /* first byte is the reg pointer */
+        s->pointer = data;
+        s->len++;
+    } else if (s->len == 1) {
+        s->data = data;
+        emc141x_write(s);
+    }
+
+    return 0;
+}
+
+static int emc141x_event(I2CSlave *i2c, enum i2c_event event)
+{
+    EMC141XState *s = EMC141X(i2c);
+
+    if (event == I2C_START_RECV) {
+        emc141x_read(s);
+    }
+
+    s->len = 0;
+    return 0;
+}
+
+static const VMStateDescription vmstate_emc141x = {
+    .name = "EMC141X",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(len, EMC141XState),
+        VMSTATE_UINT8(data, EMC141XState),
+        VMSTATE_UINT8(pointer, EMC141XState),
+        VMSTATE_UINT8_ARRAY(temperature, EMC141XState, 4),
+        VMSTATE_UINT8_ARRAY(min, EMC141XState, 4),
+        VMSTATE_UINT8_ARRAY(max, EMC141XState, 4),
+        VMSTATE_I2C_SLAVE(i2c, EMC141XState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void emc141x_reset(I2CSlave *i2c)
+{
+    EMC141XState *s = EMC141X(i2c);
+
+    memset(s->temperature, 0, sizeof(s->temperature));
+    memset(s->min, 0, sizeof(s->min));
+    memset(s->max, 0x55, sizeof(s->max));
+    s->pointer = 0;
+    s->len = 0;
+}
+
+static void emc141x_realize(DeviceState *dev, Error **errp)
+{
+    EMC141XState *s = EMC141X(dev);
+
+    emc141x_reset(&s->i2c);
+}
+
+static void emc141x_initfn(Object *obj)
+{
+    object_property_add(obj, "temperature0", "int",
+                        emc141x_get_temperature,
+                        emc141x_set_temperature, NULL, NULL);
+    object_property_add(obj, "temperature1", "int",
+                        emc141x_get_temperature,
+                        emc141x_set_temperature, NULL, NULL);
+    object_property_add(obj, "temperature2", "int",
+                        emc141x_get_temperature,
+                        emc141x_set_temperature, NULL, NULL);
+    object_property_add(obj, "temperature3", "int",
+                        emc141x_get_temperature,
+                        emc141x_set_temperature, NULL, NULL);
+}
+
+static void emc141x_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    EMC141XClass *sc = EMC141X_CLASS(klass);
+
+    dc->realize = emc141x_realize;
+    k->event = emc141x_event;
+    k->recv = emc141x_rx;
+    k->send = emc141x_tx;
+    dc->vmsd = &vmstate_emc141x;
+    sc->model = (uintptr_t)data;
+}
+
+static const TypeInfo emc141x_info = {
+    .name          = TYPE_EMC141X,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(EMC141XState),
+    .class_size    = sizeof(EMC141XClass),
+    .instance_init = emc141x_initfn,
+    .abstract      = true,
+};
+
+static const TypeInfo emc1413_info = {
+    .name          = "emc1413",
+    .parent        = TYPE_EMC141X,
+    .class_init    = emc141x_class_init,
+    .class_data    = (void *)EMC1413_DEVICE_ID,
+};
+
+static const TypeInfo emc1414_info = {
+    .name          = "emc1414",
+    .parent        = TYPE_EMC141X,
+    .class_init    = emc141x_class_init,
+    .class_data    = (void *)EMC1414_DEVICE_ID,
+};
+
+static void emc141x_register_types(void)
+{
+    type_register_static(&emc141x_info);
+    type_register_static(&emc1413_info);
+    type_register_static(&emc1414_info);
+}
+
+type_init(emc141x_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 793d45b1dc..08821c72ba 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -9,6 +9,7 @@ softmmu_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
 softmmu_ss.add(when: 'CONFIG_SGA', if_true: files('sga.c'))
 softmmu_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
 softmmu_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
+softmmu_ss.add(when: 'CONFIG_EMC1413', if_true: files('emc1413.c'))
 softmmu_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 softmmu_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 
-- 
2.17.1


