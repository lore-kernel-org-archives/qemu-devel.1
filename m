Received: from eggs.gnu.org ([2001:4830:134:3::10]:39662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5E68-00011I-Rr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5E61-0000X5-MC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:55:08 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:50219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5E61-0000Vk-AX
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:55:01 -0400
Received: by mail-qk0-x244.google.com with SMTP id o187so11166657qke.7
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 09:54:59 -0700 (PDT)
From: gabriel291075@gmail.com
Date: Thu, 19 Oct 2017 08:50:43 -0400
Message-Id: <1508417443-31849-1-git-send-email-gabriel291075@gmail.com>
Subject: [Qemu-devel] [PATCH v1] arm: Adding new arm machine,
 Kinetis K64 MK64FN1M0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gabriel Augusto Costa <gabriel291075@gmail.com>

From: Gabriel Augusto Costa <gabriel291075@gmail.com>

I add a new arm machine with some peripherals. The machine is mk64fn1m0, a 
cortex-m4 microcontroller from NXP Kinetis family. The machine can run a 
simple arm binary file using UART0 in polling mode.
I prepared two patchs to include this machine:
PATCH v1: Include the machine and peripherals devices;
PATCH v2: Change the make file to compile this machine.
Also, I made a folder tree to accomodate this machine more or less like u-boot.
In my opinion put all files in the same folder "/hw/arm" is not a good idea, 
or put all code in an unique file, because machines from the same family 
sharing the same peripherals.
The folder tree struct is machine/family/peripheral, as an example:
kinetis/k64/peripheral.
So, in this way the code will be more maintainable. 

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 hw/arm/kinetis/k64/mk64fn1m0.c                    | 170 +++++++++
 hw/arm/kinetis/k64/peripheral/flextimer.c         | 139 +++++++
 hw/arm/kinetis/k64/peripheral/mcg.c               | 225 ++++++++++++
 hw/arm/kinetis/k64/peripheral/pmux.c              | 423 ++++++++++++++++++++++
 hw/arm/kinetis/k64/peripheral/sim.c               | 292 +++++++++++++++
 hw/arm/kinetis/k64/peripheral/uart.c              | 369 +++++++++++++++++++
 include/hw/arm/kinetis/k64/peripheral/flextimer.h |  62 ++++
 include/hw/arm/kinetis/k64/peripheral/mcg.h       |  47 +++
 include/hw/arm/kinetis/k64/peripheral/pmux.h      |  73 ++++
 include/hw/arm/kinetis/k64/peripheral/sim.h       |  56 +++
 include/hw/arm/kinetis/k64/peripheral/uart.h      |  85 +++++
 11 files changed, 1941 insertions(+)
 create mode 100755 hw/arm/kinetis/k64/mk64fn1m0.c
 create mode 100755 hw/arm/kinetis/k64/peripheral/flextimer.c
 create mode 100755 hw/arm/kinetis/k64/peripheral/mcg.c
 create mode 100755 hw/arm/kinetis/k64/peripheral/pmux.c
 create mode 100755 hw/arm/kinetis/k64/peripheral/sim.c
 create mode 100755 hw/arm/kinetis/k64/peripheral/uart.c
 create mode 100755 include/hw/arm/kinetis/k64/peripheral/flextimer.h
 create mode 100755 include/hw/arm/kinetis/k64/peripheral/mcg.h
 create mode 100755 include/hw/arm/kinetis/k64/peripheral/pmux.h
 create mode 100755 include/hw/arm/kinetis/k64/peripheral/sim.h
 create mode 100755 include/hw/arm/kinetis/k64/peripheral/uart.h

diff --git a/hw/arm/kinetis/k64/mk64fn1m0.c b/hw/arm/kinetis/k64/mk64fn1m0.c
new file mode 100755
index 0000000..4509af9
--- /dev/null
+++ b/hw/arm/kinetis/k64/mk64fn1m0.c
@@ -0,0 +1,170 @@
+/*
+ * Kinetis K64 MK64FN1M0 microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "hw/i2c/i2c.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "cpu.h"
+#include "hw/arm/kinetis/k64/peripheral/sim.h"
+#include "hw/arm/kinetis/k64/peripheral/mcg.h"
+#include "hw/arm/kinetis/k64/peripheral/flextimer.h"
+#include "hw/arm/kinetis/k64/peripheral/pmux.h"
+#include "hw/arm/kinetis/k64/peripheral/uart.h"
+
+#define FLASH_SIZE              1024*1024
+#define FLASH_BASE_ADDRESS      0x00000000
+#define SRAM_SIZE               192*1024
+#define SRAM_BASE_ADDRESS       0x20000000
+
+#define NUM_IRQ_LINES 85
+
+/* System controller.  */
+
+static void do_sys_reset(void *opaque, int n, int level)
+{
+    if (level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+/* Interruptions at pag.77 K64P144M120F5RM.pdf */
+
+static void mk64fn1m0_init_mach(MachineState *ms, const char *kernel_filename)
+{
+    DeviceState *nvic;
+
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *sram = g_new(MemoryRegion, 1);
+    MemoryRegion *flash = g_new(MemoryRegion, 1);
+
+    memory_region_init_ram(flash, NULL, "k64.flash", FLASH_SIZE, &error_fatal);
+    memory_region_set_readonly(flash, true);
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
+
+    memory_region_init_ram(sram, NULL, "k64.sram", SRAM_SIZE, &error_fatal);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
+
+    nvic = armv7m_init(system_memory, FLASH_SIZE, NUM_IRQ_LINES,
+            ms->kernel_filename, ms->cpu_type);
+    
+    qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
+            qemu_allocate_irq(&do_sys_reset, NULL, 0));
+
+    sysbus_create_simple(TYPE_KINETIS_K64_SIM, 0x40048000, NULL);
+
+    sysbus_create_simple(TYPE_KINETIS_K64_MCG, 0x40064000, NULL);
+    
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x40049000,
+            qdev_get_gpio_in(nvic, 59));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004A000,
+            qdev_get_gpio_in(nvic, 60));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004B000,
+            qdev_get_gpio_in(nvic, 61));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004C000,
+            qdev_get_gpio_in(nvic, 62));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004D000,
+            qdev_get_gpio_in(nvic, 63));
+
+    sysbus_create_simple(TYPE_KINETIS_K64_FLEXTIMER, 0x40038000,
+            qdev_get_gpio_in(nvic, 42));
+    sysbus_create_simple(TYPE_KINETIS_K64_FLEXTIMER, 0x40039000,
+            qdev_get_gpio_in(nvic, 43));
+    sysbus_create_simple(TYPE_KINETIS_K64_FLEXTIMER, 0x4003A000,
+            qdev_get_gpio_in(nvic, 44));
+    
+/*    dev = sysbus_create_simple(TYPE_KINETIS_SPI, 0x4002C000,
+            qdev_get_gpio_in(nvic, 31)); *SPI0*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_SPI, 0x4002D000,
+            qdev_get_gpio_in(nvic, 33)); *SPI1*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_ADC, 0x4003B000,
+            qdev_get_gpio_in(nvic, 31)); *ADC0*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_DAC, 0x4002F000,
+            qdev_get_gpio_in(nvic, 33)); *DAC0*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_I2C, 0x40066000,
+            qdev_get_gpio_in(nvic, 31)); *I2C0*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_I2C, 0x40067000,
+            qdev_get_gpio_in(nvic, 33)); *I2C1*/
+
+//    sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006A000,
+//            qdev_get_gpio_in(nvic, 31)); /*UART0*/
+    kinetis_k64_uart_create(0x4006A000, qdev_get_gpio_in(nvic, 31),
+            serial_hds[0]);    
+/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006B000,
+            qdev_get_gpio_in(nvic, 33)); *UART1*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006C000,
+            qdev_get_gpio_in(nvic, 35)); *UART2*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x4006D000,
+            qdev_get_gpio_in(nvic, 37)); *UART3*/
+
+/*    dev = sysbus_create_simple(TYPE_KINETIS_SPI, 0x400AC000,
+            qdev_get_gpio_in(nvic, 65)); *SPI2*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_ADC, 0x400BB000,
+            qdev_get_gpio_in(nvic, 73)); *ADC1*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_I2C, 0x400E6000,
+            qdev_get_gpio_in(nvic, 74)); *I2C2*/
+
+/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x400EA000,
+            qdev_get_gpio_in(nvic, 66)); *UART4*/
+/*    dev = sysbus_create_simple(TYPE_KINETIS_K64_UART, 0x400EB000,
+            qdev_get_gpio_in(nvic, 68)); *UART5*/
+   
+    create_unimplemented_device("peripheral_bridge_0",  0x40000000, 0x1000);
+    create_unimplemented_device("Crossbar_Switch",      0x40004000, 0x1000);
+    create_unimplemented_device("DMA_Controller",       0x40008000, 0x1000);
+    create_unimplemented_device("DMA_Controller_t",     0x40009000, 0x1000);
+    create_unimplemented_device("FlexBus",              0x4000C000, 0x1000);
+    create_unimplemented_device("MPU",                  0x4000D000, 0x1000);
+    create_unimplemented_device("Flash_mem_ctrl",       0x4001F000, 0x1000);
+    create_unimplemented_device("Flash_mem",            0x40020000, 0x1000);
+    create_unimplemented_device("DMA_ch_multiplexer",   0x40021000, 0x1000);
+}
+
+static void mk64fn1m0_init(MachineState *machine)
+{
+    const char *kernel_filename = machine->kernel_filename;
+    mk64fn1m0_init_mach(machine, kernel_filename);
+}
+
+static void mk64fn1m0_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Kinetis K64 MCU (Cortex-M4)";
+    mc->init = mk64fn1m0_init;
+    mc->ignore_memory_transaction_failures = true;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
+    mc->max_cpus = 1;
+}
+
+static const TypeInfo mk64_type = {
+    .name = MACHINE_TYPE_NAME("mk64fn1m0"),
+    .parent = TYPE_MACHINE,
+    .class_init = mk64fn1m0_class_init,
+};
+
+static void mk64fn1m0_machine_init(void)
+{
+    type_register_static(&mk64_type);
+}
+
+type_init(mk64fn1m0_machine_init)
\ No newline at end of file
diff --git a/hw/arm/kinetis/k64/peripheral/flextimer.c b/hw/arm/kinetis/k64/peripheral/flextimer.c
new file mode 100755
index 0000000..9037789
--- /dev/null
+++ b/hw/arm/kinetis/k64/peripheral/flextimer.c
@@ -0,0 +1,139 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series FLEXTIMER controller.  */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/kinetis/k64/peripheral/flextimer.h" 
+
+static const VMStateDescription vmstate_kinetis_k64_flextimer = {
+    .name = TYPE_KINETIS_K64_FLEXTIMER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(SC, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(CNT, kinetis_k64_flextimer_state),
+//        VMSTATE_UINT32(CONTROLS[0], kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(CNTIN, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(STATUS, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(MODE, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(SYNC, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(OUTINIT, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(OUTMASK, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(COMBINE, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(DEADTIME, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(EXTTRIG, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(POL, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(FMS, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(FILTER, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(FLTCTRL, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(QDCTRL, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(CONF, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(FLTPOL, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(SYNCONF, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(INVCTRL, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(SWOCTRL, kinetis_k64_flextimer_state),
+        VMSTATE_UINT32(PWMLOAD, kinetis_k64_flextimer_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_flextimer_reset(DeviceState *dev)
+{
+    kinetis_k64_flextimer_state *s = KINETIS_K64_FLEXTIMER(dev);
+    
+    s->CNT = 0x00;
+}
+
+static void kinetis_k64_flextimer_write(void *opaque, hwaddr offset,
+        uint64_t value, unsigned size)
+{
+//    kinetis_k64_flextimer_state *s = (kinetis_k64_flextimer_state *)opaque;
+	
+    value = value & 0xFF;
+/*    printf("kinetis_k64_flextimer_write: Offset = 0x%02X, Value = 0x%02X\n",
+        (unsigned int)offset, (unsigned int)value);*/
+    
+    switch (offset) {
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "kinetis_k64_flextimer: write at bad offset 0x%x\n",
+                    (int)offset);
+    }
+}
+
+static uint64_t kinetis_k64_flextimer_read(void *opaque, hwaddr offset,
+        unsigned size)
+{
+//    kinetis_k64_flextimer_state *s = (kinetis_k64_flextimer_state *)opaque;
+
+    switch (offset) {
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "kinetis_k64_flextimer: read at bad offset 0x%x\n",
+                    (int)offset);
+            return 0;
+    }
+}
+
+static const MemoryRegionOps kinetis_k64_flextimer_ops = {
+    .read = kinetis_k64_flextimer_read,
+    .write = kinetis_k64_flextimer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void kinetis_k64_flextimer_init(Object *obj)
+{
+    kinetis_k64_flextimer_state *s = KINETIS_K64_FLEXTIMER(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_flextimer_ops, s,
+            TYPE_KINETIS_K64_FLEXTIMER, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void kinetis_k64_flextimer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_flextimer;
+    dc->reset = kinetis_k64_flextimer_reset;
+    dc->desc = "Kinetis K64 series FlexTimer";      
+}
+
+static const TypeInfo kinetis_k64_flextimer_info = {
+    .name          = TYPE_KINETIS_K64_FLEXTIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_flextimer_state),
+    .instance_init = kinetis_k64_flextimer_init,
+    .class_init    = kinetis_k64_flextimer_class_init,
+};
+
+static void kinetis_k64_flextimer_register_types(void)
+{
+    type_register_static(&kinetis_k64_flextimer_info);
+}
+
+type_init(kinetis_k64_flextimer_register_types)
\ No newline at end of file
diff --git a/hw/arm/kinetis/k64/peripheral/mcg.c b/hw/arm/kinetis/k64/peripheral/mcg.c
new file mode 100755
index 0000000..e904038
--- /dev/null
+++ b/hw/arm/kinetis/k64/peripheral/mcg.c
@@ -0,0 +1,225 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series MCG controller.  */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/kinetis/k64/peripheral/mcg.h"
+
+static const VMStateDescription vmstate_kinetis_k64_mcg = {
+    .name = TYPE_KINETIS_K64_MCG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(C1, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C2, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C3, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C4, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C5, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C6, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(S, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(SC, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(ATCVH, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(ATCVL, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C7, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C8, kinetis_k64_mcg_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_mcg_reset(DeviceState *dev)
+{
+    kinetis_k64_mcg_state *s = KINETIS_K64_MCG(dev);
+    
+    s->C1 = 0x04;
+    s->C2 = 0x80;
+    s->C3 = 0x00;
+    s->C4 = 0x00;
+    s->C5 = 0x00;
+    s->C6 = 0x00;
+    s->S = 0x10;
+    s->SC = 0x02;
+    s->ATCVH = 0x00;
+    s->ATCVL = 0x00;
+    s->C7 = 0x00;
+    s->C8 = 0x80;
+}
+
+static void kinetis_k64_mcg_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    kinetis_k64_mcg_state *s = (kinetis_k64_mcg_state *)opaque;
+
+    value &= 0xFF;
+/*    printf("kinetis_k64_mcg_write: Offset = 0x%02X, Value = 0x%02X\n", 
+            (unsigned int)offset, (unsigned int)value);*/    
+    
+    switch (offset) {
+        case 0x00: /**< MCG Control 1 Register, offset: 0x0 */
+            if (value & 1<<2){ //IREFS
+                s->S = 0;    
+                s->S |= 1<<3; // 10 Enconding 2 - External ref clk is selected    
+            }
+            if ((s->C1 & 0x80) && (value>>6 == 0)){
+                s->S |= 1<<2; // 11 Enconding 3 - Output of the PLL is selected    
+            }
+            s->C1 = value;
+            break;
+        case 0x01: /**< MCG Control 2 Register, offset: 0x1 */
+            s->C2 = value;
+            break;
+        case 0x02: /**< MCG Control 3 Register, offset: 0x2 */
+            s->C3 = value;
+            break;
+        case 0x03: /**< MCG Control 4 Register, offset: 0x3 */
+            s->C4 = value;
+            break;
+        case 0x04: /**< MCG Control 5 Register, offset: 0x4 */
+            s->C5 = value;
+            if (s->C5 & 1<<6){ //PLLCLKEN0
+                s->S |= 1<<6;  //LOCK0   
+            }
+            break;
+        case 0x05: /**< MCG Control 6 Register, offset: 0x5 */
+            s->C6 = value;
+            if (s->C6 & 1<<6){ //PLLS
+                s->S |= 1<<5;  //PLLST 
+            }            
+            break;
+        case 0x06: /**< MCG Status Register, offset: 0x6 */
+            s->S = value;
+            break;
+        case 0x08: /**< MCG Status and Control Register, offset: 0x8 */
+            s->SC = value;
+            break;
+        case 0x0A: /**< MCG Auto Trim Compare Value High Register, offset: 0xA*/
+            s->ATCVH = value;
+            break;
+        case 0x0B: /**< MCG Auto Trim Compare Value Low Register, offset: 0xB */
+            s->ATCVL = value;
+            break;
+        case 0x0C: /**< MCG Control 7 Register, offset: 0xC */
+            s->C7 = value;
+            break;
+        case 0x0D: /**< MCG Control 8 Register, offset: 0xD */
+            s->C8 = value;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "kinetis_k64_mcg: write at bad offset 0x%x\n", (int)offset);
+    }
+}
+
+static uint64_t kinetis_k64_mcg_read(void *opaque, hwaddr offset, unsigned size)
+{
+    kinetis_k64_mcg_state *s = (kinetis_k64_mcg_state *)opaque;
+    uint8_t value;
+    
+    switch (offset) {
+        case 0x00: /**< MCG Control 1 Register, offset: 0x0 */
+            value = s->C1;
+            break;
+        case 0x01: /**< MCG Control 2 Register, offset: 0x1 */
+            value = s->C2;
+            break;
+        case 0x02: /**< MCG Control 3 Register, offset: 0x2 */
+            value = s->C3;
+            break;
+        case 0x03: /**< MCG Control 4 Register, offset: 0x3 */
+            value = s->C4;
+            break;
+        case 0x04: /**< MCG Control 5 Register, offset: 0x4 */
+            value = s->C5;
+            break;
+        case 0x05: /**< MCG Control 6 Register, offset: 0x5 */
+            value = s->C6;
+            break;
+        case 0x06: /**< MCG Status Register, offset: 0x6 */
+            value = s->S;
+            break;
+        case 0x08: /**< MCG Status and Control Register, offset: 0x8 */
+            value = s->SC;
+            break;
+        case 0x0A: /**< MCG Auto Trim Compare Value High Register, offset: 0xA*/
+            value = s->ATCVH;
+            break;
+        case 0x0B: /**< MCG Auto Trim Compare Value Low Register, offset: 0xB */
+            value = s->ATCVL;
+            break;
+        case 0x0C: /**< MCG Control 7 Register, offset: 0xC */
+            value = s->C7;
+            break;
+        case 0x0D: /**< MCG Control 8 Register, offset: 0xD */
+            value = s->C8;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, 
+                    "kinetis_k64_mcg: read at bad offset 0x%x\n", (int)offset);
+            return 0;
+    }
+/*    printf("kinetis_k64_mcg_read: Offset = 0x%02X, Value = 0x%02X\n",
+            (unsigned int)offset, (unsigned int)value);*/
+    return value;    
+}
+
+static const MemoryRegionOps kinetis_k64_mcg_ops = {
+    .read = kinetis_k64_mcg_read,
+    .write = kinetis_k64_mcg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void kinetis_k64_mcg_init(Object *obj)
+{
+    kinetis_k64_mcg_state *s = KINETIS_K64_MCG(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_mcg_ops, s,
+            TYPE_KINETIS_K64_MCG, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void kinetis_k64_mcg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_mcg;
+    dc->reset = kinetis_k64_mcg_reset;
+    dc->desc = "Kinetis K64 series MCG";      
+}
+
+static const TypeInfo kinetis_k64_mcg_info = {
+    .name          = TYPE_KINETIS_K64_MCG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_mcg_state),
+    .instance_init = kinetis_k64_mcg_init,
+    .class_init    = kinetis_k64_mcg_class_init,
+};
+
+static void kinetis_k64_mcg_register_types(void)
+{
+    type_register_static(&kinetis_k64_mcg_info);
+}
+
+type_init(kinetis_k64_mcg_register_types)
\ No newline at end of file
diff --git a/hw/arm/kinetis/k64/peripheral/pmux.c b/hw/arm/kinetis/k64/peripheral/pmux.c
new file mode 100755
index 0000000..1177ce3
--- /dev/null
+++ b/hw/arm/kinetis/k64/peripheral/pmux.c
@@ -0,0 +1,423 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series PMUX controller.  */
+ 
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/kinetis/k64/peripheral/pmux.h"
+
+static const VMStateDescription vmstate_kinetis_k64_pmux = {
+    .name = TYPE_KINETIS_K64_PMUX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(PCR00, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR01, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR02, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR03, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR04, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR05, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR06, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR07, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR08, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR09, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR10, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR11, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR12, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR13, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR14, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR15, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR16, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR17, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR18, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR19, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR20, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR21, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR22, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR23, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR24, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR25, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR26, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR27, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR28, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR29, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR30, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR31, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(GPCLR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(GPCHR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(ISFR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(DFER, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(DFCR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(DFWR, kinetis_k64_pmux_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_pmux_reset(DeviceState *dev)
+{
+    kinetis_k64_pmux_state *s = KINETIS_K64_PMUX(dev);
+    
+    s->PCR00 = 0x00000000;  
+    s->PCR01 = 0x00000000;  
+    s->PCR02 = 0x00000000; 
+    s->PCR03 = 0x00000000;  
+    s->PCR04 = 0x00000000;  
+    s->PCR05 = 0x00000000; 
+    s->PCR06 = 0x00000000; 
+    s->PCR07 = 0x00000000;  
+    s->PCR08 = 0x00000000; 
+    s->PCR09 = 0x00000000; 
+    s->PCR10 = 0x00000000;  
+    s->PCR11 = 0x00000000; 
+    s->PCR12 = 0x00000000;  
+    s->PCR13 = 0x00000000;  
+    s->PCR14 = 0x00000000; 
+    s->PCR15 = 0x00000000; 
+    s->PCR16 = 0x00000000; 
+    s->PCR17 = 0x00000000;  
+    s->PCR18 = 0x00000000; 
+    s->PCR19 = 0x00000000; 
+    s->PCR20 = 0x00000000; 
+    s->PCR21 = 0x00000000;  
+    s->PCR22 = 0x00000000; 
+    s->PCR23 = 0x00000000;  
+    s->PCR24 = 0x00000000; 
+    s->PCR25 = 0x00000000; 
+    s->PCR26 = 0x00000000; 
+    s->PCR27 = 0x00000000;  
+    s->PCR28 = 0x00000000; 
+    s->PCR29 = 0x00000000;  
+    s->PCR30 = 0x00000000;  
+    s->PCR31 = 0x00000000;  
+    s->GPCLR = 0x00000000; 
+    s->GPCHR = 0x00000000; 
+    s->ISFR = 0x00000000;  
+    s->DFER = 0x00000000;   
+    s->DFCR = 0x00000000;   
+    s->DFWR = 0x00000000;
+}
+
+static void kinetis_k64_pmux_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    kinetis_k64_pmux_state *s = (kinetis_k64_pmux_state *)opaque;
+
+    value = value & 0xFFFFFFFF;
+/*    printf("kinetis_k64_pmux_write: Offset = 0x%08X, Value = 0x%08X\n",
+            (unsigned int)offset, (unsigned int)value);*/
+    
+    switch (offset) {
+        case 0x00: /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+            s->PCR00 = value;
+            break;
+        case 0x04: 
+            s->PCR01 = value;
+            break;
+        case 0x08: 
+            s->PCR02 = value;
+            break;
+        case 0x0C: 
+            s->PCR03 = value;
+            break;
+        case 0x10: 
+            s->PCR04 = value;
+            break;
+        case 0x14: 
+            s->PCR05 = value;
+            break;
+        case 0x18: 
+            s->PCR06 = value;
+            break;
+        case 0x1C: 
+            s->PCR07 = value;
+            break;
+        case 0x20: 
+            s->PCR08 = value;
+            break;
+        case 0x24: 
+            s->PCR09 = value;
+            break;
+        case 0x28: 
+            s->PCR10 = value;
+            break;
+        case 0x2C: 
+            s->PCR11 = value;
+            break;
+        case 0x30: 
+            s->PCR12 = value;
+            break;
+        case 0x34: 
+            s->PCR13 = value;
+            break;
+        case 0x38: 
+            s->PCR14 = value;
+            break;
+        case 0x3C: 
+            s->PCR15 = value;
+            break;
+        case 0x40: 
+            s->PCR16 = value;
+            break;
+        case 0x44: 
+            s->PCR17 = value;
+            break;
+        case 0x48: 
+            s->PCR18 = value;
+            break;
+        case 0x4C:
+            s->PCR19 = value;
+            break;
+        case 0x50:
+            s->PCR20 = value;
+            break;
+        case 0x54:
+            s->PCR21 = value;
+            break;
+        case 0x58:
+            s->PCR22 = value;
+            break;
+        case 0x5C:
+            s->PCR23 = value;
+            break;
+        case 0x60:
+            s->PCR24 = value;
+            break;
+        case 0x64:
+            s->PCR25 = value;
+            break;
+        case 0x68:
+            s->PCR26 = value;
+            break;
+        case 0x6C:
+            s->PCR27 = value;
+            break;
+        case 0x70:
+            s->PCR28 = value;
+            break;
+        case 0x74:
+            s->PCR29 = value;
+            break;
+        case 0x78:
+            s->PCR30 = value;
+            break;
+        case 0x7C:
+            s->PCR31 = value;
+            break;
+        case 0x80: /**< Global Pin Control Low Register, offset: 0x80 */
+            s->GPCLR = value;
+            break;
+        case 0x84:  /**< Global Pin Control High Register, offset: 0x84 */
+            s->GPCHR = value;
+            break;
+        case 0xA0: /**< Interrupt Status Flag Register, offset: 0xA0 */
+            s->ISFR = value;
+            break;
+        case 0xC0: /**< Digital Filter Enable Register, offset: 0xC0 */
+            s->DFER = value;
+            break;
+        case 0xC4: /**< Digital Filter Clock Register, offset: 0xC4 */
+            s->DFCR = value;
+            break;
+        case 0xC8: /**< Digital Filter Width Register, offset: 0xC8 */
+            s->DFWR = value;
+            break;
+        
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "kinetis_k64_pmux: write at bad offset 0x%x\n",
+                    (int)offset);
+    }
+}
+
+static uint64_t kinetis_k64_pmux_read(void *opaque, hwaddr offset,
+        unsigned size)
+{
+    kinetis_k64_pmux_state *s = (kinetis_k64_pmux_state *)opaque;
+    uint8_t value;
+    
+    switch (offset) {
+        case 0x00: /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+            value = s->PCR00;
+            break;
+        case 0x04: 
+            value = s->PCR01;
+            break;
+        case 0x08: 
+            value = s->PCR02;
+            break;
+        case 0x0C: 
+            value = s->PCR03;
+            break;
+        case 0x10: 
+            value = s->PCR04;
+            break;
+        case 0x14: 
+            value = s->PCR05;
+            break;
+        case 0x18: 
+            value = s->PCR06;
+            break;
+        case 0x1C: 
+            value = s->PCR07;
+            break;
+        case 0x20: 
+            value = s->PCR08;
+            break;
+        case 0x24: 
+            value = s->PCR09;
+            break;
+        case 0x28: 
+            value = s->PCR10;
+            break;
+        case 0x2C: 
+            value = s->PCR11;
+            break;
+        case 0x30: 
+            value = s->PCR12;
+            break;
+        case 0x34: 
+            value = s->PCR13;
+            break;
+        case 0x38: 
+            value = s->PCR14;
+            break;
+        case 0x3C: 
+            value = s->PCR15;
+            break;
+        case 0x40: 
+            value = s->PCR16;
+            break;
+        case 0x44: 
+            value = s->PCR17;
+            break;
+        case 0x48: 
+            value = s->PCR18;
+            break;
+        case 0x4C:
+            value = s->PCR19;
+            break;
+        case 0x50:
+            value = s->PCR20;
+            break;
+        case 0x54:
+            value = s->PCR21;
+            break;
+        case 0x58:
+            value = s->PCR22;
+            break;
+        case 0x5C:
+            value = s->PCR23;
+            break;
+        case 0x60:
+            value = s->PCR24;
+            break;
+        case 0x64:
+            value = s->PCR25;
+            break;
+        case 0x68:
+            value = s->PCR26;
+            break;
+        case 0x6C:
+            value = s->PCR27;
+            break;
+        case 0x70:
+            value = s->PCR28;
+            break;
+        case 0x74:
+            value = s->PCR29;
+            break;
+        case 0x78:
+            value = s->PCR30;
+            break;
+        case 0x7C:
+            value = s->PCR31;
+            break;
+        case 0x80: /**< Global Pin Control Low Register, offset: 0x80 */
+            value = s->GPCLR;
+            break;
+        case 0x84:  /**< Global Pin Control High Register, offset: 0x84 */
+            value = s->GPCHR;
+            break;
+        case 0xA0: /**< Interrupt Status Flag Register, offset: 0xA0 */
+            value = s->ISFR;
+            break;
+        case 0xC0: /**< Digital Filter Enable Register, offset: 0xC0 */
+            value = s->DFER;
+            break;
+        case 0xC4: /**< Digital Filter Clock Register, offset: 0xC4 */
+            value = s->DFCR;
+            break;
+        case 0xC8: /**< Digital Filter Width Register, offset: 0xC8 */
+            value = s->DFWR;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "kinetis_k64_pmux: read at bad offset 0x%x\n", (int)offset);
+            return 0;
+    }
+/*    printf("kinetis_k64_pmux_read: Offset = 0x%08X, Value = 0x%08X\n", 
+            (unsigned int)offset, (unsigned int)value);*/
+    return value;
+}
+
+static const MemoryRegionOps kinetis_k64_pmux_ops = {
+    .read = kinetis_k64_pmux_read,
+    .write = kinetis_k64_pmux_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void kinetis_k64_pmux_init(Object *obj)
+{
+    kinetis_k64_pmux_state *s = KINETIS_K64_PMUX(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_pmux_ops, s,
+            TYPE_KINETIS_K64_PMUX, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void kinetis_k64_pmux_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_pmux;
+    dc->reset = kinetis_k64_pmux_reset;
+    dc->desc = "Kinetis K64 series PMUX";    
+}
+
+static const TypeInfo kinetis_k64_pmux_info = {
+    .name          = TYPE_KINETIS_K64_PMUX,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_pmux_state),
+    .instance_init = kinetis_k64_pmux_init,
+    .class_init    = kinetis_k64_pmux_class_init,
+};
+
+static void kinetis_k64_pmux_register_types(void)
+{
+    type_register_static(&kinetis_k64_pmux_info);
+}
+
+type_init(kinetis_k64_pmux_register_types)
\ No newline at end of file
diff --git a/hw/arm/kinetis/k64/peripheral/sim.c b/hw/arm/kinetis/k64/peripheral/sim.c
new file mode 100755
index 0000000..dacf28d
--- /dev/null
+++ b/hw/arm/kinetis/k64/peripheral/sim.c
@@ -0,0 +1,292 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series SIM controller.  */
+ 
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/kinetis/k64/peripheral/sim.h"
+
+static const VMStateDescription vmstate_kinetis_k64_sim = {
+    .name = TYPE_KINETIS_K64_SIM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(SOPT1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT1CFG, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT4, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT5, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT7, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SDID, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC3, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC4, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC5, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC6, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC7, kinetis_k64_sim_state),
+        VMSTATE_UINT32(CLKDIV1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(CLKDIV2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(FCFG1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(FCFG2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDH, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDMH, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDML, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDL, kinetis_k64_sim_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_sim_reset(DeviceState *dev)
+{
+    kinetis_k64_sim_state *s = KINETIS_K64_SIM(dev);
+    
+    s->SOPT1 = 0x00008000;
+    s->SOPT1CFG = 0x00000000;
+    s->SOPT2 = 0x00001000;
+    s->SOPT4 = 0x00000000;
+    s->SOPT5 = 0x00000000;
+    s->SOPT7 = 0x00000000;
+    s->SDID = 0x00000000;
+    s->SCGC1 = 0x00000000;
+    s->SCGC2 = 0x00000000;
+    s->SCGC3 = 0x00000000;
+    s->SCGC4 = 0xF0100030;
+    s->SCGC5 = 0x00040182;
+    s->SCGC6 = 0x40000001;
+    s->SCGC7 = 0x00000006;
+    s->CLKDIV1 = 0x00000000;
+    s->CLKDIV2 = 0x00000000;
+    s->FCFG1 = 0xFF000000;
+    s->FCFG2 = 0x00000000;
+    s->UIDH = 0x00000000;
+    s->UIDMH = 0x00000000;
+    s->UIDML = 0x00000000;
+    s->UIDL = 0x00000000;
+}
+
+static void kinetis_k64_sim_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    kinetis_k64_sim_state *s = (kinetis_k64_sim_state *)opaque;
+
+    value = value & 0xFFFFFFFF;
+/*    printf("kinetis_k64_sim_write: Offset = 0x%08X, Value = 0x%08X\n",
+            (unsigned int)offset, (unsigned int)value);*/
+    
+    switch (offset) {
+        case 0x0000: /**< System Options Register 1, offset: 0x0 */
+            s->SOPT1 = value;
+            break;
+        case 0x0004: /**< SOPT1 Configuration Register, offset: 0x4 */
+            s->SOPT1CFG = value;
+            break;
+        case 0x1004: /**< System Options Register 2, offset: 0x1004 */
+            s->SOPT2 = value;
+            break;
+        case 0x100C: /**< System Options Register 4, offset: 0x100C */
+            s->SOPT4 = value;
+            break;
+        case 0x1010: /**< System Options Register 5, offset: 0x1010 */
+            s->SOPT5 = value;
+            break;
+        case 0x1018: /**< System Options Register 7, offset: 0x1018 */
+            s->SOPT7 = value;
+            break;
+        case 0x1024: /**< System Device Id Register, offset: 0x1024 */
+            s->SDID = value;
+            break;
+        case 0x1028: /**< System Clock Gating Ctrl Register 1, offset: 0x1028 */
+            s->SCGC1 = value;
+            break;
+        case 0x102C: /**< System Clock Gating Ctrl Register 2, offset: 0x102C */
+            s->SCGC2 = value;
+            break;
+        case 0x1030: /**< System Clock Gating Ctrl Register 3, offset: 0x1030 */
+            s->SCGC3 = value;
+            break;
+        case 0x1034: /**< System Clock Gating Ctrl Register 4, offset: 0x1034 */
+            s->SCGC4 = value;
+            break;
+        case 0x1013: /**< System Clock Gating Ctrl Register 5, offset: 0x1038 */
+            s->SCGC5 = value;
+            break;
+        case 0x103C: /**< System Clock Gating Ctrl Register 6, offset: 0x103C */
+            s->SCGC6 = value;
+            break;
+        case 0x1040: /**< System Clock Gating Ctrl Register 7, offset: 0x1040 */
+            s->SCGC7 = value;
+            break;
+        case 0x1044: /**< System Clock Divider Register 1, offset: 0x1044 */
+            s->CLKDIV1 = value;
+            break;
+        case 0x1048: /**< System Clock Divider Register 2, offset: 0x1048 */
+            s->CLKDIV2 = value;
+            break;
+        case 0x104C: /**< Flash Configuration Register 1, offset: 0x104C */
+            s->FCFG1 = value;
+            break;
+        case 0x1050: /**< Flash Configuration Register 2, offset: 0x1050 */
+            s->FCFG2 = value;
+            break;
+        case 0x1054: /**< Unique Id Register High, offset: 0x1054 */
+            s->UIDH = value;
+            break;
+        case 0x1058: /**< Unique Id Register Mid-High, offset: 0x1058 */
+            s->UIDMH = value;
+            break;
+        case 0x105C: /**< Unique Id Register Mid Low, offset: 0x105C */
+            s->UIDML = value;
+            break;
+        case 0x1060: /**< Unique Id Register Low, offset: 0x1060 */   
+            s->UIDL = value;        
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "kinetis_k64_sim: write at bad offset 0x%x\n", (int)offset);
+    }
+}
+
+static uint64_t kinetis_k64_sim_read(void *opaque, hwaddr offset, unsigned size)
+{
+    kinetis_k64_sim_state *s = (kinetis_k64_sim_state *)opaque;
+
+    uint32_t value;
+    
+    switch (offset) {
+        case 0x0000: /**< System Options Register 1, offset: 0x0 */
+            value = s->SOPT1;
+            break;
+        case 0x0004: /**< SOPT1 Configuration Register, offset: 0x4 */
+            value = s->SOPT1CFG;
+            break;
+        case 0x1004: /**< System Options Register 2, offset: 0x1004 */
+            value = s->SOPT2;
+            break;
+        case 0x100C: /**< System Options Register 4, offset: 0x100C */
+            value = s->SOPT4;
+            break;
+        case 0x1010: /**< System Options Register 5, offset: 0x1010 */
+            value = s->SOPT5;
+            break;
+        case 0x1018: /**< System Options Register 7, offset: 0x1018 */
+            value = s->SOPT7;
+            break;
+        case 0x1024: /**< System Device Id Register, offset: 0x1024 */
+            value = s->SDID;
+            break;
+        case 0x1028: /**< System Clock Gating Ctrl Register 1, offset: 0x1028 */
+            value = s->SCGC1;
+            break;
+        case 0x102C: /**< System Clock Gating Ctrl Register 2, offset: 0x102C */
+            value = s->SCGC2;
+            break;
+        case 0x1030: /**< System Clock Gating Ctrl Register 3, offset: 0x1030 */
+            value = s->SCGC3;
+            break;
+        case 0x1034: /**< System Clock Gating Ctrl Register 4, offset: 0x1034 */
+            value = s->SCGC4;
+            break;
+        case 0x1013: /**< System Clock Gating Ctrl Register 5, offset: 0x1038 */
+            value = s->SCGC5;
+            break;
+        case 0x103C: /**< System Clock Gating Ctrl Register 6, offset: 0x103C */
+            value = s->SCGC6;
+            break;
+        case 0x1040: /**< System Clock Gating Ctrl Register 7, offset: 0x1040 */
+            value = s->SCGC7;
+            break;
+        case 0x1044: /**< System Clock Divider Register 1, offset: 0x1044 */
+            value = s->CLKDIV1;
+            break;
+        case 0x1048: /**< System Clock Divider Register 2, offset: 0x1048 */
+            value = s->CLKDIV2;
+            break;
+        case 0x104C: /**< Flash Configuration Register 1, offset: 0x104C */
+            value = s->FCFG1;
+            break;
+        case 0x1050: /**< Flash Configuration Register 2, offset: 0x1050 */
+            value = s->FCFG2;
+            break;
+        case 0x1054: /**< Unique Id Register High, offset: 0x1054 */
+            value = s->UIDH;
+            break;
+        case 0x1058: /**< Unique Id Register Mid-High, offset: 0x1058 */
+            value = s->UIDMH;
+            break;
+        case 0x105C: /**< Unique Id Register Mid Low, offset: 0x105C */
+            value = s->UIDML;
+            break;
+        case 0x1060: /**< Unique Id Register Low, offset: 0x1060 */   
+            value = s->UIDL;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "kinetis_k64_sim: read at bad offset 0x%x\n", (int)offset);
+            return 0;
+    }
+/*    printf("kinetis_k64_sim_read: Offset = 0x%08X, Value = 0x%08X\n",
+            (unsigned int)offset, (unsigned int)value);*/
+    return value;    
+}
+
+static const MemoryRegionOps kinetis_k64_sim_ops = {
+    .read = kinetis_k64_sim_read,
+    .write = kinetis_k64_sim_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void kinetis_k64_sim_init(Object *obj)
+{
+    kinetis_k64_sim_state *s = KINETIS_K64_SIM(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_sim_ops, s,
+            TYPE_KINETIS_K64_SIM, 0x2000);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void kinetis_k64_sim_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_sim;
+    dc->reset = kinetis_k64_sim_reset;
+    dc->desc = "Kinetis K64 series SIM";
+}
+
+static const TypeInfo kinetis_k64_sim_info = {
+    .name          = TYPE_KINETIS_K64_SIM,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_sim_state),
+    .instance_init = kinetis_k64_sim_init,
+    .class_init    = kinetis_k64_sim_class_init,
+};
+
+static void kinetis_k64_sim_register_types(void)
+{
+    type_register_static(&kinetis_k64_sim_info);
+}
+
+type_init(kinetis_k64_sim_register_types)
\ No newline at end of file
diff --git a/hw/arm/kinetis/k64/peripheral/uart.c b/hw/arm/kinetis/k64/peripheral/uart.c
new file mode 100755
index 0000000..5d6be62
--- /dev/null
+++ b/hw/arm/kinetis/k64/peripheral/uart.c
@@ -0,0 +1,369 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series UART controller.  */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/kinetis/k64/peripheral/uart.h"
+
+static const VMStateDescription vmstate_kinetis_k64_uart = {
+    .name = TYPE_KINETIS_K64_UART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(BDH, kinetis_k64_uart_state),
+        VMSTATE_UINT8(BDL, kinetis_k64_uart_state),
+        VMSTATE_UINT8(C1, kinetis_k64_uart_state),
+        VMSTATE_UINT8(C2, kinetis_k64_uart_state),
+        VMSTATE_UINT8(S1, kinetis_k64_uart_state),
+        VMSTATE_UINT8(S2, kinetis_k64_uart_state),
+        VMSTATE_UINT8(C3, kinetis_k64_uart_state),
+        VMSTATE_UINT8(D, kinetis_k64_uart_state),
+        VMSTATE_UINT8(MA1, kinetis_k64_uart_state),
+        VMSTATE_UINT8(MA2, kinetis_k64_uart_state),
+        VMSTATE_UINT8(C4, kinetis_k64_uart_state),
+        VMSTATE_UINT8(C5, kinetis_k64_uart_state),
+        VMSTATE_UINT8(ED, kinetis_k64_uart_state),
+        VMSTATE_UINT8(MODEM, kinetis_k64_uart_state),
+        VMSTATE_UINT8(IR, kinetis_k64_uart_state),
+        VMSTATE_UINT8(PFIFO, kinetis_k64_uart_state),
+        VMSTATE_UINT8(CFIFO, kinetis_k64_uart_state),
+        VMSTATE_UINT8(SFIFO, kinetis_k64_uart_state),
+        VMSTATE_UINT8(TWFIFO, kinetis_k64_uart_state),
+        VMSTATE_UINT8(TCFIFO, kinetis_k64_uart_state),
+        VMSTATE_UINT8(RWFIFO, kinetis_k64_uart_state),
+        VMSTATE_UINT8(RCFIFO, kinetis_k64_uart_state),
+        VMSTATE_UINT8(C7816, kinetis_k64_uart_state),
+        VMSTATE_UINT8(IE7816, kinetis_k64_uart_state),
+        VMSTATE_UINT8(IS7816, kinetis_k64_uart_state),
+        VMSTATE_UINT8(WP7816T0, kinetis_k64_uart_state),
+        VMSTATE_UINT8(WN7816, kinetis_k64_uart_state),
+        VMSTATE_UINT8(WF7816, kinetis_k64_uart_state),
+        VMSTATE_UINT8(ET7816, kinetis_k64_uart_state),
+        VMSTATE_UINT8(TL7816, kinetis_k64_uart_state),         
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_uart_reset(DeviceState *dev)
+{
+    kinetis_k64_uart_state *s = KINETIS_K64_UART(dev);
+    
+    s->BDH = 0x00;
+    s->BDL = 0x04;
+    s->C1 = 0x00;
+    s->C2 = 0x00;
+    s->S1 = 0xC0;
+    s->S2 = 0x00;
+    s->C3 = 0x00;
+    s->D = 0x00;
+    s->MA1 = 0x00;
+    s->MA2 = 0x00;
+    s->C4 = 0x00;
+    s->C5 = 0x00;
+    s->ED = 0x00;
+    s->MODEM = 0x00;
+    s->IR = 0x00;
+    s->PFIFO = 0x00;
+    s->CFIFO = 0x00;
+    s->SFIFO = 0xC0;
+    s->TWFIFO = 0x00;
+    s->TCFIFO = 0x00;
+    s->RWFIFO = 0x01;
+    s->RCFIFO = 0x00;
+    s->C7816 = 0x00;
+    s->IE7816 = 0x00;
+    s->IS7816 = 0x00;
+    s->WP7816T0 = 0x0A;
+    s->WN7816 = 0x00;
+    s->WF7816 = 0x01;
+    s->ET7816 = 0x00;
+    s->TL7816 = 0x00;
+    
+    qemu_set_irq(s->irq, 0);
+}
+
+static void kinetis_k64_uart_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
+
+    value &= 0xFF;
+/*    printf("kinetis_k64_uart_write: Offset = 0x%02X, Value = 0x%02X, ch=%c\n",
+            (unsigned int)offset, (unsigned int)value, (unsigned int)value);*/    
+    
+    switch (offset) {
+        case 0x00: /**< UART Baud Rate Registers: High, offset: 0x0 */
+            s->BDH = value;
+            break;
+        case 0x01: /**< UART Baud Rate Registers: Low, offset: 0x1 */
+            s->BDL = value;
+            break;
+        case 0x02: /**< UART Control Register 1, offset: 0x2 */
+            s->C1 = value;
+            break;
+        case 0x03: /**< UART Control Register 2, offset: 0x3 */
+            s->C2 = value;
+            break;
+        case 0x04: /**< UART Status Register 1, offset: 0x4 */
+            s->S1 = value;
+            break;
+        case 0x05: /**< UART Status Register 2, offset: 0x5 */
+            s->S2 = value;
+            break;
+        case 0x06: /**< UART Control Register 3, offset: 0x6 */
+            s->C3 = value;
+            break;
+        case 0x07: /**< UART Data Register, offset: 0x7 */
+            s->D = value;
+            qemu_chr_fe_write_all(&s->chr, &s->D, 1);
+            break;
+        case 0x08: /**< UART Match Address Registers 1, offset: 0x8 */
+            s->MA1 = value;
+            break;
+        case 0x09: /**< UART Match Address Registers 2, offset: 0x9 */
+            s->MA2 = value;
+            break;
+        case 0x0A: /**< UART Control Register 4, offset: 0xA */
+            s->C4 = value;
+            break;
+        case 0x0B: /**< UART Control Register 5, offset: 0xB */
+            s->C5 = value;
+            break;
+        case 0x0C: /**< UART Extended Data Register, offset: 0xC */
+            s->ED = value;
+            break;
+        case 0x0D: /**< UART Modem Register, offset: 0xD */
+            s->MODEM = value;
+            break;
+        case 0x0E: /**< UART Infrared Register, offset: 0xE */
+            s->IR = value;
+            break;
+        case 0x10: /**< UART FIFO Parameters, offset: 0x10 */
+            s->PFIFO = value;
+            break;
+        case 0x11: /**< UART FIFO Control Register, offset: 0x11 */
+            s->CFIFO = value;
+            break;
+        case 0x12: /**< UART FIFO Status Register, offset: 0x12 */
+            s->SFIFO = value;
+            break;
+        case 0x13: /**< UART FIFO Transmit Watermark, offset: 0x13 */
+            s->TWFIFO = value;
+            break;
+        case 0x14: /**< UART FIFO Transmit Count, offset: 0x14 */
+            s->TCFIFO = value;
+            break;
+        case 0x15: /**< UART FIFO Receive Watermark, offset: 0x15 */
+            s->RWFIFO = value;
+            break;
+        case 0x16: /**< UART FIFO Receive Count, offset: 0x16 */
+            s->RCFIFO = value;
+            break;
+        case 0x18: /**< UART 7816 Control Register, offset: 0x18 */
+            s->C7816 = value;
+            break;
+        case 0x19: /**< UART 7816 Interrupt Enable Register, offset: 0x19 */
+            s->IE7816 = value;
+            break;
+        case 0x1A: /**< UART 7816 Interrupt Status Register, offset: 0x1A */
+            s->IS7816 = value;
+            break;
+        case 0x1B: /**< UART 7816 Wait Parameter Register, offset: 0x1B */
+            s->WP7816T0 = value;
+            break;
+        case 0x1C: /**< UART 7816 Wait N Register, offset: 0x1C */
+            s->WN7816 = value;
+            break;
+        case 0x1D: /**< UART 7816 Wait FD Register, offset: 0x1D */
+            s->WF7816 = value;
+            break;
+        case 0x1E: /**< UART 7816 Error Threshold Register, offset: 0x1E */
+            s->ET7816 = value;
+            break;
+        case 0x1F: /**< UART 7816 Transmit Length Register, offset: 0x1F */
+            s->TL7816 = value;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "kinetis_k64_uart: write at bad offset 0x%x\n",
+                    (int)offset);
+    }
+}
+
+static uint64_t kinetis_k64_uart_read(void *opaque, hwaddr offset,
+        unsigned size)
+{
+    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
+
+    switch (offset) {
+        case 0x00: /**< UART Baud Rate Registers: High, offset: 0x0 */
+            return s->BDH;
+        case 0x01: /**< UART Baud Rate Registers: Low, offset: 0x1 */
+            return s->BDL;
+        case 0x02: /**< UART Control Register 1, offset: 0x2 */
+            return s->C1;
+        case 0x03: /**< UART Control Register 2, offset: 0x3 */
+            return s->C2;
+        case 0x04: /**< UART Status Register 1, offset: 0x4 */
+            return s->S1;
+        case 0x05: /**< UART Status Register 2, offset: 0x5 */
+            return s->S2;
+        case 0x06: /**< UART Control Register 3, offset: 0x6 */
+            return s->C3;
+        case 0x07: /**< UART Data Register, offset: 0x7 */
+            s->RCFIFO = 0;
+            qemu_chr_fe_accept_input(&s->chr);
+            return s->D;
+        case 0x08: /**< UART Match Address Registers 1, offset: 0x8 */
+            return s->MA1;
+        case 0x09: /**< UART Match Address Registers 2, offset: 0x9 */
+            return s->MA2;
+        case 0x0A: /**< UART Control Register 4, offset: 0xA */
+            return s->C4;
+        case 0x0B: /**< UART Control Register 5, offset: 0xB */
+            return s->C5;
+        case 0x0C: /**< UART Extended Data Register, offset: 0xC */
+            return s->ED;
+        case 0x0D: /**< UART Modem Register, offset: 0xD */
+            return s->MODEM;
+        case 0x0E: /**< UART Infrared Register, offset: 0xE */
+            return s->IR;
+        case 0x10: /**< UART FIFO Parameters, offset: 0x10 */
+            return s->PFIFO;
+        case 0x11: /**< UART FIFO Control Register, offset: 0x11 */
+            return s->CFIFO;
+        case 0x12: /**< UART FIFO Status Register, offset: 0x12 */
+            return s->SFIFO;
+        case 0x13: /**< UART FIFO Transmit Watermark, offset: 0x13 */
+            return s->TWFIFO;
+        case 0x14: /**< UART FIFO Transmit Count, offset: 0x14 */
+            return s->TCFIFO;
+        case 0x15: /**< UART FIFO Receive Watermark, offset: 0x15 */
+            return s->RWFIFO;
+        case 0x16: /**< UART FIFO Receive Count, offset: 0x16 */
+            return s->RCFIFO;
+        case 0x18: /**< UART 7816 Control Register, offset: 0x18 */
+            return s->C7816;
+        case 0x19: /**< UART 7816 Interrupt Enable Register, offset: 0x19 */
+            return s->IE7816;
+        case 0x1A: /**< UART 7816 Interrupt Status Register, offset: 0x1A */
+            return s->IS7816;
+        case 0x1B: /**< UART 7816 Wait Parameter Register, offset: 0x1B */
+            return s->WP7816T0;
+        case 0x1C: /**< UART 7816 Wait N Register, offset: 0x1C */
+            return s->WN7816;
+        case 0x1D: /**< UART 7816 Wait FD Register, offset: 0x1D */
+            return s->WF7816;
+        case 0x1E: /**< UART 7816 Error Threshold Register, offset: 0x1E */
+            return s->ET7816;
+        case 0x1F: /**< UART 7816 Transmit Length Register, offset: 0x1F */
+            return s->TL7816;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "kinetis_k64_uart: read at bad offset 0x%x\n", (int)offset);
+            return 0;
+    }
+}
+
+static const MemoryRegionOps kinetis_k64_uart_ops = {
+    .read = kinetis_k64_uart_read,
+    .write = kinetis_k64_uart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static int kinetis_k64_uart_can_receive(void *opaque)
+{
+    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
+    
+    if (s->RCFIFO == 0){
+        return 1; //Can read a byte
+    }else{
+        return 0; //Cannot read a byte
+    }
+}
+
+static void kinetis_k64_uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    kinetis_k64_uart_state *s = (kinetis_k64_uart_state *)opaque;
+    
+    if (size > 0){
+        if (buf != NULL){
+            s->D = buf[0];
+            s->RCFIFO = 1;
+        }
+    }
+}
+
+static void kinetis_k64_uart_realize(DeviceState *dev, Error **errp)
+{
+    kinetis_k64_uart_state *s = KINETIS_K64_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, kinetis_k64_uart_can_receive,
+                             kinetis_k64_uart_receive, NULL, NULL,
+                             s, NULL, true);
+}
+
+static Property kinetis_k64_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", kinetis_k64_uart_state, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void kinetis_k64_uart_init(Object *obj)
+{
+    kinetis_k64_uart_state *s = KINETIS_K64_UART(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_uart_ops, s,
+            TYPE_KINETIS_K64_UART, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void kinetis_k64_uart_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_uart;
+    dc->reset = kinetis_k64_uart_reset;
+    dc->desc = "Kinetis K64 series UART";
+    dc->hotpluggable = false;
+    dc->props = kinetis_k64_uart_properties;
+    dc->realize = kinetis_k64_uart_realize;
+}
+
+static const TypeInfo kinetis_k64_uart_info = {
+    .name          = TYPE_KINETIS_K64_UART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_uart_state),
+    .instance_init = kinetis_k64_uart_init,
+    .class_init    = kinetis_k64_uart_class_init,
+};
+
+static void kinetis_k64_uart_register_types(void)
+{
+    type_register_static(&kinetis_k64_uart_info);
+}
+
+type_init(kinetis_k64_uart_register_types)
\ No newline at end of file
diff --git a/include/hw/arm/kinetis/k64/peripheral/flextimer.h b/include/hw/arm/kinetis/k64/peripheral/flextimer.h
new file mode 100755
index 0000000..270a4a0
--- /dev/null
+++ b/include/hw/arm/kinetis/k64/peripheral/flextimer.h
@@ -0,0 +1,62 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series FLEXTIMER controller.  */
+
+#ifndef KINETIS_FLEXTIMER_H
+#define KINETIS_FLEXTIMER_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_FLEXTIMER "kinetis_K64_flextimer"
+#define KINETIS_K64_FLEXTIMER(obj) \
+    OBJECT_CHECK(kinetis_k64_flextimer_state, (obj), TYPE_KINETIS_K64_FLEXTIMER)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t SC;        /**< Status And Control, offset: 0x0 */
+    uint32_t CNT;       /**< Counter, offset: 0x4 */
+    uint32_t MOD;       /**< Modulo, offset: 0x8 */
+    struct {            /* offset: 0xC, array step: 0x8 */
+     uint32_t CnSC;     /**< Ch(n) Status And Control, offset: 0xC, step: 0x8 */
+     uint32_t CnV;      /**< Ch(n) Value, array offset: 0x10, array step: 0x8 */
+    }CONTROLS[8];
+    uint32_t CNTIN;     /**< Counter Initial Value, offset: 0x4C */
+    uint32_t STATUS;    /**< Capture And Compare Status, offset: 0x50 */
+    uint32_t MODE;      /**< Features Mode Selection, offset: 0x54 */
+    uint32_t SYNC;      /**< Synchronization, offset: 0x58 */
+    uint32_t OUTINIT;   /**< Initial State For Channels Output, offset: 0x5C */
+    uint32_t OUTMASK;   /**< Output Mask, offset: 0x60 */
+    uint32_t COMBINE;   /**< Function For Linked Channels, offset: 0x64 */
+    uint32_t DEADTIME;  /**< Deadtime Insertion Control, offset: 0x68 */
+    uint32_t EXTTRIG;   /**< FTM External Trigger, offset: 0x6C */
+    uint32_t POL;       /**< Channels Polarity, offset: 0x70 */
+    uint32_t FMS;       /**< Fault Mode Status, offset: 0x74 */
+    uint32_t FILTER;    /**< Input Capture Filter Control, offset: 0x78 */
+    uint32_t FLTCTRL;   /**< Fault Control, offset: 0x7C */
+    uint32_t QDCTRL; /**< Quadrature Decoder Control And Status, offset: 0x80 */
+    uint32_t CONF;      /**< Configuration, offset: 0x84 */
+    uint32_t FLTPOL;    /**< FTM Fault Input Polarity, offset: 0x88 */
+    uint32_t SYNCONF;   /**< Synchronization Configuration, offset: 0x8C */
+    uint32_t INVCTRL;   /**< FTM Inverting Control, offset: 0x90 */
+    uint32_t SWOCTRL;   /**< FTM Software Output Control, offset: 0x94 */
+    uint32_t PWMLOAD;   /**< FTM PWM Load, offset: 0x98 */    
+    
+    qemu_irq irq;
+} kinetis_k64_flextimer_state;
+
+#endif
\ No newline at end of file
diff --git a/include/hw/arm/kinetis/k64/peripheral/mcg.h b/include/hw/arm/kinetis/k64/peripheral/mcg.h
new file mode 100755
index 0000000..2911452
--- /dev/null
+++ b/include/hw/arm/kinetis/k64/peripheral/mcg.h
@@ -0,0 +1,47 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series MCG controller.  */
+
+#ifndef KINETIS_MCG_H
+#define KINETIS_MCG_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_MCG "kinetis_k64_mcg"
+#define KINETIS_K64_MCG(obj) \
+    OBJECT_CHECK(kinetis_k64_mcg_state, (obj), TYPE_KINETIS_K64_MCG)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint8_t C1;     /**< MCG Control 1 Register, offset: 0x0 */
+    uint8_t C2;     /**< MCG Control 2 Register, offset: 0x1 */
+    uint8_t C3;     /**< MCG Control 3 Register, offset: 0x2 */
+    uint8_t C4;     /**< MCG Control 4 Register, offset: 0x3 */
+    uint8_t C5;     /**< MCG Control 5 Register, offset: 0x4 */
+    uint8_t C6;     /**< MCG Control 6 Register, offset: 0x5 */
+    uint8_t S;      /**< MCG Status Register, offset: 0x6 */
+    uint8_t SC;     /**< MCG Status and Control Register, offset: 0x8 */
+    uint8_t ATCVH;  /**< MCG Auto Trim Compare Value High Register, offset:0xA*/
+    uint8_t ATCVL;  /**< MCG Auto Trim Compare Value Low Register, offset:0xB*/
+    uint8_t C7;     /**< MCG Control 7 Register, offset: 0xC */
+    uint8_t C8;     /**< MCG Control 8 Register, offset: 0xD */    
+    
+    qemu_irq irq;
+} kinetis_k64_mcg_state;
+
+#endif
\ No newline at end of file
diff --git a/include/hw/arm/kinetis/k64/peripheral/pmux.h b/include/hw/arm/kinetis/k64/peripheral/pmux.h
new file mode 100755
index 0000000..59a3313
--- /dev/null
+++ b/include/hw/arm/kinetis/k64/peripheral/pmux.h
@@ -0,0 +1,73 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series PMUX controller.  */
+
+#ifndef KINETIS_PMUX_H
+#define KINETIS_PMUX_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_PMUX "kinetis_k64_pmux"
+#define KINETIS_K64_PMUX(obj) \
+    OBJECT_CHECK(kinetis_k64_pmux_state, (obj), TYPE_KINETIS_K64_PMUX)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    
+    uint32_t PCR00;/**< Pin Control Register n, offset: 0x0, array step: 0x4 */
+    uint32_t PCR01;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR02;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR03;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR04;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR05;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR06;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR07;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR08;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR09;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR10;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR11;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR12;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR13;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR14;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR15;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR16;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR17;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR18;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR19;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR20;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR21;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR22;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR23;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR24;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR25;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR26;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR27;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR28;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR29;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR30;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR31;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t GPCLR;     /**< Global Pin Control Low Register, offset: 0x80 */
+    uint32_t GPCHR;     /**< Global Pin Control High Register, offset: 0x84 */
+    uint32_t ISFR;      /**< Interrupt Status Flag Register, offset: 0xA0 */
+    uint32_t DFER;      /**< Digital Filter Enable Register, offset: 0xC0 */
+    uint32_t DFCR;      /**< Digital Filter Clock Register, offset: 0xC4 */
+    uint32_t DFWR;      /**< Digital Filter Width Register, offset: 0xC8 */    
+    
+    qemu_irq irq;
+} kinetis_k64_pmux_state;
+
+#endif
\ No newline at end of file
diff --git a/include/hw/arm/kinetis/k64/peripheral/sim.h b/include/hw/arm/kinetis/k64/peripheral/sim.h
new file mode 100755
index 0000000..7ae3465
--- /dev/null
+++ b/include/hw/arm/kinetis/k64/peripheral/sim.h
@@ -0,0 +1,56 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series SIM controller.  */
+
+#ifndef KINETIS_SIM_H
+#define KINETIS_SIM_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_SIM "kinetis_k64_sim"
+#define KINETIS_K64_SIM(obj) \
+    OBJECT_CHECK(kinetis_k64_sim_state, (obj), TYPE_KINETIS_K64_SIM)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t SOPT1;     /**< System Options Register 1, offset: 0x0 */
+    uint32_t SOPT1CFG;  /**< SOPT1 Configuration Register, offset: 0x4 */
+    uint32_t SOPT2;     /**< System Options Register 2, offset: 0x1004 */
+    uint32_t SOPT4;     /**< System Options Register 4, offset: 0x100C */
+    uint32_t SOPT5;     /**< System Options Register 5, offset: 0x1010 */
+    uint32_t SOPT7;     /**< System Options Register 7, offset: 0x1018 */
+    uint32_t SDID;      /**< System Device Id Register, offset: 0x1024 */
+    uint32_t SCGC1;     /**< System Clock Gating Ctrl Reg 1, offset: 0x1028 */
+    uint32_t SCGC2;     /**< System Clock Gating Ctrl Reg 2, offset: 0x102C */
+    uint32_t SCGC3;     /**< System Clock Gating Ctrl Reg 3, offset: 0x1030 */
+    uint32_t SCGC4;     /**< System Clock Gating Ctrl Reg 4, offset: 0x1034 */
+    uint32_t SCGC5;     /**< System Clock Gating Ctrl Reg 5, offset: 0x1038 */
+    uint32_t SCGC6;     /**< System Clock Gating Ctrl Reg 6, offset: 0x103C */
+    uint32_t SCGC7;     /**< System Clock Gating Ctrl Reg 7, offset: 0x1040 */
+    uint32_t CLKDIV1;   /**< System Clock Divider Register 1, offset: 0x1044 */
+    uint32_t CLKDIV2;   /**< System Clock Divider Register 2, offset: 0x1048 */
+    uint32_t FCFG1;     /**< Flash Configuration Register 1, offset: 0x104C */
+    uint32_t FCFG2;     /**< Flash Configuration Register 2, offset: 0x1050 */
+    uint32_t UIDH;      /**< Unique Id Register High, offset: 0x1054 */
+    uint32_t UIDMH;     /**< Unique Id Register Mid-High, offset: 0x1058 */
+    uint32_t UIDML;     /**< Unique Id Register Mid Low, offset: 0x105C */
+    uint32_t UIDL;      /**< Unique Id Register Low, offset: 0x1060 */    
+
+} kinetis_k64_sim_state;
+
+#endif
\ No newline at end of file
diff --git a/include/hw/arm/kinetis/k64/peripheral/uart.h b/include/hw/arm/kinetis/k64/peripheral/uart.h
new file mode 100755
index 0000000..46e42f6
--- /dev/null
+++ b/include/hw/arm/kinetis/k64/peripheral/uart.h
@@ -0,0 +1,85 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+ 
+/* Kinetis K64 series UART controller.  */
+
+#ifndef KINETIS_UART_H
+#define KINETIS_UART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_UART "kinetis_k64_uart"
+#define KINETIS_K64_UART(obj) \
+    OBJECT_CHECK(kinetis_k64_uart_state, (obj), TYPE_KINETIS_K64_UART)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint8_t BDH;    /**< UART Baud Rate Registers: High, offset: 0x0 */
+    uint8_t BDL;    /**< UART Baud Rate Registers: Low, offset: 0x1 */
+    uint8_t C1;     /**< UART Control Register 1, offset: 0x2 */
+    uint8_t C2;     /**< UART Control Register 2, offset: 0x3 */
+    uint8_t S1;     /**< UART Status Register 1, offset: 0x4 */
+    uint8_t S2;     /**< UART Status Register 2, offset: 0x5 */
+    uint8_t C3;     /**< UART Control Register 3, offset: 0x6 */
+    uint8_t D;      /**< UART Data Register, offset: 0x7 */
+    uint8_t MA1;    /**< UART Match Address Registers 1, offset: 0x8 */
+    uint8_t MA2;    /**< UART Match Address Registers 2, offset: 0x9 */
+    uint8_t C4;     /**< UART Control Register 4, offset: 0xA */
+    uint8_t C5;     /**< UART Control Register 5, offset: 0xB */
+    uint8_t ED;     /**< UART Extended Data Register, offset: 0xC */
+    uint8_t MODEM;  /**< UART Modem Register, offset: 0xD */
+    uint8_t IR;     /**< UART Infrared Register, offset: 0xE */
+    uint8_t PFIFO;  /**< UART FIFO Parameters, offset: 0x10 */
+    uint8_t CFIFO;  /**< UART FIFO Control Register, offset: 0x11 */
+    uint8_t SFIFO;  /**< UART FIFO Status Register, offset: 0x12 */
+    uint8_t TWFIFO; /**< UART FIFO Transmit Watermark, offset: 0x13 */
+    uint8_t TCFIFO; /**< UART FIFO Transmit Count, offset: 0x14 */
+    uint8_t RWFIFO; /**< UART FIFO Receive Watermark, offset: 0x15 */
+    uint8_t RCFIFO; /**< UART FIFO Receive Count, offset: 0x16 */
+    uint8_t C7816;  /**< UART 7816 Control Register, offset: 0x18 */
+    uint8_t IE7816; /**< UART 7816 Interrupt Enable Register, offset: 0x19 */
+    uint8_t IS7816; /**< UART 7816 Interrupt Status Register, offset: 0x1A */
+    union {               /* offset: 0x1B */
+        uint8_t WP7816T0; /**< UART 7816 Wait Parameter Register, offset: 0x1B*/
+        uint8_t WP7816T1; /**< UART 7816 Wait Parameter Register, offset: 0x1B*/
+    };
+    uint8_t WN7816; /**< UART 7816 Wait N Register, offset: 0x1C */
+    uint8_t WF7816; /**< UART 7816 Wait FD Register, offset: 0x1D */
+    uint8_t ET7816; /**< UART 7816 Error Threshold Register, offset: 0x1E */
+    uint8_t TL7816; /**< UART 7816 Transmit Length Register, offset: 0x1F */
+    
+    qemu_irq irq;
+    CharBackend chr;
+} kinetis_k64_uart_state;
+
+static inline DeviceState *kinetis_k64_uart_create(hwaddr addr, qemu_irq irq, 
+        Chardev *chr)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_create(NULL, TYPE_KINETIS_K64_UART);
+    qdev_prop_set_chr(dev, "chardev", chr);
+    qdev_init_nofail(dev);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(s, 0, addr);
+    sysbus_connect_irq(s, 0, irq);
+
+    return dev;
+}
+
+#endif
\ No newline at end of file
-- 
2.1.4
