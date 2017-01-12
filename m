Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkE-0003F4-8U
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk9-0006kI-2t
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:08 +1100
Message-Id: <20170112020327.24882-49-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 48/67] prep: add PReP System I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

This device is a partial duplicate of System I/O device available in hw/p=
pc/prep.c
This new one doesn't have all the Motorola-specific registers.
The old one should be deprecated and removed with the 'prep' machine.

Partial documentation available at
ftp://ftp.software.ibm.com/rs6000/technology/spec/srp1_1.exe
section 6.1.5 (I/O Device Mapping)

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs   |   1 +
 hw/ppc/prep_systemio.c | 303 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/trace-events    |   4 +
 3 files changed, 308 insertions(+)
 create mode 100644 hw/ppc/prep_systemio.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 8025129..db72297 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -16,6 +16,7 @@ obj-y +=3D ppc405_boards.o ppc4xx_devs.o ppc405_uc.o pp=
c440_bamboo.o
 obj-y +=3D ppc4xx_pci.o
 # PReP
 obj-$(CONFIG_PREP) +=3D prep.o
+obj-$(CONFIG_PREP) +=3D prep_systemio.o
 # OldWorld PowerMac
 obj-$(CONFIG_MAC) +=3D mac_oldworld.o
 # NewWorld PowerMac
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
new file mode 100644
index 0000000..50893ec
--- /dev/null
+++ b/hw/ppc/prep_systemio.c
@@ -0,0 +1,303 @@
+/*
+ * QEMU PReP System I/O emulation
+ *
+ * Copyright (c) 2017 Herv=C3=A9 Poussineau
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/isa/isa.h"
+#include "exec/address-spaces.h"
+#include "qemu/error-report.h" /* for error_report() */
+#include "sysemu/sysemu.h" /* for vm_stop() */
+#include "cpu.h"
+#include "trace.h"
+
+#define TYPE_PREP_SYSTEMIO "prep-systemio"
+#define PREP_SYSTEMIO(obj) \
+    OBJECT_CHECK(PrepSystemIoState, (obj), TYPE_PREP_SYSTEMIO)
+
+/* Bit as defined in PowerPC Reference Plaform v1.1, sect. 6.1.5, p. 132=
 */
+#define PREP_BIT(n) (1 << (7 - (n)))
+
+typedef struct PrepSystemIoState {
+    ISADevice parent_obj;
+    MemoryRegion ppc_parity_mem;
+
+    qemu_irq non_contiguous_io_map_irq;
+    uint8_t sreset; /* 0x0092 */
+    uint8_t equipment; /* 0x080c */
+    uint8_t system_control; /* 0x081c */
+    uint8_t iomap_type; /* 0x0850 */
+    uint8_t ibm_planar_id; /* 0x0852 */
+    qemu_irq softreset_irq;
+    PortioList portio;
+} PrepSystemIoState;
+
+/* PORT 0092 -- Special Port 92 (Read/Write) */
+
+enum {
+    PORT0092_SOFTRESET  =3D PREP_BIT(7),
+    PORT0092_LE_MODE    =3D PREP_BIT(6),
+};
+
+static void prep_port0092_write(void *opaque, uint32_t addr, uint32_t va=
l)
+{
+    PrepSystemIoState *s =3D opaque;
+
+    trace_prep_systemio_write(addr, val);
+
+    s->sreset =3D val & PORT0092_SOFTRESET;
+    qemu_set_irq(s->softreset_irq, s->sreset);
+
+    if ((val & PORT0092_LE_MODE) !=3D 0) {
+        /* XXX Not supported yet */
+        error_report("little-endian mode not supported");
+        vm_stop(RUN_STATE_PAUSED);
+    } else {
+        /* Nothing to do */
+    }
+}
+
+static uint32_t prep_port0092_read(void *opaque, uint32_t addr)
+{
+    PrepSystemIoState *s =3D opaque;
+    trace_prep_systemio_read(addr, s->sreset);
+    return s->sreset;
+}
+
+/* PORT 0808 -- Hardfile Light Register (Write Only) */
+
+enum {
+    PORT0808_HARDFILE_LIGHT_ON  =3D PREP_BIT(7),
+};
+
+static void prep_port0808_write(void *opaque, uint32_t addr, uint32_t va=
l)
+{
+    trace_prep_systemio_write(addr, val);
+}
+
+/* PORT 0810 -- Password Protect 1 Register (Write Only) */
+
+/* reset by port 0x4D in the SIO */
+static void prep_port0810_write(void *opaque, uint32_t addr, uint32_t va=
l)
+{
+    trace_prep_systemio_write(addr, val);
+}
+
+/* PORT 0812 -- Password Protect 2 Register (Write Only) */
+
+/* reset by port 0x4D in the SIO */
+static void prep_port0812_write(void *opaque, uint32_t addr, uint32_t va=
l)
+{
+    trace_prep_systemio_write(addr, val);
+}
+
+/* PORT 0814 -- L2 Invalidate Register (Write Only) */
+
+static void prep_port0814_write(void *opaque, uint32_t addr, uint32_t va=
l)
+{
+    trace_prep_systemio_write(addr, val);
+}
+
+/* PORT 0818 -- Reserved for Keylock (Read Only) */
+
+enum {
+    PORT0818_KEYLOCK_SIGNAL_HIGH    =3D PREP_BIT(7),
+};
+
+static uint32_t prep_port0818_read(void *opaque, uint32_t addr)
+{
+    uint32_t val =3D 0;
+    trace_prep_systemio_read(addr, val);
+    return val;
+}
+
+/* PORT 080C -- Equipment */
+
+enum {
+    PORT080C_SCSIFUSE               =3D PREP_BIT(1),
+    PORT080C_L2_COPYBACK            =3D PREP_BIT(4),
+    PORT080C_L2_256                 =3D PREP_BIT(5),
+    PORT080C_UPGRADE_CPU            =3D PREP_BIT(6),
+    PORT080C_L2                     =3D PREP_BIT(7),
+};
+
+static uint32_t prep_port080c_read(void *opaque, uint32_t addr)
+{
+    PrepSystemIoState *s =3D opaque;
+    trace_prep_systemio_read(addr, s->equipment);
+    return s->equipment;
+}
+
+/* PORT 081C -- System Control Register (Read/Write) */
+
+enum {
+    PORT081C_FLOPPY_MOTOR_INHIBIT   =3D PREP_BIT(3),
+    PORT081C_MASK_TEA               =3D PREP_BIT(2),
+    PORT081C_L2_UPDATE_INHIBIT      =3D PREP_BIT(1),
+    PORT081C_L2_CACHEMISS_INHIBIT   =3D PREP_BIT(0),
+};
+
+static void prep_port081c_write(void *opaque, uint32_t addr, uint32_t va=
l)
+{
+    static const uint8_t mask =3D PORT081C_FLOPPY_MOTOR_INHIBIT |
+                                PORT081C_MASK_TEA |
+                                PORT081C_L2_UPDATE_INHIBIT |
+                                PORT081C_L2_CACHEMISS_INHIBIT;
+    PrepSystemIoState *s =3D opaque;
+    trace_prep_systemio_write(addr, val);
+    s->system_control =3D val & mask;
+}
+
+static uint32_t prep_port081c_read(void *opaque, uint32_t addr)
+{
+    PrepSystemIoState *s =3D opaque;
+    trace_prep_systemio_read(addr, s->system_control);
+    return s->system_control;
+}
+
+/* System Board Identification */
+
+static uint32_t prep_port0852_read(void *opaque, uint32_t addr)
+{
+    PrepSystemIoState *s =3D opaque;
+    trace_prep_systemio_read(addr, s->ibm_planar_id);
+    return s->ibm_planar_id;
+}
+
+/* PORT 0850 -- I/O Map Type Register (Read/Write) */
+
+enum {
+    PORT0850_IOMAP_NONCONTIGUOUS    =3D PREP_BIT(7),
+};
+
+static uint32_t prep_port0850_read(void *opaque, uint32_t addr)
+{
+    PrepSystemIoState *s =3D opaque;
+    trace_prep_systemio_read(addr, s->iomap_type);
+    return s->iomap_type;
+}
+
+static void prep_port0850_write(void *opaque, uint32_t addr, uint32_t va=
l)
+{
+    PrepSystemIoState *s =3D opaque;
+
+    trace_prep_systemio_write(addr, val);
+    qemu_set_irq(s->non_contiguous_io_map_irq,
+                 val & PORT0850_IOMAP_NONCONTIGUOUS);
+    s->iomap_type =3D val & PORT0850_IOMAP_NONCONTIGUOUS;
+}
+
+static const MemoryRegionPortio ppc_io800_port_list[] =3D {
+    { 0x092, 1, 1, .read =3D prep_port0092_read,
+                   .write =3D prep_port0092_write, },
+    { 0x808, 1, 1, .write =3D prep_port0808_write, },
+    { 0x80c, 1, 1, .read =3D prep_port080c_read, },
+    { 0x810, 1, 1, .write =3D prep_port0810_write, },
+    { 0x812, 1, 1, .write =3D prep_port0812_write, },
+    { 0x814, 1, 1, .write =3D prep_port0814_write, },
+    { 0x818, 1, 1, .read =3D prep_port0818_read },
+    { 0x81c, 1, 1, .read =3D prep_port081c_read,
+                   .write =3D prep_port081c_write, },
+    { 0x850, 1, 1, .read =3D prep_port0850_read,
+                   .write =3D prep_port0850_write, },
+    { 0x852, 1, 1, .read =3D prep_port0852_read, },
+    PORTIO_END_OF_LIST()
+};
+
+static uint64_t ppc_parity_error_readl(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    uint32_t val =3D 0;
+    trace_prep_systemio_read((unsigned int)addr, val);
+    return val;
+}
+
+static const MemoryRegionOps ppc_parity_error_ops =3D {
+    .read =3D ppc_parity_error_readl,
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+    },
+};
+
+static void prep_systemio_realize(DeviceState *dev, Error **errp)
+{
+    ISADevice *isa =3D ISA_DEVICE(dev);
+    PrepSystemIoState *s =3D PREP_SYSTEMIO(dev);
+    PowerPCCPU *cpu;
+
+    qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
+    s->iomap_type =3D PORT0850_IOMAP_NONCONTIGUOUS;
+    qemu_set_irq(s->non_contiguous_io_map_irq,
+                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
+    cpu =3D POWERPC_CPU(first_cpu);
+    s->softreset_irq =3D cpu->env.irq_inputs[PPC6xx_INPUT_HRESET];
+
+    isa_register_portio_list(isa, &s->portio, 0x0, ppc_io800_port_list, =
s,
+                             "systemio800");
+
+    memory_region_init_io(&s->ppc_parity_mem, OBJECT(dev),
+                          &ppc_parity_error_ops, s, "ppc-parity", 0x4);
+    memory_region_add_subregion(get_system_memory(), 0xbfffeff0,
+                                &s->ppc_parity_mem);
+}
+
+static const VMStateDescription vmstate_prep_systemio =3D {
+    .name =3D "prep_systemio",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT8(sreset, PrepSystemIoState),
+        VMSTATE_UINT8(system_control, PrepSystemIoState),
+        VMSTATE_UINT8(iomap_type, PrepSystemIoState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property prep_systemio_properties[] =3D {
+    DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id,=
 0),
+    DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void prep_systemio_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D prep_systemio_realize;
+    dc->vmsd =3D &vmstate_prep_systemio;
+    dc->props =3D prep_systemio_properties;
+}
+
+static TypeInfo prep_systemio800_info =3D {
+    .name          =3D TYPE_PREP_SYSTEMIO,
+    .parent        =3D TYPE_ISA_DEVICE,
+    .instance_size =3D sizeof(PrepSystemIoState),
+    .class_init    =3D prep_systemio_class_initfn,
+};
+
+static void prep_systemio_register_types(void)
+{
+    type_register_static(&prep_systemio800_info);
+}
+
+type_init(prep_systemio_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 2297ead..2ba6166 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -74,3 +74,7 @@ ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t d=
iff, int64_t seconds) "ad
 # hw/ppc/prep.c
 prep_io_800_writeb(uint32_t addr, uint32_t val) "0x%08" PRIx32 " =3D> 0x=
%02" PRIx32
 prep_io_800_readb(uint32_t addr, uint32_t retval) "0x%08" PRIx32 " <=3D =
0x%02" PRIx32
+
+# hw/ppc/prep_systemio.c
+prep_systemio_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D%x=
"
+prep_systemio_write(uint32_t addr, uint32_t val) "write addr=3D%x val=3D=
%x"
--=20
2.9.3
