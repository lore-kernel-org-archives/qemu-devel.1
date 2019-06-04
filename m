Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6D8C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D42423CDC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="PT2EjDQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D42423CDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55249 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCTW-0003Gh-L1
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:39:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCG1-0000dC-Qh
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFz-0003iJ-Tw
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:53 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCFw-0003aF-0A; Tue, 04 Jun 2019 12:25:48 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id 6D65596F66;
	Tue,  4 Jun 2019 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=RJnlyxIty4fLwwQiMvBz/j1I0JzfWGjMPHXoCBbOxXs=;
	b=PT2EjDQG9SJEPXNUE6DFCZ7TwXTh4S2WsycqvJATPQeQXxlgLNoUWOaOx6XMZfBuo7RnRq
	wRc80TYY6eZvDkWFKnsOneHWCiBNJT8SgdAnnJlxa08ihAe5oMNY7CQlSurrInpKTRR/xS
	SVyLvpwYVjinOCDbQrtUyRifYv18R4M=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:23 +0200
Message-Id: <20190604162526.10655-10-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=RJnlyxIty4fLwwQiMvBz/j1I0JzfWGjMPHXoCBbOxXs=;
	b=5uFxHyoMJ2onrUfU8x44gQER65ssz+/p2HTTsBcFh5gg3GjCcgwrRwg/zEvazjZuQpPg26
	kkcAITaYgsXXfP1RZdJdjKk9HCBBjKDk+LlGUs26rEUdMxSviIBfhieNvOQDmilDFZr6m4
	BfDLyQsDGcnHrAZXkq1B6FD1ljZ4PwY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665547; a=rsa-sha256; cv=none;
	b=FAQQqQEQH7sumjpQLjQjDjevuovkwfVfkjmWRjiJFXUZmp0pb+HxgRimaHhQMfopISsZLQ
	CbVUMJBF1NW0xPVBOLNAa1vQ8z0TOS+IanVTmJ09DGIrCmz3xjhHpfnzM2Jvtx7gvp+/a3
	pNLqqqe//UmTp3XqsuPIqkIXvmNgFnE=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 09/12] convert cadence_uart to 3-phases
 reset
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

Split the existing reset procedure into 3 phases.
Test the resetting flag to discard register accesses
and character reception.
Also adds a active high reset io.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/char/cadence_uart.c | 81 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index fbdbd463bb..27e1c70678 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -38,6 +38,18 @@
     #define DB_PRINT(...)
 #endif
=20
+#define CADENCE_UART_CLASS(class) \
+    OBJECT_CLASS_CHECK(CadenceUartClass, (class), TYPE_CADENCE_UART)
+#define CADENCE_UART_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(CadenceUartClass, (obj), TYPE_CADENCE_UART)
+
+typedef struct CadenceUartClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+
+    struct ResettablePhases parent_reset_phases;
+} CadenceUartClass;
+
 #define UART_SR_INTR_RTRIG     0x00000001
 #define UART_SR_INTR_REMPTY    0x00000002
 #define UART_SR_INTR_RFUL      0x00000004
@@ -222,6 +234,10 @@ static int uart_can_receive(void *opaque)
     int ret =3D MAX(CADENCE_UART_RX_FIFO_SIZE, CADENCE_UART_TX_FIFO_SIZE=
);
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return 0;
+    }
+
     if (ch_mode =3D=3D NORMAL_MODE || ch_mode =3D=3D ECHO_MODE) {
         ret =3D MIN(ret, CADENCE_UART_RX_FIFO_SIZE - s->rx_count);
     }
@@ -337,6 +353,10 @@ static void uart_receive(void *opaque, const uint8_t=
 *buf, int size)
     CadenceUARTState *s =3D opaque;
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return;
+    }
+
     if (ch_mode =3D=3D NORMAL_MODE || ch_mode =3D=3D ECHO_MODE) {
         uart_write_rx_fifo(opaque, buf, size);
     }
@@ -350,6 +370,10 @@ static void uart_event(void *opaque, int event)
     CadenceUARTState *s =3D opaque;
     uint8_t buf =3D '\0';
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return;
+    }
+
     if (event =3D=3D CHR_EVENT_BREAK) {
         uart_write_rx_fifo(opaque, &buf, 1);
     }
@@ -382,6 +406,10 @@ static void uart_write(void *opaque, hwaddr offset,
 {
     CadenceUARTState *s =3D opaque;
=20
+    if (device_is_resetting((DeviceState *)opaque)) {
+        return;
+    }
+
     DB_PRINT(" offset:%x data:%08x\n", (unsigned)offset, (unsigned)value=
);
     offset >>=3D 2;
     if (offset >=3D CADENCE_UART_R_MAX) {
@@ -440,6 +468,10 @@ static uint64_t uart_read(void *opaque, hwaddr offse=
t,
     CadenceUARTState *s =3D opaque;
     uint32_t c =3D 0;
=20
+    if (device_is_resetting((DeviceState *)opaque)) {
+        return 0;
+    }
+
     offset >>=3D 2;
     if (offset >=3D CADENCE_UART_R_MAX) {
         c =3D 0;
@@ -459,9 +491,14 @@ static const MemoryRegionOps uart_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static void cadence_uart_reset(DeviceState *dev)
+static void cadence_uart_reset_init(Object *obj, bool cold)
 {
-    CadenceUARTState *s =3D CADENCE_UART(dev);
+    CadenceUARTState *s =3D CADENCE_UART(obj);
+    CadenceUartClass *cc =3D CADENCE_UART_GET_CLASS(obj);
+
+    if (cc->parent_reset_phases.init) {
+        cc->parent_reset_phases.init(obj, cold);
+    }
=20
     s->r[R_CR] =3D 0x00000128;
     s->r[R_IMR] =3D 0;
@@ -470,6 +507,28 @@ static void cadence_uart_reset(DeviceState *dev)
     s->r[R_BRGR] =3D 0x0000028B;
     s->r[R_BDIV] =3D 0x0000000F;
     s->r[R_TTRIG] =3D 0x00000020;
+}
+
+static void cadence_uart_reset_hold(Object *obj)
+{
+    CadenceUARTState *s =3D CADENCE_UART(obj);
+    CadenceUartClass *cc =3D CADENCE_UART_GET_CLASS(obj);
+
+    if (cc->parent_reset_phases.hold) {
+        cc->parent_reset_phases.hold(obj);
+    }
+
+    qemu_set_irq(s->irq, 0);
+}
+
+static void cadence_uart_reset_exit(Object *obj)
+{
+    CadenceUARTState *s =3D CADENCE_UART(obj);
+    CadenceUartClass *cc =3D CADENCE_UART_GET_CLASS(obj);
+
+    if (cc->parent_reset_phases.exit) {
+        cc->parent_reset_phases.exit(obj);
+    }
=20
     uart_rx_reset(s);
     uart_tx_reset(s);
@@ -498,6 +557,8 @@ static void cadence_uart_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq);
=20
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 9600) * 10;
+
+    qdev_init_warm_reset_gpio(DEVICE(obj), "rst", DEVICE_ACTIVE_HIGH);
 }
=20
 static int cadence_uart_post_load(void *opaque, int version_id)
@@ -532,6 +593,10 @@ static const VMStateDescription vmstate_cadence_uart=
 =3D {
         VMSTATE_UINT32(rx_wpos, CadenceUARTState),
         VMSTATE_TIMER_PTR(fifo_trigger_handle, CadenceUARTState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections =3D (const VMStateDescription * []) {
+        &device_vmstate_reset,
+        NULL
     }
 };
=20
@@ -543,12 +608,19 @@ static Property cadence_uart_properties[] =3D {
 static void cadence_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+    CadenceUartClass *cc =3D CADENCE_UART_CLASS(klass);
=20
     dc->realize =3D cadence_uart_realize;
     dc->vmsd =3D &vmstate_cadence_uart;
-    dc->reset =3D cadence_uart_reset;
     dc->props =3D cadence_uart_properties;
-  }
+
+    resettable_class_set_parent_reset_phases(rc,
+                                             cadence_uart_reset_init,
+                                             cadence_uart_reset_hold,
+                                             cadence_uart_reset_exit,
+                                             &cc->parent_reset_phases);
+}
=20
 static const TypeInfo cadence_uart_info =3D {
     .name          =3D TYPE_CADENCE_UART,
@@ -556,6 +628,7 @@ static const TypeInfo cadence_uart_info =3D {
     .instance_size =3D sizeof(CadenceUARTState),
     .instance_init =3D cadence_uart_init,
     .class_init    =3D cadence_uart_class_init,
+    .class_size =3D sizeof(CadenceUartClass),
 };
=20
 static void cadence_uart_register_types(void)
--=20
2.21.0


