Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A72ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ECA21721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lKcUFegv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ECA21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8Vy-0001ZI-Lx
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pl-0005bD-SJ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pk-0003z1-89
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pk-0003yV-2i
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id e10so7139635pgd.11
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=ct4cr7W6py/Lt0mv4tyWad4FZUBLOwRZsnuR9ooXN68=;
 b=lKcUFegvxOGeJtPrIpO67ycOGwpirfCYk0H/5K1Q1Ur9INE9DcipnLbeP6/XyW1Mv1
 /TeXGYVt4VlPMzp/BTah0/Mxn0Qkyz617Gvl1Mfs03hEVJLGhwpAbklifA/Hn3Df5DH9
 /3G9UbO6zHbTY9Ys/7aqyQIXYrG8DldywiD5mbgsG/FjAZgy1Ykdt2+ifkkMD4kazCOx
 GexXy5jwbx6VtV24Np0m8wj06hJqrItVmzOZD7sSDBDncZJIkUifnHs4pp4z+uG+lY7M
 QeYNMbZWw79FpQ7JoKrVoqxsHKAgxEVB1eyKokT1D9m2CSGzS2SyxyWC4PUKPjrzwh+a
 LW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ct4cr7W6py/Lt0mv4tyWad4FZUBLOwRZsnuR9ooXN68=;
 b=ABhLfITWaBROjN+MvDUAa3Y0O+NsZe5lP3kx1JsylGpmkr4tNOsWMf7R3dnEqedkOd
 3s9YQ+swuncY85W/s3u/lPT15/UfHKFvvghubHGOguAFLJADtiifRum8Y8CkhGY88CWQ
 bAgDgRAkaecb+DvJsjOG0YKJuQ1GhaLATMkR2RQnA2RfdjjKBRwKWaPbG5otasdKsHzu
 IFkMEd4c1CPfCsTArrVTiHanmufb3f7VBddKDwXWywmXic752CfmA2kLNn6lZ8wi2jg8
 IqVfnIqXjYI+eXNv2TMSc3Z4PizYsw7HeI4otK/CmSh7WuZ9QI3DoBZ2ifJtQ5Mw5Aic
 5oEA==
X-Gm-Message-State: APjAAAXUR+YNvOmQqldM8X2IxgFdFXhcxodj7qe+xRsvlo0/9ljpRh5d
 MwsE2Pe0dkqbtnEdqrb/ByHFaCKzSFSyTg==
X-Google-Smtp-Source: APXvYqyyrkf2iXf/M3sAPyscML9ecRJ/ajwLarnjl1ZBxqxeUQ7V6a/O2iA5579r1vVscdjByn1qCQ==
X-Received: by 2002:a17:90a:25e1:: with SMTP id k88mr19596pje.14.1572278318592; 
 Mon, 28 Oct 2019 08:58:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id u36sm13047761pgn.29.2019.10.28.08.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:37 -0700 (PDT)
Subject: [PULL 12/18] riscv/virt: Add the PFlash CFI01 device
Date: Mon, 28 Oct 2019 08:48:56 -0700
Message-Id: <20191028154902.32491-13-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add the CFI01 PFlash to the RISC-V virt board. This is the same PFlash
from the ARM Virt board and the implementation is based on the ARM Virt
board. This allows users to specify flash files from the command line.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 86 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  3 ++
 3 files changed, 90 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb19b2df3a..b12660b9f8 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -36,4 +36,5 @@ config RISCV_VIRT
     select SERIAL
     select VIRTIO_MMIO
     select PCI_EXPRESS_GENERIC_BRIDGE
+    select PFLASH_CFI01
     select SIFIVE
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bdbdfadd29..b2156abd6c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -26,6 +26,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
@@ -61,12 +62,77 @@ static const struct MemmapEntry {
     [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =       { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
+    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
     [VIRT_DRAM] =        { 0x80000000,           0x0 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
     [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
 };
 
+#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
+
+static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
+                                       const char *name,
+                                       const char *alias_prop_name)
+{
+    /*
+     * Create a single flash device.  We use the same parameters as
+     * the flash devices on the ARM virt board.
+     */
+    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+
+    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
+    qdev_prop_set_uint8(dev, "width", 4);
+    qdev_prop_set_uint8(dev, "device-width", 2);
+    qdev_prop_set_bit(dev, "big-endian", false);
+    qdev_prop_set_uint16(dev, "id0", 0x89);
+    qdev_prop_set_uint16(dev, "id1", 0x18);
+    qdev_prop_set_uint16(dev, "id2", 0x00);
+    qdev_prop_set_uint16(dev, "id3", 0x00);
+    qdev_prop_set_string(dev, "name", name);
+
+    object_property_add_child(OBJECT(s), name, OBJECT(dev),
+                              &error_abort);
+    object_property_add_alias(OBJECT(s), alias_prop_name,
+                              OBJECT(dev), "drive", &error_abort);
+
+    return PFLASH_CFI01(dev);
+}
+
+static void virt_flash_create(RISCVVirtState *s)
+{
+    s->flash[0] = virt_flash_create1(s, "virt.flash0", "pflash0");
+    s->flash[1] = virt_flash_create1(s, "virt.flash1", "pflash1");
+}
+
+static void virt_flash_map1(PFlashCFI01 *flash,
+                            hwaddr base, hwaddr size,
+                            MemoryRegion *sysmem)
+{
+    DeviceState *dev = DEVICE(flash);
+
+    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
+    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
+    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
+    qdev_init_nofail(dev);
+
+    memory_region_add_subregion(sysmem, base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       0));
+}
+
+static void virt_flash_map(RISCVVirtState *s,
+                           MemoryRegion *sysmem)
+{
+    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
+
+    virt_flash_map1(s->flash[0], flashbase, flashsize,
+                    sysmem);
+    virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
+                    sysmem);
+}
+
 static void create_pcie_irq_map(void *fdt, char *nodename,
                                 uint32_t plic_phandle)
 {
@@ -121,6 +187,8 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     char *nodename;
     uint32_t plic_phandle, phandle = 1;
     int i;
+    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -314,6 +382,15 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
     g_free(nodename);
+
+    nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
+    qemu_fdt_add_subnode(s->fdt, nodename);
+    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "cfi-flash");
+    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
+                                 2, flashbase, 2, flashsize,
+                                 2, flashbase + flashsize, 2, flashsize);
+    qemu_fdt_setprop_cell(s->fdt, nodename, "bank-width", 4);
+    g_free(nodename);
 }
 
 
@@ -493,6 +570,15 @@ static void riscv_virt_board_init(MachineState *machine)
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    virt_flash_create(s);
+
+    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
+        /* Map legacy -drive if=pflash to machine properties */
+        pflash_cfi01_legacy_drive(s->flash[i],
+                                  drive_get(IF_PFLASH, 0, i));
+    }
+    virt_flash_map(s, system_memory);
+
     g_free(plic_hart_config);
 }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 3d875305d3..b17048a93a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -21,6 +21,7 @@
 
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
+#include "hw/block/flash.h"
 
 #define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
 #define RISCV_VIRT_MACHINE(obj) \
@@ -33,6 +34,7 @@ typedef struct {
     /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
+    PFlashCFI01 *flash[2];
 
     void *fdt;
     int fdt_size;
@@ -46,6 +48,7 @@ enum {
     VIRT_PLIC,
     VIRT_UART0,
     VIRT_VIRTIO,
+    VIRT_FLASH,
     VIRT_DRAM,
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
-- 
2.21.0


