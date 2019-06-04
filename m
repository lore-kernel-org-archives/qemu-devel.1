Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D13DC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC14A23CE7
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="MO/dXTmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC14A23CE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCVc-00051T-65
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:42:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCGL-0000zF-2o
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCGJ-00041d-Uu
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:26:13 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCGH-0003d2-Ho; Tue, 04 Jun 2019 12:26:09 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id 01B3496F6C;
	Tue,  4 Jun 2019 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=CihRZQunkxTGZ4U7sNwYsib0KibNAR66LPQ5v0zTSC4=;
	b=MO/dXTmDEHb8C5VJLfz/lbmaj+YnAT52ftDmmz9Uh2aD61bcvm/UqsttXVJ5P/lqqsc3o4
	Wc/4kbBH+QMUtGq81Zu5ZhlD4IrsZdBtXkRl+NEby7d1czwk3FkJFD/KQaJfpJnZfmV25N
	uOPn31JkUtjKMGTjMzpgGfSZTCKWZQM=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:25 +0200
Message-Id: <20190604162526.10655-12-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=CihRZQunkxTGZ4U7sNwYsib0KibNAR66LPQ5v0zTSC4=;
	b=Dj16i1Kr8SiQ97HKvf66ZNVNY1Gkfm1d5rbs/5CDCcIlQ5VUClIOeT6OMvgLebVT0INH2l
	DZMZf2Ie31Ykw22O58NUG1K/8KhYvTk4WcpENlIUyCc+55CEX/n2+TlgZnu9shRqEUp3ww
	F7twX4NvoEUbElFr4+dnL2Lzzply2Zw=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665548; a=rsa-sha256; cv=none;
	b=ZQqaIiB+16PRLS4keI5kd7wD0qmQsGtSsTtZb3D7hmiRmcn8ywyAK82GjXtmIWvilJfziu
	8MPHO1IjrlRKD0MJ0tyDr4YUqkTImsZvfAtdvhSZcihyZCHwLA44Ub8OZT4skd0q1no7wM
	UnhTkLBLyCmnG5F/AEmFmQTeVg32rw4=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 11/12] Add uart reset support in
 zynq_slcr
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

Add two gpio outputs to control the uart resets.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/misc/zynq_slcr.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index c6d2bba966..6649c93a90 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -96,6 +96,10 @@ REG32(SPI_RST_CTRL, 0x21c)
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
@@ -189,8 +193,14 @@ typedef struct ZynqSLCRState {
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
 static void zynq_slcr_reset_init(Object *obj, bool cold)
 {
     ZynqSLCRState *s =3D ZYNQ_SLCR(obj);
@@ -292,6 +302,24 @@ static void zynq_slcr_reset_init(Object *obj, bool c=
old)
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
@@ -431,6 +459,9 @@ static void zynq_slcr_write(void *opaque, hwaddr offs=
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
@@ -447,6 +478,9 @@ static void zynq_slcr_init(Object *obj)
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
@@ -469,7 +503,7 @@ static void zynq_slcr_class_init(ObjectClass *klass, =
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
2.21.0


