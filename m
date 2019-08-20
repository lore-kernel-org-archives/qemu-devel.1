Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C4AC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17BD22CF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17BD22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03O8-0008JW-Qv
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i03Ln-000620-UL
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i03Lm-0002hq-47
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:34:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i03Lh-0002bM-1l; Tue, 20 Aug 2019 08:34:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5763D3084246;
 Tue, 20 Aug 2019 12:34:52 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9714A5C21F;
 Tue, 20 Aug 2019 12:34:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:34:17 +0200
Message-Id: <20190820123417.27930-3-philmd@redhat.com>
In-Reply-To: <20190820123417.27930-1-philmd@redhat.com>
References: <20190820123417.27930-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 20 Aug 2019 12:34:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 2/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The BCM2835 AUX UART is compatible with the 16650 model.
Since a such model is already available and tested, reuse
it.

TODO:
- The serial model hardcodes a 16B FIFO (16550A) while
  this model is a 8B FIFO
- Various 16550A register bits are not implemented, thus
  require to be properly masked
- How to keep migration working?
- How to use a chardev property?

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c  |   2 -
 hw/char/bcm2835_aux.c         | 211 +++-------------------------------
 include/hw/char/bcm2835_aux.h |   7 +-
 3 files changed, 20 insertions(+), 200 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8984e2e91f..dbe396fd40 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -167,8 +167,6 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_UART));
     /* AUX / UART1 */
-    qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
-
     object_property_set_bool(OBJECT(&s->aux), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 3f855196e3..10154b9530 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -2,149 +2,56 @@
  * BCM2835 (Raspberry Pi / Pi 2) Aux block (mini UART and SPI).
  * Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
- * Based on pl011.c, copyright terms below:
- *
- * Arm PrimeCell PL011 UART
- *
- * Copyright (c) 2006 CodeSourcery.
- * Written by Paul Brook
  *
  * This code is licensed under the GPL.
  *
  * At present only the core UART functions (data path for tx/rx) are
  * implemented. The following features/registers are unimplemented:
- *  - Line/modem control
- *  - Scratch register
  *  - Extra control
- *  - Baudrate
  *  - SPI interfaces
  */
=20
 #include "qemu/osdep.h"
 #include "hw/char/bcm2835_aux.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
+#include "sysemu/sysemu.h"
=20
 #define AUX_IRQ         0x0
 #define AUX_ENABLES     0x4
-#define AUX_MU_IO_REG   0x40
-#define AUX_MU_IER_REG  0x44
-#define AUX_MU_IIR_REG  0x48
-#define AUX_MU_LCR_REG  0x4c
-#define AUX_MU_MCR_REG  0x50
-#define AUX_MU_LSR_REG  0x54
-#define AUX_MU_MSR_REG  0x58
-#define AUX_MU_SCRATCH  0x5c
+#define AUX_MU_REGS     0x40
 #define AUX_MU_CNTL_REG 0x60
 #define AUX_MU_STAT_REG 0x64
 #define AUX_MU_BAUD_REG 0x68
=20
-/* bits in IER/IIR registers */
-#define RX_INT  0x1
-#define TX_INT  0x2
-
-static void bcm2835_aux_update(BCM2835AuxState *s)
-{
-    /* signal an interrupt if either:
-     * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
-     * 2. the tx interrupt is enabled (since we instantly drain the tx f=
ifo)
-     */
-    s->iir =3D 0;
-    if ((s->ier & RX_INT) && s->read_count !=3D 0) {
-        s->iir |=3D RX_INT;
-    }
-    if (s->ier & TX_INT) {
-        s->iir |=3D TX_INT;
-    }
-    qemu_set_irq(s->irq, s->iir !=3D 0);
-}
-
 static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned s=
ize)
 {
     BCM2835AuxState *s =3D opaque;
-    uint32_t c, res;
+    uint32_t res;
=20
     switch (offset) {
     case AUX_IRQ:
-        return s->iir !=3D 0;
+        return s->serial->iir !=3D 0;
=20
     case AUX_ENABLES:
         return 1; /* mini UART permanently enabled */
=20
-    case AUX_MU_IO_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        c =3D s->read_fifo[s->read_pos];
-        if (s->read_count > 0) {
-            s->read_count--;
-            if (++s->read_pos =3D=3D BCM2835_AUX_RX_FIFO_LEN) {
-                s->read_pos =3D 0;
-            }
-        }
-        qemu_chr_fe_accept_input(&s->chr);
-        bcm2835_aux_update(s);
-        return c;
-
-    case AUX_MU_IER_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        return 0xc0 | s->ier; /* FIFO enables always read 1 */
-
-    case AUX_MU_IIR_REG:
-        res =3D 0xc0; /* FIFO enables */
-        /* The spec is unclear on what happens when both tx and rx
-         * interrupts are active, besides that this cannot occur. At
-         * present, we choose to prioritise the rx interrupt, since
-         * the tx fifo is always empty. */
-        if (s->read_count !=3D 0) {
-            res |=3D 0x4;
-        } else {
-            res |=3D 0x2;
-        }
-        if (s->iir =3D=3D 0) {
-            res |=3D 0x1;
-        }
-        return res;
-
-    case AUX_MU_LCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n", __f=
unc__);
-        return 0;
-
-    case AUX_MU_MCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MCR_REG unsupported\n", __f=
unc__);
-        return 0;
-
-    case AUX_MU_LSR_REG:
-        res =3D 0x60; /* tx idle, empty */
-        if (s->read_count !=3D 0) {
-            res |=3D 0x1;
-        }
-        return res;
-
-    case AUX_MU_MSR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MSR_REG unsupported\n", __f=
unc__);
-        return 0;
-
-    case AUX_MU_SCRATCH:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_SCRATCH unsupported\n", __f=
unc__);
-        return 0;
-
     case AUX_MU_CNTL_REG:
         return 0x3; /* tx, rx enabled */
=20
     case AUX_MU_STAT_REG:
         res =3D 0x30e; /* space in the output buffer, empty tx fifo, idl=
e tx/rx */
-        if (s->read_count > 0) {
-            res |=3D 0x1; /* data in input buffer */
-            assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN);
-            res |=3D ((uint32_t)s->read_count) << 16; /* rx fifo fill le=
vel */
-        }
+        res |=3D fifo8_num_used(&s->serial->xmit_fifo) << 24;
+        res |=3D fifo8_num_used(&s->serial->recv_fifo) << 16;
+        res |=3D fifo8_is_empty(&s->serial->xmit_fifo) << 8;
+        res |=3D fifo8_is_full(&s->serial->xmit_fifo) << 5;
+        res |=3D fifo8_is_full(&s->serial->recv_fifo) << 4;
+        res |=3D !fifo8_is_full(&s->serial->xmit_fifo) << 1;
+        res |=3D !fifo8_is_empty(&s->serial->recv_fifo) << 0;
         return res;
=20
     case AUX_MU_BAUD_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n", __=
func__);
-        return 0;
+        return s->serial->divider;
=20
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
@@ -157,7 +64,6 @@ static void bcm2835_aux_write(void *opaque, hwaddr off=
set, uint64_t value,
                               unsigned size)
 {
     BCM2835AuxState *s =3D opaque;
-    unsigned char ch;
=20
     switch (offset) {
     case AUX_ENABLES:
@@ -167,81 +73,18 @@ static void bcm2835_aux_write(void *opaque, hwaddr o=
ffset, uint64_t value,
         }
         break;
=20
-    case AUX_MU_IO_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        ch =3D value;
-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        break;
-
-    case AUX_MU_IER_REG:
-        /* "DLAB bit set means access baudrate register" is NYI */
-        s->ier =3D value & (TX_INT | RX_INT);
-        bcm2835_aux_update(s);
-        break;
-
-    case AUX_MU_IIR_REG:
-        if (value & 0x2) {
-            s->read_count =3D 0;
-        }
-        break;
-
-    case AUX_MU_LCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n", __f=
unc__);
-        break;
-
-    case AUX_MU_MCR_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MCR_REG unsupported\n", __f=
unc__);
-        break;
-
-    case AUX_MU_SCRATCH:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_SCRATCH unsupported\n", __f=
unc__);
-        break;
-
     case AUX_MU_CNTL_REG:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_CNTL_REG unsupported\n", __=
func__);
         break;
=20
     case AUX_MU_BAUD_REG:
-        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n", __=
func__);
+        serial_set_divider(s->serial, value);
         break;
=20
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
                       __func__, offset);
     }
-
-    bcm2835_aux_update(s);
-}
-
-static int bcm2835_aux_can_receive(void *opaque)
-{
-    BCM2835AuxState *s =3D opaque;
-
-    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
-}
-
-static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
-{
-    BCM2835AuxState *s =3D opaque;
-    int slot;
-
-    slot =3D s->read_pos + s->read_count;
-    if (slot >=3D BCM2835_AUX_RX_FIFO_LEN) {
-        slot -=3D BCM2835_AUX_RX_FIFO_LEN;
-    }
-    s->read_fifo[slot] =3D value;
-    s->read_count++;
-    if (s->read_count =3D=3D BCM2835_AUX_RX_FIFO_LEN) {
-        /* buffer full */
-    }
-    bcm2835_aux_update(s);
-}
-
-static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int si=
ze)
-{
-    bcm2835_aux_put_fifo(opaque, *buf);
 }
=20
 static const MemoryRegionOps bcm2835_aux_ops =3D {
@@ -254,15 +97,9 @@ static const MemoryRegionOps bcm2835_aux_ops =3D {
=20
 static const VMStateDescription vmstate_bcm2835_aux =3D {
     .name =3D TYPE_BCM2835_AUX,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(read_fifo, BCM2835AuxState,
-                            BCM2835_AUX_RX_FIFO_LEN),
-        VMSTATE_UINT8(read_pos, BCM2835AuxState),
-        VMSTATE_UINT8(read_count, BCM2835AuxState),
-        VMSTATE_UINT8(ier, BCM2835AuxState),
-        VMSTATE_UINT8(iir, BCM2835AuxState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -276,29 +113,17 @@ static void bcm2835_aux_init(Object *obj)
                           TYPE_BCM2835_AUX, 0x100);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
+
+    s->serial =3D serial_mm_init(&s->iomem, AUX_MU_REGS, 2, s->irq, 2419=
200,
+                               serial_hd(1), DEVICE_LITTLE_ENDIAN);
 }
=20
-static void bcm2835_aux_realize(DeviceState *dev, Error **errp)
-{
-    BCM2835AuxState *s =3D BCM2835_AUX(dev);
-
-    qemu_chr_fe_set_handlers(&s->chr, bcm2835_aux_can_receive,
-                             bcm2835_aux_receive, NULL, NULL, s, NULL, t=
rue);
-}
-
-static Property bcm2835_aux_props[] =3D {
-    DEFINE_PROP_CHR("chardev", BCM2835AuxState, chr),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void bcm2835_aux_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
=20
-    dc->realize =3D bcm2835_aux_realize;
     dc->vmsd =3D &vmstate_bcm2835_aux;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    dc->props =3D bcm2835_aux_props;
 }
=20
 static const TypeInfo bcm2835_aux_info =3D {
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.=
h
index cdbf7e3e37..f534bccf5d 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -9,6 +9,7 @@
 #define BCM2835_AUX_H
=20
 #include "hw/sysbus.h"
+#include "hw/char/serial.h"
 #include "chardev/char-fe.h"
=20
 #define TYPE_BCM2835_AUX "bcm2835-aux"
@@ -22,12 +23,8 @@ typedef struct {
     /*< public >*/
=20
     MemoryRegion iomem;
-    CharBackend chr;
     qemu_irq irq;
-
-    uint8_t read_fifo[BCM2835_AUX_RX_FIFO_LEN];
-    uint8_t read_pos, read_count;
-    uint8_t ier, iir;
+    SerialState *serial;
 } BCM2835AuxState;
=20
 #endif
--=20
2.20.1


