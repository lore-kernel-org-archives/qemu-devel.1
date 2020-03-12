Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1551DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A9E206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL9pFigF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A9E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR3M-00066Q-Ra
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxY-00009Z-7x
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxW-0005A1-1d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxV-00059m-Py
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id m3so7126356wmi.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=78jazQtF+RQHW96LIyEOH/mPjBtNV9tWgWuJ9A/+O8o=;
 b=VL9pFigFD1Wg7GVHt6PNQA4S4jaxUQhyN76sKuOfSCtAOOY7plFmVUmeinnlviFNq5
 EnpV7w95KPKAcNiQC8VJS7lxL8E4HyTc8n6XUuunp59d+kFCgf1kEx2/DSKQbGvg8VAA
 YKx8DF4ErylOAFO4yeDJVD82amLBhvD4t0wM10LS9Mhc+JveSV8FhuqBdYm/+HmFsx+W
 sEpIUX6vSIIrWvqLSvoacPR8WxCpCYC14RhaH+C2C/MNWVq+umjsxSXBwHhhNABAWe7I
 WckIrMcUSK6gsv88yvGKhU/wrv/xEmWgz/7SS0CPQRKNkf72ThycPSyEEKjRucUhsGx4
 iH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=78jazQtF+RQHW96LIyEOH/mPjBtNV9tWgWuJ9A/+O8o=;
 b=O9ikx9xDjck/kWnTgQ49KEah1cjScSH58AakaZzr3uyEUS9EvxdZyTsxgvgFFVblpV
 6diA5K7fDbz+QMZEyPef0D9pPS33E5RMDFUEvqqK5U15/h+HnPw234gINpP217B3qrjL
 O6gl5RKL2EE4mE97+kbV5leK+yGxKujeFMolM9FNO29b1R7ztv5g/K0gMyTzWUV+Zs/x
 vsKwie5rtMz6umRplzecNO5DGrXXxriIuVJUeu08R1lZsPbucaJ69hGsil8zT559racs
 RQRxJdggYDmA0otuAT2tlKiL1pPM63MRSjBrN0aB4Z1QcVY7wVy6wyFfMkXSTd0nneu5
 +6HQ==
X-Gm-Message-State: ANhLgQ3G4S9on014lw6YykCTdXqlngO7s4wkUop5TzCAHRSiX7VDsKY9
 WvB1m45K8M3iVDqUN0Z/HJVOUoxy3HV1Ew==
X-Google-Smtp-Source: ADFU+vsP103tZ6OyLNNr/Ii98cblgy1bzVINWUY+GG3lv8kE6/sH1jDcaaZhuaauONXqgSnqpEgO+A==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr5487869wme.173.1584031520264; 
 Thu, 12 Mar 2020 09:45:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/36] hw/arm/allwinner-h3: add System Control module
Date: Thu, 12 Mar 2020 16:44:39 +0000
Message-Id: <20200312164459.25924-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The Allwinner H3 System on Chip has an System Control
module that provides system wide generic controls and
device information. This commit adds support for the
Allwinner H3 System Control module.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200311221854.30370-6-nieklinnenbank@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs                  |   1 +
 include/hw/arm/allwinner-h3.h          |   3 +
 include/hw/misc/allwinner-h3-sysctrl.h |  67 ++++++++++++
 hw/arm/allwinner-h3.c                  |   9 +-
 hw/misc/allwinner-h3-sysctrl.c         | 140 +++++++++++++++++++++++++
 5 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/allwinner-h3-sysctrl.h
 create mode 100644 hw/misc/allwinner-h3-sysctrl.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 5e635b74d5a..63b2e528f98 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sysctrl.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 4f4dcbcd177..43500c42621 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -40,6 +40,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/allwinner-h3-ccu.h"
+#include "hw/misc/allwinner-h3-sysctrl.h"
 #include "target/arm/cpu.h"
 
 /**
@@ -56,6 +57,7 @@ enum {
     AW_H3_SRAM_A1,
     AW_H3_SRAM_A2,
     AW_H3_SRAM_C,
+    AW_H3_SYSCTRL,
     AW_H3_EHCI0,
     AW_H3_OHCI0,
     AW_H3_EHCI1,
@@ -108,6 +110,7 @@ typedef struct AwH3State {
     const hwaddr *memmap;
     AwA10PITState timer;
     AwH3ClockCtlState ccu;
+    AwH3SysCtrlState sysctrl;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-sysctrl.h b/include/hw/misc/allwinner-h3-sysctrl.h
new file mode 100644
index 00000000000..af4119e0269
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-sysctrl.h
@@ -0,0 +1,67 @@
+/*
+ * Allwinner H3 System Control emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_MISC_ALLWINNER_H3_SYSCTRL_H
+#define HW_MISC_ALLWINNER_H3_SYSCTRL_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Highest register address used by System Control device */
+#define AW_H3_SYSCTRL_REGS_MAXADDR   (0x30)
+
+/** Total number of known registers */
+#define AW_H3_SYSCTRL_REGS_NUM       ((AW_H3_SYSCTRL_REGS_MAXADDR / \
+                                      sizeof(uint32_t)) + 1)
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_H3_SYSCTRL    "allwinner-h3-sysctrl"
+#define AW_H3_SYSCTRL(obj) \
+    OBJECT_CHECK(AwH3SysCtrlState, (obj), TYPE_AW_H3_SYSCTRL)
+
+/** @} */
+
+/**
+ * Allwinner H3 System Control object instance state
+ */
+typedef struct AwH3SysCtrlState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_H3_SYSCTRL_REGS_NUM];
+
+} AwH3SysCtrlState;
+
+#endif /* HW_MISC_ALLWINNER_H3_SYSCTRL_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index c205f06738a..0aa46712db7 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -37,6 +37,7 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_SRAM_A1]    = 0x00000000,
     [AW_H3_SRAM_A2]    = 0x00044000,
     [AW_H3_SRAM_C]     = 0x00010000,
+    [AW_H3_SYSCTRL]    = 0x01c00000,
     [AW_H3_EHCI0]      = 0x01c1a000,
     [AW_H3_OHCI0]      = 0x01c1a400,
     [AW_H3_EHCI1]      = 0x01c1b000,
@@ -66,7 +67,6 @@ struct AwH3Unimplemented {
 } unimplemented[] = {
     { "d-engine",  0x01000000, 4 * MiB },
     { "d-inter",   0x01400000, 128 * KiB },
-    { "syscon",    0x01c00000, 4 * KiB },
     { "dma",       0x01c02000, 4 * KiB },
     { "nfdc",      0x01c03000, 4 * KiB },
     { "ts",        0x01c06000, 4 * KiB },
@@ -192,6 +192,9 @@ static void allwinner_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
                           TYPE_AW_H3_CCU);
+
+    sysbus_init_child_obj(obj, "sysctrl", &s->sysctrl, sizeof(s->sysctrl),
+                          TYPE_AW_H3_SYSCTRL);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -301,6 +304,10 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(DEVICE(&s->ccu));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
 
+    /* System Control */
+    qdev_init_nofail(DEVICE(&s->sysctrl));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0, s->memmap[AW_H3_SYSCTRL]);
+
     /* Universal Serial Bus */
     sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/misc/allwinner-h3-sysctrl.c b/hw/misc/allwinner-h3-sysctrl.c
new file mode 100644
index 00000000000..1d07efa880d
--- /dev/null
+++ b/hw/misc/allwinner-h3-sysctrl.c
@@ -0,0 +1,140 @@
+/*
+ * Allwinner H3 System Control emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/allwinner-h3-sysctrl.h"
+
+/* System Control register offsets */
+enum {
+    REG_VER               = 0x24,  /* Version */
+    REG_EMAC_PHY_CLK      = 0x30,  /* EMAC PHY Clock */
+};
+
+#define REG_INDEX(offset)   (offset / sizeof(uint32_t))
+
+/* System Control register reset values */
+enum {
+    REG_VER_RST           = 0x0,
+    REG_EMAC_PHY_CLK_RST  = 0x58000,
+};
+
+static uint64_t allwinner_h3_sysctrl_read(void *opaque, hwaddr offset,
+                                          unsigned size)
+{
+    const AwH3SysCtrlState *s = AW_H3_SYSCTRL(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_SYSCTRL_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_h3_sysctrl_write(void *opaque, hwaddr offset,
+                                       uint64_t val, unsigned size)
+{
+    AwH3SysCtrlState *s = AW_H3_SYSCTRL(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_SYSCTRL_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
+    case REG_VER:       /* Version */
+        break;
+    default:
+        s->regs[idx] = (uint32_t) val;
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_h3_sysctrl_ops = {
+    .read = allwinner_h3_sysctrl_read,
+    .write = allwinner_h3_sysctrl_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_h3_sysctrl_reset(DeviceState *dev)
+{
+    AwH3SysCtrlState *s = AW_H3_SYSCTRL(dev);
+
+    /* Set default values for registers */
+    s->regs[REG_INDEX(REG_VER)] = REG_VER_RST;
+    s->regs[REG_INDEX(REG_EMAC_PHY_CLK)] = REG_EMAC_PHY_CLK_RST;
+}
+
+static void allwinner_h3_sysctrl_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3SysCtrlState *s = AW_H3_SYSCTRL(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_sysctrl_ops, s,
+                           TYPE_AW_H3_SYSCTRL, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_h3_sysctrl_vmstate = {
+    .name = "allwinner-h3-sysctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwH3SysCtrlState, AW_H3_SYSCTRL_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_sysctrl_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_sysctrl_reset;
+    dc->vmsd = &allwinner_h3_sysctrl_vmstate;
+}
+
+static const TypeInfo allwinner_h3_sysctrl_info = {
+    .name          = TYPE_AW_H3_SYSCTRL,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_sysctrl_init,
+    .instance_size = sizeof(AwH3SysCtrlState),
+    .class_init    = allwinner_h3_sysctrl_class_init,
+};
+
+static void allwinner_h3_sysctrl_register(void)
+{
+    type_register_static(&allwinner_h3_sysctrl_info);
+}
+
+type_init(allwinner_h3_sysctrl_register)
-- 
2.20.1


