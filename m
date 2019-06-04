Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85F7C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4E323CDC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="r3PPACRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4E323CDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCTN-00038T-9f
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:39:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCGL-000102-Oj
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCGK-000422-Mn
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:26:13 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCGI-0003ea-8R; Tue, 04 Jun 2019 12:26:10 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id BE31F96F7B;
	Tue,  4 Jun 2019 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=hPGMgixGP9cMjZnkAysbw7ZF4rrVQ1Cey8fOKWl2H6M=;
	b=r3PPACRHX3mKBa1LqS1d0U/U+GxHe/y+LkRaCi46Y/JlC8fkKqxull3KLYelEKlbukSVCK
	zx5SCJ6ipiQCoCfIgHUS94DLXt+Ljp6p5fkorPrdDa26YON6/ftZ5Jhc0ylGcmP5Fl69wH
	6u6wWZA1qYQv6gDQlPR9W33ShpLYb9s=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:26 +0200
Message-Id: <20190604162526.10655-13-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=hPGMgixGP9cMjZnkAysbw7ZF4rrVQ1Cey8fOKWl2H6M=;
	b=DpRJPl4lrFiokKw3pUe0ZpGcJTDu/yrQdS3A8IHsrOJ/etF6n2MFRAhA3e9ECtwBvvEDM+
	LqXy9d9X4MTpaon2sZXUzrqw6gI70/BDl+pxyLkQ22X1fZh3vHjwHogZrKnefKQObZAVj5
	uWg1IV7r0MLf+Moodto9BmdoaJMqyTk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665549; a=rsa-sha256; cv=none;
	b=Uzbfd/I4A/nNTTls+Hs2QE1gyGisLFFbrQVkDniLxWN5zVq/icGaIJnCOaY85b41OshfXi
	o9wpt0KIq78uT1/KhEXKi5OblLb4dQTBV1O3x2h1/So8xXYmf+rDAS6Bkb4XVOJ2flaAw1
	DhYnwPHzD5+QgpP8p83YvrJUfmspq0g=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 12/12] Connect the uart reset gpios in
 the zynq platform
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	marc.burton@greensocs.com, alistair@alistair23.me,
	qemu-arm@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect the two uart reset inputs to the slcr corresponding outputs.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/arm/xilinx_zynq.c           | 14 ++++++++------
 include/hw/char/cadence_uart.h | 10 +++++++++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 198e3f9763..ed7549a6a2 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -166,7 +166,7 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *ocm_ram =3D g_new(MemoryRegion, 1);
-    DeviceState *dev;
+    DeviceState *dev, *slcr;
     SysBusDevice *busdev;
     qemu_irq pic[64];
     int n;
@@ -211,9 +211,9 @@ static void zynq_init(MachineState *machine)
                           1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2=
aa,
                           0);
=20
-    dev =3D qdev_create(NULL, "xilinx,zynq_slcr");
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8000000);
+    slcr =3D qdev_create(NULL, "xilinx,zynq_slcr");
+    qdev_init_nofail(slcr);
+    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
=20
     dev =3D qdev_create(NULL, TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
@@ -234,8 +234,10 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET])=
;
     sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET])=
;
=20
-    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
-    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
+    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0),
+                        slcr, "uart0_rst", 0);
+    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1),
+                        slcr, "uart1_rst", 0);
=20
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
             pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], =
NULL);
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index 118e3f10de..b7489a711f 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -51,7 +51,10 @@ typedef struct {
=20
 static inline DeviceState *cadence_uart_create(hwaddr addr,
                                         qemu_irq irq,
-                                        Chardev *chr)
+                                        Chardev *chr,
+                                        DeviceState *rst_dev,
+                                        const char *rst_name,
+                                        int rst_n)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -63,6 +66,11 @@ static inline DeviceState *cadence_uart_create(hwaddr =
addr,
     sysbus_mmio_map(s, 0, addr);
     sysbus_connect_irq(s, 0, irq);
=20
+    if (rst_dev) {
+        qdev_connect_gpio_out_named(rst_dev, rst_name, rst_n,
+                qdev_get_gpio_in_named(dev, "rst", 0));
+    }
+
     return dev;
 }
=20
--=20
2.21.0


