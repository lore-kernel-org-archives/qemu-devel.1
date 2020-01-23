Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC027C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E6E24673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNPTnF9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E6E24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQJq-0001GI-Mw
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzg-0002Hi-KX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzX-0002KK-OO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzX-0002Jw-Ha
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so617442pfn.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Yoj9Ef3PvobNNzt7Mf8CoMZH4vxGIaCLIOj2GwlEFM=;
 b=dNPTnF9zEaYZbnlx9Ct88GAB0is7fVBD5d+DOy9ktdvYkKh/ANHlbv+5zKsnQpxLtw
 QFf8bksfs1OLqzgACS0faP8BpoAmZT/vhiGpcoQzzKyJXzXXbmupyx+cE8KWOZijYtsp
 QtbSg2NBIL7FT6ixSAiB4ruzubGYvm3T5e2i71bJWm3i/qByLY6yceZd6uVYjFMQs5aW
 1swWSszHg7RTGnMS23KavHKywNy08DrdSMNxfOSRmB9N2sOLPTxP60Zz8mkngc9G3yI7
 ky3c3KZMkZqZgtanMP3fGeNhn8/khpspQJMnrMPgypB6T44/7H0gSDK5VIoMIkDmKtdW
 7EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Yoj9Ef3PvobNNzt7Mf8CoMZH4vxGIaCLIOj2GwlEFM=;
 b=G9R51LMRKaNyJotbw+V9tg/3TY9FEt24fIBqUfbfSOoIYNdxFFTH/qq7p8aICC34rm
 FKzbRF7dGy81NBGWZtDPFU307j8tUDZ2WPgcZIUN3cyqY4GYL0Hsoc3flk91D8lLjS5o
 J41B8+7QJtIzYpQ1UpiYC+K3wDpahKyMFYLzys5hRiBrvWuKtV/0Evo6T9l7AaEvo0Yn
 d93voD3WxIc9LwDi433jSquxHBUzyQDho7RQceo6zp2ZSjcsckOAZqVrfK0SwnR1iNnb
 4FGLWf1bdIcAhTp5A/hitPRpoYUqUehMbGN1LJWhyB1uef8hLqiTHsya4RIg8f/z4XBd
 znOQ==
X-Gm-Message-State: APjAAAV4bEa65MKelPVhquQfNuzOBD2UYaSAhOynQo7rEKSu3MWw/Y/I
 AFQ6w/oiHR9LHabiFa9TLNzXC/UWO0I=
X-Google-Smtp-Source: APXvYqyYk9tpvrdPO+53VNYEZyKMKzqC6lTZQ13jPnRVALpacDI5ZD1EHsQfmyiYXCA0kee7nbof8A==
X-Received: by 2002:a65:68ca:: with SMTP id k10mr932404pgt.222.1579737838231; 
 Wed, 22 Jan 2020 16:03:58 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 20/24] hw/avr: Add some Arduino boards
Date: Wed, 22 Jan 2020 14:03:03 -1000
Message-Id: <20200123000307.11541-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Arduino boards are build with AVR chipsets.
Add some of the popular boards:

- Arduino Duemilanove
- Arduino Uno
- Arduino Mega

For more information:
  https://www.arduino.cc/en/Main/Products
  https://store.arduino.cc/arduino-genuino/most-popular

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200120220107.17825-15-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/arduino.c     | 175 +++++++++++++++++++++++++++++++++++++++++++
 hw/avr/Kconfig       |   4 +
 hw/avr/Makefile.objs |   1 +
 3 files changed, 180 insertions(+)
 create mode 100644 hw/avr/arduino.c

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
new file mode 100644
index 0000000000..784246baba
--- /dev/null
+++ b/hw/avr/arduino.c
@@ -0,0 +1,175 @@
+/*
+ * QEMU Arduino boards
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* TODO: Implement the use of EXTRAM */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "atmel_atmega.h"
+
+typedef struct ArduinoMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    AtmegaMcuState mcu;
+} ArduinoMachineState;
+
+typedef struct ArduinoMachineClass {
+    /*< private >*/
+    MachineClass parent_class;
+    /*< public >*/
+    const char *mcu_type;
+    uint64_t xtal_hz;
+} ArduinoMachineClass;
+
+#define TYPE_ARDUINO_MACHINE \
+        MACHINE_TYPE_NAME("arduino")
+#define ARDUINO_MACHINE(obj) \
+        OBJECT_CHECK(ArduinoMachineState, (obj), TYPE_ARDUINO_MACHINE)
+#define ARDUINO_MACHINE_CLASS(klass) \
+        OBJECT_CLASS_CHECK(ArduinoMachineClass, (klass), TYPE_ARDUINO_MACHINE)
+#define ARDUINO_MACHINE_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(ArduinoMachineClass, (obj), TYPE_ARDUINO_MACHINE)
+
+static void load_firmware(const char *firmware, uint64_t flash_size)
+{
+    const char *filename;
+    int bytes_loaded;
+
+    /* Load firmware (contents of flash) trying to auto-detect format */
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+    if (filename == NULL) {
+        error_report("Unable to find %s", firmware);
+        exit(1);
+    }
+
+    bytes_loaded = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL,
+                            0, EM_NONE, 0, 0);
+    if (bytes_loaded < 0) {
+        bytes_loaded = load_image_targphys(filename, OFFSET_CODE, flash_size);
+    }
+    if (bytes_loaded < 0) {
+        error_report("Unable to load firmware image %s as ELF or raw binary",
+                     firmware);
+        exit(1);
+    }
+}
+
+static void arduino_machine_init(MachineState *machine)
+{
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_GET_CLASS(machine);
+    ArduinoMachineState *ams = ARDUINO_MACHINE(machine);
+
+    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof(ams->mcu),
+                          amc->mcu_type);
+    object_property_set_uint(OBJECT(&ams->mcu), amc->xtal_hz,
+                             "xtal-frequency-hz", &error_abort);
+    object_property_set_bool(OBJECT(&ams->mcu), true, "realized",
+                             &error_abort);
+
+    if (machine->firmware) {
+        load_firmware(machine->firmware, memory_region_size(&ams->mcu.flash));
+    }
+}
+
+static void arduino_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = arduino_machine_init;
+    mc->default_cpus = 1;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_parallel = 1;
+}
+
+static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
+    mc->desc        = "Arduino Duemilanove (ATmega168)",
+    mc->alias       = "2009";
+    amc->mcu_type   = TYPE_ATMEGA168_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000;
+};
+
+static void arduino_uno_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://store.arduino.cc/arduino-uno-rev3 */
+    mc->desc        = "Arduino UNO (ATmega328P)";
+    mc->alias       = "uno";
+    amc->mcu_type   = TYPE_ATMEGA328_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000;
+};
+
+static void arduino_mega_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
+    mc->desc        = "Arduino Mega (ATmega1280)";
+    mc->alias       = "mega";
+    amc->mcu_type   = TYPE_ATMEGA1280_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000;
+};
+
+static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://store.arduino.cc/arduino-mega-2560-rev3 */
+    mc->desc        = "Arduino Mega 2560 (ATmega2560)";
+    mc->alias       = "mega2560";
+    mc->is_default  = true;
+    amc->mcu_type   = TYPE_ATMEGA2560_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
+};
+
+static const TypeInfo arduino_machine_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("arduino-duemilanove"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_duemilanove_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("arduino-uno"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_uno_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("arduino-mega"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_mega_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_mega2560_class_init,
+    }, {
+        .name           = TYPE_ARDUINO_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(ArduinoMachineState),
+        .class_size     = sizeof(ArduinoMachineClass),
+        .class_init     = arduino_machine_class_init,
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(arduino_machine_types)
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index da3b10afec..59d9649d27 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -3,3 +3,7 @@ config ATMEL_ATMEGA_MCU
     select ATMEL_TIMER16
     select ATMEL_USART
     select ATMEL_POWER
+
+config ARDUINO
+    select ATMEL_ATMEGA_MCU
+    select UNIMP
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 7c7a4c3f67..f6aab1438d 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1 +1,2 @@
 obj-$(CONFIG_ATMEL_ATMEGA_MCU) += atmel_atmega.o
+obj-$(CONFIG_ARDUINO) += arduino.o
-- 
2.20.1


