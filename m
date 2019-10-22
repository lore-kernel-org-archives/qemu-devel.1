Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0332ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 06:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB5E21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 06:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="htEBCOJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB5E21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMnEq-0006mv-QP
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 02:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iMn86-000147-Cd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iMn84-0000AC-9g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:54:50 -0400
Received: from [2001:470:70c5:1111::170] (port=44592 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iMn83-00009B-LA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=l57N/EJ4xUk8Mux+d3CR9HZLwYgFFv7PqS9bSNJBN4g=; b=htEBCOJW6Awa9XC8vmjtE1GHhL
 XR3Etn2OHwdJSYc7CMgdYO4iXVGdHkB9dZ2aq5ZGz+DEeym3ipyWhDUJD/2e7EbBCDvXCy24Cqrxz
 d6Oy8I1BcmGnQz8XL5/7/cBZZ8JKfa3rOYtWih1/PRNYXhdcsWJJAJzEN4wcU5npXVb8=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.eurescom.eu with esmtpa (Exim 4.86_2)
 (envelope-from <svens@stackframe.org>)
 id 1iMn7w-00072u-B6; Tue, 22 Oct 2019 07:54:40 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <rth@twiddle.net>
Subject: [PATCH v2 4/6] hppa: add emulation of LASI PS2 controllers
Date: Tue, 22 Oct 2019 07:54:13 +0200
Message-Id: <20191022055415.18122-5-svens@stackframe.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022055415.18122-1-svens@stackframe.org>
References: <20191022055415.18122-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/hppa/Kconfig            |   1 +
 hw/hppa/lasi.c             |  10 +-
 hw/input/Kconfig           |   3 +
 hw/input/Makefile.objs     |   1 +
 hw/input/lasips2.c         | 289 +++++++++++++++++++++++++++++++++++++
 hw/input/ps2.c             |   5 +
 hw/input/trace-events      |   5 +
 include/hw/input/lasips2.h |  16 ++
 include/hw/input/ps2.h     |   1 +
 9 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 hw/input/lasips2.c
 create mode 100644 include/hw/input/lasips2.h

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 2a7b38d6d6..7f9be7f25c 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -11,3 +11,4 @@ config DINO
     select MC146818RTC
     select LSI_SCSI_PCI
     select LASI_82596
+    select LASIPS2
diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index 51752589f3..d8d03f95c0 100644
--- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -22,6 +22,7 @@
 #include "hw/net/lasi_82596.h"
 #include "hw/char/parallel.h"
 #include "hw/char/serial.h"
+#include "hw/input/lasips2.h"
 #include "exec/address-spaces.h"
 #include "migration/vmstate.h"
 
@@ -324,6 +325,7 @@ DeviceState *lasi_init(MemoryRegion *address_space)
                      lpt_irq, parallel_hds[0]);
 
     /* Real time clock (RTC), it's only one 32-bit counter @9000 */
+
     s->rtc = time(NULL);
     s->rtc_ref = 0;
 
@@ -333,8 +335,14 @@ DeviceState *lasi_init(MemoryRegion *address_space)
                 lasi_get_irq(LASI_UART_HPA));
         serial_mm_init(address_space, LASI_UART_HPA + 0x800, 0,
                 serial_irq, 8000000 / 16,
-                serial_hd(1), DEVICE_NATIVE_ENDIAN);
+                serial_hd(0), DEVICE_NATIVE_ENDIAN);
     }
+
+    /* PS/2 Keyboard/Mouse */
+    qemu_irq ps2kbd_irq = qemu_allocate_irq(lasi_set_irq, s,
+            lasi_get_irq(LASI_PS2KBD_HPA));
+    lasips2_init(address_space, LASI_PS2KBD_HPA,  ps2kbd_irq);
+
     return dev;
 }
 
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 287f08887b..25c77a1b87 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -41,3 +41,6 @@ config VHOST_USER_INPUT
 
 config TSC210X
     bool
+
+config LASIPS2
+    select PS2
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index a1bc502ed0..f98f635685 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -15,3 +15,4 @@ common-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input.o
 obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_keypad.o
 obj-$(CONFIG_TSC210X) += tsc210x.o
+obj-$(CONFIG_LASIPS2) += lasips2.o
diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
new file mode 100644
index 0000000000..1943671d1e
--- /dev/null
+++ b/hw/input/lasips2.c
@@ -0,0 +1,289 @@
+/*
+ * QEMU HP Lasi PS/2 interface emulation
+ *
+ * Copyright (c) 2019 Sven Schnelle
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/hw.h"
+#include "hw/input/ps2.h"
+#include "hw/input/lasips2.h"
+#include "hw/sysbus.h"
+#include "exec/hwaddr.h"
+#include "sysemu/sysemu.h"
+#include "trace.h"
+#include "exec/address-spaces.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+struct LASIPS2State;
+typedef struct LASIPS2Port {
+    struct LASIPS2State *parent;
+    MemoryRegion reg;
+    void *dev;
+    uint8_t id;
+    uint8_t control;
+    uint8_t buf;
+    bool loopback_rbne;
+    bool irq;
+} LASIPS2Port;
+
+typedef struct LASIPS2State {
+    LASIPS2Port kbd;
+    LASIPS2Port mouse;
+    qemu_irq irq;
+} LASIPS2State;
+
+static const VMStateDescription vmstate_lasips2 = {
+    .name = "lasips2",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(kbd.control, LASIPS2State),
+        VMSTATE_UINT8(kbd.id, LASIPS2State),
+        VMSTATE_BOOL(kbd.irq, LASIPS2State),
+        VMSTATE_UINT8(mouse.control, LASIPS2State),
+        VMSTATE_UINT8(mouse.id, LASIPS2State),
+        VMSTATE_BOOL(mouse.irq, LASIPS2State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+typedef enum {
+    REG_PS2_ID = 0,
+    REG_PS2_RCVDATA = 4,
+    REG_PS2_CONTROL = 8,
+    REG_PS2_STATUS = 12,
+} lasips2_read_reg_t;
+
+typedef enum {
+    REG_PS2_RESET = 0,
+    REG_PS2_XMTDATA = 4,
+} lasips2_write_reg_t;
+
+typedef enum {
+    LASIPS2_CONTROL_ENABLE = 0x01,
+    LASIPS2_CONTROL_LOOPBACK = 0x02,
+    LASIPS2_CONTROL_DIAG = 0x20,
+    LASIPS2_CONTROL_DATDIR = 0x40,
+    LASIPS2_CONTROL_CLKDIR = 0x80,
+} lasips2_control_reg_t;
+
+typedef enum {
+    LASIPS2_STATUS_RBNE = 0x01,
+    LASIPS2_STATUS_TBNE = 0x02,
+    LASIPS2_STATUS_TERR = 0x04,
+    LASIPS2_STATUS_PERR = 0x08,
+    LASIPS2_STATUS_CMPINTR = 0x10,
+    LASIPS2_STATUS_DATSHD = 0x40,
+    LASIPS2_STATUS_CLKSHD = 0x80,
+} lasips2_status_reg_t;
+
+static const char *artist_read_reg_name(uint64_t addr)
+{
+    switch (addr & 0xc) {
+    case REG_PS2_ID:
+        return " PS2_ID";
+
+    case REG_PS2_RCVDATA:
+        return " PS2_RCVDATA";
+
+    case REG_PS2_CONTROL:
+        return " PS2_CONTROL";
+
+    case REG_PS2_STATUS:
+        return " PS2_STATUS";
+
+    default:
+        return "";
+    }
+    return "";
+}
+
+static const char *artist_write_reg_name(uint64_t addr)
+{
+    switch (addr & 0x0c) {
+    case REG_PS2_RESET:
+        return " PS2_RESET";
+
+    case REG_PS2_XMTDATA:
+        return " PS2_XMTDATA";
+
+    case REG_PS2_CONTROL:
+        return " PS2_CONTROL";
+
+    default:
+        return "";
+    }
+    return "";
+}
+
+static void lasips2_update_irq(LASIPS2State *s)
+{
+    trace_lasips2_intr(s->kbd.irq | s->mouse.irq);
+    qemu_set_irq(s->irq, s->kbd.irq | s->mouse.irq);
+}
+
+static void lasips2_reg_write(void *opaque, hwaddr addr, uint64_t val,
+        unsigned size)
+{
+    LASIPS2Port *port = opaque;
+
+    trace_lasips2_reg_write(size, port->id, addr,
+        artist_write_reg_name(addr), val);
+
+    switch (addr & 0xc) {
+    case REG_PS2_CONTROL:
+        port->control = val;
+        break;
+
+    case REG_PS2_XMTDATA:
+        if (port->control & LASIPS2_CONTROL_LOOPBACK) {
+            port->buf = val;
+            port->irq = true;
+            port->loopback_rbne = true;
+            lasips2_update_irq(port->parent);
+            break;
+        }
+
+        if (port->id) {
+            ps2_write_mouse(port->dev, val);
+        } else {
+            ps2_write_keyboard(port->dev, val);
+        }
+        break;
+
+    case REG_PS2_RESET:
+        break;
+
+    default:
+        qemu_log("%s: unknown register 0x%02lx\n", __func__, addr);
+        break;
+    }
+}
+
+static uint64_t lasips2_reg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    LASIPS2Port *port = opaque;
+    uint64_t ret = 0;
+
+    switch (addr & 0xc) {
+    case REG_PS2_ID:
+        ret = port->id;
+        break;
+
+    case REG_PS2_RCVDATA:
+        if (port->control & LASIPS2_CONTROL_LOOPBACK) {
+            port->irq = false;
+            port->loopback_rbne = false;
+            lasips2_update_irq(port->parent);
+            ret = port->buf;
+            break;
+        }
+
+        ret = ps2_read_data(port->dev);
+        break;
+
+    case REG_PS2_CONTROL:
+        ret = port->control;
+        break;
+
+    case REG_PS2_STATUS:
+
+        ret = LASIPS2_STATUS_DATSHD | LASIPS2_STATUS_CLKSHD;
+
+        if (port->control & LASIPS2_CONTROL_DIAG) {
+            if (!(port->control & LASIPS2_CONTROL_DATDIR)) {
+                ret &= ~LASIPS2_STATUS_DATSHD;
+            }
+
+            if (!(port->control & LASIPS2_CONTROL_CLKDIR)) {
+                ret &= ~LASIPS2_STATUS_CLKSHD;
+            }
+        }
+
+        if (port->control & LASIPS2_CONTROL_LOOPBACK) {
+            if (port->loopback_rbne) {
+                ret |= LASIPS2_STATUS_RBNE;
+            }
+        } else {
+            if (!ps2_queue_empty(port->dev)) {
+                ret |= LASIPS2_STATUS_RBNE;
+            }
+        }
+
+        if (port->parent->kbd.irq || port->parent->mouse.irq) {
+            ret |= LASIPS2_STATUS_CMPINTR;
+        }
+        break;
+
+    default:
+        qemu_log("%s: unknown register 0x%02lx\n", __func__, addr);
+        break;
+    }
+    trace_lasips2_reg_read(size, port->id, addr,
+        artist_read_reg_name(addr), ret);
+
+    return ret;
+}
+
+static const MemoryRegionOps lasips2_reg_ops = {
+    .read = lasips2_reg_read,
+    .write = lasips2_reg_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void ps2dev_update_irq(void *opaque, int level)
+{
+    LASIPS2Port *port = opaque;
+    port->irq = level;
+    lasips2_update_irq(port->parent);
+}
+
+void lasips2_init(MemoryRegion *address_space,
+                  hwaddr base, qemu_irq irq)
+{
+    LASIPS2State *s;
+
+    s = g_malloc0(sizeof(LASIPS2State));
+
+    s->irq = irq;
+    s->mouse.id = 1;
+    s->kbd.parent = s;
+    s->mouse.parent = s;
+
+    vmstate_register(NULL, base, &vmstate_lasips2, s);
+
+    s->kbd.dev = ps2_kbd_init(ps2dev_update_irq, &s->kbd);
+    s->mouse.dev = ps2_mouse_init(ps2dev_update_irq, &s->mouse);
+
+    memory_region_init_io(&s->kbd.reg, NULL, &lasips2_reg_ops, &s->kbd,
+                          "lasips2-kbd", 0x100);
+    memory_region_add_subregion(address_space, base, &s->kbd.reg);
+
+    memory_region_init_io(&s->mouse.reg, NULL, &lasips2_reg_ops, &s->mouse,
+                          "lasips2-mouse", 0x100);
+    memory_region_add_subregion(address_space, base + 0x100, &s->mouse.reg);
+}
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 6c2c7066a6..7b0739aa7f 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -192,6 +192,11 @@ static void ps2_reset_queue(PS2State *s)
     q->count = 0;
 }
 
+int ps2_queue_empty(PS2State *s)
+{
+    return s->queue.count == 0;
+}
+
 void ps2_queue_noirq(PS2State *s, int b)
 {
     PS2Queue *q = &s->queue;
diff --git a/hw/input/trace-events b/hw/input/trace-events
index cf072fa2f8..a2888fd10c 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -53,3 +53,8 @@ tsc2005_sense(const char *state) "touchscreen sense %s"
 
 # virtio-input.c
 virtio_input_queue_full(void) "queue full"
+
+# lasips2.c
+lasips2_reg_read(unsigned int size, int id, uint64_t addr, const char *name, uint64_t val) "%u %d addr 0x%"PRIx64 "%s -> 0x%"PRIx64
+lasips2_reg_write(unsigned int size, int id, uint64_t addr, const char *name, uint64_t val) "%u %d addr 0x%"PRIx64 "%s <- 0x%"PRIx64
+lasips2_intr(unsigned int val) "%d"
diff --git a/include/hw/input/lasips2.h b/include/hw/input/lasips2.h
new file mode 100644
index 0000000000..0cd7b59064
--- /dev/null
+++ b/include/hw/input/lasips2.h
@@ -0,0 +1,16 @@
+/*
+ * QEMU LASI PS/2 emulation
+ *
+ * Copyright (c) 2019 Sven Schnelle
+ *
+ */
+#ifndef HW_INPUT_LASIPS2_H
+#define HW_INPUT_LASIPS2_H
+
+#include "exec/hwaddr.h"
+
+#define TYPE_LASIPS2 "lasips2"
+
+void lasips2_init(MemoryRegion *address_space, hwaddr base, qemu_irq irq);
+
+#endif /* HW_INPUT_LASIPS2_H */
diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index b60455d4f6..35d983897a 100644
--- a/include/hw/input/ps2.h
+++ b/include/hw/input/ps2.h
@@ -47,5 +47,6 @@ void ps2_queue_3(PS2State *s, int b1, int b2, int b3);
 void ps2_queue_4(PS2State *s, int b1, int b2, int b3, int b4);
 void ps2_keyboard_set_translation(void *opaque, int mode);
 void ps2_mouse_fake_event(void *opaque);
+int ps2_queue_empty(PS2State *s);
 
 #endif /* HW_PS2_H */
-- 
2.23.0


