Received: from eggs.gnu.org ([2001:4830:134:3::10]:37032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZGQE-0003TR-Vv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZGQ8-0002pi-8O
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:32:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gZGQ7-0002oz-Ry
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:32:28 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 18 Dec 2018 15:32:19 +0100
Message-Id: <1545143539-26253-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [QEMU PATCH] hw/misc/ivshmem: Remove deprecated
 "ivshmem" legacy device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com

It's been marked as deprecated in QEMU v2.6.0 already, so really nobody
should use the legacy "ivshmem" device anymore (but use ivshmem-plain or
ivshmem-doorbell instead). Time to remove the deprecated device now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/specs/ivshmem-spec.txt |   8 +-
 hw/i386/pc_piix.c           |   4 -
 hw/misc/ivshmem.c           | 206 +-------------------------------------------
 qemu-deprecated.texi        |   5 --
 scripts/device-crash-test   |   1 -
 tests/ivshmem-test.c        |  65 +++++---------
 6 files changed, 29 insertions(+), 260 deletions(-)

diff --git a/docs/specs/ivshmem-spec.txt b/docs/specs/ivshmem-spec.txt
index a1f5499..042f7ea 100644
--- a/docs/specs/ivshmem-spec.txt
+++ b/docs/specs/ivshmem-spec.txt
@@ -17,12 +17,16 @@ get interrupted by its peers.
 
 There are two basic configurations:
 
-- Just shared memory: -device ivshmem-plain,memdev=HMB,...
+- Just shared memory:
+
+      -device ivshmem-plain,memdev=HMB,...
 
   This uses host memory backend HMB.  It should have option "share"
   set.
 
-- Shared memory plus interrupts: -device ivshmem,chardev=CHR,vectors=N,...
+- Shared memory plus interrupts:
+
+      -device ivshmem-doorbell,chardev=CHR,vectors=N,...
 
   An ivshmem server must already be running on the host.  The device
   connects to the server's UNIX domain socket via character device
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7653fbb..5cbe976 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -725,10 +725,6 @@ DEFINE_I440FX_MACHINE(v1_3, "pc-1.3", pc_compat_1_3,
             .property = "msix",\
             .value    = "off",\
         },{\
-            .driver   = "ivshmem",\
-            .property = "use64",\
-            .value    = "0",\
-        },{\
             .driver   = "qxl",\
             .property = "revision",\
             .value    = stringify(3),\
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 8213659..2ab741f 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -112,13 +112,6 @@ typedef struct IVShmemState {
     /* migration stuff */
     OnOffAuto master;
     Error *migration_blocker;
-
-    /* legacy cruft */
-    char *role;
-    char *shmobj;
-    char *sizearg;
-    size_t legacy_size;
-    uint32_t not_legacy_32bit;
 } IVShmemState;
 
 /* registers for the Inter-VM shared memory device */
@@ -529,17 +522,6 @@ static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
 
     size = buf.st_size;
 
-    /* Legacy cruft */
-    if (s->legacy_size != SIZE_MAX) {
-        if (size < s->legacy_size) {
-            error_setg(errp, "server sent only %zd bytes of shared memory",
-                       (size_t)buf.st_size);
-            close(fd);
-            return;
-        }
-        size = s->legacy_size;
-    }
-
     /* mmap the region and map into the BAR2 */
     memory_region_init_ram_from_fd(&s->server_bar2, OBJECT(s),
                                    "ivshmem.bar2", size, true, fd, &local_err);
@@ -882,8 +864,8 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     IVShmemState *s = IVSHMEM_COMMON(dev);
     Error *err = NULL;
     uint8_t *pci_conf;
-    uint8_t attr = PCI_BASE_ADDRESS_SPACE_MEMORY |
-        PCI_BASE_ADDRESS_MEM_PREFETCH;
+    const uint8_t attr = PCI_BASE_ADDRESS_SPACE_MEMORY |
+        PCI_BASE_ADDRESS_MEM_PREFETCH | PCI_BASE_ADDRESS_MEM_TYPE_64;
     Error *local_err = NULL;
 
     /* IRQFD requires MSI */
@@ -903,10 +885,6 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY,
                      &s->ivshmem_mmio);
 
-    if (s->not_legacy_32bit) {
-        attr |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-    }
-
     if (s->hostmem != NULL) {
         IVSHMEM_DPRINTF("using hostmem\n");
 
@@ -1084,13 +1062,6 @@ static Property ivshmem_plain_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void ivshmem_plain_init(Object *obj)
-{
-    IVShmemState *s = IVSHMEM_PLAIN(obj);
-
-    s->not_legacy_32bit = 1;
-}
-
 static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
 {
     IVShmemState *s = IVSHMEM_COMMON(dev);
@@ -1122,7 +1093,6 @@ static const TypeInfo ivshmem_plain_info = {
     .name          = TYPE_IVSHMEM_PLAIN,
     .parent        = TYPE_IVSHMEM_COMMON,
     .instance_size = sizeof(IVShmemState),
-    .instance_init = ivshmem_plain_init,
     .class_init    = ivshmem_plain_class_init,
 };
 
@@ -1155,8 +1125,6 @@ static void ivshmem_doorbell_init(Object *obj)
     IVShmemState *s = IVSHMEM_DOORBELL(obj);
 
     s->features |= (1 << IVSHMEM_MSI);
-    s->legacy_size = SIZE_MAX;  /* whatever the server sends */
-    s->not_legacy_32bit = 1;
 }
 
 static void ivshmem_doorbell_realize(PCIDevice *dev, Error **errp)
@@ -1189,181 +1157,11 @@ static const TypeInfo ivshmem_doorbell_info = {
     .class_init    = ivshmem_doorbell_class_init,
 };
 
-static int ivshmem_load_old(QEMUFile *f, void *opaque, int version_id)
-{
-    IVShmemState *s = opaque;
-    PCIDevice *pdev = PCI_DEVICE(s);
-    int ret;
-
-    IVSHMEM_DPRINTF("ivshmem_load_old\n");
-
-    if (version_id != 0) {
-        return -EINVAL;
-    }
-
-    ret = ivshmem_pre_load(s);
-    if (ret) {
-        return ret;
-    }
-
-    ret = pci_device_load(pdev, f);
-    if (ret) {
-        return ret;
-    }
-
-    if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
-        msix_load(pdev, f);
-        ivshmem_msix_vector_use(s);
-    } else {
-        s->intrstatus = qemu_get_be32(f);
-        s->intrmask = qemu_get_be32(f);
-    }
-
-    return 0;
-}
-
-static bool test_msix(void *opaque, int version_id)
-{
-    IVShmemState *s = opaque;
-
-    return ivshmem_has_feature(s, IVSHMEM_MSI);
-}
-
-static bool test_no_msix(void *opaque, int version_id)
-{
-    return !test_msix(opaque, version_id);
-}
-
-static const VMStateDescription ivshmem_vmsd = {
-    .name = "ivshmem",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_load = ivshmem_pre_load,
-    .post_load = ivshmem_post_load,
-    .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(parent_obj, IVShmemState),
-
-        VMSTATE_MSIX_TEST(parent_obj, IVShmemState, test_msix),
-        VMSTATE_UINT32_TEST(intrstatus, IVShmemState, test_no_msix),
-        VMSTATE_UINT32_TEST(intrmask, IVShmemState, test_no_msix),
-
-        VMSTATE_END_OF_LIST()
-    },
-    .load_state_old = ivshmem_load_old,
-    .minimum_version_id_old = 0
-};
-
-static Property ivshmem_properties[] = {
-    DEFINE_PROP_CHR("chardev", IVShmemState, server_chr),
-    DEFINE_PROP_STRING("size", IVShmemState, sizearg),
-    DEFINE_PROP_UINT32("vectors", IVShmemState, vectors, 1),
-    DEFINE_PROP_BIT("ioeventfd", IVShmemState, features, IVSHMEM_IOEVENTFD,
-                    false),
-    DEFINE_PROP_BIT("msi", IVShmemState, features, IVSHMEM_MSI, true),
-    DEFINE_PROP_STRING("shm", IVShmemState, shmobj),
-    DEFINE_PROP_STRING("role", IVShmemState, role),
-    DEFINE_PROP_UINT32("use64", IVShmemState, not_legacy_32bit, 1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void desugar_shm(IVShmemState *s)
-{
-    Object *obj;
-    char *path;
-
-    obj = object_new("memory-backend-file");
-    path = g_strdup_printf("/dev/shm/%s", s->shmobj);
-    object_property_set_str(obj, path, "mem-path", &error_abort);
-    g_free(path);
-    object_property_set_int(obj, s->legacy_size, "size", &error_abort);
-    object_property_set_bool(obj, true, "share", &error_abort);
-    object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
-                              &error_abort);
-    object_unref(obj);
-    user_creatable_complete(USER_CREATABLE(obj), &error_abort);
-    s->hostmem = MEMORY_BACKEND(obj);
-}
-
-static void ivshmem_realize(PCIDevice *dev, Error **errp)
-{
-    IVShmemState *s = IVSHMEM_COMMON(dev);
-
-    if (!qtest_enabled()) {
-        warn_report("ivshmem is deprecated, please use ivshmem-plain"
-                    " or ivshmem-doorbell instead");
-    }
-
-    if (qemu_chr_fe_backend_connected(&s->server_chr) + !!s->shmobj != 1) {
-        error_setg(errp, "You must specify either 'shm' or 'chardev'");
-        return;
-    }
-
-    if (s->sizearg == NULL) {
-        s->legacy_size = 4 * MiB; /* 4 MB default */
-    } else {
-        int ret;
-        uint64_t size;
-
-        ret = qemu_strtosz_MiB(s->sizearg, NULL, &size);
-        if (ret < 0 || (size_t)size != size || !is_power_of_2(size)) {
-            error_setg(errp, "Invalid size %s", s->sizearg);
-            return;
-        }
-        s->legacy_size = size;
-    }
-
-    /* check that role is reasonable */
-    if (s->role) {
-        if (strncmp(s->role, "peer", 5) == 0) {
-            s->master = ON_OFF_AUTO_OFF;
-        } else if (strncmp(s->role, "master", 7) == 0) {
-            s->master = ON_OFF_AUTO_ON;
-        } else {
-            error_setg(errp, "'role' must be 'peer' or 'master'");
-            return;
-        }
-    } else {
-        s->master = ON_OFF_AUTO_AUTO;
-    }
-
-    if (s->shmobj) {
-        desugar_shm(s);
-    }
-
-    /*
-     * Note: we don't use INTx with IVSHMEM_MSI at all, so this is a
-     * bald-faced lie then.  But it's a backwards compatible lie.
-     */
-    pci_config_set_interrupt_pin(dev->config, 1);
-
-    ivshmem_common_realize(dev, errp);
-}
-
-static void ivshmem_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = ivshmem_realize;
-    k->revision = 0;
-    dc->desc = "Inter-VM shared memory (legacy)";
-    dc->props = ivshmem_properties;
-    dc->vmsd = &ivshmem_vmsd;
-}
-
-static const TypeInfo ivshmem_info = {
-    .name          = TYPE_IVSHMEM,
-    .parent        = TYPE_IVSHMEM_COMMON,
-    .instance_size = sizeof(IVShmemState),
-    .class_init    = ivshmem_class_init,
-};
-
 static void ivshmem_register_types(void)
 {
     type_register_static(&ivshmem_common_info);
     type_register_static(&ivshmem_plain_info);
     type_register_static(&ivshmem_doorbell_info);
-    type_register_static(&ivshmem_info);
 }
 
 type_init(ivshmem_register_types)
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 190250f..038df3d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -110,11 +110,6 @@ documentation of ``query-hotpluggable-cpus'' for additional details.
 
 @section System emulator devices
 
-@subsection ivshmem (since 2.6.0)
-
-The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
-or ``ivshmem-doorbell`` device types.
-
 @subsection bluetooth (since 3.1)
 
 The bluetooth subsystem is unmaintained since many years and likely bitrotten
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e93a7c0..a835772 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -83,7 +83,6 @@ ERROR_WHITELIST = [
     {'device':'isa-ipmi-bt', 'expected':True},             # IPMI device requires a bmc attribute to be set
     {'device':'isa-ipmi-kcs', 'expected':True},            # IPMI device requires a bmc attribute to be set
     {'device':'isa-parallel', 'expected':True},            # Can't create serial device, empty char device
-    {'device':'ivshmem', 'expected':True},                 # You must specify either 'shm' or 'chardev'
     {'device':'ivshmem-doorbell', 'expected':True},        # You must specify a 'chardev'
     {'device':'ivshmem-plain', 'expected':True},           # You must specify a 'memdev'
     {'device':'loader', 'expected':True},                  # please include valid arguments
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index c37b196..9811d66 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -305,20 +305,18 @@ static void *server_thread(void *data)
     return NULL;
 }
 
-static void setup_vm_with_server(IVState *s, int nvectors, bool msi)
+static void setup_vm_with_server(IVState *s, int nvectors)
 {
-    char *cmd = g_strdup_printf("-chardev socket,id=chr0,path=%s,nowait "
-                                "-device ivshmem%s,chardev=chr0,vectors=%d",
-                                tmpserver,
-                                msi ? "-doorbell" : ",size=1M,msi=off",
-                                nvectors);
+    char *cmd = g_strdup_printf("-chardev socket,id=chr0,path=%s,nowait -device"
+                                " ivshmem-doorbell,chardev=chr0,vectors=%d",
+                                tmpserver, nvectors);
 
-    setup_vm_cmd(s, cmd, msi);
+    setup_vm_cmd(s, cmd, true);
 
     g_free(cmd);
 }
 
-static void test_ivshmem_server(bool msi)
+static void test_ivshmem_server(void)
 {
     IVState state1, state2, *s1, *s2;
     ServerThread thread;
@@ -341,9 +339,9 @@ static void test_ivshmem_server(bool msi)
     thread.thread = g_thread_new("ivshmem-server", server_thread, &thread);
     g_assert(thread.thread != NULL);
 
-    setup_vm_with_server(&state1, nvectors, msi);
+    setup_vm_with_server(&state1, nvectors);
     s1 = &state1;
-    setup_vm_with_server(&state2, nvectors, msi);
+    setup_vm_with_server(&state2, nvectors);
     s2 = &state2;
 
     /* check got different VM ids */
@@ -355,39 +353,29 @@ static void test_ivshmem_server(bool msi)
 
     /* check number of MSI-X vectors */
     global_qtest = s1->qs->qts;
-    if (msi) {
-        ret = qpci_msix_table_size(s1->dev);
-        g_assert_cmpuint(ret, ==, nvectors);
-    }
+    ret = qpci_msix_table_size(s1->dev);
+    g_assert_cmpuint(ret, ==, nvectors);
 
     /* TODO test behavior before MSI-X is enabled */
 
     /* ping vm2 -> vm1 on vector 0 */
-    if (msi) {
-        ret = qpci_msix_pending(s1->dev, 0);
-        g_assert_cmpuint(ret, ==, 0);
-    } else {
-        g_assert_cmpuint(in_reg(s1, INTRSTATUS), ==, 0);
-    }
+    ret = qpci_msix_pending(s1->dev, 0);
+    g_assert_cmpuint(ret, ==, 0);
     out_reg(s2, DOORBELL, vm1 << 16);
     do {
         g_usleep(10000);
-        ret = msi ? qpci_msix_pending(s1->dev, 0) : in_reg(s1, INTRSTATUS);
+        ret = qpci_msix_pending(s1->dev, 0);
     } while (ret == 0 && g_get_monotonic_time() < end_time);
     g_assert_cmpuint(ret, !=, 0);
 
     /* ping vm1 -> vm2 on vector 1 */
     global_qtest = s2->qs->qts;
-    if (msi) {
-        ret = qpci_msix_pending(s2->dev, 1);
-        g_assert_cmpuint(ret, ==, 0);
-    } else {
-        g_assert_cmpuint(in_reg(s2, INTRSTATUS), ==, 0);
-    }
+    ret = qpci_msix_pending(s2->dev, 1);
+    g_assert_cmpuint(ret, ==, 0);
     out_reg(s1, DOORBELL, vm2 << 16 | 1);
     do {
         g_usleep(10000);
-        ret = msi ? qpci_msix_pending(s2->dev, 1) : in_reg(s2, INTRSTATUS);
+        ret = qpci_msix_pending(s2->dev, 1);
     } while (ret == 0 && g_get_monotonic_time() < end_time);
     g_assert_cmpuint(ret, !=, 0);
 
@@ -405,27 +393,17 @@ static void test_ivshmem_server(bool msi)
     close(thread.pipe[0]);
 }
 
-static void test_ivshmem_server_msi(void)
-{
-    test_ivshmem_server(true);
-}
-
-static void test_ivshmem_server_irq(void)
-{
-    test_ivshmem_server(false);
-}
-
 #define PCI_SLOT_HP             0x06
 
 static void test_ivshmem_hotplug(void)
 {
     const char *arch = qtest_get_arch();
 
-    qtest_start("");
+    qtest_start("-object memory-backend-ram,size=1M,id=mb1");
 
-    qtest_qmp_device_add("ivshmem",
-                         "iv1", "{'addr': %s, 'shm': %s, 'size': '1M'}",
-                         stringify(PCI_SLOT_HP), tmpshm);
+    qtest_qmp_device_add("ivshmem-plain", "iv1",
+                         "{'addr': %s, 'memdev': 'mb1'}",
+                         stringify(PCI_SLOT_HP));
     if (strcmp(arch, "ppc64") != 0) {
         qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
     }
@@ -525,8 +503,7 @@ int main(int argc, char **argv)
     if (g_test_slow()) {
         qtest_add_func("/ivshmem/pair", test_ivshmem_pair);
         if (strcmp(arch, "ppc64") != 0) {
-            qtest_add_func("/ivshmem/server-msi", test_ivshmem_server_msi);
-            qtest_add_func("/ivshmem/server-irq", test_ivshmem_server_irq);
+            qtest_add_func("/ivshmem/server", test_ivshmem_server);
         }
     }
 
-- 
1.8.3.1
