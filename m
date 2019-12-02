Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4652C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7582071F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaaNGa/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7582071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtXO-0003Am-CP
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxn-0002pc-4z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxk-0000pS-4E
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:34 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxj-0000Zk-PN; Mon, 02 Dec 2019 16:10:32 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so1104582wmi.3;
 Mon, 02 Dec 2019 13:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8lluLcXPi3hnYH6Ygv8lu4PnBF+2/P64LGe20+1b09Y=;
 b=IaaNGa/xTJJsau+FEd6bH3Orvmr7M2hmoP8N4NJOvvEdG5FBhAw7r5qoEF3O2E4oq4
 T29F62P3aY/FBVASqu1vlTt6Y23w3xBZoaHA+6bPbx0NEssAcq1dNOqNcTLFVQWHHB53
 rgX7XNIAV5m/TEsEpTVQyX//tVS0wpbPouzxhCtKtIbwFF1Bmu81qdlZQ9qDwGz8YL9q
 RGKFx2LyN3zHBWWRHuyq7Qj3rb6+TgNkcki6bcp97TNv6knjtjkVug0E7cG6lvsebw3n
 cVFtCATFktltFwI2eBDF7asFVTEr4jcRCp+Du+9fCYYx1s5wBTGF9hSKR0uIO9WhcLr/
 adQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8lluLcXPi3hnYH6Ygv8lu4PnBF+2/P64LGe20+1b09Y=;
 b=Wq1okkFiPenTfcVusacAWlGnGr3n8T/DT2z2XgqO/56y2FUFX25TnkYy1f/N0Y2xTT
 rbV8tYwe0gsbx+HG79+fXASonCknMD8aBB7RNEI5ffQ8sGOdXA9JttQpLndXYvIqeUI9
 aDOAWPEHKjC75vlxtle3+UIsPyHpkrMyXBnmrqi69ATKnYU5RkT9Il6aS5GwBwU2djfl
 ksnVGg5BKv0gmoZkz4D7BpM/5bv5QVE2WKNuWkhX4Jndq8IQ+YW0kZfChHkwaTIZhh7v
 krSfRGUYpE4TdV1ue6ihU2mco4aPQ/HKd8RhEUBrLtGju+jfQEzBpRGszRwqFDnBleWL
 oA/g==
X-Gm-Message-State: APjAAAV2Dp9H9CXqhoRwzWM6XpJK85vgwliPAmd29ErrEIuwHeTOdzh6
 6AOymjpBZvfR1w4aJUtZjLpgngQH
X-Google-Smtp-Source: APXvYqytFB54mKI6R0m+7yMnJirBfUWuIzriMBd0azSgoDQMki+WNs15DxWXwzfcUHM7rH3SfeXAdw==
X-Received: by 2002:a1c:a548:: with SMTP id o69mr30725863wme.31.1575321003600; 
 Mon, 02 Dec 2019 13:10:03 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:10:03 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] arm: allwinner-h3: add Security Identifier device
Date: Mon,  2 Dec 2019 22:09:45 +0100
Message-Id: <20191202210947.3603-9-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Mon, 02 Dec 2019 16:38:25 -0500
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Security Identifier device in Allwinner H3 System on Chip
gives applications a per-board unique identifier. This commit
adds support for the Allwinner H3 Security Identifier using
randomized data as input.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/allwinner-h3.c              |  11 ++
 hw/misc/Makefile.objs              |   1 +
 hw/misc/allwinner-h3-sid.c         | 162 +++++++++++++++++++++++++++++
 hw/misc/trace-events               |   5 +
 include/hw/arm/allwinner-h3.h      |   2 +
 include/hw/misc/allwinner-h3-sid.h |  42 ++++++++
 6 files changed, 223 insertions(+)
 create mode 100644 hw/misc/allwinner-h3-sid.c
 create mode 100644 include/hw/misc/allwinner-h3-sid.h

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 44aba1de6a..4fc4c8c725 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -47,6 +47,9 @@ static void aw_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
                           TYPE_AW_H3_CPUCFG);
+
+    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
+                          TYPE_AW_H3_SID);
 }
 
 static void aw_h3_realize(DeviceState *dev, Error **errp)
@@ -206,6 +209,14 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, AW_H3_CPUCFG_BASE);
 
+    /* Security Identifier */
+    object_property_set_bool(OBJECT(&s->sid), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, AW_H3_SID_BASE);
+
     /* Universal Serial Bus */
     sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
                          s->irq[AW_H3_GIC_SPI_EHCI0]);
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c4ca2ed689..f3620eee4e 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
 obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-cpucfg.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-syscon.o
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sid.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
diff --git a/hw/misc/allwinner-h3-sid.c b/hw/misc/allwinner-h3-sid.c
new file mode 100644
index 0000000000..e13e0d9887
--- /dev/null
+++ b/hw/misc/allwinner-h3-sid.c
@@ -0,0 +1,162 @@
+/*
+ * Allwinner H3 Security ID emulation
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
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/guest-random.h"
+#include "qapi/error.h"
+#include "hw/misc/allwinner-h3-sid.h"
+
+/* SID register offsets */
+#define REG_PRCTL         (0x40) /* Control */
+#define REG_RDKEY         (0x60) /* Read Key */
+
+/* SID register flags */
+#define REG_PRCTL_WRITE   (0x2)  /* Unknown write flag */
+#define REG_PRCTL_OP_LOCK (0xAC) /* Lock operation */
+
+static uint64_t allwinner_h3_sid_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    const AwH3SidState *s = (AwH3SidState *)opaque;
+    uint64_t val = 0;
+
+    switch (offset) {
+    case REG_PRCTL:    /* Control */
+        val = s->control;
+        break;
+    case REG_RDKEY:    /* Read Key */
+        val = s->rdkey;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return val;
+}
+
+static void allwinner_h3_sid_write(void *opaque, hwaddr offset,
+                                      uint64_t val, unsigned size)
+{
+    AwH3SidState *s = (AwH3SidState *)opaque;
+
+    switch (offset) {
+    case REG_PRCTL:    /* Control */
+        s->control = val & ~(REG_PRCTL_WRITE);
+        if (!(s->control & REG_PRCTL_OP_LOCK)) {
+            uint32_t id = (s->control >> 16) / sizeof(uint32_t);
+            if (id < AW_H3_SID_NUM_IDS) {
+                s->rdkey = s->identifier[id];
+            }
+        }
+        break;
+    case REG_RDKEY:    /* Read Key */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_h3_sid_ops = {
+    .read = allwinner_h3_sid_read,
+    .write = allwinner_h3_sid_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    }
+};
+
+static void allwinner_h3_sid_reset(DeviceState *dev)
+{
+    AwH3SidState *s = AW_H3_SID(dev);
+    Error *err = NULL;
+
+    /* Set default values for registers */
+    s->control = 0;
+    s->rdkey = 0;
+
+    /* Initialize identifier data */
+    for (int i = 0; i < AW_H3_SID_NUM_IDS; i++) {
+        s->identifier[i] = 0;
+    }
+
+    if (qemu_guest_getrandom(s->identifier, sizeof(s->identifier), &err)) {
+        error_report_err(err);
+    }
+}
+
+static void allwinner_h3_sid_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void allwinner_h3_sid_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3SidState *s = AW_H3_SID(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_sid_ops, s,
+                          TYPE_AW_H3_SID, AW_H3_SID_REGS_MEM_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_h3_sid_vmstate = {
+    .name = TYPE_AW_H3_SID,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(control, AwH3SidState),
+        VMSTATE_UINT32(rdkey, AwH3SidState),
+        VMSTATE_UINT32_ARRAY(identifier, AwH3SidState, AW_H3_SID_NUM_IDS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_sid_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_sid_reset;
+    dc->realize = allwinner_h3_sid_realize;
+    dc->vmsd = &allwinner_h3_sid_vmstate;
+}
+
+static const TypeInfo allwinner_h3_sid_info = {
+    .name          = TYPE_AW_H3_SID,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_sid_init,
+    .instance_size = sizeof(AwH3SidState),
+    .class_init    = allwinner_h3_sid_class_init,
+};
+
+static void allwinner_h3_sid_register(void)
+{
+    type_register_static(&allwinner_h3_sid_info);
+}
+
+type_init(allwinner_h3_sid_register)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 1deb1d08c1..5d8a95816a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# allwinner-h3-cpucfg.c
+allwinner_h3_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t reset_addr) "H3-CPUCFG: cpu_reset: id %u, reset_addr 0x%08x"
+allwinner_h3_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "H3-CPUCFG: read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+allwinner_h3_cpucfg_write(uint64_t offset, uint64_t data, unsigned size) "H3-CPUCFG: write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
 ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 374061b550..33602599eb 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -29,6 +29,7 @@
 #include "hw/misc/allwinner-h3-clk.h"
 #include "hw/misc/allwinner-h3-cpucfg.h"
 #include "hw/misc/allwinner-h3-syscon.h"
+#include "hw/misc/allwinner-h3-sid.h"
 #include "target/arm/cpu.h"
 
 #define AW_H3_SRAM_A1_BASE     (0x00000000)
@@ -115,6 +116,7 @@ typedef struct AwH3State {
     AwH3ClockState ccu;
     AwH3CpuCfgState cpucfg;
     AwH3SysconState syscon;
+    AwH3SidState sid;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-sid.h b/include/hw/misc/allwinner-h3-sid.h
new file mode 100644
index 0000000000..359cc86dfc
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-sid.h
@@ -0,0 +1,42 @@
+/*
+ * Allwinner H3 Security ID emulation
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
+#ifndef HW_MISC_ALLWINNER_H3_SID_H
+#define HW_MISC_ALLWINNER_H3_SID_H
+
+#include "hw/sysbus.h"
+
+#define AW_H3_SID_NUM_IDS        (4)
+#define AW_H3_SID_REGS_MEM_SIZE  (1024)
+
+#define TYPE_AW_H3_SID    "allwinner-h3-sid"
+#define AW_H3_SID(obj)    OBJECT_CHECK(AwH3SidState, (obj), TYPE_AW_H3_SID)
+
+typedef struct AwH3SidState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t control;
+    uint32_t rdkey;
+    uint32_t identifier[AW_H3_SID_NUM_IDS];
+} AwH3SidState;
+
+#endif
-- 
2.17.1


