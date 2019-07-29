Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C8AC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C349F21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="JFhI1VWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C349F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7PB-0005t3-1l
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79H-0007eV-Pg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79G-0006kf-EA
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:15 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs78x-0005Zz-SH; Mon, 29 Jul 2019 11:00:56 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id C54EF97082;
 Mon, 29 Jul 2019 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VM1iJKivn2M3c7C3sqBxBOTVwxONCMfs1SbQ7OUKqo=;
 b=JFhI1VWmw5aW8DhY6yb1HIbEVBPBLHw6o1FXIo1pOtJMjb4Xy8DJdCAbQh1UmRMUg71FYP
 RcDS1xWqPob4GrDhF7a0SnXgkbLerqE7w/5H84k7ZikohwRXTH6l4NTKvd3xD33RNJMueE
 Piu8+CwJ6aHwS/QvVlz5y0OsSO2Nc/Y=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:54 +0200
Message-Id: <20190729145654.14644-34-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VM1iJKivn2M3c7C3sqBxBOTVwxONCMfs1SbQ7OUKqo=;
 b=tPylVglyjK9gj7L05jvLEdTjQdzcShhevAGcpugN9tKGnnRPmDnIjLzVb0aFa3aj8BGmvY
 Krc4+SDcg2GkvqAoQU4jqYpy+T1qBajDRwazVHrA/46oVUVLoAY208vaCoChQ6m+8FJIoP
 H6/nIGQbxl+AnBVOLYWYyrYOViGJzJM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412377; a=rsa-sha256; cv=none;
 b=Rt9UvrTi1HwN2iK14uquO2Uf7oQ7gOVVHwpz1BIj2a6c1vFEbRwjiRfBD9EaWmjBNWcTr4
 6HvjLFVtH1ncBizrQ2fKV84IZNrmDFc8NkM7JR7Y+4RPx3k5+iDv4rzOYqCoAbHI0rhWwd
 yICqDgcfj4q+45phrH4/8Tspiz7VeSk=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 33/33] Connect the uart reset gpios in the
 zynq platform
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
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
index 89da34808b..bb56f1e03c 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -165,7 +165,7 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *ocm_ram =3D g_new(MemoryRegion, 1);
-    DeviceState *dev;
+    DeviceState *dev, *slcr;
     SysBusDevice *busdev;
     qemu_irq pic[64];
     int n;
@@ -210,9 +210,9 @@ static void zynq_init(MachineState *machine)
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
@@ -233,8 +233,10 @@ static void zynq_init(MachineState *machine)
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
index e1cf33e94c..c03c61a1f2 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -52,7 +52,10 @@ typedef struct {
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
@@ -64,6 +67,11 @@ static inline DeviceState *cadence_uart_create(hwaddr =
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
2.22.0


