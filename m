Received: from eggs.gnu.org ([2001:4830:134:3::10]:49794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnVhV-0003B4-U6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnVhT-0006f4-RQ
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:09:01 -0400
Received: from smtp20.mail.ru ([94.100.179.251]:33076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fnVhT-0006eW-Ex
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:08:59 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Thu,  9 Aug 2018 00:07:47 +0300
Message-Id: <20180808210750.3915-2-jusual@mail.ru>
In-Reply-To: <20180808210750.3915-1-jusual@mail.ru>
References: <20180808210750.3915-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 1/4] hw/char: Implement nRF51 SoC UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Not implemented: CTS/NCTS, PSEL*.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/char/Makefile.objs        |   1 +
 hw/char/nrf51_uart.c         | 329 +++++++++++++++++++++++++++++++++++
 hw/char/trace-events         |   4 +
 include/hw/char/nrf51_uart.h |  78 +++++++++
 4 files changed, 412 insertions(+)
 create mode 100644 hw/char/nrf51_uart.c
 create mode 100644 include/hw/char/nrf51_uart.h

diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index b570531291..c4947d7ae7 100644
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
index 0000000000..55404e8f37
--- /dev/null
+++ b/hw/char/nrf51_uart.c
@@ -0,0 +1,329 @@
+/*
+ * nRF51 SoC UART emulation
+ *
+ * See nRF51 Series Reference Manual, "29 Universal Asynchronous
+ * Receiver/Transmitter" for hardware specifications:
+ * http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
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
+#include "hw/char/nrf51_uart.h"
+#include "trace.h"
+
+static void nrf51_uart_update_irq(NRF51UARTState *s)
+{
+    bool irq = false;
+
+    irq |= (s->reg[R_UART_RXDRDY] &&
+            (s->reg[R_UART_INTEN] & R_UART_INTEN_RXDRDY_MASK));
+    irq |= (s->reg[R_UART_TXDRDY] &&
+            (s->reg[R_UART_INTEN] & R_UART_INTEN_TXDRDY_MASK));
+    irq |= (s->reg[R_UART_ERROR]  &&
+            (s->reg[R_UART_INTEN] & R_UART_INTEN_ERROR_MASK));
+    irq |= (s->reg[R_UART_RXTO]   &&
+            (s->reg[R_UART_INTEN] & R_UART_INTEN_RXTO_MASK));
+
+    qemu_set_irq(s->irq, irq);
+}
+
+static uint64_t uart_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    NRF51UARTState *s = NRF51_UART(opaque);
+    uint64_t r;
+
+    if (!s->enabled) {
+        return 0;
+    }
+
+    switch (addr) {
+    case A_UART_RXD:
+        r = s->rx_fifo[s->rx_fifo_pos];
+        if (s->rx_started && s->rx_fifo_len) {
+            qemu_chr_fe_accept_input(&s->chr);
+            s->rx_fifo_pos = (s->rx_fifo_pos + 1) % UART_FIFO_LENGTH;
+            s->rx_fifo_len--;
+            if (s->rx_fifo_len) {
+                s->reg[R_UART_RXDRDY] = 1;
+                nrf51_uart_update_irq(s);
+            }
+        }
+        break;
+    case A_UART_INTENSET:
+    case A_UART_INTENCLR:
+    case A_UART_INTEN:
+        r = s->reg[R_UART_INTEN];
+        break;
+    default:
+        r = s->reg[addr / 4];
+        break;
+    }
+
+    trace_nrf51_uart_read(addr, r, size);
+
+    return r;
+}
+
+static gboolean uart_transmit(GIOChannel *chan, GIOCondition cond, void *opaque)
+{
+    NRF51UARTState *s = NRF51_UART(opaque);
+    int r;
+    uint8_t c = s->reg[R_UART_TXD];
+
+    s->watch_tag = 0;
+
+    r = qemu_chr_fe_write(&s->chr, &c, 1);
+    if (r <= 0) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                             uart_transmit, s);
+        if (!s->watch_tag) {
+            /* The hardware has no transmit error reporting,
+             * so silently drop the byte
+             */
+            goto buffer_drained;
+        }
+        return FALSE;
+    }
+
+buffer_drained:
+    s->reg[R_UART_TXDRDY] = 1;
+    s->pending_tx_byte = false;
+    return FALSE;
+}
+
+static void uart_cancel_transmit(NRF51UARTState *s)
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
+    NRF51UARTState *s = NRF51_UART(opaque);
+
+    trace_nrf51_uart_write(addr, value, size);
+
+    if (!s->enabled && (addr != A_UART_ENABLE)) {
+        return;
+    }
+
+    switch (addr) {
+    case A_UART_TXD:
+        if (!s->pending_tx_byte && s->tx_started) {
+            s->reg[R_UART_TXD] = value;
+            s->pending_tx_byte = true;
+            uart_transmit(NULL, G_IO_OUT, s);
+        }
+        break;
+    case A_UART_INTEN:
+        s->reg[R_UART_INTEN] = value;
+        break;
+    case A_UART_INTENSET:
+        s->reg[R_UART_INTEN] |= value;
+        break;
+    case A_UART_INTENCLR:
+        s->reg[R_UART_INTEN] &= ~value;
+        break;
+    case A_UART_TXDRDY ... A_UART_RXTO:
+        s->reg[addr / 4] = value;
+        break;
+    case A_UART_ERRORSRC:
+        s->reg[addr / 4] &= ~value;
+        break;
+    case A_UART_RXD:
+        break;
+    case A_UART_RXDRDY:
+        if (value == 0) {
+            s->reg[R_UART_RXDRDY] = 0;
+        }
+        break;
+    case A_UART_STARTTX:
+        if (value == 1) {
+            s->tx_started = true;
+        }
+        break;
+    case A_UART_STARTRX:
+        if (value == 1) {
+            s->rx_started = true;
+        }
+        break;
+    case A_UART_ENABLE:
+        if (value) {
+            if (value == 4) {
+                s->enabled = true;
+            }
+            break;
+        }
+        s->enabled = false;
+        value = 1;
+        /* fall through */
+    case A_UART_SUSPEND:
+    case A_UART_STOPTX:
+        if (value == 1) {
+            s->tx_started = false;
+        }
+    case A_UART_STOPRX:
+        if (addr != A_UART_STOPTX && value == 1) {
+            s->rx_started = false;
+            s->reg[R_UART_RXTO] = 1;
+        }
+        break;
+    default:
+        s->reg[addr / 4] = value;
+        break;
+    }
+    nrf51_uart_update_irq(s);
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
+    NRF51UARTState *s = NRF51_UART(dev);
+
+    s->pending_tx_byte = 0;
+
+    uart_cancel_transmit(s);
+
+    memset(s->reg, 0, sizeof(s->reg));
+
+    s->reg[R_UART_PSELRTS] = 0xFFFFFFFF;
+    s->reg[R_UART_PSELTXD] = 0xFFFFFFFF;
+    s->reg[R_UART_PSELCTS] = 0xFFFFFFFF;
+    s->reg[R_UART_PSELRXD] = 0xFFFFFFFF;
+    s->reg[R_UART_BAUDRATE] = 0x4000000;
+
+    s->rx_fifo_len = 0;
+    s->rx_fifo_pos = 0;
+    s->rx_started = false;
+    s->tx_started = false;
+    s->enabled = false;
+}
+
+static void uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+
+    NRF51UARTState *s = NRF51_UART(opaque);
+    int i;
+
+    if (size == 0 || s->rx_fifo_len >= UART_FIFO_LENGTH) {
+        return;
+    }
+
+    for (i = 0; i < size; i++) {
+        uint32_t pos = (s->rx_fifo_pos + s->rx_fifo_len) % UART_FIFO_LENGTH;
+        s->rx_fifo[pos] = buf[i];
+        s->rx_fifo_len++;
+    }
+
+    s->reg[R_UART_RXDRDY] = 1;
+    nrf51_uart_update_irq(s);
+}
+
+static int uart_can_receive(void *opaque)
+{
+    NRF51UARTState *s = NRF51_UART(opaque);
+
+    return s->rx_started ? (UART_FIFO_LENGTH - s->rx_fifo_len) : 0;
+}
+
+static void uart_event(void *opaque, int event)
+{
+    NRF51UARTState *s = NRF51_UART(opaque);
+
+    if (event == CHR_EVENT_BREAK) {
+        s->reg[R_UART_ERRORSRC] |= 3;
+        s->reg[R_UART_ERROR] = 1;
+        nrf51_uart_update_irq(s);
+    }
+}
+
+static void nrf51_uart_realize(DeviceState *dev, Error **errp)
+{
+    NRF51UARTState *s = NRF51_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
+                             uart_event, NULL, s, NULL, true);
+}
+
+static void nrf51_uart_init(Object *obj)
+{
+    NRF51UARTState *s = NRF51_UART(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &uart_ops, s,
+                          "nrf51_soc.uart", UART_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static int nrf51_uart_post_load(void *opaque, int version_id)
+{
+    NRF51UARTState *s = NRF51_UART(opaque);
+
+    if (s->pending_tx_byte) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                             uart_transmit, s);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription nrf51_uart_vmstate = {
+    .name = "nrf51_soc.uart",
+    .post_load = nrf51_uart_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(reg, NRF51UARTState, 0x56C),
+        VMSTATE_UINT8_ARRAY(rx_fifo, NRF51UARTState, UART_FIFO_LENGTH),
+        VMSTATE_UINT32(rx_fifo_pos, NRF51UARTState),
+        VMSTATE_UINT32(rx_fifo_len, NRF51UARTState),
+        VMSTATE_BOOL(rx_started, NRF51UARTState),
+        VMSTATE_BOOL(tx_started, NRF51UARTState),
+        VMSTATE_BOOL(pending_tx_byte, NRF51UARTState),
+        VMSTATE_BOOL(enabled, NRF51UARTState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property nrf51_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", NRF51UARTState, chr),
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
+    dc->vmsd = &nrf51_uart_vmstate;
+}
+
+static const TypeInfo nrf51_uart_info = {
+    .name = TYPE_NRF51_UART,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NRF51UARTState),
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
diff --git a/hw/char/trace-events b/hw/char/trace-events
index b64213d4dd..de34a74399 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -73,3 +73,7 @@ cmsdk_apb_uart_receive(uint8_t c) "CMSDK APB UART: got character 0x%x from backe
 cmsdk_apb_uart_tx_pending(void) "CMSDK APB UART: character send to backend pending"
 cmsdk_apb_uart_tx(uint8_t c) "CMSDK APB UART: character 0x%x sent to backend"
 cmsdk_apb_uart_set_params(int speed) "CMSDK APB UART: params set to %d 8N1"
+
+# hw/char/nrf51_uart.c
+nrf51_uart_read(uint64_t addr, uint64_t r, unsigned int size) "addr 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
+nrf51_uart_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
new file mode 100644
index 0000000000..1d49b53da7
--- /dev/null
+++ b/include/hw/char/nrf51_uart.h
@@ -0,0 +1,78 @@
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
+#include "hw/registerfields.h"
+
+#define UART_FIFO_LENGTH 6
+#define UART_BASE 0x40002000
+#define UART_SIZE 0x1000
+
+#define TYPE_NRF51_UART "nrf51_soc.uart"
+#define NRF51_UART(obj) OBJECT_CHECK(NRF51UARTState, (obj), TYPE_NRF51_UART)
+
+REG32(UART_STARTRX, 0x000)
+REG32(UART_STOPRX, 0x004)
+REG32(UART_STARTTX, 0x008)
+REG32(UART_STOPTX, 0x00C)
+REG32(UART_SUSPEND, 0x01C)
+
+REG32(UART_CTS, 0x100)
+REG32(UART_NCTS, 0x104)
+REG32(UART_RXDRDY, 0x108)
+REG32(UART_TXDRDY, 0x11C)
+REG32(UART_ERROR, 0x124)
+REG32(UART_RXTO, 0x144)
+
+REG32(UART_INTEN, 0x300)
+    FIELD(UART_INTEN, CTS, 0, 1)
+    FIELD(UART_INTEN, NCTS, 1, 1)
+    FIELD(UART_INTEN, RXDRDY, 2, 1)
+    FIELD(UART_INTEN, TXDRDY, 7, 1)
+    FIELD(UART_INTEN, ERROR, 9, 1)
+    FIELD(UART_INTEN, RXTO, 17, 1)
+REG32(UART_INTENSET, 0x304)
+REG32(UART_INTENCLR, 0x308)
+REG32(UART_ERRORSRC, 0x480)
+REG32(UART_ENABLE, 0x500)
+REG32(UART_PSELRTS, 0x508)
+REG32(UART_PSELTXD, 0x50C)
+REG32(UART_PSELCTS, 0x510)
+REG32(UART_PSELRXD, 0x514)
+REG32(UART_RXD, 0x518)
+REG32(UART_TXD, 0x51C)
+REG32(UART_BAUDRATE, 0x524)
+REG32(UART_CONFIG, 0x56C)
+
+typedef struct NRF51UARTState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    CharBackend chr;
+    qemu_irq irq;
+    guint watch_tag;
+
+    uint8_t rx_fifo[UART_FIFO_LENGTH];
+    unsigned int rx_fifo_pos;
+    unsigned int rx_fifo_len;
+
+    uint32_t reg[0x56C];
+
+    bool rx_started;
+    bool tx_started;
+    bool pending_tx_byte;
+    bool enabled;
+} NRF51UARTState;
+
+#endif
-- 
2.17.1
