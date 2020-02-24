Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2313AC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A328020838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Nj2SRToL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A328020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HHz-0004Mm-GP
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6H8j-0003Aq-T0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6H8h-0005jn-V3
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:03:29 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:46602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1j6H8V-0005aE-Nc; Mon, 24 Feb 2020 12:03:15 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 5C09896F56;
 Mon, 24 Feb 2020 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582563794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bB21GtN06DZNJaUHjbU4l90Vg+Ru8G4ozYaR4LBMQ+Q=;
 b=Nj2SRToLewbAxnWA4H/Kl/bK2Wz/bxZWe6nlAvyUx53xLYKJ8XBahma1dWwRoxwYa70Z5N
 NA95OJ4pUESnEVeHqcJ0WtbkWFo33xKdl5NWSxQHcCTdsX06xlmTWFAkGXqasMTv0xBPGe
 skGiJ3+V/hpvyYZZqOEB/9u/AmKz/cE=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 7/9] hw/char/cadence_uart: add clock support
Date: Mon, 24 Feb 2020 18:02:59 +0100
Message-Id: <20200224170301.246623-8-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224170301.246623-1-damien.hedde@greensocs.com>
References: <20200224170301.246623-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582563794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bB21GtN06DZNJaUHjbU4l90Vg+Ru8G4ozYaR4LBMQ+Q=;
 b=Rjlb4WLwH4wHwPcTw1rVwhcmoHbMFDrbBC52GG4uPpSaI88Qmd0lWxGnkaYZIIBqUZGxhK
 MkTR0bibdKYD7D3ByQCFc8AwbIWbsq7lRD1mX5VNaZ+A4XzMlzxkDb5BIfX4wfEOi18mtq
 zO+EmF8SsBwaxYoXMFPEYZAkC6fZYSc=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582563794; a=rsa-sha256; cv=none;
 b=W8aAoPKwah911pI+zTBD3ec0s43WGulxTnlOOKffm/MEvjxPjU/uTT7G5a5HSdTKVJhbky
 fvCirljDvjvHAs30XsiejwBa2Z4IFNVg8bx8yQnyRkKVjHCdfjczz27DC8PBlQKKofBrkA
 fRbxgV3KklpXO6h4fdgMfKCjjqrXx+k=
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

Switch the cadence uart to multi-phase reset and add the
reference clock input.

The input clock frequency is added to the migration structure.

The reference clock controls the baudrate generation. If it disabled,
any input characters and events are ignored.

If this clock remains unconnected, the uart behaves as before
(it default to a 50MHz ref clock).

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

---

v7:
 + update ClockIn/ClockOut types
 + update due to resettable changes
 + use a versioned field instead subsection in vmstate
---
 include/hw/char/cadence_uart.h |  1 +
 hw/char/cadence_uart.c         | 73 +++++++++++++++++++++++++++++-----
 hw/char/trace-events           |  3 ++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index 47cec956c4..2a179a572f 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -49,6 +49,7 @@ typedef struct {
     CharBackend chr;
     qemu_irq irq;
     QEMUTimer *fifo_trigger_handle;
+    Clock *refclk;
 } CadenceUARTState;
=20
 static inline DeviceState *cadence_uart_create(hwaddr addr,
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 22e47972f1..e196906c92 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -31,6 +31,8 @@
 #include "qemu/module.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "trace.h"
=20
 #ifdef CADENCE_UART_ERR_DEBUG
 #define DB_PRINT(...) do { \
@@ -97,7 +99,7 @@
 #define LOCAL_LOOPBACK         (0x2 << UART_MR_CHMODE_SH)
 #define REMOTE_LOOPBACK        (0x3 << UART_MR_CHMODE_SH)
=20
-#define UART_INPUT_CLK         50000000
+#define UART_DEFAULT_REF_CLK (50 * 1000 * 1000)
=20
 #define R_CR       (0x00/4)
 #define R_MR       (0x04/4)
@@ -171,12 +173,15 @@ static void uart_send_breaks(CadenceUARTState *s)
 static void uart_parameters_setup(CadenceUARTState *s)
 {
     QEMUSerialSetParams ssp;
-    unsigned int baud_rate, packet_size;
+    unsigned int baud_rate, packet_size, input_clk;
+    input_clk =3D clock_get_hz(s->refclk);
=20
-    baud_rate =3D (s->r[R_MR] & UART_MR_CLKS) ?
-            UART_INPUT_CLK / 8 : UART_INPUT_CLK;
+    baud_rate =3D (s->r[R_MR] & UART_MR_CLKS) ? input_clk / 8 : input_cl=
k;
+    baud_rate /=3D (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
+    trace_cadence_uart_baudrate(baud_rate);
+
+    ssp.speed =3D baud_rate;
=20
-    ssp.speed =3D baud_rate / (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
     packet_size =3D 1;
=20
     switch (s->r[R_MR] & UART_MR_PAR) {
@@ -215,6 +220,13 @@ static void uart_parameters_setup(CadenceUARTState *=
s)
     }
=20
     packet_size +=3D ssp.data_bits + ssp.stop_bits;
+    if (ssp.speed =3D=3D 0) {
+        /*
+         * Avoid division-by-zero below.
+         * TODO: find something better
+         */
+        ssp.speed =3D 1;
+    }
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / ssp.speed) * packet_si=
ze;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 }
@@ -340,6 +352,11 @@ static void uart_receive(void *opaque, const uint8_t=
 *buf, int size)
     CadenceUARTState *s =3D opaque;
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
=20
+    /* ignore characters when unclocked or in reset */
+    if (!clock_is_enabled(s->refclk) || device_is_in_reset(DEVICE(s))) {
+        return;
+    }
+
     if (ch_mode =3D=3D NORMAL_MODE || ch_mode =3D=3D ECHO_MODE) {
         uart_write_rx_fifo(opaque, buf, size);
     }
@@ -353,6 +370,11 @@ static void uart_event(void *opaque, QEMUChrEvent ev=
ent)
     CadenceUARTState *s =3D opaque;
     uint8_t buf =3D '\0';
=20
+    /* ignore characters when unclocked or in reset */
+    if (!clock_is_enabled(s->refclk) || device_is_in_reset(DEVICE(s))) {
+        return;
+    }
+
     if (event =3D=3D CHR_EVENT_BREAK) {
         uart_write_rx_fifo(opaque, &buf, 1);
     }
@@ -462,9 +484,9 @@ static const MemoryRegionOps uart_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static void cadence_uart_reset(DeviceState *dev)
+static void cadence_uart_reset_init(Object *obj, ResetType type)
 {
-    CadenceUARTState *s =3D CADENCE_UART(dev);
+    CadenceUARTState *s =3D CADENCE_UART(obj);
=20
     s->r[R_CR] =3D 0x00000128;
     s->r[R_IMR] =3D 0;
@@ -473,6 +495,11 @@ static void cadence_uart_reset(DeviceState *dev)
     s->r[R_BRGR] =3D 0x0000028B;
     s->r[R_BDIV] =3D 0x0000000F;
     s->r[R_TTRIG] =3D 0x00000020;
+}
+
+static void cadence_uart_reset_hold(Object *obj)
+{
+    CadenceUARTState *s =3D CADENCE_UART(obj);
=20
     uart_rx_reset(s);
     uart_tx_reset(s);
@@ -491,6 +518,14 @@ static void cadence_uart_realize(DeviceState *dev, E=
rror **errp)
                              uart_event, NULL, s, NULL, true);
 }
=20
+static void cadence_uart_refclk_update(void *opaque)
+{
+    CadenceUARTState *s =3D opaque;
+
+    /* recompute uart's speed on clock change */
+    uart_parameters_setup(s);
+}
+
 static void cadence_uart_init(Object *obj)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
@@ -500,9 +535,23 @@ static void cadence_uart_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
=20
+    s->refclk =3D qdev_init_clock_in(DEVICE(obj), "refclk",
+            cadence_uart_refclk_update, s);
+    /* initialize the frequency in case the clock remains unconnected */
+    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
+
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 9600) * 10;
 }
=20
+static int cadence_uart_pre_load(void *opaque)
+{
+    CadenceUARTState *s =3D opaque;
+
+    /* the frequency will be overriden if the refclk field is present */
+    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
+    return 0;
+}
+
 static int cadence_uart_post_load(void *opaque, int version_id)
 {
     CadenceUARTState *s =3D opaque;
@@ -521,8 +570,9 @@ static int cadence_uart_post_load(void *opaque, int v=
ersion_id)
=20
 static const VMStateDescription vmstate_cadence_uart =3D {
     .name =3D "cadence_uart",
-    .version_id =3D 2,
+    .version_id =3D 3,
     .minimum_version_id =3D 2,
+    .pre_load =3D cadence_uart_pre_load,
     .post_load =3D cadence_uart_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
@@ -534,8 +584,9 @@ static const VMStateDescription vmstate_cadence_uart =
=3D {
         VMSTATE_UINT32(tx_count, CadenceUARTState),
         VMSTATE_UINT32(rx_wpos, CadenceUARTState),
         VMSTATE_TIMER_PTR(fifo_trigger_handle, CadenceUARTState),
+        VMSTATE_CLOCK_V(refclk, CadenceUARTState, 3),
         VMSTATE_END_OF_LIST()
-    }
+    },
 };
=20
 static Property cadence_uart_properties[] =3D {
@@ -546,10 +597,12 @@ static Property cadence_uart_properties[] =3D {
 static void cadence_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
     dc->realize =3D cadence_uart_realize;
     dc->vmsd =3D &vmstate_cadence_uart;
-    dc->reset =3D cadence_uart_reset;
+    rc->phases.enter =3D cadence_uart_reset_init;
+    rc->phases.hold  =3D cadence_uart_reset_hold;
     device_class_set_props(dc, cadence_uart_properties);
   }
=20
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 6f938301d9..d20eafd56f 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -97,3 +97,6 @@ exynos_uart_wo_read(uint32_t channel, const char *name,=
 uint32_t reg) "UART%d: T
 exynos_uart_rxsize(uint32_t channel, uint32_t size) "UART%d: Rx FIFO siz=
e: %d"
 exynos_uart_channel_error(uint32_t channel) "Wrong UART channel number: =
%d"
 exynos_uart_rx_timeout(uint32_t channel, uint32_t stat, uint32_t intsp) =
"UART%d: Rx timeout stat=3D0x%x intsp=3D0x%x"
+
+# hw/char/cadence_uart.c
+cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
--=20
2.24.1


