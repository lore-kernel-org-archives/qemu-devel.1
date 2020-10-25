Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B65C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 13:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2BA20720
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 13:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="bBYWMDcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2BA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWfsV-0001gu-TX
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 09:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kWfrC-0000Lf-15
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 09:14:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:44302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kWfr6-0002N3-4C
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 09:14:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id h2so3364406pll.11
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=95LtK+mOAjWk/jT1lnBF6+rktUK8JP7X6ieakwHTeEs=;
 b=bBYWMDcYAaKM6iESjDKlvLCSOAwE+C6D4r7eRXW3eO6jukg/QUeRt2j1uXzK4kdlnm
 EbfCvIY5B7MSm6SbCwd+GOKinjQOjBkGWOIVbLjBa/TVpVpQCpSMkK0pThv/+Jp1E1N5
 U4tFpEV6FUBU1ncT+UL7ZrxuhQQyzH2UoiTdYUiHf+1JFUBcIfY2yDWpoMHT9yRY1TzQ
 k9/jNDHvkXF2jU8QNiHt0eiis9NPWlSOXGwEIv1UFGe8kgOHDwUdJidPkTyzY0CyhVsW
 MXLdoqv/Z5sJwkIXcIG5wssnnVpYrFSCF4jLD+2mktj2t1Gg+oUtO2R3RVatZJ2vXACt
 JUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=95LtK+mOAjWk/jT1lnBF6+rktUK8JP7X6ieakwHTeEs=;
 b=IvQuVxtzxYBQolg0zOqkdVyq16hVVc8iLi3X+JH5vFEOQwyZZwe9IDqszZpC5HEsV0
 kyaUeITkPLWTG2jzAwc4JRZ5WRSCzMylzcJSkbDuSAgLBD2Hh8sWaKpphtE4QnSmEaWM
 i+0Zqh7xVpHk6PSknrhDeVmjgKGFDBLbCLETo8sJLSKp0l9zVAfpWQfw302/YQWeP3BS
 iv/KRx5IN4HvPzlKEkiIqshbvEcAAIoM02z8+h2vKMsFP+hCY1S7djdyUgQhfXy4Is88
 p+hB9FWbeEIigAc97DeIpX47JN9XDQjF07jTMc9fvw3rQxoVrdL0yUqX6fH6Uh2nGiBE
 nUQQ==
X-Gm-Message-State: AOAM5307RBCE+DjPAiIX2ptOaxeepgS4m3XNznW6aSrDntYFGt0VtphP
 /Gxl1W6TbivPzxIOzZ3ZjLLfKw==
X-Google-Smtp-Source: ABdhPJzaNCUVFu6bWsjPdRMyM/9H1QcqoJ4wyvAQCccxblpLo4G4l+8t773e46Kj9kuYvwoJlc5Gsg==
X-Received: by 2002:a17:90a:62c1:: with SMTP id
 k1mr11985234pjs.135.1603631677349; 
 Sun, 25 Oct 2020 06:14:37 -0700 (PDT)
Received: from localhost ([103.136.220.131])
 by smtp.gmail.com with ESMTPSA id t10sm9344642pjr.37.2020.10.25.06.14.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 25 Oct 2020 06:14:36 -0700 (PDT)
From: John Wang <wangzhiqiang.bj@bytedance.com>
To: clg@kaod.org, xuxiaohan@bytedance.com, yulei.sh@bytedance.com,
 joel@jms.id.au, f4bug@amsat.org
Subject: [PATCH v3 1/2] hw/misc: add an EMC141{3,4} device model
Date: Sun, 25 Oct 2020 13:14:34 +0000
Message-Id: <20201025131435.144-1-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-pl1-x636.google.com
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
the EMC1413/EMC1414 temperature sensors.

Specs can be found here :
  http://ww1.microchip.com/downloads/en/DeviceDoc/20005274A.pdf

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
v3:
  - update the link to the spec
  - Rename emc1413.c to emc141x.c
  - Add sensors_count in EMC141XClass
  - Make emc1413_read/write easier to review :)
v2:
  - Remove DeviceInfo
  - commit message: TMP423 -> TMP421
---
 hw/arm/Kconfig      |   1 +
 hw/misc/Kconfig     |   4 +
 hw/misc/emc141x.c   | 347 ++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build |   1 +
 4 files changed, 353 insertions(+)
 create mode 100644 hw/misc/emc141x.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7d040827af..3dd651a236 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -403,6 +403,7 @@ config ASPEED_SOC
     select SSI_M25P80
     select TMP105
     select TMP421
+    select EMC141X
     select UNIMP
 
 config MPS2
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3185456110..169d087d3d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -13,6 +13,10 @@ config TMP421
     bool
     depends on I2C
 
+config EMC141X
+    bool
+    depends on I2C
+
 config ISA_DEBUG
     bool
     depends on ISA_BUS
diff --git a/hw/misc/emc141x.c b/hw/misc/emc141x.c
new file mode 100644
index 0000000000..a2bce74719
--- /dev/null
+++ b/hw/misc/emc141x.c
@@ -0,0 +1,347 @@
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
+#define EMC1413_DEVICE_ID                0x21
+#define EMC1414_DEVICE_ID                0x25
+#define MANUFACTURER_ID                  0x5d
+#define REVISION                         0x04
+
+#define SENSORS_COUNT_MAX    4
+
+struct EMC141XState {
+    I2CSlave i2c;
+    uint8_t temperature[SENSORS_COUNT_MAX];
+    uint8_t min[SENSORS_COUNT_MAX];
+    uint8_t max[SENSORS_COUNT_MAX];
+    uint8_t len;
+    uint8_t data;
+    uint8_t pointer;
+};
+
+struct EMC141XClass {
+    I2CSlaveClass parent_class;
+    uint8_t model;
+    unsigned sensors_count;
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
+#define EMC141X_DEVICE_ID                0xfd
+#define EMC141X_MANUFACTURER_ID          0xfe
+#define EMC141X_REVISION                 0xff
+
+static void emc141x_get_temperature(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    EMC141XState *s = EMC141X(obj);
+    EMC141XClass *sc = EMC141X_GET_CLASS(s);
+    int64_t value;
+    int tempid;
+
+    if (sscanf(name, "temperature%d", &tempid) != 1) {
+        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
+        return;
+    }
+
+    if (tempid >= sc->sensors_count || tempid < 0) {
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
+    EMC141XClass *sc = EMC141X_GET_CLASS(s);
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
+    if (tempid >= sc->sensors_count || tempid < 0) {
+        error_setg(errp, "error reading %s", name);
+        return;
+    }
+
+    s->temperature[tempid] = temp / 1000;
+}
+
+static void emc141x_read(EMC141XState *s)
+{
+    EMC141XClass *sc = EMC141X_GET_CLASS(s);
+    switch (s->pointer) {
+    case EMC141X_DEVICE_ID:
+        s->data = sc->model;
+        break;
+    case EMC141X_MANUFACTURER_ID:
+        s->data = MANUFACTURER_ID;
+        break;
+    case EMC141X_REVISION:
+        s->data = REVISION;
+        break;
+    case EMC141X_TEMP_HIGH0:
+        s->data = s->temperature[0];
+        break;
+    case EMC141X_TEMP_HIGH1:
+        s->data = s->temperature[1];
+        break;
+    case EMC141X_TEMP_HIGH2:
+        s->data = s->temperature[2];
+        break;
+    case EMC141X_TEMP_HIGH3:
+        s->data = s->temperature[3];
+        break;
+    case EMC141X_TEMP_MAX_HIGH0:
+        s->data = s->max[0];
+        break;
+    case EMC141X_TEMP_MAX_HIGH1:
+        s->data = s->max[1];
+        break;
+    case EMC141X_TEMP_MAX_HIGH2:
+        s->data = s->max[2];
+        break;
+    case EMC141X_TEMP_MAX_HIGH3:
+        s->data = s->max[3];
+        break;
+    case EMC141X_TEMP_MIN_HIGH0:
+        s->data = s->min[0];
+        break;
+    case EMC141X_TEMP_MIN_HIGH1:
+        s->data = s->min[1];
+        break;
+    case EMC141X_TEMP_MIN_HIGH2:
+        s->data = s->min[2];
+        break;
+    case EMC141X_TEMP_MIN_HIGH3:
+        s->data = s->min[3];
+        break;
+    default:
+        s->data = 0;
+    }
+}
+
+static void emc141x_write(EMC141XState *s)
+{
+    switch (s->pointer) {
+    case EMC141X_TEMP_MAX_HIGH0:
+        s->max[0] = s->data;
+        break;
+    case EMC141X_TEMP_MAX_HIGH1:
+        s->max[1] = s->data;
+        break;
+    case EMC141X_TEMP_MAX_HIGH2:
+        s->max[2] = s->data;
+        break;
+    case EMC141X_TEMP_MAX_HIGH3:
+        s->max[3] = s->data;
+        break;
+    case EMC141X_TEMP_MIN_HIGH0:
+        s->min[0] = s->data;
+        break;
+    case EMC141X_TEMP_MIN_HIGH1:
+        s->min[1] = s->data;
+        break;
+    case EMC141X_TEMP_MIN_HIGH2:
+        s->min[2] = s->data;
+        break;
+    case EMC141X_TEMP_MIN_HIGH3:
+        s->min[3] = s->data;
+        break;
+    default:
+        s->data = 0;
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
+        VMSTATE_UINT8_ARRAY(temperature, EMC141XState, SENSORS_COUNT_MAX),
+        VMSTATE_UINT8_ARRAY(min, EMC141XState, SENSORS_COUNT_MAX),
+        VMSTATE_UINT8_ARRAY(max, EMC141XState, SENSORS_COUNT_MAX),
+        VMSTATE_I2C_SLAVE(i2c, EMC141XState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void emc141x_reset(DeviceState *dev)
+{
+    EMC141XState *s = EMC141X(dev);
+
+    memset(s->min, 0, sizeof(s->min));
+    memset(s->max, 0x55, sizeof(s->max));
+    s->pointer = 0;
+    s->len = 0;
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
+
+    dc->reset = emc141x_reset;
+    k->event = emc141x_event;
+    k->recv = emc141x_rx;
+    k->send = emc141x_tx;
+    dc->vmsd = &vmstate_emc141x;
+}
+
+static void emc1413_class_init(ObjectClass *klass, void *data)
+{
+    EMC141XClass *ec = EMC141X_CLASS(klass);
+
+    emc141x_class_init(klass, data);
+    ec->model = EMC1413_DEVICE_ID;
+    ec->sensors_count = 3;
+}
+
+static void emc1414_class_init(ObjectClass *klass, void *data)
+{
+    EMC141XClass *ec = EMC141X_CLASS(klass);
+
+    emc141x_class_init(klass, data);
+    ec->model = EMC1414_DEVICE_ID;
+    ec->sensors_count = 4;
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
+    .class_init    = emc1413_class_init,
+};
+
+static const TypeInfo emc1414_info = {
+    .name          = "emc1414",
+    .parent        = TYPE_EMC141X,
+    .class_init    = emc1414_class_init,
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
index 793d45b1dc..b18693c9af 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -9,6 +9,7 @@ softmmu_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
 softmmu_ss.add(when: 'CONFIG_SGA', if_true: files('sga.c'))
 softmmu_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
 softmmu_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
+softmmu_ss.add(when: 'CONFIG_EMC141X', if_true: files('emc141x.c'))
 softmmu_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 softmmu_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 
-- 
2.17.1


