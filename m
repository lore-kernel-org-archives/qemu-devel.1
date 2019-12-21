Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE50C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160CD206D3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWYD8I/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160CD206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTHP-0005SV-AC
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAN-0002V3-Jk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAL-0006fy-SR
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:47 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAL-0006bb-JH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:45 -0500
Received: by mail-wm1-x344.google.com with SMTP id 20so10820304wmj.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jEWOWsDNpA+QuC5gOHidbYVbCm1raMtNvR7n6dT4QJ4=;
 b=aWYD8I/9Q+5quXrXoYafplHOiSSJst5nWJIATWMdUbZDZGxxl4CkpqQFxB4omyWmGy
 OzcTT3OFk4ogNJUSjBnyTduTTmXGz7isvA+jDR4Ge0rqJ8EDD5cKi/CSKVexMm5ChUgZ
 bZNVXyn1B6kBcgirZE87L3UkHG5VsIuRuSIxf8qdDeKkphB/CQqb1/9wCYII0ACIJfi6
 ZCyE/A3TOHPrEXrcbRIc2eiPmvvuQVpavCTpvSZHbedtyQWBJs7hTXYg/yEPVK9FT5HD
 u03mP+4IsJY0yxXm+qM59q+GS/2lkJFEm5P3V2vXVfBT70b5qA9wI+6R0skW+hM+GDZO
 ArdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jEWOWsDNpA+QuC5gOHidbYVbCm1raMtNvR7n6dT4QJ4=;
 b=GFzGjbqnvqe3/y36QWrOl+29bm/1Lj9kVLAG7+ZIYdmjkGWdbs/PLc3QyCBIK8PhHk
 Q2ZpqiNBEMAh8uten+2VP3gLGOiuDt+JwyEP8rbuMyy7mwXvO+np1QUELbaPl/qaYuzT
 8wzVa1LLDvXOnYBtNeZY1nfSH8xiZ7WfpyOaECTNE2I4gLVsaVAP8Vifh1K+Sfjgp8Mv
 RMyk8aoqzNGSRH7xMxZKZqV0Qf6i3zxnPaVaFVJtpO/3tiWcyWd9dRQs+WCj3P64rkc0
 7EJjdZUkYavkNMn0JIwaNx6YQOoHlJY3p0Vmhw9vzINVkB8fKjOPp/3addVAuI72xZkp
 Ob9Q==
X-Gm-Message-State: APjAAAV9aMO5iKAvTsv5cNJ3pB67U7CaYzu4yETXooWFPKDS1mM7kDEi
 ZG6jlh5M+1pSfZpZ2TvltvRVZH+2
X-Google-Smtp-Source: APXvYqy8UJ1QIAB5bI9KQDx5bl4wuiisXUA+VApG9i2FHf/oDObjxtHIKko/yGMd248OIcYDLJ5j/A==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr18416472wml.176.1576890164331; 
 Fri, 20 Dec 2019 17:02:44 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm8449596wmf.17.2019.12.20.17.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 17:02:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 4/8] hw/avr: Add some Arduino boards
Date: Sat, 21 Dec 2019 02:02:22 +0100
Message-Id: <20191221010226.9230-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191221010226.9230-1-f4bug@amsat.org>
References: <20191221010226.9230-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>,
 Phillip Stevens <phillip.stevens@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Arduino boards are build with AVR chipsets.
Add some of the popular boards:

- Arduino Duemilanove
- Arduino Uno
- Arduino Mega

For more information:
  https://www.arduino.cc/en/Main/Products
  https://store.arduino.cc/arduino-genuino/most-popular

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2:
- Reword description adding more information (Aleksandar)
- Use DEFINE_TYPES (Igor)

Cc: Phillip Stevens <phillip.stevens@gmail.com> (for FreeRTOS example)
Cc: Igor Mammedov <imammedo@redhat.com>
---
 hw/avr/arduino.c     | 177 +++++++++++++++++++++++++++++++++++++++++++
 hw/avr/Makefile.objs |   1 +
 2 files changed, 178 insertions(+)
 create mode 100644 hw/avr/arduino.c

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
new file mode 100644
index 0000000000..ecaaa295d8
--- /dev/null
+++ b/hw/avr/arduino.c
@@ -0,0 +1,177 @@
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
+#include "atmega.h"
+
+typedef struct ArduinoMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    AtmegaMcuState mcu;
+    MemoryRegion extram;
+} ArduinoMachineState;
+
+typedef struct ArduinoMachineClass {
+    /*< private >*/
+    MachineClass parent_class;
+    /*< public >*/
+    const char *mcu_type;
+    uint64_t xtal_hz;
+    size_t extram_size;
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
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 4b6b911820..39ee3c32b2 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y += sample.o
 obj-y += atmega.o
+obj-y += arduino.o
-- 
2.21.0


