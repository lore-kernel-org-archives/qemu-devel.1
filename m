Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE90A20679
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtDh3RDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE90A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1katH8-0002ZK-P2
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katGP-0001dB-B4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:22:13 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katGM-0007PC-SD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:22:13 -0500
Received: by mail-pf1-x442.google.com with SMTP id y7so125501pfq.11
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eCD+pauRdp3SBAQI04BtMDy2Ka19nq9jUPcBN5vCWy0=;
 b=HtDh3RDYydnPr9iS/tJA6QYv/m8gbVIR9aNZzpvz213FklacaYnK65IjpcTYSeIHeI
 CxVR6YR4hZhoImXLAJo5F1a64HXCmXaxxGTuYIgsTbGuOBvzJvVTZ2TQuiShjpS3bNAD
 62zWkXT0kXzOZDDIDAw2e9CYU8MthvA03LPKNMNs4CjncT5WLzmtg2/DerSLyweYjqCo
 OKnSe2ifgquVfetWJiXKr0sM23X3oIerY21LCAMt5c/FSFJjIwbWgA3mlKZnIk7PSPQ7
 ZR5qWYAx5xiMsPf1k2KxpP+1ClgTowabRdufBWENBwKv4X7eQ25N2ht4wvU/ktTIXp71
 4TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eCD+pauRdp3SBAQI04BtMDy2Ka19nq9jUPcBN5vCWy0=;
 b=dev7wtar3CezsG6bFf+glzJSPDRKxK2Pr99/yzvApjDLWugV7sUjM0pXyDnL82QnTn
 MS7P7KZx5EODGg/3X9EudWpxOgz+mbsTheJAovyWLftjOm6x7ojR4PijZXXGCZlILcdx
 r4CetxXBzWsYWjvJFIZizoofWUKb7Eg7heQBu1qGp8g2NPJ2M5zymEVZQSxhfEqusxd9
 eEYPupmuygHoHFHmjN1GKQR4hY+7nP5KCZXRGq37pNcRk9VGGKrfZjXPxp6hUlfDl5K1
 nXqZ41YsAGnZSW76Gpz34U8+/t61XZuBhRLOTP6x2gwmRDZmtJW2W6n5SFGU/+I0oZUl
 AmHw==
X-Gm-Message-State: AOAM533rL6sQ3atUE51UZq39lSLt7XCcyHHJWtVgr8MnKWE4kXcrb3pU
 V/gH9RAnkYcNXMqZpHwHVtk=
X-Google-Smtp-Source: ABdhPJwtfpC6wHEpGqXxj4DSsBuggRsWmuXs3mOXQJX0/5WOfLWd10ztqibe3nObkDITwY9PFbjftA==
X-Received: by 2002:a63:5a4f:: with SMTP id k15mr116351pgm.402.1604636529445; 
 Thu, 05 Nov 2020 20:22:09 -0800 (PST)
Received: from software.domain.org (111-252-196-15.dynamic-ip.hinet.net.
 [111.252.196.15])
 by smtp.gmail.com with ESMTPSA id y1sm262235pjl.12.2020.11.05.20.22.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2020 20:22:08 -0800 (PST)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH V17 4/6] hw/mips: Add Loongson-3 boot parameter helpers
Date: Fri,  6 Nov 2020 12:21:48 +0800
Message-Id: <1604636510-8347-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
References: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparing to add Loongson-3 machine support, add Loongson-3's LEFI (a
UEFI-like interface for BIOS-Kernel boot parameters) helpers first.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/loongson3_bootp.c | 165 +++++++++++++++++++++++++++++++
 hw/mips/loongson3_bootp.h | 241 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/mips/meson.build       |   1 +
 3 files changed, 407 insertions(+)
 create mode 100644 hw/mips/loongson3_bootp.c
 create mode 100644 hw/mips/loongson3_bootp.h

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
new file mode 100644
index 0000000..3a16081
--- /dev/null
+++ b/hw/mips/loongson3_bootp.c
@@ -0,0 +1,165 @@
+/*
+ * LEFI (a UEFI-like interface for BIOS-Kernel boot parameters) helpers
+ *
+ * Copyright (c) 2018-2020 Huacai Chen (chenhc@lemote.com)
+ * Copyright (c) 2018-2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "cpu.h"
+#include "hw/boards.h"
+#include "hw/mips/loongson3_bootp.h"
+
+#define LOONGSON3_CORE_PER_NODE 4
+
+static struct efi_cpuinfo_loongson *init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
+{
+    struct efi_cpuinfo_loongson *c = g_cpuinfo;
+
+    stl_le_p(&c->cputype, Loongson_3A);
+    stl_le_p(&c->processor_id, MIPS_CPU(first_cpu)->env.CP0_PRid);
+    if (cpu_freq > UINT_MAX) {
+        stl_le_p(&c->cpu_clock_freq, UINT_MAX);
+    } else {
+        stl_le_p(&c->cpu_clock_freq, cpu_freq);
+    }
+
+    stw_le_p(&c->cpu_startup_core_id, 0);
+    stl_le_p(&c->nr_cpus, current_machine->smp.cpus);
+    stl_le_p(&c->total_node, DIV_ROUND_UP(current_machine->smp.cpus,
+                                          LOONGSON3_CORE_PER_NODE));
+
+    return c;
+}
+
+static struct efi_memory_map_loongson *init_memory_map(void *g_map, uint64_t ram_size)
+{
+    struct efi_memory_map_loongson *emap = g_map;
+
+    stl_le_p(&emap->nr_map, 2);
+    stl_le_p(&emap->mem_freq, 300000000);
+
+    stl_le_p(&emap->map[0].node_id, 0);
+    stl_le_p(&emap->map[0].mem_type, 1);
+    stq_le_p(&emap->map[0].mem_start, 0x0);
+    stl_le_p(&emap->map[0].mem_size, 240);
+
+    stl_le_p(&emap->map[1].node_id, 0);
+    stl_le_p(&emap->map[1].mem_type, 2);
+    stq_le_p(&emap->map[1].mem_start, 0x90000000);
+    stl_le_p(&emap->map[1].mem_size, (ram_size / MiB) - 256);
+
+    return emap;
+}
+
+static struct system_loongson *init_system_loongson(void *g_system)
+{
+    struct system_loongson *s = g_system;
+
+    stl_le_p(&s->ccnuma_smp, 0);
+    stl_le_p(&s->sing_double_channel, 1);
+    stl_le_p(&s->nr_uarts, 1);
+    stl_le_p(&s->uarts[0].iotype, 2);
+    stl_le_p(&s->uarts[0].int_offset, 2);
+    stl_le_p(&s->uarts[0].uartclk, 25000000); /* Random value */
+    stq_le_p(&s->uarts[0].uart_base, virt_memmap[VIRT_UART].base);
+
+    return s;
+}
+
+static struct irq_source_routing_table *init_irq_source(void *g_irq_source)
+{
+    struct irq_source_routing_table *irq_info = g_irq_source;
+
+    stl_le_p(&irq_info->node_id, 0);
+    stl_le_p(&irq_info->PIC_type, 0);
+    stw_le_p(&irq_info->dma_mask_bits, 64);
+    stq_le_p(&irq_info->pci_mem_start_addr, virt_memmap[VIRT_PCIE_MMIO].base);
+    stq_le_p(&irq_info->pci_mem_end_addr, virt_memmap[VIRT_PCIE_MMIO].base +
+                                          virt_memmap[VIRT_PCIE_MMIO].size - 1);
+    stq_le_p(&irq_info->pci_io_start_addr, virt_memmap[VIRT_PCIE_PIO].base);
+
+    return irq_info;
+}
+
+static struct interface_info *init_interface_info(void *g_interface)
+{
+    struct interface_info *interface = g_interface;
+
+    stw_le_p(&interface->vers, 0x01);
+    strpadcpy(interface->description, 64, "UEFI_Version_v1.0", '\0');
+
+    return interface;
+}
+
+static struct board_devices *board_devices_info(void *g_board)
+{
+    struct board_devices *bd = g_board;
+
+    strpadcpy(bd->name, 64, "Loongson-3A-VIRT-1w-V1.00-demo", '\0');
+
+    return bd;
+}
+
+static struct loongson_special_attribute *init_special_info(void *g_special)
+{
+    struct loongson_special_attribute *special = g_special;
+
+    strpadcpy(special->special_name, 64, "2018-04-01", '\0');
+
+    return special;
+}
+
+void init_loongson_params(struct loongson_params *lp, void *p,
+                          uint64_t cpu_freq, uint64_t ram_size)
+{
+    stq_le_p(&lp->cpu_offset,
+              (uintptr_t)init_cpu_info(p, cpu_freq) - (uintptr_t)lp);
+    p += ROUND_UP(sizeof(struct efi_cpuinfo_loongson), 64);
+
+    stq_le_p(&lp->memory_offset,
+              (uintptr_t)init_memory_map(p, ram_size) - (uintptr_t)lp);
+    p += ROUND_UP(sizeof(struct efi_memory_map_loongson), 64);
+
+    stq_le_p(&lp->system_offset,
+              (uintptr_t)init_system_loongson(p) - (uintptr_t)lp);
+    p += ROUND_UP(sizeof(struct system_loongson), 64);
+
+    stq_le_p(&lp->irq_offset,
+              (uintptr_t)init_irq_source(p) - (uintptr_t)lp);
+    p += ROUND_UP(sizeof(struct irq_source_routing_table), 64);
+
+    stq_le_p(&lp->interface_offset,
+              (uintptr_t)init_interface_info(p) - (uintptr_t)lp);
+    p += ROUND_UP(sizeof(struct interface_info), 64);
+
+    stq_le_p(&lp->boarddev_table_offset,
+              (uintptr_t)board_devices_info(p) - (uintptr_t)lp);
+    p += ROUND_UP(sizeof(struct board_devices), 64);
+
+    stq_le_p(&lp->special_offset,
+              (uintptr_t)init_special_info(p) - (uintptr_t)lp);
+    p += ROUND_UP(sizeof(struct loongson_special_attribute), 64);
+}
+
+void init_reset_system(struct efi_reset_system_t *reset)
+{
+    stq_le_p(&reset->Shutdown, 0xffffffffbfc000a8);
+    stq_le_p(&reset->ResetCold, 0xffffffffbfc00080);
+    stq_le_p(&reset->ResetWarm, 0xffffffffbfc00080);
+}
diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
new file mode 100644
index 0000000..bf4fd8c
--- /dev/null
+++ b/hw/mips/loongson3_bootp.h
@@ -0,0 +1,241 @@
+/*
+ * LEFI (a UEFI-like interface for BIOS-Kernel boot parameters) data structrues
+ * defined at arch/mips/include/asm/mach-loongson64/boot_param.h in Linux kernel
+ *
+ * Copyright (c) 2017-2020 Huacai Chen (chenhc@lemote.com)
+ * Copyright (c) 2017-2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_MIPS_LOONGSON3_BOOTP_H
+#define HW_MIPS_LOONGSON3_BOOTP_H
+
+struct efi_memory_map_loongson {
+    uint16_t vers;               /* version of efi_memory_map */
+    uint32_t nr_map;             /* number of memory_maps */
+    uint32_t mem_freq;           /* memory frequence */
+    struct mem_map {
+        uint32_t node_id;        /* node_id which memory attached to */
+        uint32_t mem_type;       /* system memory, pci memory, pci io, etc. */
+        uint64_t mem_start;      /* memory map start address */
+        uint32_t mem_size;       /* each memory_map size, not the total size */
+    } map[128];
+} QEMU_PACKED;
+
+enum loongson_cpu_type {
+    Legacy_2E = 0x0,
+    Legacy_2F = 0x1,
+    Legacy_3A = 0x2,
+    Legacy_3B = 0x3,
+    Legacy_1A = 0x4,
+    Legacy_1B = 0x5,
+    Legacy_2G = 0x6,
+    Legacy_2H = 0x7,
+    Loongson_1A = 0x100,
+    Loongson_1B = 0x101,
+    Loongson_2E = 0x200,
+    Loongson_2F = 0x201,
+    Loongson_2G = 0x202,
+    Loongson_2H = 0x203,
+    Loongson_3A = 0x300,
+    Loongson_3B = 0x301
+};
+
+/*
+ * Capability and feature descriptor structure for MIPS CPU
+ */
+struct efi_cpuinfo_loongson {
+    uint16_t vers;               /* version of efi_cpuinfo_loongson */
+    uint32_t processor_id;       /* PRID, e.g. 6305, 6306 */
+    uint32_t cputype;            /* Loongson_3A/3B, etc. */
+    uint32_t total_node;         /* num of total numa nodes */
+    uint16_t cpu_startup_core_id;   /* Boot core id */
+    uint16_t reserved_cores_mask;
+    uint32_t cpu_clock_freq;     /* cpu_clock */
+    uint32_t nr_cpus;
+    char cpuname[64];
+} QEMU_PACKED;
+
+#define MAX_UARTS 64
+struct uart_device {
+    uint32_t iotype;
+    uint32_t uartclk;
+    uint32_t int_offset;
+    uint64_t uart_base;
+} QEMU_PACKED;
+
+#define MAX_SENSORS 64
+#define SENSOR_TEMPER  0x00000001
+#define SENSOR_VOLTAGE 0x00000002
+#define SENSOR_FAN     0x00000004
+struct sensor_device {
+    char name[32];  /* a formal name */
+    char label[64]; /* a flexible description */
+    uint32_t type;       /* SENSOR_* */
+    uint32_t id;         /* instance id of a sensor-class */
+    uint32_t fan_policy; /* step speed or constant speed */
+    uint32_t fan_percent;/* only for constant speed policy */
+    uint64_t base_addr;  /* base address of device registers */
+} QEMU_PACKED;
+
+struct system_loongson {
+    uint16_t vers;               /* version of system_loongson */
+    uint32_t ccnuma_smp;         /* 0: no numa; 1: has numa */
+    uint32_t sing_double_channel;/* 1: single; 2: double */
+    uint32_t nr_uarts;
+    struct uart_device uarts[MAX_UARTS];
+    uint32_t nr_sensors;
+    struct sensor_device sensors[MAX_SENSORS];
+    char has_ec;
+    char ec_name[32];
+    uint64_t ec_base_addr;
+    char has_tcm;
+    char tcm_name[32];
+    uint64_t tcm_base_addr;
+    uint64_t workarounds;
+    uint64_t of_dtb_addr; /* NULL if not support */
+} QEMU_PACKED;
+
+struct irq_source_routing_table {
+    uint16_t vers;
+    uint16_t size;
+    uint16_t rtr_bus;
+    uint16_t rtr_devfn;
+    uint32_t vendor;
+    uint32_t device;
+    uint32_t PIC_type;           /* conform use HT or PCI to route to CPU-PIC */
+    uint64_t ht_int_bit;         /* 3A: 1<<24; 3B: 1<<16 */
+    uint64_t ht_enable;          /* irqs used in this PIC */
+    uint32_t node_id;            /* node id: 0x0-0; 0x1-1; 0x10-2; 0x11-3 */
+    uint64_t pci_mem_start_addr;
+    uint64_t pci_mem_end_addr;
+    uint64_t pci_io_start_addr;
+    uint64_t pci_io_end_addr;
+    uint64_t pci_config_addr;
+    uint16_t dma_mask_bits;
+    uint16_t dma_noncoherent;
+} QEMU_PACKED;
+
+struct interface_info {
+    uint16_t vers;               /* version of the specificition */
+    uint16_t size;
+    uint8_t  flag;
+    char description[64];
+} QEMU_PACKED;
+
+#define MAX_RESOURCE_NUMBER 128
+struct resource_loongson {
+    uint64_t start;              /* resource start address */
+    uint64_t end;                /* resource end address */
+    char name[64];
+    uint32_t flags;
+};
+
+struct archdev_data {};          /* arch specific additions */
+
+struct board_devices {
+    char name[64];               /* hold the device name */
+    uint32_t num_resources;      /* number of device_resource */
+    /* for each device's resource */
+    struct resource_loongson resource[MAX_RESOURCE_NUMBER];
+    /* arch specific additions */
+    struct archdev_data archdata;
+};
+
+struct loongson_special_attribute {
+    uint16_t vers;               /* version of this special */
+    char special_name[64];       /* special_atribute_name */
+    uint32_t loongson_special_type; /* type of special device */
+    /* for each device's resource */
+    struct resource_loongson resource[MAX_RESOURCE_NUMBER];
+};
+
+struct loongson_params {
+    uint64_t memory_offset;      /* efi_memory_map_loongson struct offset */
+    uint64_t cpu_offset;         /* efi_cpuinfo_loongson struct offset */
+    uint64_t system_offset;      /* system_loongson struct offset */
+    uint64_t irq_offset;         /* irq_source_routing_table struct offset */
+    uint64_t interface_offset;   /* interface_info struct offset */
+    uint64_t special_offset;     /* loongson_special_attribute struct offset */
+    uint64_t boarddev_table_offset;  /* board_devices offset */
+};
+
+struct smbios_tables {
+    uint16_t vers;               /* version of smbios */
+    uint64_t vga_bios;           /* vga_bios address */
+    struct loongson_params lp;
+};
+
+struct efi_reset_system_t {
+    uint64_t ResetCold;
+    uint64_t ResetWarm;
+    uint64_t ResetType;
+    uint64_t Shutdown;
+    uint64_t DoSuspend; /* NULL if not support */
+};
+
+struct efi_loongson {
+    uint64_t mps;                /* MPS table */
+    uint64_t acpi;               /* ACPI table (IA64 ext 0.71) */
+    uint64_t acpi20;             /* ACPI table (ACPI 2.0) */
+    struct smbios_tables smbios; /* SM BIOS table */
+    uint64_t sal_systab;         /* SAL system table */
+    uint64_t boot_info;          /* boot info table */
+};
+
+struct boot_params {
+    struct efi_loongson efi;
+    struct efi_reset_system_t reset_system;
+};
+
+/* Overall MMIO & Memory layout */
+enum {
+    VIRT_LOWMEM,
+    VIRT_PM,
+    VIRT_FW_CFG,
+    VIRT_RTC,
+    VIRT_PCIE_PIO,
+    VIRT_PCIE_ECAM,
+    VIRT_BIOS_ROM,
+    VIRT_UART,
+    VIRT_LIOINTC,
+    VIRT_PCIE_MMIO,
+    VIRT_HIGHMEM
+};
+
+/* Low MEM layout for QEMU kernel loader */
+enum {
+    LOADER_KERNEL,
+    LOADER_INITRD,
+    LOADER_CMDLINE
+};
+
+/* BIOS ROM layout for QEMU kernel loader */
+enum {
+    LOADER_BOOTROM,
+    LOADER_PARAM,
+};
+
+struct MemmapEntry {
+    hwaddr base;
+    hwaddr size;
+};
+
+extern const struct MemmapEntry virt_memmap[];
+void init_loongson_params(struct loongson_params *lp, void *p,
+                          uint64_t cpu_freq, uint64_t ram_size);
+void init_reset_system(struct efi_reset_system_t *reset);
+
+#endif
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 0e9f930..9e58c2b 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -1,6 +1,7 @@
 mips_ss = ss.source_set()
 mips_ss.add(files('addr.c', 'mips_int.c', 'fw_cfg.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
+mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c'))
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'malta.c'))
 mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
-- 
2.7.0


