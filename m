Received: from eggs.gnu.org ([2001:4830:134:3::10]:38950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds7ew-0004hC-5e
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds7ep-0002QP-5H
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:24:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ds7eo-0002Ou-SZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:24:47 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 13 Sep 2017 15:23:58 +0200
Message-Id: <20170913132417.24384-4-david@redhat.com>
In-Reply-To: <20170913132417.24384-1-david@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/22] s390x: get rid of s390-virtio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

It is a leftover from the days where we had still the !ccw virtio
machine. As this one is long gone, let's move everything to
s390-virtio-ccw.c.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/Makefile.objs     |   1 -
 hw/s390x/s390-virtio-ccw.c | 157 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/s390-virtio.c     |  37 -----------
 hw/s390x/s390-virtio.h     |  15 -----
 4 files changed, 156 insertions(+), 54 deletions(-)

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 7ee19d3abc..dc704b57d6 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -1,4 +1,3 @@
-obj-y += s390-virtio.o
 obj-y += s390-virtio-hcall.o
 obj-y += sclp.o
 obj-y += event-facility.o
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index dd504dd5ae..4c3a3e177b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -2,6 +2,7 @@
  * virtio ccw machine
  *
  * Copyright 2012 IBM Corp.
+ * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
@@ -31,6 +32,46 @@
 #include "hw/s390x/css-bridge.h"
 #include "migration/register.h"
 #include "cpu_models.h"
+#include "qapi/qmp/qerror.h"
+#include "hw/nmi.h"
+
+static S390CPU **cpu_states;
+
+S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
+{
+    if (cpu_addr >= max_cpus) {
+        return NULL;
+    }
+
+    /* Fast lookup via CPU ID */
+    return cpu_states[cpu_addr];
+}
+
+static void s390_init_cpus(MachineState *machine)
+{
+    int i;
+    gchar *name;
+
+    if (machine->cpu_model == NULL) {
+        machine->cpu_model = s390_default_cpu_model_name();
+    }
+
+    cpu_states = g_new0(S390CPU *, max_cpus);
+
+    for (i = 0; i < max_cpus; i++) {
+        name = g_strdup_printf("cpu[%i]", i);
+        object_property_add_link(OBJECT(machine), name, TYPE_S390_CPU,
+                                 (Object **) &cpu_states[i],
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                                 &error_abort);
+        g_free(name);
+    }
+
+    for (i = 0; i < smp_cpus; i++) {
+        s390x_new_cpu(machine->cpu_model, i, &error_fatal);
+    }
+}
 
 static const char *const reset_dev_types[] = {
     TYPE_VIRTUAL_CSS_BRIDGE,
@@ -94,7 +135,7 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
 
-void s390_memory_init(ram_addr_t mem_size)
+static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
@@ -109,11 +150,103 @@ void s390_memory_init(ram_addr_t mem_size)
     s390_stattrib_init();
 }
 
+#define S390_TOD_CLOCK_VALUE_MISSING    0x00
+#define S390_TOD_CLOCK_VALUE_PRESENT    0x01
+
+static void gtod_save(QEMUFile *f, void *opaque)
+{
+    uint64_t tod_low;
+    uint8_t tod_high;
+    int r;
+
+    r = s390_get_clock(&tod_high, &tod_low);
+    if (r) {
+        fprintf(stderr, "WARNING: Unable to get guest clock for migration. "
+                        "Error code %d. Guest clock will not be migrated "
+                        "which could cause the guest to hang.\n", r);
+        qemu_put_byte(f, S390_TOD_CLOCK_VALUE_MISSING);
+        return;
+    }
+
+    qemu_put_byte(f, S390_TOD_CLOCK_VALUE_PRESENT);
+    qemu_put_byte(f, tod_high);
+    qemu_put_be64(f, tod_low);
+}
+
+static int gtod_load(QEMUFile *f, void *opaque, int version_id)
+{
+    uint64_t tod_low;
+    uint8_t tod_high;
+    int r;
+
+    if (qemu_get_byte(f) == S390_TOD_CLOCK_VALUE_MISSING) {
+        fprintf(stderr, "WARNING: Guest clock was not migrated. This could "
+                        "cause the guest to hang.\n");
+        return 0;
+    }
+
+    tod_high = qemu_get_byte(f);
+    tod_low = qemu_get_be64(f);
+
+    r = s390_set_clock(&tod_high, &tod_low);
+    if (r) {
+        fprintf(stderr, "WARNING: Unable to set guest clock value. "
+                        "s390_get_clock returned error %d. This could cause "
+                        "the guest to hang.\n", r);
+    }
+
+    return 0;
+}
+
 static SaveVMHandlers savevm_gtod = {
     .save_state = gtod_save,
     .load_state = gtod_load,
 };
 
+static void s390_init_ipl_dev(const char *kernel_filename,
+                              const char *kernel_cmdline,
+                              const char *initrd_filename, const char *firmware,
+                              const char *netboot_fw, bool enforce_bios)
+{
+    Object *new = object_new(TYPE_S390_IPL);
+    DeviceState *dev = DEVICE(new);
+
+    if (kernel_filename) {
+        qdev_prop_set_string(dev, "kernel", kernel_filename);
+    }
+    if (initrd_filename) {
+        qdev_prop_set_string(dev, "initrd", initrd_filename);
+    }
+    qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
+    qdev_prop_set_string(dev, "firmware", firmware);
+    qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
+    qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
+    object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
+                              new, NULL);
+    object_unref(new);
+    qdev_init_nofail(dev);
+}
+
+static void s390_create_virtio_net(BusState *bus, const char *name)
+{
+    int i;
+
+    for (i = 0; i < nb_nics; i++) {
+        NICInfo *nd = &nd_table[i];
+        DeviceState *dev;
+
+        if (!nd->model) {
+            nd->model = g_strdup("virtio");
+        }
+
+        qemu_check_nic_model(nd, "virtio");
+
+        dev = qdev_create(bus, name);
+        qdev_set_nic_properties(dev, nd);
+        qdev_init_nofail(dev);
+    }
+}
+
 static void ccw_init(MachineState *machine)
 {
     int ret;
@@ -177,6 +310,19 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
     g_free(name);
 }
 
+static void s390_machine_reset(void)
+{
+    S390CPU *ipl_cpu = S390_CPU(qemu_get_cpu(0));
+
+    s390_cmma_reset();
+    qemu_devices_reset();
+    s390_crypto_reset();
+
+    /* all cpus are stopped - configure and start the ipl cpu only */
+    s390_ipl_prepare_cpu(ipl_cpu);
+    s390_cpu_set_state(CPU_STATE_OPERATING, ipl_cpu);
+}
+
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
@@ -201,6 +347,15 @@ static void s390_hot_add_cpu(const int64_t id, Error **errp)
     s390x_new_cpu(machine->cpu_model, id, errp);
 }
 
+static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    CPUState *cs = qemu_get_cpu(cpu_index);
+
+    if (s390_cpu_restart(S390_CPU(cs))) {
+        error_setg(errp, QERR_UNSUPPORTED);
+    }
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index da3f49e80e..9316be1cfc 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -48,17 +48,6 @@
 #define S390_TOD_CLOCK_VALUE_MISSING    0x00
 #define S390_TOD_CLOCK_VALUE_PRESENT    0x01
 
-static S390CPU **cpu_states;
-
-S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
-{
-    if (cpu_addr >= max_cpus) {
-        return NULL;
-    }
-
-    /* Fast lookup via CPU ID */
-    return cpu_states[cpu_addr];
-}
 
 void s390_init_ipl_dev(const char *kernel_filename,
                        const char *kernel_cmdline,
@@ -86,32 +75,6 @@ void s390_init_ipl_dev(const char *kernel_filename,
     qdev_init_nofail(dev);
 }
 
-void s390_init_cpus(MachineState *machine)
-{
-    int i;
-    gchar *name;
-
-    if (machine->cpu_model == NULL) {
-        machine->cpu_model = s390_default_cpu_model_name();
-    }
-
-    cpu_states = g_new0(S390CPU *, max_cpus);
-
-    for (i = 0; i < max_cpus; i++) {
-        name = g_strdup_printf("cpu[%i]", i);
-        object_property_add_link(OBJECT(machine), name, TYPE_S390_CPU,
-                                 (Object **) &cpu_states[i],
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                                 &error_abort);
-        g_free(name);
-    }
-
-    for (i = 0; i < smp_cpus; i++) {
-        s390x_new_cpu(machine->cpu_model, i, &error_fatal);
-    }
-}
-
 
 void s390_create_virtio_net(BusState *bus, const char *name)
 {
diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio.h
index ca97fd6814..d984cd4115 100644
--- a/hw/s390x/s390-virtio.h
+++ b/hw/s390x/s390-virtio.h
@@ -12,24 +12,9 @@
 #ifndef HW_S390_VIRTIO_H
 #define HW_S390_VIRTIO_H
 
-#include "hw/nmi.h"
 #include "standard-headers/asm-s390/kvm_virtio.h"
 #include "standard-headers/asm-s390/virtio-ccw.h"
 
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
-
-void s390_init_cpus(MachineState *machine);
-void s390_init_ipl_dev(const char *kernel_filename,
-                       const char *kernel_cmdline,
-                       const char *initrd_filename,
-                       const char *firmware,
-                       const char *netboot_fw,
-                       bool enforce_bios);
-void s390_create_virtio_net(BusState *bus, const char *name);
-void s390_nmi(NMIState *n, int cpu_index, Error **errp);
-void s390_machine_reset(void);
-void s390_memory_init(ram_addr_t mem_size);
-void gtod_save(QEMUFile *f, void *opaque);
-int gtod_load(QEMUFile *f, void *opaque, int version_id);
 #endif
-- 
2.13.5
