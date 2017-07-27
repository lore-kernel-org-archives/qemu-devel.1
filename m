Received: from eggs.gnu.org ([2001:4830:134:3::10]:34544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dacwy-0008C5-BK
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dacwt-0001CS-WF
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:11:12 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:39506)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dacwt-0001BZ-Dq
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:11:07 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 27 Jul 2017 10:10:57 +0300
Message-Id: <150113945756.25904.1680815499292736130.stgit@frigg.lan>
In-Reply-To: <150113848793.25904.12006041120076726256.stgit@frigg.lan>
References: <150113848793.25904.12006041120076726256.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 4/5] hypertrace: [softmmu] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Uses a virtual device to trigger the hypertrace channel event.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 hypertrace/Makefile.objs |    4 +
 hypertrace/softmmu.c     |  237 ++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/pci/pci.h     |    2=20
 3 files changed, 243 insertions(+)
 create mode 100644 hypertrace/softmmu.c

diff --git a/hypertrace/Makefile.objs b/hypertrace/Makefile.objs
index 2bda105c2f..01c56c910c 100644
--- a/hypertrace/Makefile.objs
+++ b/hypertrace/Makefile.objs
@@ -1,10 +1,14 @@
 # -*- mode: makefile -*-
=20
 target-obj-$(CONFIG_USER_ONLY) +=3D user.o
+ifdef CONFIG_PCI
+target-obj-$(CONFIG_SOFTMMU) +=3D softmmu.o
+endif
 target-obj-y +=3D common.o
=20
 $(obj)/user.o: $(obj)/emit.c
 $(obj)/common.o: $(obj)/emit.c
+$(obj)/softmmu.o: $(obj)/emit.c
=20
 $(obj)/emit.c: $(obj)/emit.c-timestamp $(BUILD_DIR)/config-host.mak
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
diff --git a/hypertrace/softmmu.c b/hypertrace/softmmu.c
new file mode 100644
index 0000000000..ecf2e86393
--- /dev/null
+++ b/hypertrace/softmmu.c
@@ -0,0 +1,237 @@
+/*
+ * QEMU-side management of hypertrace in softmmu emulation.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * Implementation details
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ * There are 3 channels, each a BAR of a virtual device that can be used=
 through
+ * MMIO.
+ *
+ *
+ * - Configuration channel: Exposes configuration parameters.
+ *
+ * - Data channel: Lets guests write argument values. Each guest client =
should
+ *   use a different offset to avoid concurrency problems.
+ *
+ * - Control channel: Triggers the hypertrace event on a write, providin=
g the
+ *   first argument. Offset in the control channel sets the offset in th=
e data
+ *   channel.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hypertrace/common.h"
+#include "hypertrace/trace.h"
+#include "hw/pci/pci.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+
+typedef struct HypertraceState {
+    PCIDevice dev;
+
+    uint64_t max_clients;
+    struct hypertrace_config hconfig;
+
+    MemoryRegion config;
+    void *config_ptr;
+    MemoryRegion data;
+    void *data_ptr;
+    MemoryRegion control;
+    void *control_ptr;
+
+    Error *migration_blocker;
+} HypertraceState;
+
+
+static uint64_t hypertrace_control_io_read(void *opaque, hwaddr addr,
+                                           unsigned size)
+{
+    uint64_t res;
+    HypertraceState *s =3D opaque;
+    char *mem =3D &((char *)s->control_ptr)[addr];
+
+    switch (size) {
+    case 1:
+    {
+        res =3D ((uint8_t *)mem)[0];
+        break;
+    }
+    case 2:
+    {
+        res =3D ((uint16_t *)mem)[0];
+        break;
+    }
+    case 4:
+    {
+        res =3D ((uint32_t *)mem)[0];
+        break;
+    }
+    case 8:
+    {
+        res =3D ((uint64_t *)mem)[0];
+        break;
+    }
+    default:
+        error_report("error: hypertrace: Unexpected read of size %d", si=
ze);
+	abort();
+    }
+
+    return res;
+}
+
+static void hypertrace_control_io_write(void *opaque, hwaddr addr,
+                                        uint64_t data, unsigned size)
+{
+    HypertraceState *s =3D opaque;
+    char *mem =3D &((char *)s->control_ptr)[addr];
+
+    switch (size) {
+    case 1:
+    {
+        uint8_t *res =3D (uint8_t *)mem;
+        *res =3D (uint8_t)data;
+        break;
+    }
+    case 2:
+    {
+        uint16_t *res =3D (uint16_t *)mem;
+        *res =3D (uint16_t)data;
+        break;
+    }
+    case 4:
+    {
+        uint32_t *res =3D (uint32_t *)mem;
+        *res =3D (uint32_t)data;
+        break;
+    }
+    case 8:
+    {
+        uint64_t *res =3D (uint64_t *)mem;
+        *res =3D (uint64_t)data;
+        break;
+    }
+    default:
+        error_report("error: hypertrace: Unexpected write of size %d", s=
ize);
+	abort();
+    }
+
+    if ((addr + size) % sizeof(uint64_t) =3D=3D 0) {
+        uint64_t client =3D addr / sizeof(uint64_t);
+        uint64_t vcontrol =3D ((uint64_t *)s->control_ptr)[client];
+        uint64_t *data_ptr =3D (uint64_t *)s->data_ptr;
+        data_ptr =3D &data_ptr[client * s->hconfig.client_data_size];
+        hypertrace_emit(current_cpu, vcontrol, data_ptr);
+    }
+}
+
+static const MemoryRegionOps hypertrace_control_ops =3D {
+    .read =3D &hypertrace_control_io_read,
+    .write =3D &hypertrace_control_io_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
+
+static void hypertrace_realize(PCIDevice *dev, Error **errp)
+{
+    Error *local_err =3D NULL;
+    struct hypertrace_config *config;
+    HypertraceState *s =3D DO_UPCAST(HypertraceState, dev, dev);
+    Error *err =3D NULL;
+
+    if (s->max_clients < 1) {
+        error_setg(errp, "hypertrace: must have at least one client");
+        return;
+    }
+
+    hypertrace_init_config(&s->hconfig, s->max_clients);
+
+    error_setg(&s->migration_blocker,
+               "The 'hypertrace' device cannot be migrated");
+    migrate_add_blocker(s->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_free(s->migration_blocker);
+        return;
+    }
+
+    pci_set_word(s->dev.config + PCI_COMMAND,
+                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+
+    /* config channel */
+    memory_region_init_ram(&s->config, OBJECT(s), "hypertrace.config",
+                           TARGET_PAGE_SIZE, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    pci_register_bar(&s->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->conf=
ig);
+    s->config_ptr =3D qemu_map_ram_ptr(s->config.ram_block, 0);
+    config =3D s->config_ptr;
+    config->max_clients =3D tswap64(s->hconfig.max_clients);
+    config->client_args =3D tswap64(s->hconfig.client_args);
+    config->client_data_size =3D tswap64(s->hconfig.client_data_size);
+    config->control_size =3D tswap64(s->hconfig.control_size);
+    config->data_size =3D tswap64(s->hconfig.data_size);
+
+    /* data channel */
+    memory_region_init_ram(&s->data, OBJECT(s), "hypertrace.data",
+                           s->hconfig.data_size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    pci_register_bar(&s->dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->data=
);
+    s->data_ptr =3D qemu_map_ram_ptr(s->data.ram_block, 0);
+
+    /* control channel */
+    memory_region_init_io(&s->control, OBJECT(s), &hypertrace_control_op=
s, s,
+                          "hypertrace.control", s->hconfig.control_size)=
;
+    pci_register_bar(&s->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->cont=
rol);
+    s->control_ptr =3D qemu_map_ram_ptr(s->control.ram_block, 0);
+}
+
+
+static Property hypertrace_properties[] =3D {
+    DEFINE_PROP_UINT64("max-clients", HypertraceState, max_clients, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void hypertrace_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D hypertrace_realize;
+    k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k->device_id =3D PCI_DEVICE_ID_HYPERTRACE;
+    k->class_id =3D PCI_CLASS_MEMORY_RAM;
+    dc->desc  =3D "Hypertrace communication channel",
+    dc->props =3D hypertrace_properties;
+}
+
+static TypeInfo hypertrace_info =3D {
+    .name          =3D "hypertrace",
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(HypertraceState),
+    .class_init    =3D hypertrace_class_init,
+};
+
+static void hypertrace_register_types(void)
+{
+    type_register_static(&hypertrace_info);
+}
+
+type_init(hypertrace_register_types)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e598b095eb..3910a9b89f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -84,6 +84,8 @@
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
=20
+#define PCI_DEVICE_ID_HYPERTRACE         0x10f0
+
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
 #define PCI_DEVICE_ID_REDHAT_SERIAL      0x0002
