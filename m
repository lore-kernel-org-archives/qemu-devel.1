Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC04C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7510C206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mpV3YjKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7510C206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONOP-00067o-Gn
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCM-0004KK-NU; Fri, 02 Oct 2020 11:42:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCJ-0004A2-Rb; Fri, 02 Oct 2020 11:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601653335; x=1633189335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=urafqw6/5hxvDuPMaVr9zng5Nq+MbPlIdYqVYn2xjT4=;
 b=mpV3YjKOwOzHHrTQDrKhsrKazzHi5bgNVn40IgL4AwPdX30uH8gqXBZQ
 mVzAYoYJ3fs3YsNoPNnnaF3N2amy06tuAHn8lA7UZR/g8euGxUxNLI7Rt
 3lK6fTcye34vgGD6TeHcX9M4RrRPZHfsSvqu1L5sypQxWQXs8rNIVwnwJ
 RZxKUPdOz1+MYOuR/hdmLmrpX/+1vmA6hRu4EDVyhvDBC7bRcv+n7DodI
 YgFyuzXzONcUM+R8nkoF7HetWDEmn0ZdWxW9tiFVFRrd39H6gCvxUb4jP
 z+e7Uw0C0aYNEnFegpurTYiKNkyJ0YO4BD1IbbwB5EWk0QyKyqyDFFwYY w==;
IronPort-SDR: SGKARZi5oC/plm2ntz5o/fx+Xoflf+n1iC9G/7ATANkqrYv2OsZqZBwI3XRjghAxw3CIM+3/Rq
 gjUz4TkzSeSbuAxsjvPhMP+yRS0k1Q31UsB6am66FWHLSwQGrr5GkciDw3GHhvXuNrQw6vJf+I
 3lY3xMU4012T02M7YB1cSn/5c157z4CQMH/831CClyJmK2UMQ8SjfW5nxbW8phi/sa14Pd04U+
 qBsU5ehl74NnnPWI8IDO/01HmeFpWJVemPxauMabwcEN+/eudJYF29K03ngPS51176ZYyDia7G
 TAQ=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="258699511"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 23:42:13 +0800
IronPort-SDR: tLZ6q7HqHRSSlKJ57jRsl/JefF+adAlg9nYL/6NBNvluD2dSH6c8ho/zR1OJM76V6j5rk8M2PW
 SclGgEhYZVnQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:28:09 -0700
IronPort-SDR: MyilKsbWK4ebXnlC0Ky/FtZHq2eFo5M+VJj9EjUtbldKYU6KRaO8Ed0JI/eNsddncOQNWjmDl6
 ymsOPG3GR6qA==
WDCIronportException: Internal
Received: from dbzljc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.174])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Oct 2020 08:42:13 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 4/4] hw/riscv: Load the kernel after the firmware
Date: Fri,  2 Oct 2020 08:31:13 -0700
Message-Id: <4f272c9fab34bedc34b22adb8f9e2fb2dbd338d2.1601652616.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601652616.git.alistair.francis@wdc.com>
References: <cover.1601652616.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:42:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  1 +
 hw/riscv/boot.c         | 10 +++++-----
 hw/riscv/opentitan.c    |  3 ++-
 hw/riscv/sifive_e.c     |  3 ++-
 hw/riscv/sifive_u.c     | 13 +++++++++++--
 hw/riscv/spike.c        | 14 +++++++++++---
 hw/riscv/virt.c         | 14 +++++++++++---
 7 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 2975ed1a31..85d3227ea6 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -34,6 +34,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr,
                                  symbol_fn_t sym_cb);
 target_ulong riscv_load_kernel(const char *kernel_filename,
+                               target_ulong firmware_end_addr,
                                symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5dea644f47..f8e55ca16a 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -33,10 +33,8 @@
 #include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
-# define KERNEL_BOOT_ADDRESS 0x80400000
 #define fw_dynamic_info_data(__val)     cpu_to_le32(__val)
 #else
-# define KERNEL_BOOT_ADDRESS 0x80200000
 #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
 #endif
 
@@ -123,7 +121,9 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     exit(1);
 }
 
-target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
+target_ulong riscv_load_kernel(const char *kernel_filename,
+                               target_ulong kernel_start_addr,
+                               symbol_fn_t sym_cb)
 {
     uint64_t kernel_entry;
 
@@ -138,9 +138,9 @@ target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
         return kernel_entry;
     }
 
-    if (load_image_targphys_as(kernel_filename, KERNEL_BOOT_ADDRESS,
+    if (load_image_targphys_as(kernel_filename, kernel_start_addr,
                                ram_size, NULL) > 0) {
-        return KERNEL_BOOT_ADDRESS;
+        return kernel_start_addr;
     }
 
     error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 0531bd879b..cc758b78b8 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -75,7 +75,8 @@ static void opentitan_board_init(MachineState *machine)
     }
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, NULL);
+        riscv_load_kernel(machine->kernel_filename,
+                          memmap[IBEX_DEV_RAM].base, NULL);
     }
 }
 
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index fcfac16816..59bac4cc9a 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -114,7 +114,8 @@ static void sifive_e_machine_init(MachineState *machine)
                           memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, NULL);
+        riscv_load_kernel(machine->kernel_filename,
+                          memmap[SIFIVE_E_DEV_DTIM].base, NULL);
     }
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5f3ad9bc0f..08b0a3937d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -415,6 +415,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
+    target_ulong firmware_end_addr, kernel_start_addr;
     uint32_t start_addr_hi32 = 0x00000000;
     int i;
     uint32_t fdt_load_addr;
@@ -474,10 +475,18 @@ static void sifive_u_machine_init(MachineState *machine)
         break;
     }
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
+    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                                     start_addr, NULL);
 
     if (machine->kernel_filename) {
-        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
+        if (riscv_is_32_bit(machine)) {
+            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x400000);
+        } else {
+            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x200000);
+        }
+
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                         kernel_start_addr, NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3fd152a035..280fb1f328 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -195,6 +195,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    target_ulong firmware_end_addr, kernel_start_addr;
     uint32_t fdt_load_addr;
     uint64_t kernel_entry;
     char *soc_name;
@@ -261,12 +262,19 @@ static void spike_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
                                 mask_rom);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[SPIKE_DRAM].base,
-                                 htif_symbol_callback);
+    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                                     memmap[SPIKE_DRAM].base,
+                                                     htif_symbol_callback);
 
     if (machine->kernel_filename) {
+        if (riscv_is_32_bit(machine)) {
+            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x400000);
+        } else {
+            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x200000);
+        }
+
         kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                         kernel_start_addr,
                                          htif_symbol_callback);
 
         if (machine->initrd_filename) {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 41bd2f38ba..bf22d28eef 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -493,6 +493,7 @@ static void virt_machine_init(MachineState *machine)
     char *plic_hart_config, *soc_name;
     size_t plic_hart_config_len;
     target_ulong start_addr = memmap[VIRT_DRAM].base;
+    target_ulong firmware_end_addr, kernel_start_addr;
     uint32_t fdt_load_addr;
     uint64_t kernel_entry;
     DeviceState *mmio_plic, *virtio_plic, *pcie_plic;
@@ -602,11 +603,18 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[VIRT_DRAM].base, NULL);
+    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                                     start_addr, NULL);
 
     if (machine->kernel_filename) {
-        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
+        if (riscv_is_32_bit(machine)) {
+            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x400000);
+        } else {
+            kernel_start_addr = QEMU_ALIGN_UP(firmware_end_addr, 0x200000);
+        }
+
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                         kernel_start_addr, NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
-- 
2.28.0


