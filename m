Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4138CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2488205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJ4jbhhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2488205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgxo-0000YV-63
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyL-0008Lu-HJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyJ-00014p-Vs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyJ-00014L-Oo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id q13so21829932wrs.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+7fLMOIAWdycUDbs1+X1UPaZ+K02U2cR6zHlqPFssiE=;
 b=bJ4jbhhcGglf5BwDKbivsKqfc0quWBi+V9LS0554uicJCWxfDly0a8OazntBMO4cmn
 /kgqMbMKvg1Zi8a98Oo+BdVrRma7K3KcZ9vxCI55hY/s08jh8cdu7W1jJnPc7OnbSaWb
 JHzjPwrc3NXBTl3ReK6NWlmm1Qr4lcVInwg63kGOKs05qqVgKbIW07Xx4cXJkrTnHbQ2
 nLNQctaVzMRiGannbZFJxvYcGTmgUa+LOit9VvSO0Bea+XAz0V1VU46y9+4Wv4HoCMlF
 R2i57uRYAMzT9h6FUwj1KJGwuPZtJTDBe1NSkICcc+uH0MhV/mJ6ZSClFnlyHu0DJVnh
 1rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+7fLMOIAWdycUDbs1+X1UPaZ+K02U2cR6zHlqPFssiE=;
 b=ilAo+jngDCiHkSbbUZ9c1M0KevdwbTa35PjbA8MHyX5Eu62yoc9b6ClyCqlwvmJLpj
 TLnviBqzsbRUkJ0XRGfXcl6F9dIxF+Hs+J/QOy+BIFMfMcCp07mIteM6zG4SmOgwr5Rz
 /yrEH5mJtC5MsOfEtTaLZwxwKzKeWLatzO8toYY+WBceiiLRPC9iwezI3uGI4Pl4PJSk
 CJVs/L/eEoNgzLpV1qrU/4pPu5NojIvan+32YqAt+a4hpYBiu1oZn5kp3FKlGpodcUPD
 4Teo3Ljycj0qmgttrJhVVH/y5cJKdtrzVRsAhNyzPihtPvhlJHD/T6DxcHSqJZkbj1x1
 s8xA==
X-Gm-Message-State: APjAAAU1wAUngJyaLJFoECsIMIy5J/f5BSpUWl717gOpLh1va9zCz8SM
 hBq5wjzqKRQSaHzLkPAvOa0XIccMgf4=
X-Google-Smtp-Source: APXvYqy6mDQlBFf7hRRa2psrJ1BFexuxvyUDGZOq3BktGJWPfY+2EW3pwwnPXmVH5m6n0mrEkP1LiA==
X-Received: by 2002:a5d:5591:: with SMTP id i17mr4469584wrv.151.1571934502411; 
 Thu, 24 Oct 2019 09:28:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/51] hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal
 sensor
Date: Thu, 24 Oct 2019 17:27:17 +0100
Message-Id: <20191024162724.31675-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We will soon implement the SYS_timer. This timer is used by Linux
in the thermal subsystem, so once available, the subsystem will be
enabled and poll the temperature sensors. We need to provide the
minimum required to keep Linux booting.

Add a dummy thermal sensor returning ~25°C based on:
https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/thermal/broadcom/bcm2835_thermal.c

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191019234715.25750-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs             |   1 +
 include/hw/misc/bcm2835_thermal.h |  27 ++++++
 hw/misc/bcm2835_thermal.c         | 135 ++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 include/hw/misc/bcm2835_thermal.h
 create mode 100644 hw/misc/bcm2835_thermal.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index a1506809660..c89f3816a52 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -53,6 +53,7 @@ common-obj-$(CONFIG_OMAP) += omap_tap.o
 common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
 common-obj-$(CONFIG_RASPI) += bcm2835_property.o
 common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
+common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
 common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
 common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
 common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_thermal.h
new file mode 100644
index 00000000000..c3651b27ec6
--- /dev/null
+++ b/include/hw/misc/bcm2835_thermal.h
@@ -0,0 +1,27 @@
+/*
+ * BCM2835 dummy thermal sensor
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_BCM2835_THERMAL_H
+#define HW_MISC_BCM2835_THERMAL_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2835_THERMAL "bcm2835-thermal"
+
+#define BCM2835_THERMAL(obj) \
+    OBJECT_CHECK(Bcm2835ThermalState, (obj), TYPE_BCM2835_THERMAL)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t ctl;
+} Bcm2835ThermalState;
+
+#endif
diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
new file mode 100644
index 00000000000..c6f3b1ad605
--- /dev/null
+++ b/hw/misc/bcm2835_thermal.c
@@ -0,0 +1,135 @@
+/*
+ * BCM2835 dummy thermal sensor
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/misc/bcm2835_thermal.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+
+REG32(CTL, 0)
+FIELD(CTL, POWER_DOWN, 0, 1)
+FIELD(CTL, RESET, 1, 1)
+FIELD(CTL, BANDGAP_CTRL, 2, 3)
+FIELD(CTL, INTERRUPT_ENABLE, 5, 1)
+FIELD(CTL, DIRECT, 6, 1)
+FIELD(CTL, INTERRUPT_CLEAR, 7, 1)
+FIELD(CTL, HOLD, 8, 10)
+FIELD(CTL, RESET_DELAY, 18, 8)
+FIELD(CTL, REGULATOR_ENABLE, 26, 1)
+
+REG32(STAT, 4)
+FIELD(STAT, DATA, 0, 10)
+FIELD(STAT, VALID, 10, 1)
+FIELD(STAT, INTERRUPT, 11, 1)
+
+#define THERMAL_OFFSET_C 412
+#define THERMAL_COEFF  (-0.538f)
+
+static uint16_t bcm2835_thermal_temp2adc(int temp_C)
+{
+    return (temp_C - THERMAL_OFFSET_C) / THERMAL_COEFF;
+}
+
+static uint64_t bcm2835_thermal_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(opaque);
+    uint32_t val = 0;
+
+    switch (addr) {
+    case A_CTL:
+        val = s->ctl;
+        break;
+    case A_STAT:
+        /* Temperature is constantly 25°C. */
+        val = FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID, true);
+        break;
+    default:
+        /* MemoryRegionOps are aligned, so this can not happen. */
+        g_assert_not_reached();
+    }
+    return val;
+}
+
+static void bcm2835_thermal_write(void *opaque, hwaddr addr,
+                                  uint64_t value, unsigned size)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(opaque);
+
+    switch (addr) {
+    case A_CTL:
+        s->ctl = value;
+        break;
+    case A_STAT:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
+                                       " to 0x%" HWADDR_PRIx "\n",
+                       __func__, value, addr);
+        break;
+    default:
+        /* MemoryRegionOps are aligned, so this can not happen. */
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps bcm2835_thermal_ops = {
+    .read = bcm2835_thermal_read,
+    .write = bcm2835_thermal_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2835_thermal_reset(DeviceState *dev)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(dev);
+
+    s->ctl = 0;
+}
+
+static void bcm2835_thermal_realize(DeviceState *dev, Error **errp)
+{
+    Bcm2835ThermalState *s = BCM2835_THERMAL(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_thermal_ops,
+                          s, TYPE_BCM2835_THERMAL, 8);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static const VMStateDescription bcm2835_thermal_vmstate = {
+    .name = "bcm2835_thermal",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctl, Bcm2835ThermalState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_thermal_realize;
+    dc->reset = bcm2835_thermal_reset;
+    dc->vmsd = &bcm2835_thermal_vmstate;
+}
+
+static const TypeInfo bcm2835_thermal_info = {
+    .name = TYPE_BCM2835_THERMAL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Bcm2835ThermalState),
+    .class_init = bcm2835_thermal_class_init,
+};
+
+static void bcm2835_thermal_register_types(void)
+{
+    type_register_static(&bcm2835_thermal_info);
+}
+
+type_init(bcm2835_thermal_register_types)
-- 
2.20.1


