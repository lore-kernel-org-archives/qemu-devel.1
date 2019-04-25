Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C18C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE28218B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE28218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJdNy-0006qW-G7
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 08:21:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hJdL5-0004IN-7w
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hJdL3-0005xO-CF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:18:55 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:49055
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hJdKz-0005of-Os
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:18:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 2DA65813A0;
	Thu, 25 Apr 2019 14:18:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3zT0ZcBvF3fx; Thu, 25 Apr 2019 14:18:44 +0200 (CEST)
Received: from localhost.localdomain.localdomain
	(apoitiers-155-1-191-106.w109-220.abo.wanadoo.fr [109.220.154.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id EA4C281392;
	Thu, 25 Apr 2019 14:18:43 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 14:18:33 +0200
Message-Id: <1556194715-24427-2-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
References: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: [Qemu-devel] [PATCH v2 1/3] leon3: add a little bootloader
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	chouteau@adacore.com, frederic.konrad@adacore.com,
	philmd@redhat.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425121833.xwG6pE0uOYdmr7OWsBUzAVwEzPi3moUgNOYoS605jRw@z>

This adds a little bootloader to the leon3_machine when a ram image is
given through the kernel parameter and no bios are provided:
  * The UART transmiter is enabled.
  * The TIMER is initialized.

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/sparc/leon3.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-=
------
 1 file changed, 74 insertions(+), 10 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 774639a..f25432c 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -1,7 +1,7 @@
 /*
  * QEMU Leon3 System Emulator
  *
- * Copyright (c) 2010-2011 AdaCore
+ * Copyright (c) 2010-2019 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
  * of this software and associated documentation files (the "Software"),=
 to deal
@@ -44,6 +44,8 @@
 #define CPU_CLK (40 * 1000 * 1000)
=20
 #define PROM_FILENAME        "u-boot.bin"
+#define LEON3_PROM_OFFSET    (0x00000000)
+#define LEON3_RAM_OFFSET     (0x40000000)
=20
 #define MAX_PILS 16
=20
@@ -53,6 +55,59 @@ typedef struct ResetData {
     target_ulong sp;            /* initial stack pointer */
 } ResetData;
=20
+static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val=
)
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
+ * When loading a kernel in RAM the machine is expected to be in a diffe=
rent
+ * state (eg: initialized by the bootloader). This little code reproduce=
s
+ * this behavior.
+ */
+static void write_bootloader(CPUSPARCState *env, uint8_t *base,
+                             hwaddr kernel_addr)
+{
+    uint32_t *p =3D (uint32_t *) base;
+
+    /* Initialize the UARTs                                        */
+    /* *UART_CONTROL =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
+    p =3D gen_store_u32(p, 0x80000108, 3);
+
+    /* Initialize the TIMER 0                                      */
+    /* *GPTIMER_SCALER_RELOAD =3D 40 - 1;                            */
+    p =3D gen_store_u32(p, 0x80000304, 39);
+    /* *GPTIMER0_COUNTER_RELOAD =3D 0xFFFE;                          */
+    p =3D gen_store_u32(p, 0x80000314, 0xFFFFFFFE);
+    /* *GPTIMER0_CONFIG =3D GPTIMER_ENABLE | GPTIMER_RESTART;        */
+    p =3D gen_store_u32(p, 0x80000318, 3);
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
     ResetData *s   =3D (ResetData *)opaque;
@@ -131,11 +186,12 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
     /* Reset data */
     reset_info        =3D g_malloc0(sizeof(ResetData));
     reset_info->cpu   =3D cpu;
-    reset_info->sp    =3D 0x40000000 + ram_size;
+    reset_info->sp    =3D LEON3_RAM_OFFSET + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
=20
     /* Allocate IRQ manager */
-    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS, &leon3_set_=
pil_in);
+    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS,
+                       &leon3_set_pil_in);
=20
     env->qemu_irq_ack =3D leon3_irq_manager;
=20
@@ -148,13 +204,13 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
     }
=20
     memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram_siz=
e);
-    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
+    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, ram=
);
=20
     /* Allocate BIOS */
     prom_size =3D 8 * MiB;
     memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_f=
atal);
     memory_region_set_readonly(prom, true);
-    memory_region_add_subregion(address_space_mem, 0x00000000, prom);
+    memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET, pr=
om);
=20
     /* Load boot prom */
     if (bios_name =3D=3D NULL) {
@@ -174,7 +230,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
     }
=20
     if (bios_size > 0) {
-        ret =3D load_image_targphys(filename, 0x00000000, bios_size);
+        ret =3D load_image_targphys(filename, LEON3_PROM_OFFSET, bios_si=
ze);
         if (ret < 0 || ret > prom_size) {
             error_report("could not load prom '%s'", filename);
             exit(1);
@@ -198,10 +254,18 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
             exit(1);
         }
         if (bios_size <=3D 0) {
-            /* If there is no bios/monitor, start the application.  */
-            env->pc =3D entry;
-            env->npc =3D entry + 4;
-            reset_info->entry =3D entry;
+            /*
+             * If there is no bios/monitor just start the application bu=
t put
+             * the machine in an initialized state through a little
+             * bootloader.
+             */
+            uint8_t *bootloader_entry;
+
+            bootloader_entry =3D memory_region_get_ram_ptr(prom);
+            write_bootloader(env, bootloader_entry, entry);
+            env->pc =3D LEON3_PROM_OFFSET;
+            env->npc =3D LEON3_PROM_OFFSET + 4;
+            reset_info->entry =3D LEON3_PROM_OFFSET;
         }
     }
=20
--=20
1.8.3.1


