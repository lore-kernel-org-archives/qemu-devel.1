Received: from eggs.gnu.org ([2001:4830:134:3::10]:49749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGl-00084X-7r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGh-0005km-Rr
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=715e8d879=Alistair.Francis@wdc.com>)
	id 1faOGh-0005ir-J2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:35:07 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  3 Jul 2018 09:34:42 -0700
Message-Id: <20180703163446.9943-4-alistair.francis@wdc.com>
In-Reply-To: <20180703163446.9943-1-alistair.francis@wdc.com>
References: <20180703163446.9943-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 3/7] hw/riscv/sifive_plic: Use gpios instead
 of irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mjc@sifive.com
Cc: f4bug@amsat.org, alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>

Instead of creating the interrupt in lines with qemu_allocate_irq() use
qdev_init_gpio_in() as this gives us the ability to use the qdev*gpio*()
helpers later on.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_e.c            | 5 +++--
 hw/riscv/sifive_plic.c         | 6 +-----
 hw/riscv/sifive_u.c            | 5 +++--
 hw/riscv/virt.c                | 4 ++--
 include/hw/riscv/sifive_plic.h | 1 -
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 384b456540..006703163b 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -190,13 +190,14 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.gpio0",
         memmap[SIFIVE_E_GPIO0].base, memmap[SIFIVE_E_GPIO0].size);
     sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
-        serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART0_IRQ]);
+        serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi0",
         memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
     /* sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
-        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_E_UART1_IRQ]); */
+        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic),
+                                       SIFIVE_E_UART1_IRQ)); */
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm1",
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 874de2ebaf..a91aeb97ab 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -435,7 +435,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
     SiFivePLICState *plic = SIFIVE_PLIC(dev);
-    int i;
 
     memory_region_init_io(&plic->mmio, OBJECT(dev), &sifive_plic_ops, plic,
                           TYPE_SIFIVE_PLIC, plic->aperture_size);
@@ -448,10 +447,7 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
     plic->claimed = g_new0(uint32_t, plic->bitfield_words);
     plic->enable = g_new0(uint32_t, plic->bitfield_words * plic->num_addrs);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &plic->mmio);
-    plic->irqs = g_new0(qemu_irq, plic->num_sources + 1);
-    for (i = 0; i <= plic->num_sources; i++) {
-        plic->irqs[i] = qemu_allocate_irq(sifive_plic_irq_request, plic, i);
-    }
+    qdev_init_gpio_in(dev, sifive_plic_irq_request, plic->num_sources);
 }
 
 static void sifive_plic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 45b6aeb36b..3883d7ff9c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -320,9 +320,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_U_PLIC].size);
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
-        serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
+        serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
     /* sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
-        serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]); */
+        serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic),
+                                       SIFIVE_U_UART1_IRQ)); */
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 34d48993a2..aeada2498d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -380,11 +380,11 @@ static void riscv_virt_board_init(MachineState *machine)
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
             memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
-            SIFIVE_PLIC(s->plic)->irqs[VIRTIO_IRQ + i]);
+            qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
-        0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
+        0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 }
 
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index 11a5a98df1..2f2af7e686 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -56,7 +56,6 @@ typedef struct SiFivePLICState {
     uint32_t *claimed;
     uint32_t *enable;
     QemuMutex lock;
-    qemu_irq *irqs;
 
     /* config */
     char *hart_config;
-- 
2.17.1
