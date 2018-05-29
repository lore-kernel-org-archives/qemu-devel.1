Received: from eggs.gnu.org ([2001:4830:134:3::10]:41897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fNmjM-0007Ld-0f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fNmjI-0007xz-PB
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:36 -0400
Received: from smtp18.mail.ru ([94.100.176.155]:45132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fNmjI-0007vu-DZ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:32 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Wed, 30 May 2018 01:03:37 +0300
Message-Id: <20180529220338.10879-3-jusual@mail.ru>
In-Reply-To: <20180529220338.10879-1-jusual@mail.ru>
References: <20180529220338.10879-1-jusual@mail.ru>
Subject: [Qemu-devel] [RFC 2/3] hw/char/nrf51_uart: Implement nRF51 SoC UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Basic implementation of nRF51 SoC UART.
Description could be found here:
http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.1.pdf

The following features are not yet implemented:
    Control with SUSPEND/START*/STOP*
    CTS/NCTS flow control
    Mapping registers to pins

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/arm/nrf51_soc.c           |   7 ++
 hw/char/Makefile.objs        |   1 +
 hw/char/nrf51_uart.c         | 232 +++++++++++++++++++++++++++++++++++
 include/hw/arm/nrf51_soc.h   |   1 +
 include/hw/char/nrf51_uart.h |  54 ++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 hw/char/nrf51_uart.c
 create mode 100644 include/hw/char/nrf51_uart.h

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 6fe06dcfd2..a2ee6f3f3b 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 
 #include "hw/arm/nrf51_soc.h"
+#include "hw/char/nrf51_uart.h"
 
 #define IOMEM_BASE      0x40000000
 #define IOMEM_SIZE      0x20000000
@@ -34,6 +35,9 @@
 #define SRAM_BASE       0x20000000
 #define SRAM_SIZE       (16 * 1024)
 
+#define UART_BASE       0x40002000
+#define UART_SIZE       0x1000
+
 static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     NRF51State *s = NRF51_SOC(dev_soc);
@@ -73,6 +77,9 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     /* TODO: implement a cortex m0 and update this */
     s->nvic = armv7m_init(get_system_memory(), FLASH_SIZE, 96,
                s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m3"));
+
+    s->uart = nrf51_uart_create(UART_BASE, qdev_get_gpio_in(s->nvic, 2),
+                                serial_hd(0));
 }
 
 static Property nrf51_soc_properties[] = {
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 1b979100b7..1060c62a54 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -1,5 +1,6 @@
 common-obj-$(CONFIG_IPACK) += ipoctal232.o
 common-obj-$(CONFIG_ESCC) += escc.o
+common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
 common-obj-$(CONFIG_PARALLEL) += parallel.o
 common-obj-$(CONFIG_PARALLEL) += parallel-isa.o
 common-obj-$(CONFIG_PL011) += pl011.o
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
new file mode 100644
index 0000000000..2da97aa0c4
--- /dev/null
+++ b/hw/char/nrf51_uart.c
@@ -0,0 +1,232 @@
+/*
+ * nRF51 SoC UART emulation
+ *
+ * Copyright (c) 2018 Julia Suvorova <jusual@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/registerfields.h"
+#include "hw/char/nrf51_uart.h"
+
+REG32(STARTRX, 0x000)
+REG32(STOPRX, 0x004)
+REG32(STARTTX, 0x008)
+REG32(STOPTX, 0x00C)
+REG32(SUSPEND, 0x01C)
+
+REG32(CTS, 0x100)
+REG32(NCTS, 0x104)
+REG32(RXDRDY, 0x108)
+REG32(TXDRDY, 0x11C)
+REG32(ERROR, 0x124)
+REG32(RXTO, 0x144)
+
+REG32(INTEN, 0x300)
+    FIELD(INTEN, CTS, 0, 1)
+    FIELD(INTEN, NCTS, 1, 1)
+    FIELD(INTEN, RXDRDY, 2, 1)
+    FIELD(INTEN, TXDRDY, 7, 1)
+    FIELD(INTEN, ERROR, 9, 1)
+    FIELD(INTEN, RXTO, 17, 1)
+REG32(INTENSET, 0x304)
+REG32(INTENCLR, 0x308)
+REG32(ERRORSRC, 0x480)
+REG32(ENABLE, 0x500)
+REG32(PSELRTS, 0x508)
+REG32(PSELTXD, 0x50C)
+REG32(PSELCTS, 0x510)
+REG32(PSELRXD, 0x514)
+REG32(RXD, 0x518)
+REG32(TXD, 0x51C)
+REG32(BAUDRATE, 0x524)
+REG32(CONFIG, 0x56C)
+
+static void nrf51_uart_update_irq(Nrf51UART *s)
+{
+    unsigned int irq = 0;
+
+    irq = irq || (s->reg[A_RXDRDY] && (s->reg[A_INTEN] & R_INTEN_RXDRDY_MASK));
+    irq = irq || (s->reg[A_TXDRDY] && (s->reg[A_INTEN] & R_INTEN_TXDRDY_MASK));
+    irq = irq || (s->reg[A_ERROR]  && (s->reg[A_INTEN] & R_INTEN_ERROR_MASK));
+    irq = irq || (s->reg[A_RXTO]   && (s->reg[A_INTEN] & R_INTEN_RXTO_MASK));
+
+    qemu_set_irq(s->irq, !!irq);
+}
+
+static uint64_t uart_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    Nrf51UART *s = NRF51_UART(opaque);
+    uint64_t r;
+
+    switch (addr) {
+    case A_RXD:
+        r = s->rx_fifo[s->rx_fifo_pos];
+        if (s->rx_fifo_len > 0) {
+            s->rx_fifo_pos = (s->rx_fifo_pos + 1) % UART_FIFO_LENGTH;
+            s->rx_fifo_len--;
+            qemu_chr_fe_accept_input(&s->chr);
+        }
+        break;
+
+    case A_INTENSET:
+    case A_INTENCLR:
+    case A_INTEN:
+        r = s->reg[A_INTEN];
+        break;
+    default:
+        r = s->reg[addr];
+        break;
+    }
+
+    return r;
+}
+
+static gboolean uart_transmit(GIOChannel *chan, GIOCondition cond, void *opaque)
+{
+    Nrf51UART *s = NRF51_UART(opaque);
+    int r;
+
+    s->watch_tag = 0;
+
+    r = qemu_chr_fe_write(&s->chr, (uint8_t *) &s->reg[A_TXD], 1);
+    if (r <= 0) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                             uart_transmit, s);
+        if (!s->watch_tag) {
+            goto buffer_drained;
+        }
+        return FALSE;
+    }
+
+buffer_drained:
+    s->reg[A_TXDRDY] = 1;
+    nrf51_uart_update_irq(s);
+    return FALSE;
+}
+
+static void uart_cancel_transmit(Nrf51UART *s)
+{
+    if (s->watch_tag) {
+        g_source_remove(s->watch_tag);
+        s->watch_tag = 0;
+    }
+}
+
+static void uart_write(void *opaque, hwaddr addr,
+                       uint64_t value, unsigned int size)
+{
+    Nrf51UART *s = NRF51_UART(opaque);
+
+    switch (addr) {
+    case A_TXD:
+        s->reg[A_TXD] = value;
+        uart_transmit(NULL, G_IO_OUT, s);
+        break;
+    case A_INTENSET:
+        s->reg[A_INTEN] |= value;
+        break;
+    case A_INTENCLR:
+        s->reg[A_INTEN] &= ~value;
+        break;
+    case A_CTS ... A_RXTO:
+        s->reg[addr] = value;
+        nrf51_uart_update_irq(s);
+    default:
+        s->reg[addr] = value;
+        break;
+    }
+}
+
+static const MemoryRegionOps uart_ops = {
+    .read =  uart_read,
+    .write = uart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void nrf51_uart_reset(DeviceState *dev)
+{
+    Nrf51UART *s = NRF51_UART(dev);
+
+    uart_cancel_transmit(s);
+
+    memset(s->reg, 0, sizeof(s->reg));
+
+    s->rx_fifo_len = 0;
+    s->rx_fifo_pos = 0;
+}
+
+static void uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+
+   Nrf51UART *s = NRF51_UART(opaque);
+
+   if (s->rx_fifo_len >= UART_FIFO_LENGTH) {
+        return;
+    }
+
+    s->rx_fifo[(s->rx_fifo_pos + s->rx_fifo_len) % UART_FIFO_LENGTH] = *buf;
+    s->rx_fifo_len++;
+
+    s->reg[A_RXDRDY] = 1;
+    nrf51_uart_update_irq(s);
+}
+
+static int uart_can_receive(void *opaque)
+{
+    Nrf51UART *s = NRF51_UART(opaque);
+
+    return (s->rx_fifo_len < sizeof(s->rx_fifo));
+}
+
+static void nrf51_uart_realize(DeviceState *dev, Error **errp)
+{
+    Nrf51UART *s = NRF51_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
+                             NULL, NULL, s, NULL, true);
+}
+
+static void nrf51_uart_init(Object *obj)
+{
+    Nrf51UART *s = NRF51_UART(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
+                          "nrf51_soc.uart", 0x1000);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static Property nrf51_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", Nrf51UART, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nrf51_uart_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = nrf51_uart_reset;
+    dc->realize = nrf51_uart_realize;
+    dc->props = nrf51_uart_properties;
+}
+
+static const TypeInfo nrf51_uart_info = {
+    .name = TYPE_NRF51_UART,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Nrf51UART),
+    .instance_init = nrf51_uart_init,
+    .class_init = nrf51_uart_class_init
+};
+
+static void nrf51_uart_register_types(void)
+{
+    type_register_static(&nrf51_uart_info);
+}
+
+type_init(nrf51_uart_register_types)
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index a6bbe9f108..a38b984675 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -24,6 +24,7 @@ typedef struct NRF51State {
     /*< public >*/
     char *kernel_filename;
     DeviceState *nvic;
+    DeviceState *uart;
 
     MemoryRegion iomem;
 } NRF51State;
diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
new file mode 100644
index 0000000000..758203f1c3
--- /dev/null
+++ b/include/hw/char/nrf51_uart.h
@@ -0,0 +1,54 @@
+/*
+ * nRF51 SoC UART emulation
+ *
+ * Copyright (c) 2018 Julia Suvorova <jusual@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+#ifndef NRF51_UART_H
+#define NRF51_UART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+
+#define UART_FIFO_LENGTH 6
+
+#define TYPE_NRF51_UART "nrf51_soc.uart"
+#define NRF51_UART(obj) OBJECT_CHECK(Nrf51UART, (obj), TYPE_NRF51_UART)
+
+typedef struct Nrf51UART {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    CharBackend chr;
+    qemu_irq irq;
+    guint watch_tag;
+
+    uint8_t rx_fifo[UART_FIFO_LENGTH];
+    unsigned int rx_fifo_pos;
+    unsigned int rx_fifo_len;
+
+    uint32_t reg[0x1000];
+} Nrf51UART;
+
+static inline DeviceState *nrf51_uart_create(hwaddr addr,
+                                             qemu_irq irq,
+                                             Chardev *chr)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_create(NULL, "nrf51_soc.uart");
+    s = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_chr(dev, "chardev", chr);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(s, 0, addr);
+    sysbus_connect_irq(s, 0, irq);
+
+    return dev;
+}
+
+#endif
-- 
2.17.0
