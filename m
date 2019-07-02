Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEF6C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2E820659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiTfaSXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2E820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMkA-0004sm-N0
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiLo4-00066v-5V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiLny-00074k-7n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:38:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiLnt-0006pF-Rx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:38:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so1511497wma.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=upT6oQXn3FiJ/gzxxzc85KhmUgnC81NBzOjBP/6qVBY=;
 b=DiTfaSXPR0Q+8Xvlwsaef1Ci5AKRJicKW4QWTgsr4LxIgAnMOfyttWyAAbcVBYh4BO
 pyOdlcSj081CjQD6lCr18zov5jIxGctw+hxxuI0Ny6Ch3Vug62jL9xH0tCGq0UJB3kX1
 1bTTkphmrfAoqojx2VbDTyMKMyJUrl/Yeyfaf5i2en9IFiAaIG5X0irNgr1Aa6Nmq/6H
 GV+hHzZZ/eNZoY1yxKo/4lsu+2Op7FABlA1eTS33+9R/bF/+NOcMSSnekRaD57gmaJFQ
 ndPzoZxmEGZU3g9Uyn4b00lU1WT3J02ideLZZdHj6eegrcdE/A3vs/iJ24w1WwspOs6Y
 zPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=upT6oQXn3FiJ/gzxxzc85KhmUgnC81NBzOjBP/6qVBY=;
 b=YmjoZHTlNeyHw40kaZsuxakDBVqMWnNmiEYSAFKk7IIJmMHHj8+vTY5hHs2WDU1HON
 GO83tbIpA/AhrSivxTfGXi9veB363tSqrOMuf1zcLPyBgcyhvvl13X73/fOq3u2taHO9
 18NMqk7/ygLx1iKkuJwet/7WZSQa1rsb+eap3djCyfas5wMcm1VZDORbWbRYOH/SqLyK
 q3NlgkNNNxiav/ZVMa7wIUKaun/5bbH2osSoynxWBFaRCe4vk7G2Jn3BgSt8JECzZYsO
 8qY+TmehYEWd4sieWOCQakb1WY/aEcSXu7lZ1WgM5oEuqNtfvvk/TQFtBz96v6Eo7/sh
 NcFg==
X-Gm-Message-State: APjAAAUj7HvmYvjcwwUEU0PEhBhm+FPCQIS0VdY7WBvgTT/wdy5OTROU
 vGVXidbk6lxZHKO8kN9jM21b86YDJC/b+w==
X-Google-Smtp-Source: APXvYqw+pZT+ToEmb8xIRcc2l2uQe/GPv1lQkBdqWZ86E5BIuWvxgCQGBYsMeNup3yu89bAElkFMFg==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr3816384wmh.132.1562085526832; 
 Tue, 02 Jul 2019 09:38:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x11sm3343950wmg.23.2019.07.02.09.38.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 09:38:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:38:44 +0100
Message-Id: <20190702163844.20458-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH for-4.1] hw/i2c/bitbang_i2c: Use in-place
 rather than malloc'd bitbang_i2c_interface struct
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
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
This isn't the only problem with this code : it is also
missing reset and migration handling and generally looks like
it needs proper conversion to QOM somehow. But this will shut
the patchew complaints up and seems ok for 4.1.

Disclaimer: checked only that the leak-sanitizer is now happy
and with a 'make check'.
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
index 9b67d0022ad..31a1927b3ec 100644
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
index 3a7126d5dee..92334e9016a 100644
--- a/include/hw/i2c/bitbang_i2c.h
+++ b/include/hw/i2c/bitbang_i2c.h
@@ -8,7 +8,43 @@ typedef struct bitbang_i2c_interface bitbang_i2c_interface;
 #define BITBANG_I2C_SDA 0
 #define BITBANG_I2C_SCL 1
 
-bitbang_i2c_interface *bitbang_i2c_init(I2CBus *bus);
+typedef enum bitbang_i2c_state {
+    STOPPED = 0,
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
+ * bitbang_i2c_init: in-place initialize the bitbang_i2c_interface struct
+ */
+void bitbang_i2c_init(bitbang_i2c_interface *s, I2CBus *bus);
 int bitbang_i2c_set(bitbang_i2c_interface *i2c, int line, int level);
 
 #endif
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 8437bf070b8..f6f837fbec0 100644
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
index 0cb11738483..c1d9d1518f4 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -538,7 +538,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case GPIO_DVI_DDC:
         if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.gpio_dvi_ddc = ati_i2c(s->bbi2c, data, 0);
+            s->regs.gpio_dvi_ddc = ati_i2c(&s->bbi2c, data, 0);
         }
         break;
     case GPIO_MONID ... GPIO_MONID + 3:
@@ -554,7 +554,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
              */
             if ((s->regs.gpio_monid & BIT(25)) &&
                 addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) {
-                s->regs.gpio_monid = ati_i2c(s->bbi2c, s->regs.gpio_monid, 1);
+                s->regs.gpio_monid = ati_i2c(&s->bbi2c, s->regs.gpio_monid, 1);
             }
         }
         break;
@@ -856,7 +856,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
 
     /* ddc, edid */
     I2CBus *i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
-    s->bbi2c = bitbang_i2c_init(i2cbus);
+    bitbang_i2c_init(&s->bbi2c, i2cbus);
     I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
     i2c_set_slave_address(i2cddc, 0x50);
 
@@ -885,7 +885,6 @@ static void ati_vga_exit(PCIDevice *dev)
     ATIVGAState *s = ATI_VGA(dev);
 
     graphic_console_close(s->vga.con);
-    g_free(s->bbi2c);
 }
 
 static Property ati_vga_properties[] = {
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 3cb0509b020..60c7a9be0bc 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -25,39 +25,6 @@ do { printf("bitbang_i2c: " fmt , ## __VA_ARGS__); } while (0)
 #define DPRINTF(fmt, ...) do {} while(0)
 #endif
 
-typedef enum bitbang_i2c_state {
-    STOPPED = 0,
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
@@ -184,18 +151,12 @@ int bitbang_i2c_set(bitbang_i2c_interface *i2c, int line, int level)
     abort();
 }
 
-bitbang_i2c_interface *bitbang_i2c_init(I2CBus *bus)
+void bitbang_i2c_init(bitbang_i2c_interface *s, I2CBus *bus)
 {
-    bitbang_i2c_interface *s;
-
-    s = g_malloc0(sizeof(bitbang_i2c_interface));
-
     s->bus = bus;
     s->last_data = 1;
     s->last_clock = 1;
     s->device_out = 1;
-
-    return s;
 }
 
 /* GPIO interface.  */
@@ -207,7 +168,7 @@ typedef struct GPIOI2CState {
     SysBusDevice parent_obj;
 
     MemoryRegion dummy_iomem;
-    bitbang_i2c_interface *bitbang;
+    bitbang_i2c_interface bitbang;
     int last_level;
     qemu_irq out;
 } GPIOI2CState;
@@ -216,7 +177,7 @@ static void bitbang_i2c_gpio_set(void *opaque, int irq, int level)
 {
     GPIOI2CState *s = opaque;
 
-    level = bitbang_i2c_set(s->bitbang, irq, level);
+    level = bitbang_i2c_set(&s->bitbang, irq, level);
     if (level != s->last_level) {
         s->last_level = level;
         qemu_set_irq(s->out, level);
@@ -234,7 +195,7 @@ static void gpio_i2c_init(Object *obj)
     sysbus_init_mmio(sbd, &s->dummy_iomem);
 
     bus = i2c_init_bus(dev, "i2c");
-    s->bitbang = bitbang_i2c_init(bus);
+    bitbang_i2c_init(&s->bitbang, bus);
 
     qdev_init_gpio_in(dev, bitbang_i2c_gpio_set, 2);
     qdev_init_gpio_out(dev, &s->out, 1);
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 5fb4f86c38f..462729db4ea 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -311,9 +311,9 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
     case IIC_DIRECTCNTL:
         i2c->directcntl = value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNTL_SCLC);
         i2c->directcntl |= (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
-        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
+        bitbang_i2c_set(&i2c->bitbang, BITBANG_I2C_SCL,
                         i2c->directcntl & IIC_DIRECTCNTL_MSCL);
-        i2c->directcntl |= bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SDA,
+        i2c->directcntl |= bitbang_i2c_set(&i2c->bitbang, BITBANG_I2C_SDA,
                                (value & IIC_DIRECTCNTL_SDAC) != 0) << 1;
         break;
     default:
@@ -347,7 +347,7 @@ static void ppc4xx_i2c_init(Object *o)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
     s->bus = i2c_init_bus(DEVICE(s), "i2c");
-    s->bitbang = bitbang_i2c_init(s->bus);
+    bitbang_i2c_init(&s->bitbang, s->bus);
 }
 
 static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index 24b6e36b6d5..1ac2a6f59a0 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -35,7 +35,7 @@ typedef struct VersatileI2CState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    bitbang_i2c_interface *bitbang;
+    bitbang_i2c_interface bitbang;
     int out;
     int in;
 } VersatileI2CState;
@@ -70,8 +70,8 @@ static void versatile_i2c_write(void *opaque, hwaddr offset,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%x\n", __func__, (int)offset);
     }
-    bitbang_i2c_set(s->bitbang, BITBANG_I2C_SCL, (s->out & 1) != 0);
-    s->in = bitbang_i2c_set(s->bitbang, BITBANG_I2C_SDA, (s->out & 2) != 0);
+    bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SCL, (s->out & 1) != 0);
+    s->in = bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SDA, (s->out & 2) != 0);
 }
 
 static const MemoryRegionOps versatile_i2c_ops = {
@@ -88,7 +88,7 @@ static void versatile_i2c_init(Object *obj)
     I2CBus *bus;
 
     bus = i2c_init_bus(dev, "i2c");
-    s->bitbang = bitbang_i2c_init(bus);
+    bitbang_i2c_init(&s->bitbang, bus);
     memory_region_init_io(&s->iomem, obj, &versatile_i2c_ops, s,
                           "versatile_i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-- 
2.20.1


