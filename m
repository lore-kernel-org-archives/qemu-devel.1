Received: from eggs.gnu.org ([2001:4830:134:3::10]:54225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4au-0003Uc-SR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4at-0002x4-R7
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:19 +1000
Message-Id: <20170606025135.2685-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/17] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

We can replace the four remaining calls of register_savevm() by
calls to register_savevm_live(). So we can remove the function and
as we don't allocate anymore the ops pointer with g_new0()
we don't have to free it then.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/net/vmxnet3.c            |  8 ++++++--
 hw/s390x/s390-skeys.c       |  9 +++++++--
 hw/s390x/s390-virtio-ccw.c  |  8 ++++++--
 include/migration/vmstate.h |  8 --------
 migration/savevm.c          | 16 ----------------
 slirp/slirp.c               |  8 ++++++--
 6 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 8b1fab2..4df3110 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2262,6 +2262,11 @@ static const MemoryRegionOps b1_ops = {
     },
 };
 
+static SaveVMHandlers savevm_vmxnet3_msix = {
+    .save_state = vmxnet3_msix_save,
+    .load_state = vmxnet3_msix_load,
+};
+
 static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
 {
     uint64_t dsn_payload;
@@ -2331,8 +2336,7 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
                               vmxnet3_device_serial_num(s));
     }
 
-    register_savevm(dev, "vmxnet3-msix", -1, 1,
-                    vmxnet3_msix_save, vmxnet3_msix_load, s);
+    register_savevm_live(dev, "vmxnet3-msix", -1, 1, &savevm_vmxnet3_msix, s);
 }
 
 static void vmxnet3_instance_init(Object *obj)
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 619152c..35e7f63 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -362,6 +362,11 @@ static inline bool s390_skeys_get_migration_enabled(Object *obj, Error **errp)
     return ss->migration_enabled;
 }
 
+static SaveVMHandlers savevm_s390_storage_keys = {
+    .save_state = s390_storage_keys_save,
+    .load_state = s390_storage_keys_load,
+};
+
 static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
                                             Error **errp)
 {
@@ -375,8 +380,8 @@ static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
     ss->migration_enabled = value;
 
     if (ss->migration_enabled) {
-        register_savevm(NULL, TYPE_S390_SKEYS, 0, 1, s390_storage_keys_save,
-                        s390_storage_keys_load, ss);
+        register_savevm_live(NULL, TYPE_S390_SKEYS, 0, 1,
+                             &savevm_s390_storage_keys, ss);
     } else {
         unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
     }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c9021f2..a806345 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -104,6 +104,11 @@ void s390_memory_init(ram_addr_t mem_size)
     s390_skeys_init();
 }
 
+static SaveVMHandlers savevm_gtod = {
+    .save_state = gtod_save,
+    .load_state = gtod_load,
+};
+
 static void ccw_init(MachineState *machine)
 {
     int ret;
@@ -151,8 +156,7 @@ static void ccw_init(MachineState *machine)
     s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
 
     /* Register savevm handler for guest TOD clock */
-    register_savevm(NULL, "todclock", 0, 1,
-                    gtod_save, gtod_load, kvm_state);
+    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, kvm_state);
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 6689562..8a3e9e6 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -59,14 +59,6 @@ typedef struct SaveVMHandlers {
     LoadStateHandler *load_state;
 } SaveVMHandlers;
 
-int register_savevm(DeviceState *dev,
-                    const char *idstr,
-                    int instance_id,
-                    int version_id,
-                    SaveStateHandler *save_state,
-                    LoadStateHandler *load_state,
-                    void *opaque);
-
 int register_savevm_live(DeviceState *dev,
                          const char *idstr,
                          int instance_id,
diff --git a/migration/savevm.c b/migration/savevm.c
index 9c320f5..035c127 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -645,21 +645,6 @@ int register_savevm_live(DeviceState *dev,
     return 0;
 }
 
-int register_savevm(DeviceState *dev,
-                    const char *idstr,
-                    int instance_id,
-                    int version_id,
-                    SaveStateHandler *save_state,
-                    LoadStateHandler *load_state,
-                    void *opaque)
-{
-    SaveVMHandlers *ops = g_new0(SaveVMHandlers, 1);
-    ops->save_state = save_state;
-    ops->load_state = load_state;
-    return register_savevm_live(dev, idstr, instance_id, version_id,
-                                ops, opaque);
-}
-
 void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
 {
     SaveStateEntry *se, *new_se;
@@ -679,7 +664,6 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
         if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
             QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
             g_free(se->compat);
-            g_free(se->ops);
             g_free(se);
         }
     }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index e79345b..2386493 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -272,6 +272,11 @@ static void slirp_init_once(void)
 static void slirp_state_save(QEMUFile *f, void *opaque);
 static int slirp_state_load(QEMUFile *f, void *opaque, int version_id);
 
+static SaveVMHandlers savevm_slirp_state = {
+    .save_state = slirp_state_save,
+    .load_state = slirp_state_load,
+};
+
 Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
                   struct in_addr vnetmask, struct in_addr vhost,
                   bool in6_enabled,
@@ -321,8 +326,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwork,
 
     slirp->opaque = opaque;
 
-    register_savevm(NULL, "slirp", 0, 4,
-                    slirp_state_save, slirp_state_load, slirp);
+    register_savevm_live(NULL, "slirp", 0, 4, &savevm_slirp_state, slirp);
 
     QTAILQ_INSERT_TAIL(&slirp_instances, slirp, entry);
 
-- 
2.9.4
