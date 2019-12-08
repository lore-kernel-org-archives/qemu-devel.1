Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA9EC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5C7205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvHI7uy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5C7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1o7-00081z-1T
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0002NQ-LE
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003LF-Pr
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003CF-7s
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id b6so13559038wrq.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oAO0yqb39g2l+jZaNDhLPdo+MAwQzUGJWBl9pLetPtg=;
 b=qvHI7uy8Imc/0t8YybbZBYQ1ppDI4ygiJnekDhO3bljChKY7KmEh+bjDmswmyPIQki
 fSHUA+NQHEG4KkoidQp05DoXewvAwbD09TV3mbaTh+hLaSTqHHgSDNM1f7sQmU3ZbP2O
 nEm43Q8B2n4pmnPQfr2OJ42TmDd732tekdQwBESE866KJ+C9GxV0mZJxJBQQycKHjBtR
 vretNtX3W7CDyHpUftsuzHyiSzK0f7fjpEEeMQNAqAhHmjjfCkSiRzFYfVLT82n9QtzY
 KEgdftAOTi3PcWmy2ubTWCIz90JWM9Q/yt9gc3KPCKEAqgtPYFpovqn+6OsvcCx4GCpi
 X99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oAO0yqb39g2l+jZaNDhLPdo+MAwQzUGJWBl9pLetPtg=;
 b=MyUd0zOeOHD/M8GXAcMG6BfvY+osWNQG+cHroY0RnSzeBsdUbUzN2yZql8NvmCP4VD
 rxQK/4MJXk2BcAeiKyOcUEcM9C0oSlo3DvjUliaMb/oWzNkcT6GETEBqqOsFc72T6QgY
 G9K3f2EjYrh+kqVeQTLrntr6/U18Bjz4pWBIq3j5YWyi+tRGWpFmiMc2/UbY3OFDamkk
 Lngg5BGBpsiDQ5s9CVrW1+XMYSyxHRZuo6preTnGNsIcmM2JHYLUusstuWjBvlbtYWF+
 xnxny0jBH5v058zy1oJG3LNxaFlPVAxWTiypOOXaoDgi82cvq0B8hz/FCvWsuAkamZhI
 AdEQ==
X-Gm-Message-State: APjAAAUmmNFnlhIT065pCWi65ZGTDJ0CRElU0S/9fz5ypz/5orEufjC5
 jc8e6smbAiBwvbDpe56QFzBnFqgFyOwxvLt/
X-Google-Smtp-Source: APXvYqxHSTdVvBdgpq2s57LF4nZmp6oRBACCj/WOcdhPk/KrUOkUtoNqpWu2EISs3TDXC/f0m4rAow==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr26445436wrt.229.1575830420477; 
 Sun, 08 Dec 2019 10:40:20 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:20 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 15/22] target/avr: Add example board configuration
Date: Sun,  8 Dec 2019 20:39:15 +0200
Message-Id: <20191208183922.13757-16-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A simple board setup that configures an AVR CPU to run a given firmware image.
This is all that's useful to implement without peripheral emulation as AVR CPUs include a lot of on-board peripherals.

NOTE: this is not a real board !!!!
NOTE: it's used for CPU testing!!!!

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Nacked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/elf.h        |   2 +
 include/hw/elf_ops.h |   6 +-
 include/hw/loader.h  |   3 +-
 hw/avr/sample.c      | 293 +++++++++++++++++++++++++++++++++++++++++++
 hw/core/loader.c     |  13 +-
 hw/Kconfig           |   1 +
 hw/avr/Kconfig       |   6 +
 hw/avr/Makefile.objs |   1 +
 8 files changed, 317 insertions(+), 8 deletions(-)
 create mode 100644 hw/avr/sample.c
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs

diff --git a/include/elf.h b/include/elf.h
index 3501e0c8d0..53cdfa23b7 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
 #define EM_MOXIE           223     /* Moxie processor family */
 #define EM_MOXIE_OLD       0xFEED
 
+#define EM_AVR 83 /* AVR 8-bit microcontroller */
+
 /* This is the info that is needed to parse the dynamic section of the file */
 #define DT_NULL		0
 #define DT_NEEDED	1
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index e07d276df7..9f28c16490 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                               void *translate_opaque,
                               int must_swab, uint64_t *pentry,
                               uint64_t *lowaddr, uint64_t *highaddr,
-                              int elf_machine, int clear_lsb, int data_swab,
+                              int elf_machine, uint32_t *pflags,
+                              int clear_lsb, int data_swab,
                               AddressSpace *as, bool load_rom,
                               symbol_fn_t sym_cb)
 {
@@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
         }
     }
 
+    if (pflags) {
+        *pflags = (uint32_t)(elf_sword)ehdr.e_flags;
+    }
     if (lowaddr)
         *lowaddr = (uint64_t)(elf_sword)low;
     if (highaddr)
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 48a96cd559..3dbdd1868d 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -132,7 +132,8 @@ int load_elf_ram_sym(const char *filename,
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
                      uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
-                     int elf_machine, int clear_lsb, int data_swab,
+                     int elf_machine, uint32_t *pflags,
+                     int clear_lsb, int data_swab,
                      AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
 
 /** load_elf_ram:
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
new file mode 100644
index 0000000000..6574733b57
--- /dev/null
+++ b/hw/avr/sample.c
@@ -0,0 +1,293 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+/*
+ *  NOTE:
+ *      This is not a real AVR board, this is an example!
+ *      The CPU is an approximation of an ATmega2560, but is missing various
+ *      built-in peripherals.
+ *
+ *      This example board loads provided binary file into flash memory and
+ *      executes it from 0x00000000 address in the code memory space.
+ *
+ *      Currently used for AVR CPU validation
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "ui/console.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "qemu/error-report.h"
+#include "exec/address-spaces.h"
+#include "include/hw/sysbus.h"
+#include "include/hw/char/avr_usart.h"
+#include "include/hw/timer/avr_timer16.h"
+#include "include/hw/misc/avr_mask.h"
+#include "elf.h"
+#include "hw/misc/unimp.h"
+
+#define SIZE_FLASH 0x00040000
+#define SIZE_SRAM 0x00002000
+/*
+ * Size of additional "external" memory, as if the AVR were configured to use
+ * an external RAM chip.
+ * Note that the configuration registers that normally enable this feature are
+ * unimplemented.
+ */
+#define SIZE_EXMEM 0x00000000
+
+/* Offsets of peripherals in emulated memory space (i.e. not host addresses)  */
+#define PRR0_BASE 0x64
+#define PRR1_BASE 0x65
+#define USART_BASE 0xc0
+#define TIMER1_BASE 0x80
+#define TIMER1_IMSK_BASE 0x6f
+#define TIMER1_IFR_BASE 0x36
+
+/* Interrupt numbers used by peripherals */
+#define USART_RXC_IRQ 24
+#define USART_DRE_IRQ 25
+#define USART_TXC_IRQ 26
+
+#define TIMER1_CAPT_IRQ 15
+#define TIMER1_COMPA_IRQ 16
+#define TIMER1_COMPB_IRQ 17
+#define TIMER1_COMPC_IRQ 18
+#define TIMER1_OVF_IRQ 19
+
+/*  Power reduction     */
+#define PRR1_BIT_PRTIM5     0x05    /*  Timer/Counter5  */
+#define PRR1_BIT_PRTIM4     0x04    /*  Timer/Counter4  */
+#define PRR1_BIT_PRTIM3     0x03    /*  Timer/Counter3  */
+#define PRR1_BIT_PRUSART3   0x02    /*  USART3  */
+#define PRR1_BIT_PRUSART2   0x01    /*  USART2  */
+#define PRR1_BIT_PRUSART1   0x00    /*  USART1  */
+
+#define PRR0_BIT_PRTWI      0x06    /*  TWI */
+#define PRR0_BIT_PRTIM2     0x05    /*  Timer/Counter2  */
+#define PRR0_BIT_PRTIM0     0x04    /*  Timer/Counter0  */
+#define PRR0_BIT_PRTIM1     0x03    /*  Timer/Counter1  */
+#define PRR0_BIT_PRSPI      0x02    /*  Serial Peripheral Interface */
+#define PRR0_BIT_PRUSART0   0x01    /*  USART0  */
+#define PRR0_BIT_PRADC      0x00    /*  ADC */
+
+typedef struct {
+    MachineClass parent;
+} SampleMachineClass;
+
+typedef struct {
+    MachineState parent;
+    MemoryRegion *ram;
+    MemoryRegion *flash;
+    AVRUsartState *usart0;
+    AVRTimer16State *timer1;
+    AVRMaskState *prr[2];
+} SampleMachineState;
+
+#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
+
+#define SAMPLE_MACHINE(obj) \
+    OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACHINE)
+#define SAMPLE_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_MACHINE)
+#define SAMPLE_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAMPLE_MACHINE)
+
+static void sample_init(MachineState *machine)
+{
+    SampleMachineState *sms = SAMPLE_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    AVRCPU *cpu;
+    const char *firmware = NULL;
+    const char *filename = NULL;
+    const char *cpu_type = NULL;
+    uint32_t flags;
+    int bytes_loaded;
+    SysBusDevice *busdev;
+    DeviceState *cpudev;
+
+    system_memory = get_system_memory();
+    sms->ram = g_new(MemoryRegion, 1);
+    sms->flash = g_new(MemoryRegion, 1);
+
+    /* if ELF file is provided, determine CPU type reading ELF flags */
+    cpu_type = machine->cpu_type;
+    firmware = machine->firmware;
+    if (firmware != NULL) {
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+        if (filename == NULL) {
+            error_report("Unable to find %s", firmware);
+            exit(1);
+        }
+
+        bytes_loaded = load_elf_ram_sym(filename, NULL, NULL, NULL, NULL, NULL,
+                NULL, 0, EM_AVR, &flags, 0, 0, NULL, 0, 0);
+        if (bytes_loaded > 0) {
+            cpu_type = avr_flags_to_cpu_type(flags, cpu_type);
+        }
+    }
+
+    cpu = AVR_CPU(cpu_create(cpu_type));
+    cpudev = DEVICE(cpu);
+
+    memory_region_init_rom(sms->flash, NULL, "avr.flash", SIZE_FLASH,
+            &error_fatal);
+    memory_region_add_subregion(system_memory, OFFSET_CODE, sms->flash);
+
+    /* following are atmel2560 device */
+    create_unimplemented_device("usart 3", OFFSET_DATA + 0x0130, 0x0007);
+    create_unimplemented_device("timer-counter-16bit 5",
+            OFFSET_DATA + 0x0120, 0x000e);
+    create_unimplemented_device("gpio L", OFFSET_DATA + 0x0109, 0x0003);
+    create_unimplemented_device("gpio K", OFFSET_DATA + 0x0106, 0x0003);
+    create_unimplemented_device("gpio J", OFFSET_DATA + 0x0103, 0x0003);
+    create_unimplemented_device("gpio H", OFFSET_DATA + 0x0100, 0x0003);
+    create_unimplemented_device("usart 2", OFFSET_DATA + 0x00d0, 0x0007);
+    create_unimplemented_device("usart 1", OFFSET_DATA + 0x00c8, 0x0007);
+    create_unimplemented_device("usart 0", OFFSET_DATA + 0x00c0, 0x0007);
+    create_unimplemented_device("twi", OFFSET_DATA + 0x00b8, 0x0006);
+    create_unimplemented_device("timer-counter-async-8bit 2",
+            OFFSET_DATA + 0x00b0, 0x0007);
+    create_unimplemented_device("timer-counter-16bit 4",
+            OFFSET_DATA + 0x00a0, 0x000e);
+    create_unimplemented_device("timer-counter-16bit 3",
+            OFFSET_DATA + 0x0090, 0x000e);
+    create_unimplemented_device("timer-counter-16bit 1",
+            OFFSET_DATA + 0x0080, 0x000e);
+    create_unimplemented_device("ac / adc",
+            OFFSET_DATA + 0x0078, 0x0008);
+    create_unimplemented_device("ext-mem-iface",
+            OFFSET_DATA + 0x0074, 0x0002);
+    create_unimplemented_device("int-controller",
+            OFFSET_DATA + 0x0068, 0x000c);
+    create_unimplemented_device("sys",
+            OFFSET_DATA + 0x0060, 0x0007);
+    create_unimplemented_device("spi",
+            OFFSET_DATA + 0x004c, 0x0003);
+    create_unimplemented_device("ext-mem-iface",
+            OFFSET_DATA + 0x004a, 0x0002);
+    create_unimplemented_device("timer-counter-pwm-8bit 0",
+            OFFSET_DATA + 0x0043, 0x0006);
+    create_unimplemented_device("ext-mem-iface",
+            OFFSET_DATA + 0x003e, 0x0005);
+    create_unimplemented_device("int-controller",
+            OFFSET_DATA + 0x0035, 0x0009);
+    create_unimplemented_device("gpio G", OFFSET_DATA + 0x0032, 0x0003);
+    create_unimplemented_device("gpio F", OFFSET_DATA + 0x002f, 0x0003);
+    create_unimplemented_device("gpio E", OFFSET_DATA + 0x002c, 0x0003);
+    create_unimplemented_device("gpio D", OFFSET_DATA + 0x0029, 0x0003);
+    create_unimplemented_device("gpio C", OFFSET_DATA + 0x0026, 0x0003);
+    create_unimplemented_device("gpio B", OFFSET_DATA + 0x0023, 0x0003);
+    create_unimplemented_device("gpio A", OFFSET_DATA + 0x0020, 0x0003);
+
+    memory_region_allocate_system_memory(
+        sms->ram, NULL, "avr.ram", SIZE_SRAM + SIZE_EXMEM);
+    memory_region_add_subregion(system_memory, OFFSET_DATA + 0x200, sms->ram);
+
+    /* Power Reduction built-in peripheral */
+    sms->prr[0] = AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
+                    OFFSET_DATA + PRR0_BASE, NULL));
+    sms->prr[1] = AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
+                    OFFSET_DATA + PRR1_BASE, NULL));
+
+    /* USART 0 built-in peripheral */
+    sms->usart0 = AVR_USART(object_new(TYPE_AVR_USART));
+    busdev = SYS_BUS_DEVICE(sms->usart0);
+    qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", serial_hd(0));
+    object_property_set_bool(OBJECT(sms->usart0), true, "realized",
+            &error_fatal);
+    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
+    /*
+     * These IRQ numbers don't match the datasheet because we're counting from
+     * zero and not including reset.
+     */
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, USART_RXC_IRQ));
+    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, USART_DRE_IRQ));
+    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, USART_TXC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_BIT_PRUSART1,
+            qdev_get_gpio_in(DEVICE(sms->usart0), 0));
+
+    /* Timer 1 built-in periphal */
+    sms->timer1 = AVR_TIMER16(object_new(TYPE_AVR_TIMER16));
+    object_property_set_bool(OBJECT(sms->timer1), true, "realized",
+            &error_fatal);
+    busdev = SYS_BUS_DEVICE(sms->timer1);
+    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
+    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
+    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, TIMER1_CAPT_IRQ));
+    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, TIMER1_COMPA_IRQ));
+    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, TIMER1_COMPB_IRQ));
+    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev, TIMER1_COMPC_IRQ));
+    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev, TIMER1_OVF_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_BIT_PRTIM1,
+            qdev_get_gpio_in(DEVICE(sms->timer1), 0));
+
+    /* Load firmware (contents of flash) trying to auto-detect format */
+    if (filename != NULL) {
+        bytes_loaded = load_elf(
+            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE, 0, 0);
+        if (bytes_loaded < 0) {
+            bytes_loaded = load_image_targphys(
+                filename, OFFSET_CODE, SIZE_FLASH);
+        }
+        if (bytes_loaded < 0) {
+            error_report(
+                "Unable to load firmware image %s as ELF or raw binary",
+                firmware);
+            exit(1);
+        }
+    }
+}
+
+static void sample_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "AVR sample/example board (ATmega2560)";
+    mc->init = sample_init;
+    mc->default_cpus = 1;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mc->default_cpu_type = "avr6-avr-cpu"; /* ATmega2560. */
+    mc->is_default = 1;
+}
+
+static const TypeInfo sample_info = {
+    .name = TYPE_SAMPLE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(SampleMachineState),
+    .class_size = sizeof(SampleMachineClass),
+    .class_init = sample_class_init,
+};
+
+static void sample_machine_init(void)
+{
+    type_register_static(&sample_info);
+}
+
+type_init(sample_machine_init);
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5099f27dc8..e6511466ba 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -439,7 +439,7 @@ int load_elf_ram(const char *filename,
     return load_elf_ram_sym(filename, elf_note_fn,
                             translate_fn, translate_opaque,
                             pentry, lowaddr, highaddr, big_endian,
-                            elf_machine, clear_lsb, data_swab, as,
+                            elf_machine, NULL, clear_lsb, data_swab, as,
                             load_rom, NULL);
 }
 
@@ -449,7 +449,8 @@ int load_elf_ram_sym(const char *filename,
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
                      uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
-                     int elf_machine, int clear_lsb, int data_swab,
+                     int elf_machine, uint32_t *pflags,
+                     int clear_lsb, int data_swab,
                      AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
 {
     int fd, data_order, target_data_order, must_swab, ret = ELF_LOAD_FAILED;
@@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
     if (e_ident[EI_CLASS] == ELFCLASS64) {
         ret = load_elf64(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
-                         pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom, sym_cb);
+                         pentry, lowaddr, highaddr, elf_machine, pflags,
+                         clear_lsb, data_swab, as, load_rom, sym_cb);
     } else {
         ret = load_elf32(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
-                         pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom, sym_cb);
+                         pentry, lowaddr, highaddr, elf_machine, pflags,
+                         clear_lsb, data_swab, as, load_rom, sym_cb);
     }
 
  fail:
diff --git a/hw/Kconfig b/hw/Kconfig
index b9685b3944..07b8abb342 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -44,6 +44,7 @@ source watchdog/Kconfig
 # arch Kconfig
 source arm/Kconfig
 source alpha/Kconfig
+source avr/Kconfig
 source cris/Kconfig
 source hppa/Kconfig
 source i386/Kconfig
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
new file mode 100644
index 0000000000..92aa1e6afb
--- /dev/null
+++ b/hw/avr/Kconfig
@@ -0,0 +1,6 @@
+config AVR_SAMPLE
+    bool
+    select AVR_TIMER16
+    select AVR_USART
+    select AVR_MASK
+    select UNIMP
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
new file mode 100644
index 0000000000..626b7064b3
--- /dev/null
+++ b/hw/avr/Makefile.objs
@@ -0,0 +1 @@
+obj-y += sample.o
-- 
2.17.2 (Apple Git-113)


