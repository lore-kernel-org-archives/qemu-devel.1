Received: from eggs.gnu.org ([2001:4830:134:3::10]:46903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkD-0003EJ-2C
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk8-0006k5-Th
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:09 +1100
Message-Id: <20170112020327.24882-50-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 49/67] prep: add IBM RS/6000 7020 (40p) memory
 controller
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

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
[dwg: Added CONFIG_RS6000_MC to ppc64 or it breaks testcases]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak   |   1 +
 default-configs/ppc64-softmmu.mak |   1 +
 hw/ppc/Makefile.objs              |   1 +
 hw/ppc/rs6000_mc.c                | 232 ++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/trace-events               |   7 ++
 5 files changed, 242 insertions(+)
 create mode 100644 hw/ppc/rs6000_mc.c

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
index d4d0f9b..e567658 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -47,3 +47,4 @@ CONFIG_LIBDECNUMBER=3Dy
 # For PReP
 CONFIG_MC146818RTC=3Dy
 CONFIG_ISA_TESTDEV=3Dy
+CONFIG_RS6000_MC=3Dy
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index 67a9bca..9ae6563 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -55,3 +55,4 @@ CONFIG_XICS_KVM=3D$(and $(CONFIG_PSERIES),$(CONFIG_KVM)=
)
 CONFIG_MC146818RTC=3Dy
 CONFIG_ISA_TESTDEV=3Dy
 CONFIG_MEM_HOTPLUG=3Dy
+CONFIG_RS6000_MC=3Dy
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index db72297..0012934 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -17,6 +17,7 @@ obj-y +=3D ppc4xx_pci.o
 # PReP
 obj-$(CONFIG_PREP) +=3D prep.o
 obj-$(CONFIG_PREP) +=3D prep_systemio.o
+obj-${CONFIG_RS6000_MC} +=3D rs6000_mc.o
 # OldWorld PowerMac
 obj-$(CONFIG_MAC) +=3D mac_oldworld.o
 # NewWorld PowerMac
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
new file mode 100644
index 0000000..b613565
--- /dev/null
+++ b/hw/ppc/rs6000_mc.c
@@ -0,0 +1,232 @@
+/*
+ * QEMU RS/6000 memory controller
+ *
+ * Copyright (c) 2017 Herv=C3=A9 Poussineau
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) version 3 or any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/isa/isa.h"
+#include "exec/address-spaces.h"
+#include "hw/boards.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+#define TYPE_RS6000MC "rs6000-mc"
+#define RS6000MC_DEVICE(obj) \
+    OBJECT_CHECK(RS6000MCState, (obj), TYPE_RS6000MC)
+
+typedef struct RS6000MCState {
+    ISADevice parent_obj;
+    /* see US patent 5,684,979 for details (expired 2001-11-04) */
+    uint32_t ram_size;
+    bool autoconfigure;
+    MemoryRegion simm[6];
+    unsigned int simm_size[6];
+    uint32_t end_address[8];
+    uint8_t port0820_index;
+    PortioList portio;
+} RS6000MCState;
+
+/* P0RT 0803 -- SIMM ID Register (32/8 MB) (Read Only) */
+
+static uint32_t rs6000mc_port0803_read(void *opaque, uint32_t addr)
+{
+    RS6000MCState *s =3D opaque;
+    uint32_t val =3D 0;
+    int socket;
+
+    /* (1 << socket) indicates 32 MB SIMM at given socket */
+    for (socket =3D 0; socket < 6; socket++) {
+        if (s->simm_size[socket] =3D=3D 32) {
+            val |=3D (1 << socket);
+        }
+    }
+
+    trace_rs6000mc_id_read(addr, val);
+    return val;
+}
+
+/* PORT 0804 -- SIMM Presence Register (Read Only) */
+
+static uint32_t rs6000mc_port0804_read(void *opaque, uint32_t addr)
+{
+    RS6000MCState *s =3D opaque;
+    uint32_t val =3D 0xff;
+    int socket;
+
+    /* (1 << socket) indicates SIMM absence at given socket */
+    for (socket =3D 0; socket < 6; socket++) {
+        if (s->simm_size[socket]) {
+            val &=3D ~(1 << socket);
+        }
+    }
+    s->port0820_index =3D 0;
+
+    trace_rs6000mc_presence_read(addr, val);
+    return val;
+}
+
+/* Memory Controller Size Programming Register */
+
+static uint32_t rs6000mc_port0820_read(void *opaque, uint32_t addr)
+{
+    RS6000MCState *s =3D opaque;
+    uint32_t val =3D s->end_address[s->port0820_index] & 0x1f;
+    s->port0820_index =3D (s->port0820_index + 1) & 7;
+    trace_rs6000mc_size_read(addr, val);
+    return val;
+}
+
+static void rs6000mc_port0820_write(void *opaque, uint32_t addr, uint32_=
t val)
+{
+    RS6000MCState *s =3D opaque;
+    uint8_t socket =3D val >> 5;
+    uint32_t end_address =3D val & 0x1f;
+
+    trace_rs6000mc_size_write(addr, val);
+    s->end_address[socket] =3D end_address;
+    if (socket > 0 && socket < 7) {
+        if (s->simm_size[socket - 1]) {
+            uint32_t size;
+            uint32_t start_address =3D 0;
+            if (socket > 1) {
+                start_address =3D s->end_address[socket - 1];
+            }
+
+            size =3D end_address - start_address;
+            memory_region_set_enabled(&s->simm[socket - 1], size !=3D 0)=
;
+            memory_region_set_address(&s->simm[socket - 1],
+                                      start_address * 8 * 1024 * 1024);
+        }
+    }
+}
+
+/* Read Memory Parity Error */
+
+enum {
+    PORT0841_NO_ERROR_DETECTED =3D 0x01,
+};
+
+static uint32_t rs6000mc_port0841_read(void *opaque, uint32_t addr)
+{
+    uint32_t val =3D PORT0841_NO_ERROR_DETECTED;
+    trace_rs6000mc_parity_read(addr, val);
+    return val;
+}
+
+static const MemoryRegionPortio rs6000mc_port_list[] =3D {
+    { 0x803, 1, 1, .read =3D rs6000mc_port0803_read },
+    { 0x804, 1, 1, .read =3D rs6000mc_port0804_read },
+    { 0x820, 1, 1, .read =3D rs6000mc_port0820_read,
+                   .write =3D rs6000mc_port0820_write, },
+    { 0x841, 1, 1, .read =3D rs6000mc_port0841_read },
+    PORTIO_END_OF_LIST()
+};
+
+static void rs6000mc_realize(DeviceState *dev, Error **errp)
+{
+    RS6000MCState *s =3D RS6000MC_DEVICE(dev);
+    int socket =3D 0;
+    unsigned int ram_size =3D s->ram_size / (1024 * 1024);
+
+    while (socket < 6) {
+        if (ram_size >=3D 64) {
+            s->simm_size[socket] =3D 32;
+            s->simm_size[socket + 1] =3D 32;
+            ram_size -=3D 64;
+        } else if (ram_size >=3D 16) {
+            s->simm_size[socket] =3D 8;
+            s->simm_size[socket + 1] =3D 8;
+            ram_size -=3D 16;
+        } else {
+            /* Not enough memory */
+            break;
+        }
+        socket +=3D 2;
+    }
+
+    for (socket =3D 0; socket < 6; socket++) {
+        if (s->simm_size[socket]) {
+            char name[] =3D "simm.?";
+            name[5] =3D socket + '0';
+            memory_region_allocate_system_memory(&s->simm[socket], OBJEC=
T(dev),
+                                                 name, s->simm_size[sock=
et]
+                                                 * 1024 * 1024);
+            memory_region_add_subregion_overlap(get_system_memory(), 0,
+                                                &s->simm[socket], socket=
);
+        }
+    }
+    if (ram_size) {
+        /* unable to push all requested RAM in SIMMs */
+        error_setg(errp, "RAM size incompatible with this board. "
+                   "Try again with something else, like %d MB",
+                   s->ram_size / 1024 / 1024 - ram_size);
+        return;
+    }
+
+    if (s->autoconfigure) {
+        uint32_t start_address =3D 0;
+        for (socket =3D 0; socket < 6; socket++) {
+            if (s->simm_size[socket]) {
+                memory_region_set_enabled(&s->simm[socket], true);
+                memory_region_set_address(&s->simm[socket], start_addres=
s);
+                start_address +=3D memory_region_size(&s->simm[socket]);
+            }
+        }
+    }
+
+    isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
+                             rs6000mc_port_list, s, "rs6000mc");
+}
+
+static const VMStateDescription vmstate_rs6000mc =3D {
+    .name =3D "rs6000-mc",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT8(port0820_index, RS6000MCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property rs6000mc_properties[] =3D {
+    DEFINE_PROP_UINT32("ram-size", RS6000MCState, ram_size, 0),
+    DEFINE_PROP_BOOL("auto-configure", RS6000MCState, autoconfigure, tru=
e),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void rs6000mc_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D rs6000mc_realize;
+    dc->vmsd =3D &vmstate_rs6000mc;
+    dc->props =3D rs6000mc_properties;
+}
+
+static const TypeInfo rs6000mc_info =3D {
+    .name          =3D TYPE_RS6000MC,
+    .parent        =3D TYPE_ISA_DEVICE,
+    .instance_size =3D sizeof(RS6000MCState),
+    .class_init    =3D rs6000mc_class_initfn,
+};
+
+static void rs6000mc_types(void)
+{
+    type_register_static(&rs6000mc_info);
+}
+
+type_init(rs6000mc_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 2ba6166..42b8ec0 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -78,3 +78,10 @@ prep_io_800_readb(uint32_t addr, uint32_t retval) "0x%=
08" PRIx32 " <=3D 0x%02" PRI
 # hw/ppc/prep_systemio.c
 prep_systemio_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D%x=
"
 prep_systemio_write(uint32_t addr, uint32_t val) "write addr=3D%x val=3D=
%x"
+
+# hw/ppc/rs6000_mc.c
+rs6000mc_id_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D%x"
+rs6000mc_presence_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D=
%x"
+rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D%x=
"
+rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=3D%x val=3D=
%x"
+rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D=
%x"
--=20
2.9.3
