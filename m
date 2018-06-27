Received: from eggs.gnu.org ([2001:4830:134:3::10]:34000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAkD-0006Ml-Dj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYAk6-0005Cm-40
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:44:25 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Jun 2018 15:44:04 +0200
Message-Id: <20180627134410.4901-4-david@redhat.com>
In-Reply-To: <20180627134410.4901-1-david@redhat.com>
References: <20180627134410.4901-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/9] s390x/tod: factor out TOD into separate
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Let's treat this like a separate device. TCG will have to store the
actual state/time later on.

Include cpu-qom.h in kvm_s390x.h (due to S390CPU) to compile tod-kvm.c.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/Makefile.objs     |   3 +
 hw/s390x/s390-virtio-ccw.c |  57 +-----------------
 hw/s390x/tod-kvm.c         |  64 ++++++++++++++++++++
 hw/s390x/tod-qemu.c        |  49 +++++++++++++++
 hw/s390x/tod.c             | 119 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/tod.h     |  46 ++++++++++++++
 target/s390x/cpu.c         |  32 ----------
 target/s390x/cpu.h         |   2 -
 target/s390x/kvm_s390x.h   |   2 +
 9 files changed, 286 insertions(+), 88 deletions(-)
 create mode 100644 hw/s390x/tod-kvm.c
 create mode 100644 hw/s390x/tod-qemu.c
 create mode 100644 hw/s390x/tod.c
 create mode 100644 include/hw/s390x/tod.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index dc704b57d6..93282f7c59 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -14,6 +14,9 @@ obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
 obj-$(call lnot,$(CONFIG_PCI)) += s390-pci-stub.o
 obj-y += s390-skeys.o
 obj-y += s390-stattrib.o
+obj-y += tod.o
+obj-$(CONFIG_KVM) += tod-kvm.o
+obj-$(CONFIG_TCG) += tod-qemu.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7ae5fb38dd..dea8dfa47b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -35,6 +35,7 @@
 #include "migration/register.h"
 #include "cpu_models.h"
 #include "hw/nmi.h"
+#include "hw/s390x/tod.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -187,58 +188,6 @@ static void s390_memory_init(ram_addr_t mem_size)
     s390_stattrib_init();
 }
 
-#define S390_TOD_CLOCK_VALUE_MISSING    0x00
-#define S390_TOD_CLOCK_VALUE_PRESENT    0x01
-
-static void gtod_save(QEMUFile *f, void *opaque)
-{
-    uint64_t tod_low;
-    uint8_t tod_high;
-    int r;
-
-    r = s390_get_clock(&tod_high, &tod_low);
-    if (r) {
-        warn_report("Unable to get guest clock for migration: %s",
-                    strerror(-r));
-        error_printf("Guest clock will not be migrated "
-                     "which could cause the guest to hang.");
-        qemu_put_byte(f, S390_TOD_CLOCK_VALUE_MISSING);
-        return;
-    }
-
-    qemu_put_byte(f, S390_TOD_CLOCK_VALUE_PRESENT);
-    qemu_put_byte(f, tod_high);
-    qemu_put_be64(f, tod_low);
-}
-
-static int gtod_load(QEMUFile *f, void *opaque, int version_id)
-{
-    uint64_t tod_low;
-    uint8_t tod_high;
-    int r;
-
-    if (qemu_get_byte(f) == S390_TOD_CLOCK_VALUE_MISSING) {
-        warn_report("Guest clock was not migrated. This could "
-                    "cause the guest to hang.");
-        return 0;
-    }
-
-    tod_high = qemu_get_byte(f);
-    tod_low = qemu_get_be64(f);
-
-    r = s390_set_clock(&tod_high, &tod_low);
-    if (r) {
-        error_report("Unable to set KVM guest TOD clock: %s", strerror(-r));
-    }
-
-    return r;
-}
-
-static SaveVMHandlers savevm_gtod = {
-    .save_state = gtod_save,
-    .load_state = gtod_load,
-};
-
 static void s390_init_ipl_dev(const char *kernel_filename,
                               const char *kernel_cmdline,
                               const char *initrd_filename, const char *firmware,
@@ -363,8 +312,8 @@ static void ccw_init(MachineState *machine)
         s390_create_sclpconsole("sclplmconsole", serial_hd(1));
     }
 
-    /* Register savevm handler for guest TOD clock */
-    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, NULL);
+    /* init the TOD clock */
+    s390_init_tod();
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
new file mode 100644
index 0000000000..df564ab89c
--- /dev/null
+++ b/hw/s390x/tod-kvm.c
@@ -0,0 +1,64 @@
+/*
+ * TOD (Time Of Day) clock - KVM implementation
+ *
+ * Copyright 2018 Red Hat, Inc.
+ * Author(s): David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/s390x/tod.h"
+#include "kvm_s390x.h"
+
+static void kvm_s390_tod_get(const S390TODState *td, S390TOD *tod, Error **errp)
+{
+    int r;
+
+    r = kvm_s390_get_clock_ext(&tod->high, &tod->low);
+    if (r == -ENXIO) {
+        r = kvm_s390_get_clock(&tod->high, &tod->low);
+    }
+    if (r) {
+        error_setg(errp, "Unable to get KVM guest TOD clock: %s",
+                   strerror(-r));
+    }
+}
+
+static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
+{
+    int r;
+
+    r = kvm_s390_set_clock_ext(tod->high, tod->low);
+    if (r == -ENXIO) {
+        r = kvm_s390_set_clock(tod->high, tod->low);
+    }
+    if (r) {
+        error_setg(errp, "Unable to set KVM guest TOD clock: %s",
+                   strerror(-r));
+    }
+}
+
+static void kvm_s390_tod_class_init(ObjectClass *oc, void *data)
+{
+    S390TODClass *tdc = S390_TOD_CLASS(oc);
+
+    tdc->get = kvm_s390_tod_get;
+    tdc->set = kvm_s390_tod_set;
+}
+
+static TypeInfo kvm_s390_tod_info = {
+    .name = TYPE_KVM_S390_TOD,
+    .parent = TYPE_S390_TOD,
+    .instance_size = sizeof(S390TODState),
+    .class_init = kvm_s390_tod_class_init,
+    .class_size = sizeof(S390TODClass),
+};
+
+static void register_types(void)
+{
+    type_register_static(&kvm_s390_tod_info);
+}
+type_init(register_types);
diff --git a/hw/s390x/tod-qemu.c b/hw/s390x/tod-qemu.c
new file mode 100644
index 0000000000..03ea1ce4e8
--- /dev/null
+++ b/hw/s390x/tod-qemu.c
@@ -0,0 +1,49 @@
+/*
+ * TOD (Time Of Day) clock - QEMU implementation
+ *
+ * Copyright 2018 Red Hat, Inc.
+ * Author(s): David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/s390x/tod.h"
+
+static void qemu_s390_tod_get(const S390TODState *td, S390TOD *tod,
+                              Error **errp)
+{
+    /* FIXME */
+    tod->high = 0;
+    tod->low = 0;
+}
+
+static void qemu_s390_tod_set(S390TODState *td, const S390TOD *tod,
+                              Error **errp)
+{
+    /* FIXME */
+}
+
+static void qemu_s390_tod_class_init(ObjectClass *oc, void *data)
+{
+    S390TODClass *tdc = S390_TOD_CLASS(oc);
+
+    tdc->get = qemu_s390_tod_get;
+    tdc->set = qemu_s390_tod_set;
+}
+
+static TypeInfo qemu_s390_tod_info = {
+    .name = TYPE_QEMU_S390_TOD,
+    .parent = TYPE_S390_TOD,
+    .instance_size = sizeof(S390TODState),
+    .class_init = qemu_s390_tod_class_init,
+    .class_size = sizeof(S390TODClass),
+};
+
+static void register_types(void)
+{
+    type_register_static(&qemu_s390_tod_info);
+}
+type_init(register_types);
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
new file mode 100644
index 0000000000..0501affa7f
--- /dev/null
+++ b/hw/s390x/tod.c
@@ -0,0 +1,119 @@
+/*
+ * TOD (Time Of Day) clock
+ *
+ * Copyright 2018 Red Hat, Inc.
+ * Author(s): David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/tod.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "migration/register.h"
+
+void s390_init_tod(void)
+{
+    Object *obj;
+
+    if (kvm_enabled()) {
+        obj = object_new(TYPE_KVM_S390_TOD);
+    } else {
+        obj = object_new(TYPE_QEMU_S390_TOD);
+    }
+    object_property_add_child(qdev_get_machine(), TYPE_S390_TOD, obj, NULL);
+    object_unref(obj);
+
+    qdev_init_nofail(DEVICE(obj));
+}
+
+#define S390_TOD_CLOCK_VALUE_MISSING    0x00
+#define S390_TOD_CLOCK_VALUE_PRESENT    0x01
+
+static void s390_tod_save(QEMUFile *f, void *opaque)
+{
+    S390TODState *td = opaque;
+    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
+    Error *err = NULL;
+    S390TOD tod;
+
+    tdc->get(td, &tod, &err);
+    if (err) {
+        warn_report_err(err);
+        error_printf("Guest clock will not be migrated "
+                     "which could cause the guest to hang.");
+        qemu_put_byte(f, S390_TOD_CLOCK_VALUE_MISSING);
+        return;
+    }
+
+    qemu_put_byte(f, S390_TOD_CLOCK_VALUE_PRESENT);
+    qemu_put_byte(f, tod.high);
+    qemu_put_be64(f, tod.low);
+}
+
+static int s390_tod_load(QEMUFile *f, void *opaque, int version_id)
+{
+    S390TODState *td = opaque;
+    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
+    Error *err = NULL;
+    S390TOD tod;
+
+    if (qemu_get_byte(f) == S390_TOD_CLOCK_VALUE_MISSING) {
+        warn_report("Guest clock was not migrated. This could "
+                    "cause the guest to hang.");
+        return 0;
+    }
+
+    tod.high = qemu_get_byte(f);
+    tod.low = qemu_get_be64(f);
+
+    tdc->set(td, &tod, &err);
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
+    return 0;
+}
+
+static SaveVMHandlers savevm_tod = {
+    .save_state = s390_tod_save,
+    .load_state = s390_tod_load,
+};
+
+static void s390_tod_realize(DeviceState *dev, Error **errp)
+{
+    S390TODState *td = S390_TOD(dev);
+
+    /* Legacy migration interface */
+    register_savevm_live(NULL, "todclock", 0, 1, &savevm_tod, td);
+}
+
+static void s390_tod_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->desc = "TOD (Time Of Day) Clock";
+    dc->realize = s390_tod_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    /* We only have one TOD clock in the system attached to the machine */
+    dc->user_creatable = false;
+}
+
+static TypeInfo s390_tod_info = {
+    .name = TYPE_S390_TOD,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(S390TODState),
+    .class_init = s390_tod_class_init,
+    .class_size = sizeof(S390TODClass),
+    .abstract = true,
+};
+
+static void register_types(void)
+{
+    type_register_static(&s390_tod_info);
+}
+type_init(register_types);
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
new file mode 100644
index 0000000000..7096b574ae
--- /dev/null
+++ b/include/hw/s390x/tod.h
@@ -0,0 +1,46 @@
+/*
+ * TOD (Time Of Day) clock
+ *
+ * Copyright 2018 Red Hat, Inc.
+ * Author(s): David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_S390_TOD_H
+#define HW_S390_TOD_H
+
+#include "hw/qdev.h"
+
+typedef struct S390TOD {
+    uint8_t high;
+    uint64_t low;
+} S390TOD;
+
+#define TYPE_S390_TOD "s390-tod"
+#define S390_TOD(obj) OBJECT_CHECK(S390TODState, (obj), TYPE_S390_TOD)
+#define S390_TOD_CLASS(oc) OBJECT_CLASS_CHECK(S390TODClass, (oc), \
+                                              TYPE_S390_TOD)
+#define S390_TOD_GET_CLASS(obj) OBJECT_GET_CLASS(S390TODClass, (obj), \
+                                                 TYPE_S390_TOD)
+#define TYPE_KVM_S390_TOD TYPE_S390_TOD "-kvm"
+#define TYPE_QEMU_S390_TOD TYPE_S390_TOD "-qemu"
+
+typedef struct S390TODState {
+    /* private */
+    DeviceState parent_obj;
+} S390TODState;
+
+typedef struct S390TODClass {
+    /* private */
+    DeviceClass parent_class;
+
+    /* public */
+    void (*get)(const S390TODState *td, S390TOD *tod, Error **errp);
+    void (*set)(S390TODState *td, const S390TOD *tod, Error **errp);
+} S390TODClass;
+
+void s390_init_tod(void);
+
+#endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 68512e3e54..03ea6eafa7 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -390,38 +390,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
-int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    int r = 0;
-
-    if (kvm_enabled()) {
-        r = kvm_s390_get_clock_ext(tod_high, tod_low);
-        if (r == -ENXIO) {
-            return kvm_s390_get_clock(tod_high, tod_low);
-        }
-    } else {
-        /* Fixme TCG */
-        *tod_high = 0;
-        *tod_low = 0;
-    }
-
-    return r;
-}
-
-int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    int r = 0;
-
-    if (kvm_enabled()) {
-        r = kvm_s390_set_clock_ext(*tod_high, *tod_low);
-        if (r == -ENXIO) {
-            return kvm_s390_set_clock(*tod_high, *tod_low);
-        }
-    }
-    /* Fixme TCG */
-    return r;
-}
-
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6629a533f3..ac51c17fb4 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -714,8 +714,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 
 
 /* cpu.c */
-int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
-int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
 void s390_crypto_reset(void);
 bool s390_get_squash_mcss(void);
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 36eb34bf99..6e52287da3 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -10,6 +10,8 @@
 #ifndef KVM_S390X_H
 #define KVM_S390X_H
 
+#include "cpu-qom.h"
+
 struct kvm_s390_irq;
 
 void kvm_s390_floating_interrupt_legacy(struct kvm_s390_irq *irq);
-- 
2.17.1
