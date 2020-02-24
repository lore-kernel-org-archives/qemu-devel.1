Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80549C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5D42080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="xkQ3puXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5D42080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HDp-0007fY-DH
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6H8i-0003An-Q0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6H8g-0005iP-0A
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:03:27 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:46614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1j6H8W-0005b5-CC; Mon, 24 Feb 2020 12:03:16 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id F2E4E96F57;
 Mon, 24 Feb 2020 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582563795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uutQKp6eXmpUWOk0nkvOXYyLqEDwh0CgmB9y3bqiiIY=;
 b=xkQ3puXGW0oTkHwFFdhsFuXGxcyDKzDugej45LpNBm0VGoAEULd/qQcecvTcrl4g2vB2Pe
 ISH7jXB+4iC7y5QyZxljSCnFCqwRI7QPDI98DCSCo5HMQAsouTJ4PUKFTnHoIS9fU59MAA
 /dykC7Sw3+rjo2/HYbuZxvrhw63MWsk=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 8/9] hw/arm/xilinx_zynq: connect uart clocks to slcr
Date: Mon, 24 Feb 2020 18:03:00 +0100
Message-Id: <20200224170301.246623-9-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224170301.246623-1-damien.hedde@greensocs.com>
References: <20200224170301.246623-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582563795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uutQKp6eXmpUWOk0nkvOXYyLqEDwh0CgmB9y3bqiiIY=;
 b=3xTCX7bArsEzUIzrAge9sFLh34QOwOcENN5Kq9li6yGwSFxtxp4XlaAoO5E67g5DtXHCSF
 BzmVKITxNVZie4sDpK/qYVa9lud6FOQE7fGOIUvX4NlCqnSZxPd0C4FfNJhX27B89A7Yrf
 6QZ1OCI96cbqrkSbOCZe7HK9V+Bfyh0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582563795; a=rsa-sha256; cv=none;
 b=Cgj0U5yhgQirTgCraqDffescohXm9iWQQNa/222tbZWnNeVXxsVfVfoeG3LV3GV6H7Gxzb
 nRJ3zuKbWnMcB+xsTYbgV3x+9NlxBCqkxjk9EB5g8drWm3QOHvAQtm8PT+y58fRvX/h93P
 3bh4J2FQTc+smsYduJMVNT7MAvBluFM=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the connection between the slcr's output clocks and the uarts inputs.

Also add the main board clock 'ps_clk', which is hard-coded to 33.33MHz
(the default frequency). This clock is used to feed the slcr's input
clock.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

---
v7
 + update ClockIn/ClockOut types
 + simplify the ps_clk frequency init
---
 hw/arm/xilinx_zynq.c | 57 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3a0fa5b23f..261a1690a8 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -34,6 +34,15 @@
 #include "hw/char/cadence_uart.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/qdev-clock.h"
+#include "sysemu/reset.h"
+
+#define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
+#define ZYNQ_MACHINE(obj) \
+    OBJECT_CHECK(ZynqMachineState, (obj), TYPE_ZYNQ_MACHINE)
+
+/* board base frequency: 33.333333 MHz */
+#define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
=20
 #define NUM_SPI_FLASHES 4
 #define NUM_QSPI_FLASHES 2
@@ -74,6 +83,11 @@ static const int dma_irqs[8] =3D {
     0xe3401000 + ARMV7_IMM16(extract32((val), 16, 16)), /* movt r1 ... *=
/ \
     0xe5801000 + (addr)
=20
+typedef struct ZynqMachineState {
+    MachineState parent;
+    Clock *ps_clk;
+} ZynqMachineState;
+
 static void zynq_write_board_setup(ARMCPU *cpu,
                                    const struct arm_boot_info *info)
 {
@@ -158,12 +172,13 @@ static inline void zynq_init_spi_flashes(uint32_t b=
ase_addr, qemu_irq irq,
=20
 static void zynq_init(MachineState *machine)
 {
+    ZynqMachineState *zynq_machine =3D ZYNQ_MACHINE(machine);
     ram_addr_t ram_size =3D machine->ram_size;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *ocm_ram =3D g_new(MemoryRegion, 1);
-    DeviceState *dev;
+    DeviceState *dev, *slcr;
     SysBusDevice *busdev;
     qemu_irq pic[64];
     int n;
@@ -208,9 +223,18 @@ static void zynq_init(MachineState *machine)
                           1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2=
aa,
                           0);
=20
-    dev =3D qdev_create(NULL, "xilinx,zynq_slcr");
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8000000);
+    /* Create slcr, keep a pointer to connect clocks */
+    slcr =3D qdev_create(NULL, "xilinx,zynq_slcr");
+    qdev_init_nofail(slcr);
+    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
+
+    /* Create the main clock source, and feed slcr with it */
+    zynq_machine->ps_clk =3D CLOCK(object_new(TYPE_CLOCK));
+    object_property_add_child(OBJECT(zynq_machine), "ps_clk",
+                              OBJECT(zynq_machine->ps_clk), &error_abort=
);
+    object_unref(OBJECT(zynq_machine->ps_clk));
+    clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
+    qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
=20
     dev =3D qdev_create(NULL, TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
@@ -231,8 +255,12 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET])=
;
     sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET])=
;
=20
-    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
-    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
+    dev =3D cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial=
_hd(0));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
+    dev =3D cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial=
_hd(1));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
=20
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
             pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], =
NULL);
@@ -310,8 +338,9 @@ static void zynq_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &zynq_binfo);
 }
=20
-static void zynq_machine_init(MachineClass *mc)
+static void zynq_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc =3D MACHINE_CLASS(oc);
     mc->desc =3D "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init =3D zynq_init;
     mc->max_cpus =3D 1;
@@ -320,4 +349,16 @@ static void zynq_machine_init(MachineClass *mc)
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
 }
=20
-DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
+static const TypeInfo zynq_machine_type =3D {
+    .name =3D TYPE_ZYNQ_MACHINE,
+    .parent =3D TYPE_MACHINE,
+    .class_init =3D zynq_machine_class_init,
+    .instance_size =3D sizeof(ZynqMachineState),
+};
+
+static void zynq_machine_register_types(void)
+{
+    type_register_static(&zynq_machine_type);
+}
+
+type_init(zynq_machine_register_types)
--=20
2.24.1


