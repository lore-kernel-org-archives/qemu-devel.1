Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A005C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09812177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09812177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHDU-0004Yd-20
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBS-0007yC-83
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:14 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:47877)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBN-0005uA-Tb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:13 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id 045621080B5;
 Thu, 27 Aug 2020 21:39:06 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id B23DE1C0696;
 Thu, 27 Aug 2020 21:39:05 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/20] hw/rx: New firmware loader.
Date: Thu, 27 Aug 2020 21:38:43 +0900
Message-Id: <20200827123859.81793-5-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.13;
 envelope-from=ysato@users.sourceforge.jp; helo=mail01.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Separate the loading of the firmware from the target definition
 as it is an obstacle to adding more targets.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/rx/rx62n.h | 15 +++++++
 hw/rx/rx-gdbsim.c     | 98 +++++++++++++++++++++----------------------
 hw/rx/rx62n.c         | 25 -----------
 3 files changed, 64 insertions(+), 74 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index aa94758c27..32e460bbad 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -45,6 +45,21 @@
 #define RX62N_NR_CMT    2
 #define RX62N_NR_SCI    6
 
+typedef struct RX62NClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+    const char *name;
+    uint64_t ram_size;
+    uint64_t rom_flash_size;
+    uint64_t data_flash_size;
+} RX62NClass;
+
+#define RX62N_MCU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RX62NClass, (klass), TYPE_RX62N_MCU)
+#define RX62N_MCU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RX62NClass, (obj), TYPE_RX62N_MCU)
+
 typedef struct RX62NState {
     /*< private >*/
     DeviceState parent_obj;
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 54992ebe57..02e03c797c 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/loader.h"
+#include "hw/rx/loader.h"
 #include "hw/rx/rx62n.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
@@ -40,6 +41,7 @@ typedef struct RxGdbSimMachineClass {
     /*< public >*/
     const char *mcu_name;
     uint32_t xtal_freq_hz;
+    size_t romsize;
 } RxGdbSimMachineClass;
 
 typedef struct RxGdbSimMachineState {
@@ -59,26 +61,39 @@ typedef struct RxGdbSimMachineState {
 #define RX_GDBSIM_MACHINE_GET_CLASS(obj) \
     OBJECT_GET_CLASS(RxGdbSimMachineClass, (obj), TYPE_RX_GDBSIM_MACHINE)
 
-static void rx_load_image(RXCPU *cpu, const char *filename,
-                          uint32_t start, uint32_t size)
+#define TINYBOOT_TOP (0xffffff00)
+
+static void set_bootstrap(hwaddr entry, hwaddr dtb)
 {
-    static uint32_t extable[32];
-    long kernel_size;
+    /* Minimal hardware initialize for kernel requirement */
+    /* linux kernel only works little-endian mode */
+    static uint8_t tinyboot[256] = {
+        0xfb, 0x2e, 0x20, 0x00, 0x08,       /* mov.l #0x80020, r2 */
+        0xf8, 0x2e, 0x00, 0x01, 0x01,       /* mov.l #0x00010100, [r2] */
+        0xfb, 0x2e, 0x10, 0x00, 0x08,       /* mov.l #0x80010, r2 */
+        0xf8, 0x22, 0xdf, 0x7d, 0xff, 0xff, /* mov.l #0xffff7ddf, [r2] */
+        0x62, 0x42,                         /* add #4, r2 */
+        0xf8, 0x22, 0xff, 0x7f, 0xff, 0x7f, /* mov.l #0x7fff7fff, [r2] */
+        0xfb, 0x2e, 0x40, 0x82, 0x08,       /* mov.l #0x88240, r2 */
+        0x3c, 0x22, 0x00,                   /* mov.b #0, 2[r2] */
+        0x3c, 0x21, 0x4e,                   /* mov.b #78, 1[r2] */
+        0xfb, 0x22, 0x70, 0xff, 0xff, 0xff, /* mov.l #0xffffff70, r2 */
+        0xec, 0x21,                         /* mov.l [r2], r1 */
+        0xfb, 0x22, 0x74, 0xff, 0xff, 0xff, /* mov.l #0xffffff74, r2 */
+        0xec, 0x22,                         /* mov.l [r2], r2 */
+        0x7f, 0x02,                         /* jmp r2 */
+    };
     int i;
 
-    kernel_size = load_image_targphys(filename, start, size);
-    if (kernel_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
-        exit(1);
-    }
-    cpu->env.pc = start;
+    *((uint32_t *)&tinyboot[0x70]) = cpu_to_le32(dtb);
+    *((uint32_t *)&tinyboot[0x74]) = cpu_to_le32(entry);
 
     /* setup exception trap trampoline */
-    /* linux kernel only works little-endian mode */
-    for (i = 0; i < ARRAY_SIZE(extable); i++) {
-        extable[i] = cpu_to_le32(0x10 + i * 4);
+    for (i = 0; i < 31; i++) {
+        *((uint32_t *)&tinyboot[0x40 + i * 4]) = cpu_to_le32(0x10 + i * 4);
     }
-    rom_add_blob_fixed("extable", extable, sizeof(extable), VECTOR_TABLE_BASE);
+    *((uint32_t *)&tinyboot[0xfc - 0x40]) = cpu_to_le32(TINYBOOT_TOP);
+    rom_add_blob_fixed("tinyboot", tinyboot, sizeof(tinyboot), TINYBOOT_TOP);
 }
 
 static void rx_gdbsim_init(MachineState *machine)
@@ -86,10 +101,11 @@ static void rx_gdbsim_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     RxGdbSimMachineState *s = RX_GDBSIM_MACHINE(machine);
     RxGdbSimMachineClass *rxc = RX_GDBSIM_MACHINE_GET_CLASS(machine);
+    RX62NClass *rx62nc;
     MemoryRegion *sysmem = get_system_memory();
     const char *kernel_filename = machine->kernel_filename;
     const char *dtb_filename = machine->dtb;
-
+    rx_kernel_info_t kernel_info;
     if (machine->ram_size < mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
         error_report("Invalid RAM size, should be more than %s", sz);
@@ -101,49 +117,33 @@ static void rx_gdbsim_init(MachineState *machine)
 
     /* Initialize MCU */
     object_initialize_child(OBJECT(machine), "mcu", &s->mcu, rxc->mcu_name);
+    rx62nc = RX62N_MCU_GET_CLASS(&s->mcu);
     object_property_set_link(OBJECT(&s->mcu), "main-bus", OBJECT(sysmem),
                              &error_abort);
     object_property_set_uint(OBJECT(&s->mcu), "xtal-frequency-hz",
                              rxc->xtal_freq_hz, &error_abort);
-    object_property_set_bool(OBJECT(&s->mcu), "load-kernel",
-                             kernel_filename != NULL, &error_abort);
-    qdev_realize(DEVICE(&s->mcu), NULL, &error_abort);
-
     /* Load kernel and dtb */
     if (kernel_filename) {
-        ram_addr_t kernel_offset;
-
-        /*
-         * The kernel image is loaded into
-         * the latter half of the SDRAM space.
-         */
-        kernel_offset = machine->ram_size / 2;
-        rx_load_image(RXCPU(first_cpu), kernel_filename,
-                      SDRAM_BASE + kernel_offset, kernel_offset);
-        if (dtb_filename) {
-            ram_addr_t dtb_offset;
-            int dtb_size;
-            void *dtb;
-
-            dtb = load_device_tree(dtb_filename, &dtb_size);
-            if (dtb == NULL) {
-                error_report("Couldn't open dtb file %s", dtb_filename);
-                exit(1);
-            }
-            if (machine->kernel_cmdline &&
-                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
-                                        machine->kernel_cmdline) < 0) {
-                error_report("Couldn't set /chosen/bootargs");
-                exit(1);
+        kernel_info.ram_start = SDRAM_BASE;
+        kernel_info.ram_size = machine->ram_size;
+        kernel_info.filename = kernel_filename;
+        kernel_info.dtbname = dtb_filename;
+        kernel_info.cmdline = machine->kernel_cmdline;
+        if (!load_kernel(&kernel_info)) {
+            exit(1);
+        }
+        set_bootstrap(kernel_info.entry, kernel_info.dtb_address);
+    } else {
+        if (bios_name) {
+            if (!load_bios(bios_name, rx62nc->rom_flash_size, &error_abort)) {
+                exit(0);
             }
-            /* DTB is located at the end of SDRAM space. */
-            dtb_offset = machine->ram_size - dtb_size;
-            rom_add_blob_fixed("dtb", dtb, dtb_size,
-                               SDRAM_BASE + dtb_offset);
-            /* Set dtb address to R1 */
-            RXCPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
+        } else if (!qtest_enabled()) {
+            error_report("No bios or kernel specified");
+            exit(1);
         }
     }
+    qdev_realize(DEVICE(&s->mcu), NULL, &error_abort);
 }
 
 static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index b9c217ebfa..4b5c3c1079 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -60,21 +60,6 @@
 #define RX62N_XTAL_MAX_HZ (14 * 1000 * 1000)
 #define RX62N_PCLK_MAX_HZ (50 * 1000 * 1000)
 
-typedef struct RX62NClass {
-    /*< private >*/
-    DeviceClass parent_class;
-    /*< public >*/
-    const char *name;
-    uint64_t ram_size;
-    uint64_t rom_flash_size;
-    uint64_t data_flash_size;
-} RX62NClass;
-
-#define RX62N_MCU_CLASS(klass) \
-    OBJECT_CLASS_CHECK(RX62NClass, (klass), TYPE_RX62N_MCU)
-#define RX62N_MCU_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(RX62NClass, (obj), TYPE_RX62N_MCU)
-
 /*
  * IRQ -> IPR mapping table
  * 0x00 - 0x91: IPR no (IPR00 to IPR91)
@@ -245,15 +230,6 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
                            rxc->rom_flash_size, &error_abort);
     memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
 
-    if (!s->kernel) {
-        if (bios_name) {
-            rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
-        }  else if (!qtest_enabled()) {
-            error_report("No bios or kernel specified");
-            exit(1);
-        }
-    }
-
     /* Initialize CPU */
     object_initialize_child(OBJECT(s), "cpu", &s->cpu, TYPE_RX62N_CPU);
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
@@ -270,7 +246,6 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
 static Property rx62n_properties[] = {
     DEFINE_PROP_LINK("main-bus", RX62NState, sysmem, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-    DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
     DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NState, xtal_freq_hz, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.20.1


