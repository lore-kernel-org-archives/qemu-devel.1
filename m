Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FDFC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B7A2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B7A2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibOd-00011D-AU
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55045)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hib2F-0003gb-Nr
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hib2D-0003QN-Ve
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:54:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hib2A-00036K-6M; Wed, 03 Jul 2019 04:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C1CF558569;
 Wed,  3 Jul 2019 08:54:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 797E9891D6;
 Wed,  3 Jul 2019 08:54:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 80EC41750B; Wed,  3 Jul 2019 10:54:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 10:54:15 +0200
Message-Id: <20190703085416.21837-4-kraxel@redhat.com>
In-Reply-To: <20190703085416.21837-1-kraxel@redhat.com>
References: <20190703085416.21837-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 03 Jul 2019 08:54:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] hw/i2c/bitbang_i2c: Use in-place rather
 than malloc'd bitbang_i2c_interface struct
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Currently the bitbang_i2c_init() function allocates a
bitbang_i2c_interface struct which it returns.  This is unfortunate
because it means that if the function is used from a DeviceState
init method then the memory will be leaked by an "init then delete"
cycle, as used by the qmp/hmp commands that list device properties.

Since three out of four of the uses of this function are in
device init methods, switch the function to do an in-place
initialization of a struct that can be embedded in the
device state struct of the caller.

This fixes LeakSanitizer leak warnings that have appeared in the
patchew configuration (which only tries to run the sanitizers
for the x86_64-softmmu target) now that we use the bitbang-i2c
code in an x86-64 config.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190702163844.20458-1-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_int.h         |  2 +-
 include/hw/i2c/bitbang_i2c.h | 38 ++++++++++++++++++++++++++++-
 include/hw/i2c/ppc4xx_i2c.h  |  2 +-
 hw/display/ati.c             |  7 +++---
 hw/i2c/bitbang_i2c.c         | 47 +++---------------------------------
 hw/i2c/ppc4xx_i2c.c          |  6 ++---
 hw/i2c/versatile_i2c.c       |  8 +++---
 7 files changed, 53 insertions(+), 57 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 9b67d0022ad9..31a1927b3ecb 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -88,7 +88,7 @@ typedef struct ATIVGAState {
     uint16_t cursor_size;
     uint32_t cursor_offset;
     QEMUCursor *cursor;
-    bitbang_i2c_interface *bbi2c;
+    bitbang_i2c_interface bbi2c;
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
diff --git a/include/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
index 3a7126d5dee8..92334e9016a8 100644
--- a/include/hw/i2c/bitbang_i2c.h
+++ b/include/hw/i2c/bitbang_i2c.h
@@ -8,7 +8,43 @@ typedef struct bitbang_i2c_interface bitbang_i2c_interfa=
ce;
 #define BITBANG_I2C_SDA 0
 #define BITBANG_I2C_SCL 1
=20
-bitbang_i2c_interface *bitbang_i2c_init(I2CBus *bus);
+typedef enum bitbang_i2c_state {
+    STOPPED =3D 0,
+    SENDING_BIT7,
+    SENDING_BIT6,
+    SENDING_BIT5,
+    SENDING_BIT4,
+    SENDING_BIT3,
+    SENDING_BIT2,
+    SENDING_BIT1,
+    SENDING_BIT0,
+    WAITING_FOR_ACK,
+    RECEIVING_BIT7,
+    RECEIVING_BIT6,
+    RECEIVING_BIT5,
+    RECEIVING_BIT4,
+    RECEIVING_BIT3,
+    RECEIVING_BIT2,
+    RECEIVING_BIT1,
+    RECEIVING_BIT0,
+    SENDING_ACK,
+    SENT_NACK
+} bitbang_i2c_state;
+
+struct bitbang_i2c_interface {
+    I2CBus *bus;
+    bitbang_i2c_state state;
+    int last_data;
+    int last_clock;
+    int device_out;
+    uint8_t buffer;
+    int current_addr;
+};
+
+/**
+ * bitbang_i2c_init: in-place initialize the bitbang_i2c_interface struc=
t
+ */
+void bitbang_i2c_init(bitbang_i2c_interface *s, I2CBus *bus);
 int bitbang_i2c_set(bitbang_i2c_interface *i2c, int line, int level);
=20
 #endif
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 8437bf070b8b..f6f837fbec00 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -41,7 +41,7 @@ typedef struct PPC4xxI2CState {
     I2CBus *bus;
     qemu_irq irq;
     MemoryRegion iomem;
-    bitbang_i2c_interface *bitbang;
+    bitbang_i2c_interface bitbang;
     int mdidx;
     uint8_t mdata[4];
     uint8_t lmadr;
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0cb117384839..c1d9d1518f4a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -538,7 +538,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case GPIO_DVI_DDC:
         if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.gpio_dvi_ddc =3D ati_i2c(s->bbi2c, data, 0);
+            s->regs.gpio_dvi_ddc =3D ati_i2c(&s->bbi2c, data, 0);
         }
         break;
     case GPIO_MONID ... GPIO_MONID + 3:
@@ -554,7 +554,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
              */
             if ((s->regs.gpio_monid & BIT(25)) &&
                 addr <=3D GPIO_MONID + 2 && addr + size > GPIO_MONID + 2=
) {
-                s->regs.gpio_monid =3D ati_i2c(s->bbi2c, s->regs.gpio_mo=
nid, 1);
+                s->regs.gpio_monid =3D ati_i2c(&s->bbi2c, s->regs.gpio_m=
onid, 1);
             }
         }
         break;
@@ -856,7 +856,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **e=
rrp)
=20
     /* ddc, edid */
     I2CBus *i2cbus =3D i2c_init_bus(DEVICE(s), "ati-vga.ddc");
-    s->bbi2c =3D bitbang_i2c_init(i2cbus);
+    bitbang_i2c_init(&s->bbi2c, i2cbus);
     I2CSlave *i2cddc =3D I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC)=
);
     i2c_set_slave_address(i2cddc, 0x50);
=20
@@ -885,7 +885,6 @@ static void ati_vga_exit(PCIDevice *dev)
     ATIVGAState *s =3D ATI_VGA(dev);
=20
     graphic_console_close(s->vga.con);
-    g_free(s->bbi2c);
 }
=20
 static Property ati_vga_properties[] =3D {
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 3cb0509b0200..60c7a9be0bca 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -25,39 +25,6 @@ do { printf("bitbang_i2c: " fmt , ## __VA_ARGS__); } w=
hile (0)
 #define DPRINTF(fmt, ...) do {} while(0)
 #endif
=20
-typedef enum bitbang_i2c_state {
-    STOPPED =3D 0,
-    SENDING_BIT7,
-    SENDING_BIT6,
-    SENDING_BIT5,
-    SENDING_BIT4,
-    SENDING_BIT3,
-    SENDING_BIT2,
-    SENDING_BIT1,
-    SENDING_BIT0,
-    WAITING_FOR_ACK,
-    RECEIVING_BIT7,
-    RECEIVING_BIT6,
-    RECEIVING_BIT5,
-    RECEIVING_BIT4,
-    RECEIVING_BIT3,
-    RECEIVING_BIT2,
-    RECEIVING_BIT1,
-    RECEIVING_BIT0,
-    SENDING_ACK,
-    SENT_NACK
-} bitbang_i2c_state;
-
-struct bitbang_i2c_interface {
-    I2CBus *bus;
-    bitbang_i2c_state state;
-    int last_data;
-    int last_clock;
-    int device_out;
-    uint8_t buffer;
-    int current_addr;
-};
-
 static void bitbang_i2c_enter_stop(bitbang_i2c_interface *i2c)
 {
     DPRINTF("STOP\n");
@@ -184,18 +151,12 @@ int bitbang_i2c_set(bitbang_i2c_interface *i2c, int=
 line, int level)
     abort();
 }
=20
-bitbang_i2c_interface *bitbang_i2c_init(I2CBus *bus)
+void bitbang_i2c_init(bitbang_i2c_interface *s, I2CBus *bus)
 {
-    bitbang_i2c_interface *s;
-
-    s =3D g_malloc0(sizeof(bitbang_i2c_interface));
-
     s->bus =3D bus;
     s->last_data =3D 1;
     s->last_clock =3D 1;
     s->device_out =3D 1;
-
-    return s;
 }
=20
 /* GPIO interface.  */
@@ -207,7 +168,7 @@ typedef struct GPIOI2CState {
     SysBusDevice parent_obj;
=20
     MemoryRegion dummy_iomem;
-    bitbang_i2c_interface *bitbang;
+    bitbang_i2c_interface bitbang;
     int last_level;
     qemu_irq out;
 } GPIOI2CState;
@@ -216,7 +177,7 @@ static void bitbang_i2c_gpio_set(void *opaque, int ir=
q, int level)
 {
     GPIOI2CState *s =3D opaque;
=20
-    level =3D bitbang_i2c_set(s->bitbang, irq, level);
+    level =3D bitbang_i2c_set(&s->bitbang, irq, level);
     if (level !=3D s->last_level) {
         s->last_level =3D level;
         qemu_set_irq(s->out, level);
@@ -234,7 +195,7 @@ static void gpio_i2c_init(Object *obj)
     sysbus_init_mmio(sbd, &s->dummy_iomem);
=20
     bus =3D i2c_init_bus(dev, "i2c");
-    s->bitbang =3D bitbang_i2c_init(bus);
+    bitbang_i2c_init(&s->bitbang, bus);
=20
     qdev_init_gpio_in(dev, bitbang_i2c_gpio_set, 2);
     qdev_init_gpio_out(dev, &s->out, 1);
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 5fb4f86c38f1..462729db4ea7 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -311,9 +311,9 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
dr, uint64_t value,
     case IIC_DIRECTCNTL:
         i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNT=
L_SCLC);
         i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
-        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
+        bitbang_i2c_set(&i2c->bitbang, BITBANG_I2C_SCL,
                         i2c->directcntl & IIC_DIRECTCNTL_MSCL);
-        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_S=
DA,
+        i2c->directcntl |=3D bitbang_i2c_set(&i2c->bitbang, BITBANG_I2C_=
SDA,
                                (value & IIC_DIRECTCNTL_SDAC) !=3D 0) << =
1;
         break;
     default:
@@ -347,7 +347,7 @@ static void ppc4xx_i2c_init(Object *o)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
     s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
-    s->bitbang =3D bitbang_i2c_init(s->bus);
+    bitbang_i2c_init(&s->bitbang, s->bus);
 }
=20
 static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index 24b6e36b6d52..1ac2a6f59a0a 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -35,7 +35,7 @@ typedef struct VersatileI2CState {
     SysBusDevice parent_obj;
=20
     MemoryRegion iomem;
-    bitbang_i2c_interface *bitbang;
+    bitbang_i2c_interface bitbang;
     int out;
     int in;
 } VersatileI2CState;
@@ -70,8 +70,8 @@ static void versatile_i2c_write(void *opaque, hwaddr of=
fset,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%x\n", __func__, (int)offset);
     }
-    bitbang_i2c_set(s->bitbang, BITBANG_I2C_SCL, (s->out & 1) !=3D 0);
-    s->in =3D bitbang_i2c_set(s->bitbang, BITBANG_I2C_SDA, (s->out & 2) =
!=3D 0);
+    bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SCL, (s->out & 1) !=3D 0);
+    s->in =3D bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SDA, (s->out & 2)=
 !=3D 0);
 }
=20
 static const MemoryRegionOps versatile_i2c_ops =3D {
@@ -88,7 +88,7 @@ static void versatile_i2c_init(Object *obj)
     I2CBus *bus;
=20
     bus =3D i2c_init_bus(dev, "i2c");
-    s->bitbang =3D bitbang_i2c_init(bus);
+    bitbang_i2c_init(&s->bitbang, bus);
     memory_region_init_io(&s->iomem, obj, &versatile_i2c_ops, s,
                           "versatile_i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
--=20
2.18.1


