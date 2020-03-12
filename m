Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2CEC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DF2206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qf51imgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DF2206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR7l-00024x-1y
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxU-0008U9-Sv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxS-00058U-3d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxR-000589-Py
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:18 -0400
Received: by mail-wr1-x431.google.com with SMTP id 6so8368449wre.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wjCJGzvnJTAqZZwBx08tIwG4nUkxfLn6g8X74yhhnmE=;
 b=qf51imghGbysB+pnLaPmPN/kX06Qn32SrMi48QOTfNzCqbDqzVugFDXdepREuUIdc8
 5svR/RRsnUpGjdu8MpLR31eX+zOtYqcgN/YkJPqiami0WFZabUkQrFDv16HsaXV2HBzu
 gUyYJfKdX8gqfwdtF6OaYdv3AEokg6S69kCDJP/iAQ+jI0hRiioi0KAaPd50wvViENnx
 C902NLK3ifk08Scvqs0KJEPPJQ/ECEcfacW39EHPt8nTHUSe0xOZimZbdGW1jowSrf0o
 P9yy9J1w3bG8XsbPxWdS6P/s1M5/1rCmGWlpF/cPzubfxJimSE7rAuGWY3kweoFKcCOy
 3y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wjCJGzvnJTAqZZwBx08tIwG4nUkxfLn6g8X74yhhnmE=;
 b=uoU/UBH/E15Vc2jqpk0dCigRVewhmJBCaAMD+YDMGO54Q8j7TkHxQ9tKNS/NqP42vH
 KBnsrZDX+JvNEcfsiHHMqk+7aieEB5Dv5Q3WKLI4TlB6IaZYu48dHjxtxzEGtZzFCIMp
 okYUZkJlzhiij0pFtGnkEO+8SudaKFfhrdZ5eDadfJ5/u6dlKZZOkabKvDn14JB6xqJl
 Z2sRv0bu8xVBJIK13+Kagn+hb1Rs1iPh64xYKZNC7I0EEnyA5Oq0rm6BL/LG8TTYNrLg
 +VhChJAAkLREsafxYIXl9I0T/GzlBbruZzdblKadZA3bdvVpd+feGfMeJXsttN/OhWzA
 e9zg==
X-Gm-Message-State: ANhLgQ0XG8isrNTm6gHROh2bS6OxOHEQT9qG8d0b4igbmWYAlbHlHQRP
 MVrtgm4XAjJRUBIKNOoIrKkvk21jJsOE+A==
X-Google-Smtp-Source: ADFU+vvaXX0EZvKqVAf8rgNbmQ9O4kWW2GPEJzkoB0kJ6A37BISM9QGD/6vqyMQ7GqRjqvf5Rl3yIw==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr11671761wrr.82.1584031515637; 
 Thu, 12 Mar 2020 09:45:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/36] hw/arm: add Allwinner H3 System-on-Chip
Date: Thu, 12 Mar 2020 16:44:35 +0000
Message-Id: <20200312164459.25924-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

The Allwinner H3 is a System on Chip containing four ARM Cortex A7
processor cores. Features and specifications include DDR2/DDR3 memory,
SD/MMC storage cards, 10/100/1000Mbit Ethernet, USB 2.0, HDMI and
various I/O modules. This commit adds support for the Allwinner H3
System on Chip.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200311221854.30370-2-nieklinnenbank@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs            |   1 +
 include/hw/arm/allwinner-h3.h   | 106 +++++++++++
 hw/arm/allwinner-h3.c           | 327 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   7 +
 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Kconfig                  |   8 +
 6 files changed, 450 insertions(+)
 create mode 100644 include/hw/arm/allwinner-h3.h
 create mode 100644 hw/arm/allwinner-h3.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 336f6dd3749..ae577e875fd 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -35,6 +35,7 @@ obj-$(CONFIG_DIGIC) += digic.o
 obj-$(CONFIG_OMAP) += omap1.o omap2.o
 obj-$(CONFIG_STRONGARM) += strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
+obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
new file mode 100644
index 00000000000..2aac9b78ecf
--- /dev/null
+++ b/include/hw/arm/allwinner-h3.h
@@ -0,0 +1,106 @@
+/*
+ * Allwinner H3 System on Chip emulation
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
+/*
+ * The Allwinner H3 is a System on Chip containing four ARM Cortex A7
+ * processor cores. Features and specifications include DDR2/DDR3 memory,
+ * SD/MMC storage cards, 10/100/1000Mbit Ethernet, USB 2.0, HDMI and
+ * various I/O modules.
+ *
+ * This implementation is based on the following datasheet:
+ *
+ *   https://linux-sunxi.org/File:Allwinner_H3_Datasheet_V1.2.pdf
+ *
+ * The latest datasheet and more info can be found on the Linux Sunxi wiki:
+ *
+ *   https://linux-sunxi.org/H3
+ */
+
+#ifndef HW_ARM_ALLWINNER_H3_H
+#define HW_ARM_ALLWINNER_H3_H
+
+#include "qom/object.h"
+#include "hw/arm/boot.h"
+#include "hw/timer/allwinner-a10-pit.h"
+#include "hw/intc/arm_gic.h"
+#include "target/arm/cpu.h"
+
+/**
+ * Allwinner H3 device list
+ *
+ * This enumeration is can be used refer to a particular device in the
+ * Allwinner H3 SoC. For example, the physical memory base address for
+ * each device can be found in the AwH3State object in the memmap member
+ * using the device enum value as index.
+ *
+ * @see AwH3State
+ */
+enum {
+    AW_H3_SRAM_A1,
+    AW_H3_SRAM_A2,
+    AW_H3_SRAM_C,
+    AW_H3_PIT,
+    AW_H3_UART0,
+    AW_H3_UART1,
+    AW_H3_UART2,
+    AW_H3_UART3,
+    AW_H3_GIC_DIST,
+    AW_H3_GIC_CPU,
+    AW_H3_GIC_HYP,
+    AW_H3_GIC_VCPU,
+    AW_H3_SDRAM
+};
+
+/** Total number of CPU cores in the H3 SoC */
+#define AW_H3_NUM_CPUS      (4)
+
+/**
+ * Allwinner H3 object model
+ * @{
+ */
+
+/** Object type for the Allwinner H3 SoC */
+#define TYPE_AW_H3 "allwinner-h3"
+
+/** Convert input object to Allwinner H3 state object */
+#define AW_H3(obj) OBJECT_CHECK(AwH3State, (obj), TYPE_AW_H3)
+
+/** @} */
+
+/**
+ * Allwinner H3 object
+ *
+ * This struct contains the state of all the devices
+ * which are currently emulated by the H3 SoC code.
+ */
+typedef struct AwH3State {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    ARMCPU cpus[AW_H3_NUM_CPUS];
+    const hwaddr *memmap;
+    AwA10PITState timer;
+    GICState gic;
+    MemoryRegion sram_a1;
+    MemoryRegion sram_a2;
+    MemoryRegion sram_c;
+} AwH3State;
+
+#endif /* HW_ARM_ALLWINNER_H3_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
new file mode 100644
index 00000000000..7958f376852
--- /dev/null
+++ b/hw/arm/allwinner-h3.c
@@ -0,0 +1,327 @@
+/*
+ * Allwinner H3 System on Chip emulation
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
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/qdev-core.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/misc/unimp.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/allwinner-h3.h"
+
+/* Memory map */
+const hwaddr allwinner_h3_memmap[] = {
+    [AW_H3_SRAM_A1]    = 0x00000000,
+    [AW_H3_SRAM_A2]    = 0x00044000,
+    [AW_H3_SRAM_C]     = 0x00010000,
+    [AW_H3_PIT]        = 0x01c20c00,
+    [AW_H3_UART0]      = 0x01c28000,
+    [AW_H3_UART1]      = 0x01c28400,
+    [AW_H3_UART2]      = 0x01c28800,
+    [AW_H3_UART3]      = 0x01c28c00,
+    [AW_H3_GIC_DIST]   = 0x01c81000,
+    [AW_H3_GIC_CPU]    = 0x01c82000,
+    [AW_H3_GIC_HYP]    = 0x01c84000,
+    [AW_H3_GIC_VCPU]   = 0x01c86000,
+    [AW_H3_SDRAM]      = 0x40000000
+};
+
+/* List of unimplemented devices */
+struct AwH3Unimplemented {
+    const char *device_name;
+    hwaddr base;
+    hwaddr size;
+} unimplemented[] = {
+    { "d-engine",  0x01000000, 4 * MiB },
+    { "d-inter",   0x01400000, 128 * KiB },
+    { "syscon",    0x01c00000, 4 * KiB },
+    { "dma",       0x01c02000, 4 * KiB },
+    { "nfdc",      0x01c03000, 4 * KiB },
+    { "ts",        0x01c06000, 4 * KiB },
+    { "keymem",    0x01c0b000, 4 * KiB },
+    { "lcd0",      0x01c0c000, 4 * KiB },
+    { "lcd1",      0x01c0d000, 4 * KiB },
+    { "ve",        0x01c0e000, 4 * KiB },
+    { "mmc0",      0x01c0f000, 4 * KiB },
+    { "mmc1",      0x01c10000, 4 * KiB },
+    { "mmc2",      0x01c11000, 4 * KiB },
+    { "sid",       0x01c14000, 1 * KiB },
+    { "crypto",    0x01c15000, 4 * KiB },
+    { "msgbox",    0x01c17000, 4 * KiB },
+    { "spinlock",  0x01c18000, 4 * KiB },
+    { "usb0-otg",  0x01c19000, 4 * KiB },
+    { "usb0-phy",  0x01c1a000, 4 * KiB },
+    { "usb1-phy",  0x01c1b000, 4 * KiB },
+    { "usb2-phy",  0x01c1c000, 4 * KiB },
+    { "usb3-phy",  0x01c1d000, 4 * KiB },
+    { "smc",       0x01c1e000, 4 * KiB },
+    { "ccu",       0x01c20000, 1 * KiB },
+    { "pio",       0x01c20800, 1 * KiB },
+    { "owa",       0x01c21000, 1 * KiB },
+    { "pwm",       0x01c21400, 1 * KiB },
+    { "keyadc",    0x01c21800, 1 * KiB },
+    { "pcm0",      0x01c22000, 1 * KiB },
+    { "pcm1",      0x01c22400, 1 * KiB },
+    { "pcm2",      0x01c22800, 1 * KiB },
+    { "audio",     0x01c22c00, 2 * KiB },
+    { "smta",      0x01c23400, 1 * KiB },
+    { "ths",       0x01c25000, 1 * KiB },
+    { "uart0",     0x01c28000, 1 * KiB },
+    { "uart1",     0x01c28400, 1 * KiB },
+    { "uart2",     0x01c28800, 1 * KiB },
+    { "uart3",     0x01c28c00, 1 * KiB },
+    { "twi0",      0x01c2ac00, 1 * KiB },
+    { "twi1",      0x01c2b000, 1 * KiB },
+    { "twi2",      0x01c2b400, 1 * KiB },
+    { "scr",       0x01c2c400, 1 * KiB },
+    { "emac",      0x01c30000, 64 * KiB },
+    { "gpu",       0x01c40000, 64 * KiB },
+    { "hstmr",     0x01c60000, 4 * KiB },
+    { "dramcom",   0x01c62000, 4 * KiB },
+    { "dramctl0",  0x01c63000, 4 * KiB },
+    { "dramphy0",  0x01c65000, 4 * KiB },
+    { "spi0",      0x01c68000, 4 * KiB },
+    { "spi1",      0x01c69000, 4 * KiB },
+    { "csi",       0x01cb0000, 320 * KiB },
+    { "tve",       0x01e00000, 64 * KiB },
+    { "hdmi",      0x01ee0000, 128 * KiB },
+    { "rtc",       0x01f00000, 1 * KiB },
+    { "r_timer",   0x01f00800, 1 * KiB },
+    { "r_intc",    0x01f00c00, 1 * KiB },
+    { "r_wdog",    0x01f01000, 1 * KiB },
+    { "r_prcm",    0x01f01400, 1 * KiB },
+    { "r_twd",     0x01f01800, 1 * KiB },
+    { "r_cpucfg",  0x01f01c00, 1 * KiB },
+    { "r_cir-rx",  0x01f02000, 1 * KiB },
+    { "r_twi",     0x01f02400, 1 * KiB },
+    { "r_uart",    0x01f02800, 1 * KiB },
+    { "r_pio",     0x01f02c00, 1 * KiB },
+    { "r_pwm",     0x01f03800, 1 * KiB },
+    { "core-dbg",  0x3f500000, 128 * KiB },
+    { "tsgen-ro",  0x3f506000, 4 * KiB },
+    { "tsgen-ctl", 0x3f507000, 4 * KiB },
+    { "ddr-mem",   0x40000000, 2 * GiB },
+    { "n-brom",    0xffff0000, 32 * KiB },
+    { "s-brom",    0xffff0000, 64 * KiB }
+};
+
+/* Per Processor Interrupts */
+enum {
+    AW_H3_GIC_PPI_MAINT     =  9,
+    AW_H3_GIC_PPI_HYPTIMER  = 10,
+    AW_H3_GIC_PPI_VIRTTIMER = 11,
+    AW_H3_GIC_PPI_SECTIMER  = 13,
+    AW_H3_GIC_PPI_PHYSTIMER = 14
+};
+
+/* Shared Processor Interrupts */
+enum {
+    AW_H3_GIC_SPI_UART0     =  0,
+    AW_H3_GIC_SPI_UART1     =  1,
+    AW_H3_GIC_SPI_UART2     =  2,
+    AW_H3_GIC_SPI_UART3     =  3,
+    AW_H3_GIC_SPI_TIMER0    = 18,
+    AW_H3_GIC_SPI_TIMER1    = 19,
+};
+
+/* Allwinner H3 general constants */
+enum {
+    AW_H3_GIC_NUM_SPI       = 128
+};
+
+static void allwinner_h3_init(Object *obj)
+{
+    AwH3State *s = AW_H3(obj);
+
+    s->memmap = allwinner_h3_memmap;
+
+    for (int i = 0; i < AW_H3_NUM_CPUS; i++) {
+        object_initialize_child(obj, "cpu[*]", &s->cpus[i], sizeof(s->cpus[i]),
+                                ARM_CPU_TYPE_NAME("cortex-a7"),
+                                &error_abort, NULL);
+    }
+
+    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
+                          TYPE_ARM_GIC);
+
+    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
+                          TYPE_AW_A10_PIT);
+    object_property_add_alias(obj, "clk0-freq", OBJECT(&s->timer),
+                              "clk0-freq", &error_abort);
+    object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
+                              "clk1-freq", &error_abort);
+}
+
+static void allwinner_h3_realize(DeviceState *dev, Error **errp)
+{
+    AwH3State *s = AW_H3(dev);
+    unsigned i;
+
+    /* CPUs */
+    for (i = 0; i < AW_H3_NUM_CPUS; i++) {
+
+        /* Provide Power State Coordination Interface */
+        qdev_prop_set_int32(DEVICE(&s->cpus[i]), "psci-conduit",
+                            QEMU_PSCI_CONDUIT_HVC);
+
+        /* Disable secondary CPUs */
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "start-powered-off",
+                          i > 0);
+
+        /* All exception levels required */
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "has_el3", true);
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "has_el2", true);
+
+        /* Mark realized */
+        qdev_init_nofail(DEVICE(&s->cpus[i]));
+    }
+
+    /* Generic Interrupt Controller */
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", AW_H3_GIC_NUM_SPI +
+                                                     GIC_INTERNAL);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_H3_NUM_CPUS);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", false);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions", true);
+    qdev_init_nofail(DEVICE(&s->gic));
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0, s->memmap[AW_H3_GIC_DIST]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1, s->memmap[AW_H3_GIC_CPU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2, s->memmap[AW_H3_GIC_HYP]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3, s->memmap[AW_H3_GIC_VCPU]);
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     */
+    for (i = 0; i < AW_H3_NUM_CPUS; i++) {
+        DeviceState *cpudev = DEVICE(&s->cpus[i]);
+        int ppibase = AW_H3_GIC_NUM_SPI + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int irq;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs used for this board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = AW_H3_GIC_PPI_PHYSTIMER,
+            [GTIMER_VIRT] = AW_H3_GIC_PPI_VIRTTIMER,
+            [GTIMER_HYP]  = AW_H3_GIC_PPI_HYPTIMER,
+            [GTIMER_SEC]  = AW_H3_GIC_PPI_SECTIMER,
+        };
+
+        /* Connect CPU timer outputs to GIC PPI inputs */
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(DEVICE(&s->gic),
+                                                   ppibase + timer_irq[irq]));
+        }
+
+        /* Connect GIC outputs to CPU interrupt inputs */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + AW_H3_NUM_CPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (2 * AW_H3_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (3 * AW_H3_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        /* GIC maintenance signal */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (4 * AW_H3_NUM_CPUS),
+                           qdev_get_gpio_in(DEVICE(&s->gic),
+                                            ppibase + AW_H3_GIC_PPI_MAINT));
+    }
+
+    /* Timer */
+    qdev_init_nofail(DEVICE(&s->timer));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_H3_PIT]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_TIMER0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 1,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_TIMER1));
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
+                            64 * KiB, &error_abort);
+    memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
+                            32 * KiB, &error_abort);
+    memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
+                            44 * KiB, &error_abort);
+    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_A1],
+                                &s->sram_a1);
+    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_A2],
+                                &s->sram_a2);
+    memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_C],
+                                &s->sram_c);
+
+    /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
+                   qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
+                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+    /* UART1 */
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART1], 2,
+                   qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART1),
+                   115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);
+    /* UART2 */
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART2], 2,
+                   qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART2),
+                   115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);
+    /* UART3 */
+    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART3], 2,
+                   qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART3),
+                   115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
+
+    /* Unimplemented devices */
+    for (i = 0; i < ARRAY_SIZE(unimplemented); i++) {
+        create_unimplemented_device(unimplemented[i].device_name,
+                                    unimplemented[i].base,
+                                    unimplemented[i].size);
+    }
+}
+
+static void allwinner_h3_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = allwinner_h3_realize;
+    /* Reason: uses serial_hd() in realize function */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo allwinner_h3_type_info = {
+    .name = TYPE_AW_H3,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(AwH3State),
+    .instance_init = allwinner_h3_init,
+    .class_init = allwinner_h3_class_init,
+};
+
+static void allwinner_h3_register_types(void)
+{
+    type_register_static(&allwinner_h3_type_info);
+}
+
+type_init(allwinner_h3_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 2903cbe564e..3efa8e53ec8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -492,6 +492,13 @@ F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 
+Allwinner-h3
+M: Niek Linnenbank <nieklinnenbank@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/*/allwinner-h3*
+F: include/hw/*/allwinner-h3*
+
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 645e6201bb5..36a0e89daae 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -41,3 +41,4 @@ CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
+CONFIG_ALLWINNER_H3=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bc54fd61f94..fcdc651b73e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -297,6 +297,14 @@ config ALLWINNER_A10
     select SERIAL
     select UNIMP
 
+config ALLWINNER_H3
+    bool
+    select ALLWINNER_A10_PIT
+    select SERIAL
+    select ARM_TIMER
+    select ARM_GIC
+    select UNIMP
+
 config RASPI
     bool
     select FRAMEBUFFER
-- 
2.20.1


