Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCD8C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772B624659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZsdfzpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772B624659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFWY-00059o-2C
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEYc-000400-JI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEYa-0000sQ-W5
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:26:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57096
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEYZ-0000it-VS
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RVrvv9IFtOxf7TVu5YfYeIqWyis1fMQehJN3vG2vBTg=;
 b=hZsdfzpougtu8kcBQiAxuTeOuqmDtlQSbTRL4Ct4qqKBeSBprFK1F5yT0ru7vC/yG3D9K6
 1iUPmoEjPEVJlPW6iQNth2R3PwJS/CDYG7qLfPrL7FOt9LPnaIjLXlUZ38V4RCffbgql3h
 Bx26SkqIqa2z2WEzNEGZWwf6qyQj7QM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-u2CuVsTvOYaalhZ8yW_cuA-1; Fri, 06 Dec 2019 02:23:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B900DB20;
 Fri,  6 Dec 2019 07:23:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-212.brq.redhat.com [10.40.204.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F49B19C4F;
 Fri,  6 Dec 2019 07:23:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] hw/arm/sbsa-ref: Call qdev_get_gpio_in in place
Date: Fri,  6 Dec 2019 08:22:57 +0100
Message-Id: <20191206072257.7221-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: u2CuVsTvOYaalhZ8yW_cuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, qemu-arm@nongnu.org,
 Leif Lindholm <leif.lindholm@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of filling an array of qemu_irq and passing it around,
directly call qdev_get_gpio_in() on the GIC.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
I accept better patch subject suggestions :)
---
 hw/arm/sbsa-ref.c | 58 +++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 27046cc284..30cb647551 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -328,7 +328,7 @@ static void create_secure_ram(SBSAMachineState *sms,
     memory_region_add_subregion(secure_sysmem, base, secram);
 }
=20
-static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
+static DeviceState *create_gic(SBSAMachineState *sms)
 {
     unsigned int smp_cpus =3D MACHINE(sms)->smp.cpus;
     DeviceState *gicdev;
@@ -403,12 +403,10 @@ static void create_gic(SBSAMachineState *sms, qemu_ir=
q *pic)
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
=20
-    for (i =3D 0; i < NUM_IRQS; i++) {
-        pic[i] =3D qdev_get_gpio_in(gicdev, i);
-    }
+    return gicdev;
 }
=20
-static void create_uart(const SBSAMachineState *sms, qemu_irq *pic, int ua=
rt,
+static void create_uart(const SBSAMachineState *sms, DeviceState *gic, int=
 uart,
                         MemoryRegion *mem, Chardev *chr)
 {
     hwaddr base =3D sbsa_ref_memmap[uart].base;
@@ -420,15 +418,15 @@ static void create_uart(const SBSAMachineState *sms, =
qemu_irq *pic, int uart,
     qdev_init_nofail(dev);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
-    sysbus_connect_irq(s, 0, pic[irq]);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(gic, irq));
 }
=20
-static void create_rtc(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_rtc(const SBSAMachineState *sms, DeviceState *gic)
 {
     hwaddr base =3D sbsa_ref_memmap[SBSA_RTC].base;
     int irq =3D sbsa_ref_irqmap[SBSA_RTC];
=20
-    sysbus_create_simple("pl031", base, pic[irq]);
+    sysbus_create_simple("pl031", base, qdev_get_gpio_in(gic, irq));
 }
=20
 static DeviceState *gpio_key_dev;
@@ -442,13 +440,13 @@ static Notifier sbsa_ref_powerdown_notifier =3D {
     .notify =3D sbsa_ref_powerdown_req
 };
=20
-static void create_gpio(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_gpio(const SBSAMachineState *sms, DeviceState *gic)
 {
     DeviceState *pl061_dev;
     hwaddr base =3D sbsa_ref_memmap[SBSA_GPIO].base;
     int irq =3D sbsa_ref_irqmap[SBSA_GPIO];
=20
-    pl061_dev =3D sysbus_create_simple("pl061", base, pic[irq]);
+    pl061_dev =3D sysbus_create_simple("pl061", base, qdev_get_gpio_in(gic=
, irq));
=20
     gpio_key_dev =3D sysbus_create_simple("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
@@ -457,7 +455,7 @@ static void create_gpio(const SBSAMachineState *sms, qe=
mu_irq *pic)
     qemu_register_powerdown_notifier(&sbsa_ref_powerdown_notifier);
 }
=20
-static void create_ahci(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_ahci(const SBSAMachineState *sms, DeviceState *gic)
 {
     hwaddr base =3D sbsa_ref_memmap[SBSA_AHCI].base;
     int irq =3D sbsa_ref_irqmap[SBSA_AHCI];
@@ -471,7 +469,7 @@ static void create_ahci(const SBSAMachineState *sms, qe=
mu_irq *pic)
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(gic, irq))=
;
=20
     sysahci =3D SYSBUS_AHCI(dev);
     ahci =3D &sysahci->ahci;
@@ -484,15 +482,15 @@ static void create_ahci(const SBSAMachineState *sms, =
qemu_irq *pic)
     }
 }
=20
-static void create_ehci(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_ehci(const SBSAMachineState *sms, DeviceState *gic)
 {
     hwaddr base =3D sbsa_ref_memmap[SBSA_EHCI].base;
     int irq =3D sbsa_ref_irqmap[SBSA_EHCI];
=20
-    sysbus_create_simple("platform-ehci-usb", base, pic[irq]);
+    sysbus_create_simple("platform-ehci-usb", base, qdev_get_gpio_in(gic, =
irq));
 }
=20
-static void create_smmu(const SBSAMachineState *sms, qemu_irq *pic,
+static void create_smmu(const SBSAMachineState *sms, DeviceState *gic,
                         PCIBus *bus)
 {
     hwaddr base =3D sbsa_ref_memmap[SBSA_SMMU].base;
@@ -507,11 +505,12 @@ static void create_smmu(const SBSAMachineState *sms, =
qemu_irq *pic,
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i =3D 0; i < NUM_SMMU_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(gic, irq + 1));
     }
 }
=20
-static void create_pcie(SBSAMachineState *sms, qemu_irq *pic)
+static void create_pcie(SBSAMachineState *sms, DeviceState *gic)
 {
     hwaddr base_ecam =3D sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
     hwaddr size_ecam =3D sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
@@ -555,7 +554,8 @@ static void create_pcie(SBSAMachineState *sms, qemu_irq=
 *pic)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
=20
     for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(gic, irq + 1));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
=20
@@ -574,7 +574,7 @@ static void create_pcie(SBSAMachineState *sms, qemu_irq=
 *pic)
=20
     pci_create_simple(pci->bus, -1, "VGA");
=20
-    create_smmu(sms, pic, pci->bus);
+    create_smmu(sms, gic, pci->bus);
 }
=20
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size=
)
@@ -598,7 +598,7 @@ static void sbsa_ref_init(MachineState *machine)
     bool firmware_loaded;
     const CPUArchIdList *possible_cpus;
     int n, sbsa_max_cpus;
-    qemu_irq pic[NUM_IRQS];
+    DeviceState *gic;
=20
     if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
         error_report("sbsa-ref: CPU type other than the built-in "
@@ -695,22 +695,22 @@ static void sbsa_ref_init(MachineState *machine)
=20
     create_secure_ram(sms, secure_sysmem);
=20
-    create_gic(sms, pic);
+    gic =3D create_gic(sms);
=20
-    create_uart(sms, pic, SBSA_UART, sysmem, serial_hd(0));
-    create_uart(sms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
+    create_uart(sms, gic, SBSA_UART, sysmem, serial_hd(0));
+    create_uart(sms, gic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
     /* Second secure UART for RAS and MM from EL0 */
-    create_uart(sms, pic, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2)=
);
+    create_uart(sms, gic, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2)=
);
=20
-    create_rtc(sms, pic);
+    create_rtc(sms, gic);
=20
-    create_gpio(sms, pic);
+    create_gpio(sms, gic);
=20
-    create_ahci(sms, pic);
+    create_ahci(sms, gic);
=20
-    create_ehci(sms, pic);
+    create_ehci(sms, gic);
=20
-    create_pcie(sms, pic);
+    create_pcie(sms, gic);
=20
     sms->bootinfo.ram_size =3D machine->ram_size;
     sms->bootinfo.nb_cpus =3D smp_cpus;
--=20
2.21.0


