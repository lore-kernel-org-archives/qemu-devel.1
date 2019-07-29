Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C1DC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF85A21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="dLSGNwEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF85A21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7SO-00048y-7V
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39906)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79G-0007ZR-BZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79E-0006i4-EP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:14 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs78x-0005a0-SV; Mon, 29 Jul 2019 11:00:56 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 63F0997069;
 Mon, 29 Jul 2019 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fki3DuRgk6JFE9a+j7+oWH+U0r34bgS+MNXGIekQZnU=;
 b=dLSGNwEpQa/20qyXIqWQDLdcESAX96U400gNwEvfr9wsyJaqlZ1ZFDYmyXCnomRQRkaJuX
 pVXUXsUeCJAysigd1Zp0xXi4EQ/RxGRA1VoD+coayzrqG9GP4INO3Py4NyuqorliAO3RQY
 XbJ321Te7+zsfFU8YdjTaUZ0zgo9aI4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:53 +0200
Message-Id: <20190729145654.14644-33-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fki3DuRgk6JFE9a+j7+oWH+U0r34bgS+MNXGIekQZnU=;
 b=D3Ba5CNsHloxQE/7q2Fo6MTt+nJj9RM2dg4sE5BGFGVQ4quJWStDjweXmmpYueaNXYRmPP
 WZfiJ34rcbt1bxEDxidnnAf1pJJ7WHPdM6Q9Oita8ymDVlSf+R5C0eysA8ra7G4hhVeefb
 ph/qxeiId+jQ+W+dvuJPNsPJKDrPZyU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412375; a=rsa-sha256; cv=none;
 b=T73fGYf+yfutNEO7kxdcE9AfaozDM7e+6TvG0gA00+Aa6/ONj7WYHbUZhIoFyBFWV6ueG1
 9jZgB5qBJSSZBDRKT68BGnv4oS3f+mPYhlYOSodCU/FXkObcTKrcRypku/dqrarlzGm2HZ
 rUtQrp4q4sQU8zwI4DknmdWMvgvhicw=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 32/33] Add uart reset support in zynq_slcr
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

Add two gpio outputs to control the uart resets.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/misc/zynq_slcr.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 6fcdbce4f0..b6c9a281c2 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -97,6 +97,10 @@ REG32(SPI_RST_CTRL, 0x21c)
 REG32(CAN_RST_CTRL, 0x220)
 REG32(I2C_RST_CTRL, 0x224)
 REG32(UART_RST_CTRL, 0x228)
+    FIELD(UART_RST_CTRL, UART0_CPU1X_RST, 0, 1)
+    FIELD(UART_RST_CTRL, UART1_CPU1X_RST, 1, 1)
+    FIELD(UART_RST_CTRL, UART0_REF_RST, 2, 1)
+    FIELD(UART_RST_CTRL, UART1_REF_RST, 3, 1)
 REG32(GPIO_RST_CTRL, 0x22c)
 REG32(LQSPI_RST_CTRL, 0x230)
 REG32(SMC_RST_CTRL, 0x234)
@@ -190,8 +194,14 @@ typedef struct ZynqSLCRState {
     MemoryRegion iomem;
=20
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
+
+    qemu_irq uart0_rst;
+    qemu_irq uart1_rst;
 } ZynqSLCRState;
=20
+#define ZYNQ_SLCR_REGFIELD_TO_OUT(state, irq, reg, field) \
+    qemu_set_irq((state)->irq, ARRAY_FIELD_EX32((state)->regs, reg, fiel=
d) !=3D 0)
+
 static void zynq_slcr_reset_init(Object *obj)
 {
     ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
@@ -293,6 +303,24 @@ static void zynq_slcr_reset_init(Object *obj)
     s->regs[R_DDRIOB + 12] =3D 0x00000021;
 }
=20
+static void zynq_slcr_compute_uart_reset(ZynqSLCRState *s)
+{
+    ZYNQ_SLCR_REGFIELD_TO_OUT(s, uart0_rst, UART_RST_CTRL, UART0_REF_RST=
);
+    ZYNQ_SLCR_REGFIELD_TO_OUT(s, uart1_rst, UART_RST_CTRL, UART1_REF_RST=
);
+}
+
+static void zynq_slcr_reset_hold(Object *obj)
+{
+    ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
+    ZynqSLCRClass *zc =3D ZYNQ_SLCR_GET_CLASS(obj);
+
+    if (zc->parent_reset_phases.hold) {
+        zc->parent_reset_phases.hold(obj);
+    }
+
+    zynq_slcr_compute_uart_reset(s);
+}
+
 static bool zynq_slcr_check_offset(hwaddr offset, bool rnw)
 {
     switch (offset) {
@@ -432,6 +460,9 @@ static void zynq_slcr_write(void *opaque, hwaddr offs=
et,
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
+    case R_UART_RST_CTRL:
+        zynq_slcr_compute_uart_reset(s);
+        break;
     }
 }
=20
@@ -448,6 +479,9 @@ static void zynq_slcr_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &slcr_ops, s, "slcr",
                           ZYNQ_SLCR_MMIO_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
+    qdev_init_gpio_out_named(DEVICE(obj), &s->uart0_rst, "uart0_rst", 1)=
;
+    qdev_init_gpio_out_named(DEVICE(obj), &s->uart1_rst, "uart1_rst", 1)=
;
 }
=20
 static const VMStateDescription vmstate_zynq_slcr =3D {
@@ -470,7 +504,7 @@ static void zynq_slcr_class_init(ObjectClass *klass, =
void *data)
=20
     resettable_class_set_parent_reset_phases(rc,
                                              zynq_slcr_reset_init,
-                                             NULL,
+                                             zynq_slcr_reset_hold,
                                              NULL,
                                              &zc->parent_reset_phases);
 }
--=20
2.22.0


