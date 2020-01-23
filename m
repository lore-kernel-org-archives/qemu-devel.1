Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE554C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845CB24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS20t6/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845CB24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQE1-00029f-62
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzZ-0002Ez-3F
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzQ-0002Fg-Ge
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzP-00029U-Pb
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:52 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so339785pjb.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vs60aoSCxThMWMdjWw9zdb8Uf19MDiz8amIUcr0Cikg=;
 b=NS20t6/oHsx4VBMvWWeH09BIXp9W6pqUP0TeqNcyRGC/jegmy5dXwgo6ordxmUy0MA
 5USBo+lUkSJBUhRqnS8sWVECckxFsD7FEARYzExHXu2obT0hE3OQzdLxlqHHNTEQ9FgK
 v6dCe+ErgeQ6Iu4CsYljXEbzg4oNlbi9qTDXAHeceRkFUZYwzCiEQ/OzdMeeUWR+4Dsv
 iP3aPDtl1hCNrRkXQzB5Epc2OkdMUOszRaBMNa+8VTbkIwe0r5PSV9LdkehUkgUDyu9d
 fthaN6w8cPqp6QefTVKaJeKY5P/4iJslo3s5Umfhf4iq6VcDTogXtHOl+SArGeLzMdUT
 wf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vs60aoSCxThMWMdjWw9zdb8Uf19MDiz8amIUcr0Cikg=;
 b=UqpqwebjNtXwE8uN6FElw3PRQV3yJUrxSvtr0HzlFQ9qtdKeeiqHmtXFoIf9WH0krT
 FphytxHuwKbckmwuj3agkqFYcLcEngQ/VkDfHQDOc5P06FBjZjSOm6iQ3Dm/NScrQVtU
 4rYl+Y4/i6WpIocsXoiIMbIe0rEdLpXTnOKukd4sXjYNuVjwItOdaw+Qk6rEztWfZuP0
 jyx3TxUL5su/nCM0+gtmHCaR1jmYaH3jsIIRuKTmWEW7/uyhZFiEzW2TJQ8YWvvOC2lu
 bbChLT5SQ2Gj7+H/QktcVbCSM1zqWxat475VB/rovG4DpjgXpw6hMrMR1BXFtBT8l3zL
 O95g==
X-Gm-Message-State: APjAAAW1vMEecRadcMqqopmZ/XMD6yfOeBGHiANK28j8k8gCfa4jDblV
 hwRvTAuc0EpmysDvyvjmfO41wq5NXE8=
X-Google-Smtp-Source: APXvYqwuSpwhAWkU7zQy/V2xnQg7fv3Cff1cXy6ssPiefStiSJ+PX20Tkuz1Z0uITp0g1tJFgDSuvQ==
X-Received: by 2002:a17:90a:b009:: with SMTP id
 x9mr1242899pjq.124.1579737822244; 
 Wed, 22 Jan 2020 16:03:42 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 13/24] hw/misc: Add Atmel power device
Date: Wed, 22 Jan 2020 14:02:56 -1000
Message-Id: <20200123000307.11541-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.216.65
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This is a simple device of just one register, whenver this register is
written it calls qemu_set_irq function for each of 8 bits/IRQs..
It is used to implement AVR Power Reduction

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20200118191416.19934-14-mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash include fix and file rename from f4bug, which was:]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/misc/atmel_power.h |  46 ++++++++++++++
 hw/misc/atmel_power.c         | 112 ++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig               |   3 +
 hw/misc/Makefile.objs         |   2 +
 4 files changed, 163 insertions(+)
 create mode 100644 include/hw/misc/atmel_power.h
 create mode 100644 hw/misc/atmel_power.c

diff --git a/include/hw/misc/atmel_power.h b/include/hw/misc/atmel_power.h
new file mode 100644
index 0000000000..5366e9693f
--- /dev/null
+++ b/include/hw/misc/atmel_power.h
@@ -0,0 +1,46 @@
+/*
+ * Atmel AVR Power Reduction Management
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_MISC_ATMEL_POWER_H
+#define HW_MISC_ATMEL_POWER_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+
+#define TYPE_AVR_MASK "atmel-power"
+#define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+
+    uint8_t val;
+    qemu_irq irq[8];
+} AVRMaskState;
+
+#endif /* HW_MISC_ATMEL_POWER_H */
diff --git a/hw/misc/atmel_power.c b/hw/misc/atmel_power.c
new file mode 100644
index 0000000000..adab729f66
--- /dev/null
+++ b/hw/misc/atmel_power.c
@@ -0,0 +1,112 @@
+/*
+ * Atmel AVR Power Reduction Management
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/atmel_power.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/irq.h"
+
+#define DB_PRINT(fmt, args...) /* Nothing */
+/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## args)*/
+
+static void avr_mask_reset(DeviceState *dev)
+{
+    AVRMaskState *s = AVR_MASK(dev);
+
+    s->val = 0x00;
+
+    for (int i = 0; i < 8; i++) {
+        qemu_set_irq(s->irq[i], 0);
+    }
+}
+
+static uint64_t avr_mask_read(void *opaque, hwaddr offset, unsigned size)
+{
+    assert(size == 1);
+    assert(offset == 0);
+    AVRMaskState *s = opaque;
+
+    return (uint64_t)s->val;
+}
+
+static void avr_mask_write(void *opaque, hwaddr offset,
+                              uint64_t val64, unsigned size)
+{
+    assert(size == 1);
+    assert(offset == 0);
+    AVRMaskState *s = opaque;
+    uint8_t val8 = val64;
+
+    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
+
+    s->val = val8;
+    for (int i = 0; i < 8; i++) {
+        qemu_set_irq(s->irq[i], (val8 & (1 << i)) != 0);
+    }
+}
+
+static const MemoryRegionOps avr_mask_ops = {
+    .read = avr_mask_read,
+    .write = avr_mask_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = 1}
+};
+
+static void avr_mask_init(Object *dev)
+{
+    AVRMaskState *s = AVR_MASK(dev);
+    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MASK,
+            0x01);
+    sysbus_init_mmio(busdev, &s->iomem);
+
+    for (int i = 0; i < 8; i++) {
+        sysbus_init_irq(busdev, &s->irq[i]);
+    }
+    s->val = 0x00;
+}
+
+static void avr_mask_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = avr_mask_reset;
+}
+
+static const TypeInfo avr_mask_info = {
+    .name          = TYPE_AVR_MASK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AVRMaskState),
+    .class_init    = avr_mask_class_init,
+    .instance_init = avr_mask_init,
+};
+
+static void avr_mask_register_types(void)
+{
+    type_register_static(&avr_mask_info);
+}
+
+type_init(avr_mask_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bdd77d8020..3a3c32e1b0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -131,4 +131,7 @@ config MAC_VIA
     select MOS6522
     select ADB
 
+config ATMEL_POWER
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index da993f45b7..e605964f4b 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -85,3 +85,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+
+obj-$(CONFIG_ATMEL_POWER) += atmel_power.o
-- 
2.20.1


