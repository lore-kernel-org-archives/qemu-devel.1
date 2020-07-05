Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3B8C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF09920724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF09920724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5NB-0006Eo-Uz
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FE-0007fI-2t
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FB-0008Kc-1s
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id e22so32237859edq.8
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KWm9PZSzGSkYjcloy35d8SPArCw3VC4k2dSqRIJb5II=;
 b=RcXm6LCD1xqH3oLpn3Z3Wkdf4wJcwDXUL5ivjpzmmGHuHXWAxQuZQDEXWDbUFfmpTU
 re42Z4iWuOIng02VnKFKfMsezVXgmwpGoG+2ibCWwvN0LwYrfFBdwPT3sAmmNteeZEwX
 4YaS0CqMg4jaTsi0BAEcxCdrqQXExxPaNPpOT8ldPfgeUQQa1EA4bc5iG5d2CATZRZ9b
 ENBHGB7W6dyIDAcuUAbqhKtXnQDvIlBd21Hb3dZDzqjmQuq605R9olw02Xf+INpB6EHa
 XneMKBW5XFV3RlNg+/9fBxE/0886vWIyc7XJGGXkl7pHEEZQAu2QS55Vf/xCmh74QtTF
 azsQ==
X-Gm-Message-State: AOAM531xFd/ExYwgY/05QGoMdupU/n6m5g+CRk8kjBsSDpCXXeMDJu2I
 M2fh15+xP1OPrMnYu2XmZLRWbn3B
X-Google-Smtp-Source: ABdhPJxjWLBHM6Sl60hnPlQrLD8N7I1hIF1GKQQhhay8fCNHV4soOtAqe6olixDS8QzxBTuMqNYXfQ==
X-Received: by 2002:a05:6402:947:: with SMTP id
 h7mr50837162edz.213.1593957823297; 
 Sun, 05 Jul 2020 07:03:43 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:43 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 21/30] hw/misc: avr: Add limited support for power
 reduction device
Date: Sun,  5 Jul 2020 16:03:06 +0200
Message-Id: <20200705140315.260514-22-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.66; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This is a simple device of just one register, and whenever this
register is written to it calls qemu_set_irq function for each
of 8 bits/IRQs. It is used to implement AVR Power Reduction.

[AM: Remove word 'Atmel' from filenames and all elements of code]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash include fix and file rename from f4bug]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS                 |   2 +
 hw/misc/Kconfig             |   3 +
 hw/misc/Makefile.objs       |   2 +
 hw/misc/avr_power.c         | 113 ++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events        |   4 ++
 include/hw/misc/avr_power.h |  46 +++++++++++++++
 6 files changed, 170 insertions(+)
 create mode 100644 hw/misc/avr_power.c
 create mode 100644 include/hw/misc/avr_power.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b1714fac96..5b5f831cd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -986,6 +986,8 @@ F: include/hw/char/avr_usart.h
 F: hw/char/avr_usart.c
 F: include/hw/timer/avr_timer16.h
 F: hw/timer/avr_timer16.c
+F: include/hw/misc/avr_power.h
+F: hw/misc/avr_power.c
 
 CRIS Machines
 -------------
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bdd77d8020..92c397ca07 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -131,4 +131,7 @@ config MAC_VIA
     select MOS6522
     select ADB
 
+config AVR_POWER
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 5aaca8a039..6be3d255ab 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -91,3 +91,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+
+obj-$(CONFIG_AVR_POWER) += avr_power.o
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
new file mode 100644
index 0000000000..65ff7c4405
--- /dev/null
+++ b/hw/misc/avr_power.c
@@ -0,0 +1,113 @@
+/*
+ * AVR Power Reduction Management
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
+#include "hw/misc/avr_power.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/irq.h"
+#include "trace.h"
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
+    trace_avr_power_read(s->val);
+
+    return (uint64_t)s->val;
+}
+
+static void avr_mask_write(void *opaque, hwaddr offset,
+                           uint64_t val64, unsigned size)
+{
+    assert(size == 1);
+    assert(offset == 0);
+    AVRMaskState *s = opaque;
+    uint8_t val8 = val64;
+
+    trace_avr_power_write(val8);
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
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static void avr_mask_init(Object *dev)
+{
+    AVRMaskState *s = AVR_MASK(dev);
+    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MASK,
+                          0x01);
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
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ebea53735c..066752aa90 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -19,6 +19,10 @@ allwinner_h3_dramphy_write(uint64_t offset, uint64_t data, unsigned size) "write
 allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 
+# avr_power.c
+avr_power_read(uint8_t value) "power_reduc read value:%u"
+avr_power_write(uint8_t value) "power_reduc write value:%u"
+
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
 ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
diff --git a/include/hw/misc/avr_power.h b/include/hw/misc/avr_power.h
new file mode 100644
index 0000000000..434ac23a3c
--- /dev/null
+++ b/include/hw/misc/avr_power.h
@@ -0,0 +1,46 @@
+/*
+ * AVR Power Reduction Management
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
+#ifndef HW_MISC_AVR_POWER_H
+#define HW_MISC_AVR_POWER_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+
+#define TYPE_AVR_MASK "avr-power"
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
+#endif /* HW_MISC_AVR_POWER_H */
-- 
2.26.2


