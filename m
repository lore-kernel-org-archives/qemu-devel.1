Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB99C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F0520833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZQS-0007YX-0I
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:45:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM0-0004IO-N5
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZLz-00020W-7u
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:40 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55336
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLz-0001tA-0a
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:39 -0400
Received: from host109-146-247-8.range109-146.btcentralplus.com
	([109.146.247.8] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLF-00018L-J4; Fri, 17 May 2019 10:39:54 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 10:40:27 +0100
Message-Id: <20190517094029.7667-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
References: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.146.247.8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 6/8] leon3: add a little bootloader
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This adds a little bootloader to the leon3_machine when a ram image is
given through the kernel parameter and no bios are provided:
  * The UART transmiter is enabled.
  * The TIMER is initialized.

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/leon3.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 4f586910f2..6ba63e68ca 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -44,6 +44,8 @@
 #define CPU_CLK (40 * 1000 * 1000)
 
 #define LEON3_PROM_FILENAME "u-boot.bin"
+#define LEON3_PROM_OFFSET    (0x00000000)
+#define LEON3_RAM_OFFSET     (0x40000000)
 
 #define MAX_PILS 16
 
@@ -62,6 +64,59 @@ typedef struct ResetData {
     target_ulong sp;            /* initial stack pointer */
 } ResetData;
 
+static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
+{
+    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
+    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
+    stl_p(code++, 0x03000000 +
+      extract32(addr, 10, 22));
+                               /* sethi %hi(addr), %g1        */
+    stl_p(code++, 0x82106000 +
+      extract32(addr, 0, 10));
+                               /* or %g1, addr, %g1           */
+    stl_p(code++, 0x05000000 +
+      extract32(val, 10, 22));
+                               /* sethi %hi(val), %g2         */
+    stl_p(code++, 0x8410a000 +
+      extract32(val, 0, 10));
+                               /* or %g2, val, %g2            */
+    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
+
+    return code;
+}
+
+/*
+ * When loading a kernel in RAM the machine is expected to be in a different
+ * state (eg: initialized by the bootloader). This little code reproduces
+ * this behavior.
+ */
+static void write_bootloader(CPUSPARCState *env, uint8_t *base,
+                             hwaddr kernel_addr)
+{
+    uint32_t *p = (uint32_t *) base;
+
+    /* Initialize the UARTs                                        */
+    /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
+    p = gen_store_u32(p, 0x80000108, 3);
+
+    /* Initialize the TIMER 0                                      */
+    /* *GPTIMER_SCALER_RELOAD = 40 - 1;                            */
+    p = gen_store_u32(p, 0x80000304, 39);
+    /* *GPTIMER0_COUNTER_RELOAD = 0xFFFE;                          */
+    p = gen_store_u32(p, 0x80000314, 0xFFFFFFFE);
+    /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
+    p = gen_store_u32(p, 0x80000318, 3);
+
+    /* JUMP to the entry point                                     */
+    stl_p(p++, 0x82100000); /* mov %g0, %g1 */
+    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
+                            /* sethi %hi(kernel_addr), %g1 */
+    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
+                            /* or kernel_addr, %g1 */
+    stl_p(p++, 0x81c04000); /* jmp  %g1 */
+    stl_p(p++, 0x01000000); /* nop */
+}
+
 static void main_cpu_reset(void *opaque)
 {
     ResetData *s   = (ResetData *)opaque;
@@ -142,7 +197,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     /* Reset data */
     reset_info        = g_malloc0(sizeof(ResetData));
     reset_info->cpu   = cpu;
-    reset_info->sp    = 0x40000000 + ram_size;
+    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate IRQ manager */
@@ -164,13 +219,13 @@ static void leon3_generic_hw_init(MachineState *machine)
     }
 
     memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram_size);
-    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
+    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, ram);
 
     /* Allocate BIOS */
     prom_size = 8 * MiB;
     memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
     memory_region_set_readonly(prom, true);
-    memory_region_add_subregion(address_space_mem, 0x00000000, prom);
+    memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET, prom);
 
     /* Load boot prom */
     if (bios_name == NULL) {
@@ -190,7 +245,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     }
 
     if (bios_size > 0) {
-        ret = load_image_targphys(filename, 0x00000000, bios_size);
+        ret = load_image_targphys(filename, LEON3_PROM_OFFSET, bios_size);
         if (ret < 0 || ret > prom_size) {
             error_report("could not load prom '%s'", filename);
             exit(1);
@@ -220,10 +275,18 @@ static void leon3_generic_hw_init(MachineState *machine)
             exit(1);
         }
         if (bios_size <= 0) {
-            /* If there is no bios/monitor, start the application.  */
-            env->pc = entry;
-            env->npc = entry + 4;
-            reset_info->entry = entry;
+            /*
+             * If there is no bios/monitor just start the application but put
+             * the machine in an initialized state through a little
+             * bootloader.
+             */
+            uint8_t *bootloader_entry;
+
+            bootloader_entry = memory_region_get_ram_ptr(prom);
+            write_bootloader(env, bootloader_entry, entry);
+            env->pc = LEON3_PROM_OFFSET;
+            env->npc = LEON3_PROM_OFFSET + 4;
+            reset_info->entry = LEON3_PROM_OFFSET;
         }
     }
 
-- 
2.11.0


