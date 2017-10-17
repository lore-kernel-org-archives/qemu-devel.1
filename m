Received: from eggs.gnu.org ([2001:4830:134:3::10]:34375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWa-0007Pq-UG
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4FWZ-00053g-Be
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:14:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Oct 2017 21:12:07 -0300
Message-Id: <20171017001209.32276-38-f4bug@amsat.org>
In-Reply-To: <20171017001209.32276-1-f4bug@amsat.org>
References: <20171017001209.32276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 37/39] i386/pc: extract port92 from pc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i386/pc.h  |   3 +-
 hw/i386/pc.c          | 126 ++------------------------------------------------
 hw/i386/port92.c      | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/Makefile.objs |   2 +-
 4 files changed, 130 insertions(+), 123 deletions(-)
 create mode 100644 hw/i386/port92.c

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 020792c2e8..fcb5223423 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -249,7 +249,8 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
 #define FW_CFG_IO_BASE     0x510
 
-#define PORT92_A20_LINE "a20"
+#define TYPE_PORT92 "port92"
+void port92_init(ISADevice *dev, qemu_irq a20_out);
 
 /* acpi_piix.c */
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 08d01b46eb..a8d20ae89c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -499,124 +499,6 @@ void pc_cmos_init(PCMachineState *pcms,
     qemu_register_reset(pc_cmos_init_late, &arg);
 }
 
-#define TYPE_PORT92 "port92"
-#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
-
-/* port 92 stuff: could be split off */
-typedef struct Port92State {
-    ISADevice parent_obj;
-
-    MemoryRegion io;
-    uint8_t outport;
-    qemu_irq a20_out;
-} Port92State;
-
-static void port92_write(void *opaque, hwaddr addr, uint64_t val,
-                         unsigned size)
-{
-    Port92State *s = opaque;
-    int oldval = s->outport;
-
-    DPRINTF("port92: write 0x%02" PRIx64 "\n", val);
-    s->outport = val;
-    qemu_set_irq(s->a20_out, (val >> 1) & 1);
-    if ((val & 1) && !(oldval & 1)) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
-static uint64_t port92_read(void *opaque, hwaddr addr,
-                            unsigned size)
-{
-    Port92State *s = opaque;
-    uint32_t ret;
-
-    ret = s->outport;
-    DPRINTF("port92: read 0x%02x\n", ret);
-    return ret;
-}
-
-static void port92_init(ISADevice *dev, qemu_irq a20_out)
-{
-    qdev_connect_gpio_out_named(DEVICE(dev), PORT92_A20_LINE, 0, a20_out);
-}
-
-static const VMStateDescription vmstate_port92_isa = {
-    .name = "port92",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(outport, Port92State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void port92_reset(DeviceState *d)
-{
-    Port92State *s = PORT92(d);
-
-    s->outport &= ~1;
-}
-
-static const MemoryRegionOps port92_ops = {
-    .read = port92_read,
-    .write = port92_write,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void port92_initfn(Object *obj)
-{
-    Port92State *s = PORT92(obj);
-
-    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1);
-
-    s->outport = 0;
-
-    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, 1);
-}
-
-static void port92_realizefn(DeviceState *dev, Error **errp)
-{
-    ISADevice *isadev = ISA_DEVICE(dev);
-    Port92State *s = PORT92(dev);
-
-    isa_register_ioport(isadev, &s->io, 0x92);
-}
-
-static void port92_class_initfn(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = port92_realizefn;
-    dc->reset = port92_reset;
-    dc->vmsd = &vmstate_port92_isa;
-    /*
-     * Reason: unlike ordinary ISA devices, this one needs additional
-     * wiring: its A20 output line needs to be wired up by
-     * port92_init().
-     */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo port92_info = {
-    .name          = TYPE_PORT92,
-    .parent        = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(Port92State),
-    .instance_init = port92_initfn,
-    .class_init    = port92_class_initfn,
-};
-
-static void port92_register_types(void)
-{
-    type_register_static(&port92_info);
-}
-
-type_init(port92_register_types)
-
 static void handle_a20_line_change(void *opaque, int irq, int level)
 {
     X86CPU *cpu = opaque;
@@ -1568,6 +1450,11 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042 = isa_create_simple(isa_bus, TYPE_I8042);
     i8042_setup_a20_line(i8042, a20_line[0]);
+
+    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
+    port92_init(port92, a20_line[1]);
+    g_free(a20_line);
+
     if (!no_vmport) {
         vmport_init(isa_bus);
         vmmouse = isa_try_create(isa_bus, TYPE_VMMOUSE);
@@ -1579,9 +1466,6 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
         qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
         qdev_init_nofail(dev);
     }
-    port92 = isa_create_simple(isa_bus, "port92");
-    port92_init(port92, a20_line[1]);
-    g_free(a20_line);
 
     DMA_init(isa_bus, 0);
 
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
new file mode 100644
index 0000000000..f067bbd051
--- /dev/null
+++ b/hw/i386/port92.c
@@ -0,0 +1,122 @@
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/i386/pc.h"
+
+#define PORT92_A20_LINE "a20"
+
+#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
+
+/* port 92 stuff: could be split off */
+typedef struct Port92State {
+    ISADevice parent_obj;
+
+    MemoryRegion io;
+    uint8_t outport;
+    qemu_irq a20_out;
+} Port92State;
+
+static void port92_write(void *opaque, hwaddr addr, uint64_t val,
+                         unsigned size)
+{
+    Port92State *s = opaque;
+    int oldval = s->outport;
+
+    //DPRINTF("port92: write 0x%02" PRIx64 "\n", val);
+    s->outport = val;
+    qemu_set_irq(s->a20_out, (val >> 1) & 1);
+    if ((val & 1) && !(oldval & 1)) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static uint64_t port92_read(void *opaque, hwaddr addr,
+                            unsigned size)
+{
+    Port92State *s = opaque;
+    uint32_t ret;
+
+    ret = s->outport;
+    //DPRINTF("port92: read 0x%02x\n", ret);
+    return ret;
+}
+
+void port92_init(ISADevice *dev, qemu_irq a20_out)
+{
+    qdev_connect_gpio_out_named(DEVICE(dev), PORT92_A20_LINE, 0, a20_out);
+}
+
+static const VMStateDescription vmstate_port92_isa = {
+    .name = "port92",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(outport, Port92State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void port92_reset(DeviceState *d)
+{
+    Port92State *s = PORT92(d);
+
+    s->outport &= ~1;
+}
+
+static const MemoryRegionOps port92_ops = {
+    .read = port92_read,
+    .write = port92_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void port92_initfn(Object *obj)
+{
+    Port92State *s = PORT92(obj);
+
+    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1);
+
+    s->outport = 0;
+
+    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, 1);
+}
+
+static void port92_realizefn(DeviceState *dev, Error **errp)
+{
+    ISADevice *isadev = ISA_DEVICE(dev);
+    Port92State *s = PORT92(dev);
+
+    isa_register_ioport(isadev, &s->io, 0x92);
+}
+
+static void port92_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = port92_realizefn;
+    dc->reset = port92_reset;
+    dc->vmsd = &vmstate_port92_isa;
+    /*
+     * Reason: unlike ordinary ISA devices, this one needs additional
+     * wiring: its A20 output line needs to be wired up by
+     * port92_init().
+     */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo port92_info = {
+    .name          = TYPE_PORT92,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(Port92State),
+    .instance_init = port92_initfn,
+    .class_init    = port92_class_initfn,
+};
+
+static void port92_register_types(void)
+{
+    type_register_static(&port92_info);
+}
+
+type_init(port92_register_types)
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 41574096f1..37ce88d380 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -9,4 +9,4 @@ obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-y += kvmvapic.o
 obj-y += acpi-build.o pvpanic.o
 obj-y += pci-assign-load-rom.o
-obj-y += vmport.o
+obj-y += vmport.o port92.o
-- 
2.15.0.rc0
