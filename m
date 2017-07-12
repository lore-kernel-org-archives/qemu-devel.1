Received: from eggs.gnu.org ([2001:4830:134:3::10]:44856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDL-0006WO-Lk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDH-00010u-H3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDH-0000zt-4B
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCs4Ex139484
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj51vyh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:53 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:51 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:37 +0200
In-Reply-To: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499864265-144136-4-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 03/11] s390x/migration: Storage attributes
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Storage attributes device, like we have for storage keys.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/Makefile.objs                |   2 +
 hw/s390x/s390-stattrib-kvm.c          | 178 +++++++++++++++++
 hw/s390x/s390-stattrib.c              | 348 ++++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c            |  10 +-
 include/hw/s390x/storage-attributes.h |  68 +++++++
 5 files changed, 605 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/s390-stattrib-kvm.c
 create mode 100644 hw/s390x/s390-stattrib.c
 create mode 100644 include/hw/s390x/storage-attributes.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index a8e5575..b2aade2 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -13,5 +13,7 @@ obj-y += css-bridge.o
 obj-y += ccw-device.o
 obj-y += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
+obj-y += s390-stattrib.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
+obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
new file mode 100644
index 0000000..2e7f144
--- /dev/null
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -0,0 +1,178 @@
+/*
+ * s390 storage attributes device -- KVM object
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "qmp-commands.h"
+#include "migration/qemu-file.h"
+#include "hw/s390x/storage-attributes.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "exec/ram_addr.h"
+#include "cpu.h"
+
+static void kvm_s390_stattrib_instance_init(Object *obj)
+{
+    KVMS390StAttribState *sas = KVM_S390_STATTRIB(obj);
+
+    sas->still_dirty = 0;
+}
+
+static int kvm_s390_stattrib_read_helper(S390StAttribState *sa,
+                                        uint64_t *start_gfn,
+                                        uint32_t count,
+                                        uint8_t *values,
+                                        uint32_t flags)
+{
+    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
+    int r;
+    struct kvm_s390_cmma_log clog = {
+        .values = (uint64_t)values,
+        .start_gfn = *start_gfn,
+        .count = count,
+        .flags = flags,
+    };
+
+    r = kvm_vm_ioctl(kvm_state, KVM_S390_GET_CMMA_BITS, &clog);
+    if (r < 0) {
+        error_report("Error: %s", strerror(-r));
+        return r;
+    }
+
+    *start_gfn = clog.start_gfn;
+    sas->still_dirty = clog.remaining;
+    return clog.count;
+}
+
+static int kvm_s390_stattrib_get_stattr(S390StAttribState *sa,
+                                        uint64_t *start_gfn,
+                                        uint32_t count,
+                                        uint8_t *values)
+{
+    return kvm_s390_stattrib_read_helper(sa, start_gfn, count, values, 0);
+}
+
+static int kvm_s390_stattrib_peek_stattr(S390StAttribState *sa,
+                                         uint64_t start_gfn,
+                                         uint32_t count,
+                                         uint8_t *values)
+{
+    return kvm_s390_stattrib_read_helper(sa, &start_gfn, count, values,
+                                         KVM_S390_CMMA_PEEK);
+}
+
+static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
+                                        uint64_t start_gfn,
+                                        uint32_t count,
+                                        uint8_t *values)
+{
+    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    unsigned long max = machine->maxram_size / TARGET_PAGE_SIZE;
+
+    if (start_gfn + count > max) {
+        error_report("Error: invalid address.");
+        return -1;
+    }
+    if (!sas->incoming_buffer) {
+        sas->incoming_buffer = g_malloc0(max);
+    }
+
+    memcpy(sas->incoming_buffer + start_gfn, values, count);
+
+    return 0;
+}
+
+static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
+{
+    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    unsigned long max = machine->maxram_size / TARGET_PAGE_SIZE;
+    unsigned long cx, len = 1 << 19;
+    int r;
+    struct kvm_s390_cmma_log clog = {
+        .flags = 0,
+        .mask = ~0ULL,
+    };
+
+    if (sas->incoming_buffer) {
+        for (cx = 0; cx + len <= max; cx += len) {
+            clog.start_gfn = cx;
+            clog.count = len;
+            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
+            r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
+            if (r) {
+                return;
+            }
+        }
+        if (cx < max) {
+            clog.start_gfn = cx;
+            clog.count = max - cx;
+            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
+            r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
+        }
+        g_free(sas->incoming_buffer);
+        sas->incoming_buffer = NULL;
+    }
+}
+
+static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MIGRATION,
+        .attr = val,
+        .addr = 0,
+    };
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
+static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
+{
+    KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
+    uint8_t val[8];
+
+    kvm_s390_stattrib_peek_stattr(sa, 0, 1, val);
+    return sas->still_dirty;
+}
+
+static int kvm_s390_stattrib_get_active(S390StAttribState *sa)
+{
+    return kvm_s390_cmma_active() && sa->migration_enabled;
+}
+
+static void kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
+{
+    S390StAttribClass *sac = S390_STATTRIB_CLASS(oc);
+
+    sac->get_stattr = kvm_s390_stattrib_get_stattr;
+    sac->peek_stattr = kvm_s390_stattrib_peek_stattr;
+    sac->set_stattr = kvm_s390_stattrib_set_stattr;
+    sac->set_migrationmode = kvm_s390_stattrib_set_migrationmode;
+    sac->get_dirtycount = kvm_s390_stattrib_get_dirtycount;
+    sac->synchronize = kvm_s390_stattrib_synchronize;
+    sac->get_active = kvm_s390_stattrib_get_active;
+}
+
+static const TypeInfo kvm_s390_stattrib_info = {
+    .name          = TYPE_KVM_S390_STATTRIB,
+    .parent        = TYPE_S390_STATTRIB,
+    .instance_init = kvm_s390_stattrib_instance_init,
+    .instance_size = sizeof(KVMS390StAttribState),
+    .class_init    = kvm_s390_stattrib_class_init,
+    .class_size    = sizeof(S390StAttribClass),
+};
+
+static void kvm_s390_stattrib_register_types(void)
+{
+    type_register_static(&kvm_s390_stattrib_info);
+}
+
+type_init(kvm_s390_stattrib_register_types)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
new file mode 100644
index 0000000..eb41fe9
--- /dev/null
+++ b/hw/s390x/s390-stattrib.c
@@ -0,0 +1,348 @@
+/*
+ * s390 storage attributes device
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "migration/qemu-file.h"
+#include "migration/register.h"
+#include "hw/s390x/storage-attributes.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "exec/ram_addr.h"
+#include "qapi/error.h"
+
+#define CMMA_BLOCK_SIZE  (1 << 10)
+
+#define STATTR_FLAG_EOS     0x01ULL
+#define STATTR_FLAG_MORE    0x02ULL
+#define STATTR_FLAG_ERROR   0x04ULL
+#define STATTR_FLAG_DONE    0x08ULL
+
+void s390_stattrib_init(void)
+{
+    Object *obj;
+
+#ifdef CONFIG_KVM
+    if (kvm_enabled() &&
+            kvm_check_extension(kvm_state, KVM_CAP_S390_CMMA_MIGRATION)) {
+        obj = object_new(TYPE_KVM_S390_STATTRIB);
+    } else {
+        obj = object_new(TYPE_QEMU_S390_STATTRIB);
+    }
+#else
+    obj = object_new(TYPE_QEMU_S390_STATTRIB);
+#endif
+
+    object_property_add_child(qdev_get_machine(), TYPE_S390_STATTRIB,
+                              obj, NULL);
+    object_unref(obj);
+
+    qdev_init_nofail(DEVICE(obj));
+}
+
+/* Migration support: */
+
+static int cmma_load(QEMUFile *f, void *opaque, int version_id)
+{
+    S390StAttribState *sas = S390_STATTRIB(opaque);
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    uint64_t count, cur_gfn;
+    int flags, ret = 0;
+    ram_addr_t addr;
+    uint8_t *buf;
+
+    while (!ret) {
+        addr = qemu_get_be64(f);
+        flags = addr & ~TARGET_PAGE_MASK;
+        addr &= TARGET_PAGE_MASK;
+
+        switch (flags) {
+        case STATTR_FLAG_MORE: {
+            cur_gfn = addr / TARGET_PAGE_SIZE;
+            count = qemu_get_be64(f);
+            buf = g_try_malloc(count);
+            if (!buf) {
+                error_report("cmma_load could not allocate memory");
+                ret = -ENOMEM;
+                break;
+            }
+
+            qemu_get_buffer(f, buf, count);
+            ret = sac->set_stattr(sas, cur_gfn, count, buf);
+            if (ret < 0) {
+                error_report("Error %d while setting storage attributes", ret);
+            }
+            g_free(buf);
+            break;
+        }
+        case STATTR_FLAG_ERROR: {
+            error_report("Storage attributes data is incomplete");
+            ret = -EINVAL;
+            break;
+        }
+        case STATTR_FLAG_DONE:
+            /* This is after the last pre-copied value has been sent, nothing
+             * more will be sent after this. Pre-copy has finished, and we
+             * are done flushing all the remaining values. Now the target
+             * system is about to take over. We synchronize the buffer to
+             * apply the actual correct values where needed.
+             */
+             sac->synchronize(sas);
+            break;
+        case STATTR_FLAG_EOS:
+            /* Normal exit */
+            return 0;
+        default:
+            error_report("Unexpected storage attribute flag data: %#x", flags);
+            ret = -EINVAL;
+        }
+    }
+
+    return ret;
+}
+
+static int cmma_save_setup(QEMUFile *f, void *opaque)
+{
+    S390StAttribState *sas = S390_STATTRIB(opaque);
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    int res;
+    /*
+     * Signal that we want to start a migration, thus needing PGSTE dirty
+     * tracking.
+     */
+    res = sac->set_migrationmode(sas, 1);
+    if (res) {
+        return res;
+    }
+    qemu_put_be64(f, STATTR_FLAG_EOS);
+    return 0;
+}
+
+static void cmma_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
+                             uint64_t *non_postcopiable_pending,
+                             uint64_t *postcopiable_pending)
+{
+    S390StAttribState *sas = S390_STATTRIB(opaque);
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    long long res = sac->get_dirtycount(sas);
+
+    if (res >= 0) {
+        *non_postcopiable_pending += res;
+    }
+}
+
+static int cmma_save(QEMUFile *f, void *opaque, int final)
+{
+    S390StAttribState *sas = S390_STATTRIB(opaque);
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    uint8_t *buf;
+    int r, cx, reallen = 0, ret = 0;
+    uint32_t buflen = 1 << 19;   /* 512kB cover 2GB of guest memory */
+    uint64_t start_gfn = sas->migration_cur_gfn;
+
+    buf = g_try_malloc(buflen);
+    if (!buf) {
+        error_report("Could not allocate memory to save storage attributes");
+        return -ENOMEM;
+    }
+
+    while (final ? 1 : qemu_file_rate_limit(f) == 0) {
+        reallen = sac->get_stattr(sas, &start_gfn, buflen, buf);
+        if (reallen < 0) {
+            g_free(buf);
+            return reallen;
+        }
+
+        ret = 1;
+        if (0 == reallen) {
+            break;
+        }
+        qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG_MORE);
+        qemu_put_be64(f, reallen);
+        for (cx = 0; cx < reallen; cx++) {
+            qemu_put_byte(f, buf[cx]);
+        }
+        if (!sac->get_dirtycount(sas)) {
+            break;
+        }
+    }
+
+    sas->migration_cur_gfn = start_gfn + reallen;
+    g_free(buf);
+    if (final) {
+        qemu_put_be64(f, STATTR_FLAG_DONE);
+    }
+    qemu_put_be64(f, STATTR_FLAG_EOS);
+
+    r = qemu_file_get_error(f);
+    if (r < 0) {
+        return r;
+    }
+
+    return ret;
+}
+
+static int cmma_save_iterate(QEMUFile *f, void *opaque)
+{
+    return cmma_save(f, opaque, 0);
+}
+
+static int cmma_save_complete(QEMUFile *f, void *opaque)
+{
+    return cmma_save(f, opaque, 1);
+}
+
+static void cmma_save_cleanup(void *opaque)
+{
+    S390StAttribState *sas = S390_STATTRIB(opaque);
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    sac->set_migrationmode(sas, 0);
+}
+
+static bool cmma_active(void *opaque)
+{
+    S390StAttribState *sas = S390_STATTRIB(opaque);
+    S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    return sac->get_active(sas);
+}
+
+/* QEMU object: */
+
+static void qemu_s390_stattrib_instance_init(Object *obj)
+{
+}
+
+static int qemu_s390_peek_stattr_stub(S390StAttribState *sa, uint64_t start_gfn,
+                                     uint32_t count, uint8_t *values)
+{
+    return 0;
+}
+static void qemu_s390_synchronize_stub(S390StAttribState *sa)
+{
+}
+static int qemu_s390_get_stattr_stub(S390StAttribState *sa, uint64_t *start_gfn,
+                                     uint32_t count, uint8_t *values)
+{
+    return 0;
+}
+static long long qemu_s390_get_dirtycount_stub(S390StAttribState *sa)
+{
+    return 0;
+}
+static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value)
+{
+    return 0;
+}
+
+static int qemu_s390_get_active(S390StAttribState *sa)
+{
+    return sa->migration_enabled;
+}
+
+static void qemu_s390_stattrib_class_init(ObjectClass *oc, void *data)
+{
+    S390StAttribClass *sa_cl = S390_STATTRIB_CLASS(oc);
+
+    sa_cl->synchronize = qemu_s390_synchronize_stub;
+    sa_cl->get_stattr = qemu_s390_get_stattr_stub;
+    sa_cl->set_stattr = qemu_s390_peek_stattr_stub;
+    sa_cl->peek_stattr = qemu_s390_peek_stattr_stub;
+    sa_cl->set_migrationmode = qemu_s390_set_migrationmode_stub;
+    sa_cl->get_dirtycount = qemu_s390_get_dirtycount_stub;
+    sa_cl->get_active = qemu_s390_get_active;
+}
+
+static const TypeInfo qemu_s390_stattrib_info = {
+    .name          = TYPE_QEMU_S390_STATTRIB,
+    .parent        = TYPE_S390_STATTRIB,
+    .instance_init = qemu_s390_stattrib_instance_init,
+    .instance_size = sizeof(QEMUS390StAttribState),
+    .class_init    = qemu_s390_stattrib_class_init,
+    .class_size    = sizeof(S390StAttribClass),
+};
+
+/* Generic abstract object: */
+
+static void s390_stattrib_realize(DeviceState *dev, Error **errp)
+{
+    bool ambiguous = false;
+
+    object_resolve_path_type("", TYPE_S390_STATTRIB, &ambiguous);
+    if (ambiguous) {
+        error_setg(errp, "storage_attributes device already exists");
+    }
+}
+
+static void s390_stattrib_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->realize = s390_stattrib_realize;
+}
+
+static inline bool s390_stattrib_get_migration_enabled(Object *obj, Error **e)
+{
+    S390StAttribState *s = S390_STATTRIB(obj);
+
+    return s->migration_enabled;
+}
+
+static inline void s390_stattrib_set_migration_enabled(Object *obj, bool value,
+                                            Error **errp)
+{
+    S390StAttribState *s = S390_STATTRIB(obj);
+
+    s->migration_enabled = value;
+}
+
+static void s390_stattrib_instance_init(Object *obj)
+{
+    S390StAttribState *sas = S390_STATTRIB(obj);
+    SaveVMHandlers *ops;
+
+    /* ops will always be freed by qemu when unregistering */
+    ops = g_new0(SaveVMHandlers, 1);
+
+    ops->save_setup = cmma_save_setup;
+    ops->save_live_iterate = cmma_save_iterate;
+    ops->save_live_complete_precopy = cmma_save_complete;
+    ops->save_live_pending = cmma_save_pending;
+    ops->save_cleanup = cmma_save_cleanup;
+    ops->load_state = cmma_load;
+    ops->is_active = cmma_active;
+    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0, ops, sas);
+
+    object_property_add_bool(obj, "migration-enabled",
+                             s390_stattrib_get_migration_enabled,
+                             s390_stattrib_set_migration_enabled, NULL);
+    object_property_set_bool(obj, true, "migration-enabled", NULL);
+    sas->migration_cur_gfn = 0;
+}
+
+static const TypeInfo s390_stattrib_info = {
+    .name          = TYPE_S390_STATTRIB,
+    .parent        = TYPE_DEVICE,
+    .instance_init = s390_stattrib_instance_init,
+    .instance_size = sizeof(S390StAttribState),
+    .class_init    = s390_stattrib_class_init,
+    .class_size    = sizeof(S390StAttribClass),
+    .abstract      = true,
+};
+
+static void s390_stattrib_register_types(void)
+{
+    type_register_static(&s390_stattrib_info);
+    type_register_static(&qemu_s390_stattrib_info);
+}
+
+type_init(s390_stattrib_register_types)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 41ca666..0c8f758 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -24,6 +24,7 @@
 #include "qemu/config-file.h"
 #include "s390-pci-bus.h"
 #include "hw/s390x/storage-keys.h"
+#include "hw/s390x/storage-attributes.h"
 #include "hw/compat.h"
 #include "ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
@@ -103,6 +104,8 @@ void s390_memory_init(ram_addr_t mem_size)
 
     /* Initialize storage key device */
     s390_skeys_init();
+    /* Initialize storage attributes device */
+    s390_stattrib_init();
 }
 
 static SaveVMHandlers savevm_gtod = {
@@ -406,7 +409,12 @@ static const TypeInfo ccw_machine_info = {
     type_init(ccw_machine_register_##suffix)
 
 #define CCW_COMPAT_2_9 \
-        HW_COMPAT_2_9
+        HW_COMPAT_2_9 \
+        {\
+            .driver   = TYPE_S390_STATTRIB,\
+            .property = "migration-enabled",\
+            .value    = "off",\
+        },
 
 #define CCW_COMPAT_2_8 \
         HW_COMPAT_2_8 \
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
new file mode 100644
index 0000000..161440b
--- /dev/null
+++ b/include/hw/s390x/storage-attributes.h
@@ -0,0 +1,68 @@
+/*
+ * s390 storage attributes device
+ *
+ * Copyright 2016 IBM Corp.
+ * Author(s): Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef S390_STORAGE_ATTRIBUTES_H
+#define S390_STORAGE_ATTRIBUTES_H
+
+#include <hw/qdev.h>
+
+#define TYPE_S390_STATTRIB "s390-storage_attributes"
+#define TYPE_QEMU_S390_STATTRIB "s390-storage_attributes-qemu"
+#define TYPE_KVM_S390_STATTRIB "s390-storage_attributes-kvm"
+
+#define S390_STATTRIB(obj) \
+    OBJECT_CHECK(S390StAttribState, (obj), TYPE_S390_STATTRIB)
+
+typedef struct S390StAttribState {
+    DeviceState parent_obj;
+    uint64_t migration_cur_gfn;
+    bool migration_enabled;
+} S390StAttribState;
+
+#define S390_STATTRIB_CLASS(klass) \
+    OBJECT_CLASS_CHECK(S390StAttribClass, (klass), TYPE_S390_STATTRIB)
+#define S390_STATTRIB_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(S390StAttribClass, (obj), TYPE_S390_STATTRIB)
+
+typedef struct S390StAttribClass {
+    DeviceClass parent_class;
+    /* Return value: < 0 on error, or new count */
+    int (*get_stattr)(S390StAttribState *sa, uint64_t *start_gfn,
+                      uint32_t count, uint8_t *values);
+    int (*peek_stattr)(S390StAttribState *sa, uint64_t start_gfn,
+                       uint32_t count, uint8_t *values);
+    int (*set_stattr)(S390StAttribState *sa, uint64_t start_gfn,
+                      uint32_t count, uint8_t *values);
+    void (*synchronize)(S390StAttribState *sa);
+    int (*set_migrationmode)(S390StAttribState *sa, bool value);
+    int (*get_active)(S390StAttribState *sa);
+    long long (*get_dirtycount)(S390StAttribState *sa);
+} S390StAttribClass;
+
+#define QEMU_S390_STATTRIB(obj) \
+    OBJECT_CHECK(QEMUS390StAttribState, (obj), TYPE_QEMU_S390_STATTRIB)
+
+typedef struct QEMUS390StAttribState {
+    S390StAttribState parent_obj;
+} QEMUS390StAttribState;
+
+#define KVM_S390_STATTRIB(obj) \
+    OBJECT_CHECK(KVMS390StAttribState, (obj), TYPE_KVM_S390_STATTRIB)
+
+typedef struct KVMS390StAttribState {
+    S390StAttribState parent_obj;
+    uint64_t still_dirty;
+    uint8_t *incoming_buffer;
+} KVMS390StAttribState;
+
+void s390_stattrib_init(void);
+
+#endif /* S390_STORAGE_ATTRIBUTES_H */
-- 
2.7.4
