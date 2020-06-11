Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95616C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2C8206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dq5yOKPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2C8206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjVpt-00085Q-Kz
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 18:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lLDiXgsKCn0itljoofnpfohpphmf.dpnrfnv-efwfmopohov.psh@flex--hskinnemoen.bounces.google.com>)
 id 1jjVin-00048A-Cd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:53 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:48127)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lLDiXgsKCn0itljoofnpfohpphmf.dpnrfnv-efwfmopohov.psh@flex--hskinnemoen.bounces.google.com>)
 id 1jjVil-0004Co-GK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:30:53 -0400
Received: by mail-yb1-xb49.google.com with SMTP id y189so8340063ybc.14
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=z5aae+ulEUK36/+EU0k/QX5fzrntAEb4TfxbdpR4q+E=;
 b=Dq5yOKPsDL70LTwsJNsmbJzATvmIqQxoJwbKDgYFusQUAAcWBjh2AXW48dObXeKxoO
 uITiGsU+lDWrNkYN7EiwOknKgJveXEGqIA5CR/Mc4UfhSPuCGROHK+wvt0HDZ65hffxC
 GQuE37fq7rUh0maGsiXZwtm8yzB78P6xvK8MG4Y90+RmGbf/XoURsyhJHN8tPodOXEZD
 3zDiLPfZBQBOKxikn+SVXsKbAL5wSk0IGJhXsZ1oZDddNSwytV4BWBlIqtnx+KaW8UqM
 Q0//5pI8Nv5q6uBfQjgUVrU9/GHGQtNs9+erNNrM//1YCdXNkvmiwLlcpJdEr1KKyDys
 936g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=z5aae+ulEUK36/+EU0k/QX5fzrntAEb4TfxbdpR4q+E=;
 b=kaEUZLUTo8Ynlp7mKhy8ns0sb/EFn6p8IriS/UaFgEh0Dh5k32VXVP0FbWCpSMrTNu
 dBfO/s0XduX3k3jjRoLQf2lr0bXqGjr65VgbUch+1pj2J3X2dBU5lsHr4lBGnFr0NzrD
 ypwPTcb0ea0ewGc9rNDwlTOke5W7/fD6Ii5DuM7m4/nPEY6zrWbpqY1J5ZAaItyp6B89
 8I1PecXq56lX0c2k9goWtCj7jDxHA9T1IR39txMGQiDxlnMndIagJrTp3c7fvNILCeER
 y2pZgyF5a0smZaNIWJDtervy58mQK++5C01KrFy+mPX64Q1UwmeAAFIjWk+5IgoiUYUy
 BK0w==
X-Gm-Message-State: AOAM5331e+LfhAgsOz8WggNXrlrp7XzCXf3Dm3tuZOLjmh6yhtAO1xDp
 58iojinqLW6fG70gQH6mI4ApLidsPpf0AyRXew==
X-Google-Smtp-Source: ABdhPJwAScGXKu2uxz/Yexi0PPEqZ6SjWjH9Gvd5BBkmCxWQHqHGFysnrJ81KqA1tiv0WMQRPD0JFv94hpmUuGKVXg==
X-Received: by 2002:a25:d088:: with SMTP id
 h130mr18262495ybg.451.1591914644261; 
 Thu, 11 Jun 2020 15:30:44 -0700 (PDT)
Date: Thu, 11 Jun 2020 15:30:13 -0700
In-Reply-To: <20200611223016.259837-1-hskinnemoen@google.com>
Message-Id: <20200611223016.259837-10-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2 09/12] hw/mem: Stubbed out NPCM7xx Memory Controller model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3lLDiXgsKCn0itljoofnpfohpphmf.dpnrfnv-efwfmopohov.psh@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This just implements the bare minimum to cause the boot block to skip
memory intialization.

Change-Id: I26fd5f3b2af5d07a24911e7e58789f7b52f78d71
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 MAINTAINERS                 |  2 +
 hw/arm/npcm7xx.c            | 11 +++++
 hw/mem/Makefile.objs        |  1 +
 hw/mem/npcm7xx_mc.c         | 83 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/npcm7xx.h    |  2 +
 include/hw/mem/npcm7xx_mc.h | 35 ++++++++++++++++
 6 files changed, 134 insertions(+)
 create mode 100644 hw/mem/npcm7xx_mc.c
 create mode 100644 include/hw/mem/npcm7xx_mc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9814e7b4c4..9a289366ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -727,10 +727,12 @@ M: Tyrone Ting <kfting@nuvoton.com>
 L: qemu-arm@nongnu.org
 S: Supported
 F: hw/arm/npcm7xx*
+F: hw/mem/npcm7xx*
 F: hw/misc/npcm7xx*
 F: hw/nvram/npcm7xx*
 F: hw/timer/npcm7xx*
 F: include/hw/arm/npcm7xx*
+F: include/hw/mem/npcm7xx*
 F: include/hw/misc/npcm7xx*
 F: include/hw/nvram/npcm7xx*
 F: include/hw/timer/npcm7xx*
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index f9e3b5842b..54d84bafa1 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -46,6 +46,7 @@
 #define NPCM7XX_CPUP_BA         (0xF03FE000)
 #define NPCM7XX_GCR_BA          (0xF0800000)
 #define NPCM7XX_CLK_BA          (0xF0801000)
+#define NPCM7XX_MC_BA           (0xF0824000)
 
 /* Memory blocks at the end of the address space */
 #define NPCM7XX_RAM2_BA         (0xFFFD0000)
@@ -161,6 +162,8 @@ static void npcm7xx_init(Object *obj)
                           sizeof(s->key_storage), TYPE_NPCM7XX_KEY_STORAGE);
     sysbus_init_child_obj(obj, "otp2", OBJECT(&s->fuse_array),
                           sizeof(s->fuse_array), TYPE_NPCM7XX_FUSE_ARRAY);
+    sysbus_init_child_obj(obj, "mc", OBJECT(&s->mc), sizeof(s->mc),
+                          TYPE_NPCM7XX_MC);
 
     for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
         sysbus_init_child_obj(obj, "tim[*]", OBJECT(&s->tim[i]),
@@ -258,6 +261,14 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM7XX_OTP2_BA);
     npcm7xx_init_fuses(s);
 
+    /* Fake Memory Controller (MC) */
+    object_property_set_bool(OBJECT(&s->mc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mc), 0, NPCM7XX_MC_BA);
+
     /* Timer Modules (TIM) */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
     for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index 56345befd0..9a33ef7b35 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,3 +1,4 @@
 common-obj-$(CONFIG_DIMM) += pc-dimm.o
 common-obj-y += memory-device.o
+common-obj-$(CONFIG_NPCM7XX) += npcm7xx_mc.o
 common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/hw/mem/npcm7xx_mc.c b/hw/mem/npcm7xx_mc.c
new file mode 100644
index 0000000000..03a7fb53dc
--- /dev/null
+++ b/hw/mem/npcm7xx_mc.c
@@ -0,0 +1,83 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/mem/npcm7xx_mc.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#define NPCM7XX_MC_REGS_SIZE (4 * KiB)
+
+static uint64_t npcm7xx_mc_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    /*
+     * If bits 8..11 @ offset 0 are not zero, the boot block thinks the memory
+     * controller has already been initialized and will skip DDR training.
+     */
+    if (addr == 0) {
+        return 0x100;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+
+    return 0;
+}
+
+static void npcm7xx_mc_write(void *opaque, hwaddr addr, uint64_t v,
+                             unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+}
+
+static const MemoryRegionOps npcm7xx_mc_ops = {
+    .read = npcm7xx_mc_read,
+    .write = npcm7xx_mc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm7xx_mc_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxMCState *s = NPCM7XX_MC(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &npcm7xx_mc_ops, s, "regs",
+                          NPCM7XX_MC_REGS_SIZE);
+    sysbus_init_mmio(&s->parent, &s->mmio);
+}
+
+static void npcm7xx_mc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx Memory Controller stub";
+    dc->realize = npcm7xx_mc_realize;
+}
+
+static const TypeInfo npcm7xx_mc_types[] = {
+    {
+        .name = TYPE_NPCM7XX_MC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCM7xxMCState),
+        .class_init = npcm7xx_mc_class_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_mc_types);
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 360cd965a7..8f49f7015c 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -17,6 +17,7 @@
 
 #include "hw/boards.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/nvram/npcm7xx_otp.h"
@@ -65,6 +66,7 @@ typedef struct NPCM7xxState {
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxOTPState     key_storage;
     NPCM7xxOTPState     fuse_array;
+    NPCM7xxMCState      mc;
 } NPCM7xxState;
 
 #define TYPE_NPCM7XX    "npcm7xx"
diff --git a/include/hw/mem/npcm7xx_mc.h b/include/hw/mem/npcm7xx_mc.h
new file mode 100644
index 0000000000..8781f5c979
--- /dev/null
+++ b/include/hw/mem/npcm7xx_mc.h
@@ -0,0 +1,35 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef NPCM7XX_MC_H
+#define NPCM7XX_MC_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/**
+ * struct NPCM7xxMCState - Device state for the memory controller.
+ * @parent: System bus device.
+ * @mmio: Memory region through which registers are accessed.
+ */
+typedef struct NPCM7xxMCState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+} NPCM7xxMCState;
+
+#define TYPE_NPCM7XX_MC "npcm7xx-mc"
+#define NPCM7XX_MC(obj) OBJECT_CHECK(NPCM7xxMCState, (obj), TYPE_NPCM7XX_MC)
+
+#endif /* NPCM7XX_MC_H */
-- 
2.27.0.290.gba653c62da-goog


