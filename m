Received: from eggs.gnu.org ([2001:4830:134:3::10]:45171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gN4kd-0000zH-5b
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 18:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gN4kK-0001jY-IZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 18:39:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gN4kK-0001j4-8n
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 18:38:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Nov 2018 21:38:31 -0200
Message-Id: <20181114233831.10374-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide version-specific
 variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

Many of the current virtio-*-pci device types actually represent
3 different types of devices:
* virtio 1.0 non-transitional devices
* virtio 1.0 transitional devices
* virtio 0.9 ("legacy device" in virtio 1.0 terminology)

That would be just an annoyance if it didn't break our device/bus
compatibility QMP interfaces.  With this multi-purpose device
type, there's no way to tell management software that
transitional devices and legacy devices require a Conventional
PCI bus.

The multi-purpose device types would also prevent us from telling
management software what's the PCI vendor/device ID for them,
because their PCI IDs change at runtime depending on the bus
where they were plugged.

This patch adds separate device types for each of those virtio
device flavors:

- virtio-*-pci: the existing multi-purpose device types
  - Configurable using `disable-legacy` and `disable-modern`
    properties
  - Legacy driver support is automatically enabled/disabled
    depending on the bus where it is plugged
  - Supports Conventional PCI and PCI Express buses
    (but Conventional PCI is incompatible with
    disable-legacy=off)
  - Changes PCI vendor/device IDs at runtime
- virtio-*-pci-transitional: virtio-1.0 device supporting legacy drivers
  - Supports Conventional PCI buses only, because
    it has a PIO BAR
- virtio-*-pci-non-transitional: modern-only
  - Supports both Conventional PCI and PCI Express buses

All the types above will inherit from an abstract
"virtio-*-pci-base" type, so existing code that doesn't care
about the virtio version can use "virtio-*-pci-base" on type
casts.

Note that devices that are always non-transitional won't have the
-non-transitional variants added, because it would be redundant.

A simple test script (tests/acceptance/virtio_version.py) is
included, to check if the new device types are equivalent to
using the `disable-legacy` and `disable-modern` options.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Reference to previous discussion that originated this idea:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg558389.html

Changes v1 -> v2:
* Removed *-0.9 devices.  Nobody will want to use them, if
  transitional devices work with legacy drivers
  (Gerd Hoffmann, Michael S. Tsirkin)
* Drop virtio version from name: rename -1.0-transitional to
  -transitional (Michael S. Tsirkin)
* Renamed -1.0 to -non-transitional
* Don't add any extra variants to modern-only device types
  (they don't need it)
* Fix typo on TYPE_VIRTIO_INPUT_HOST_PCI (crash reported by
  Cornelia Huck)
* No need to change cast macros for modern-only devices
* Rename virtio_register_types() to virtio_pci_types_register()

Note about points discussed in the v1 thread:

Andrea suggested making separate transitional Conventional PCi
and transitional PCI Express device types[1].  I didn't do that
because I don't see which problems this solves.  We have many
other device types that are hybrid (support both PCI Express and
Conventional PCI) and this was never a problem for us[2].

[1] http://mid.mail-archive.com/6f8d59b8ee2d92d73d2957b520bd8bac989fc796.camel@redhat.com
[2] http://mid.mail-archive.com/20181017155637.GC31060@habkost.net
---
 hw/virtio/virtio-pci.h             |  80 +++++++++--
 hw/display/virtio-gpu-pci.c        |   8 +-
 hw/display/virtio-vga.c            |   8 +-
 hw/virtio/virtio-crypto-pci.c      |   8 +-
 hw/virtio/virtio-pci.c             | 215 ++++++++++++++++++++---------
 tests/acceptance/virtio_version.py | 177 ++++++++++++++++++++++++
 6 files changed, 406 insertions(+), 90 deletions(-)
 create mode 100644 tests/acceptance/virtio_version.py

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..1d2a11504f 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -216,7 +216,8 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
 /*
  * virtio-scsi-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_SCSI_PCI "virtio-scsi-pci"
+#define TYPE_VIRTIO_SCSI_PCI_PREFIX "virtio-scsi-pci"
+#define TYPE_VIRTIO_SCSI_PCI (TYPE_VIRTIO_SCSI_PCI_PREFIX "-base")
 #define VIRTIO_SCSI_PCI(obj) \
         OBJECT_CHECK(VirtIOSCSIPCI, (obj), TYPE_VIRTIO_SCSI_PCI)
 
@@ -229,7 +230,8 @@ struct VirtIOSCSIPCI {
 /*
  * vhost-scsi-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VHOST_SCSI_PCI "vhost-scsi-pci"
+#define TYPE_VHOST_SCSI_PCI_PREFIX "vhost-scsi-pci"
+#define TYPE_VHOST_SCSI_PCI (TYPE_VHOST_SCSI_PCI_PREFIX "-base")
 #define VHOST_SCSI_PCI(obj) \
         OBJECT_CHECK(VHostSCSIPCI, (obj), TYPE_VHOST_SCSI_PCI)
 
@@ -239,7 +241,8 @@ struct VHostSCSIPCI {
 };
 #endif
 
-#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci"
+#define TYPE_VHOST_USER_SCSI_PCI_PREFIX "vhost-user-scsi-pci"
+#define TYPE_VHOST_USER_SCSI_PCI (TYPE_VHOST_USER_SCSI_PCI_PREFIX "-base")
 #define VHOST_USER_SCSI_PCI(obj) \
         OBJECT_CHECK(VHostUserSCSIPCI, (obj), TYPE_VHOST_USER_SCSI_PCI)
 
@@ -252,7 +255,8 @@ struct VHostUserSCSIPCI {
 /*
  * vhost-user-blk-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VHOST_USER_BLK_PCI "vhost-user-blk-pci"
+#define TYPE_VHOST_USER_BLK_PCI_PREFIX "vhost-user-blk-pci"
+#define TYPE_VHOST_USER_BLK_PCI (TYPE_VHOST_USER_BLK_PCI_PREFIX "-base")
 #define VHOST_USER_BLK_PCI(obj) \
         OBJECT_CHECK(VHostUserBlkPCI, (obj), TYPE_VHOST_USER_BLK_PCI)
 
@@ -265,7 +269,8 @@ struct VHostUserBlkPCI {
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_BLK_PCI "virtio-blk-pci"
+#define TYPE_VIRTIO_BLK_PCI_PREFIX "virtio-blk-pci"
+#define TYPE_VIRTIO_BLK_PCI (TYPE_VIRTIO_BLK_PCI_PREFIX "-base")
 #define VIRTIO_BLK_PCI(obj) \
         OBJECT_CHECK(VirtIOBlkPCI, (obj), TYPE_VIRTIO_BLK_PCI)
 
@@ -277,7 +282,8 @@ struct VirtIOBlkPCI {
 /*
  * virtio-balloon-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_BALLOON_PCI "virtio-balloon-pci"
+#define TYPE_VIRTIO_BALLOON_PCI_PREFIX "virtio-balloon-pci"
+#define TYPE_VIRTIO_BALLOON_PCI (TYPE_VIRTIO_BALLOON_PCI_PREFIX "-base")
 #define VIRTIO_BALLOON_PCI(obj) \
         OBJECT_CHECK(VirtIOBalloonPCI, (obj), TYPE_VIRTIO_BALLOON_PCI)
 
@@ -289,7 +295,8 @@ struct VirtIOBalloonPCI {
 /*
  * virtio-serial-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_SERIAL_PCI "virtio-serial-pci"
+#define TYPE_VIRTIO_SERIAL_PCI_PREFIX "virtio-serial-pci"
+#define TYPE_VIRTIO_SERIAL_PCI (TYPE_VIRTIO_SERIAL_PCI_PREFIX "-base")
 #define VIRTIO_SERIAL_PCI(obj) \
         OBJECT_CHECK(VirtIOSerialPCI, (obj), TYPE_VIRTIO_SERIAL_PCI)
 
@@ -301,7 +308,8 @@ struct VirtIOSerialPCI {
 /*
  * virtio-net-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_NET_PCI "virtio-net-pci"
+#define TYPE_VIRTIO_NET_PCI_PREFIX "virtio-net-pci"
+#define TYPE_VIRTIO_NET_PCI (TYPE_VIRTIO_NET_PCI_PREFIX "-base")
 #define VIRTIO_NET_PCI(obj) \
         OBJECT_CHECK(VirtIONetPCI, (obj), TYPE_VIRTIO_NET_PCI)
 
@@ -316,7 +324,8 @@ struct VirtIONetPCI {
 
 #ifdef CONFIG_VIRTFS
 
-#define TYPE_VIRTIO_9P_PCI "virtio-9p-pci"
+#define TYPE_VIRTIO_9P_PCI_PREFIX "virtio-9p-pci"
+#define TYPE_VIRTIO_9P_PCI (TYPE_VIRTIO_9P_PCI_PREFIX "-base")
 #define VIRTIO_9P_PCI(obj) \
         OBJECT_CHECK(V9fsPCIState, (obj), TYPE_VIRTIO_9P_PCI)
 
@@ -330,7 +339,8 @@ typedef struct V9fsPCIState {
 /*
  * virtio-rng-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_RNG_PCI "virtio-rng-pci"
+#define TYPE_VIRTIO_RNG_PCI_PREFIX "virtio-rng-pci"
+#define TYPE_VIRTIO_RNG_PCI (TYPE_VIRTIO_RNG_PCI_PREFIX "-base")
 #define VIRTIO_RNG_PCI(obj) \
         OBJECT_CHECK(VirtIORngPCI, (obj), TYPE_VIRTIO_RNG_PCI)
 
@@ -365,7 +375,8 @@ struct VirtIOInputHIDPCI {
 
 #ifdef CONFIG_LINUX
 
-#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
+#define TYPE_VIRTIO_INPUT_HOST_PCI_PREFIX "virtio-input-host-pci"
+#define TYPE_VIRTIO_INPUT_HOST_PCI (TYPE_VIRTIO_INPUT_HOST_PCI_PREFIX "-base")
 #define VIRTIO_INPUT_HOST_PCI(obj) \
         OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_PCI)
 
@@ -392,7 +403,8 @@ struct VirtIOGPUPCI {
 /*
  * vhost-vsock-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VHOST_VSOCK_PCI "vhost-vsock-pci"
+#define TYPE_VHOST_VSOCK_PCI_PREFIX "vhost-vsock-pci"
+#define TYPE_VHOST_VSOCK_PCI (TYPE_VHOST_VSOCK_PCI_PREFIX "-base")
 #define VHOST_VSOCK_PCI(obj) \
         OBJECT_CHECK(VHostVSockPCI, (obj), TYPE_VHOST_VSOCK_PCI)
 
@@ -417,4 +429,48 @@ struct VirtIOCryptoPCI {
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
 
+/**
+ * VirtioPCIDeviceTypeInfo:
+ *
+ * Template for virtio PCI device types.  See virtio_pci_types_register()
+ * for details.
+ */
+typedef struct VirtioPCIDeviceTypeInfo {
+    /* Prefix for the class names */
+    const char *name_prefix;
+    /* Parent type.  If NULL, TYPE_VIRTIO_PCI is used */
+    const char *parent;
+    /* If modern_only is true, only <name_prefix> type will be registered */
+    bool modern_only;
+
+    /* Same as TypeInfo fields: */
+    size_t instance_size;
+    void (*instance_init)(Object *obj);
+    void (*class_init)(ObjectClass *klass, void *data);
+} VirtioPCIDeviceTypeInfo;
+
+/*
+ * Register virtio-pci types.  Each virtio-pci device type will be available
+ * in 3 flavors:
+ * - <prefix>-transitional: modern device supporting legacy drivers
+ *   - Supports Conventional PCI buses only
+ * - <prefix>-non-transitional: modern-only
+ *   - Supports Conventional PCI and PCI Express buses
+ * - <prefix>: virtio version configurable, legacy driver support
+ *                  automatically selected when device is plugged
+ *   _ This was the only flavor supported until QEMU 3.1
+ *   - Supports Conventional PCI and PCI Express buses
+ *
+ * All the types above will inherit from "<prefix>-base", so generic
+ * code can use "<prefix>-base" on type casts.
+ *
+ * We need a separate "<prefix>-base" type instead of making all types inherit
+ * from <prefix> for two reasons:
+ * 1) <prefix> will implement INTERFACE_PCIE_DEVICE, but
+ *    <prefix>-transitional won't.
+ * 2) <prefix> will have the "disable-legacy" and "disable-modern" properties,
+ *    <prefix>-transitional and <prefix>-non-transitional won't.
+ */
+void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
+
 #endif
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index cece4aa495..ca47063b70 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -69,9 +69,9 @@ static void virtio_gpu_initfn(Object *obj)
                                 TYPE_VIRTIO_GPU);
 }
 
-static const TypeInfo virtio_gpu_pci_info = {
-    .name = TYPE_VIRTIO_GPU_PCI,
-    .parent = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_gpu_pci_info = {
+    .name_prefix = TYPE_VIRTIO_GPU_PCI,
+    .modern_only = true,
     .instance_size = sizeof(VirtIOGPUPCI),
     .instance_init = virtio_gpu_initfn,
     .class_init = virtio_gpu_pci_class_init,
@@ -79,6 +79,6 @@ static const TypeInfo virtio_gpu_pci_info = {
 
 static void virtio_gpu_pci_register_types(void)
 {
-    type_register_static(&virtio_gpu_pci_info);
+    virtio_pci_types_register(&virtio_gpu_pci_info);
 }
 type_init(virtio_gpu_pci_register_types)
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index ab2e369b28..aaa42a8c31 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -207,9 +207,9 @@ static void virtio_vga_inst_initfn(Object *obj)
                                 TYPE_VIRTIO_GPU);
 }
 
-static TypeInfo virtio_vga_info = {
-    .name          = TYPE_VIRTIO_VGA,
-    .parent        = TYPE_VIRTIO_PCI,
+static VirtioPCIDeviceTypeInfo virtio_vga_info = {
+    .name_prefix   = TYPE_VIRTIO_VGA,
+    .modern_only   = true,
     .instance_size = sizeof(struct VirtIOVGA),
     .instance_init = virtio_vga_inst_initfn,
     .class_init    = virtio_vga_class_init,
@@ -217,7 +217,7 @@ static TypeInfo virtio_vga_info = {
 
 static void virtio_vga_register_types(void)
 {
-    type_register_static(&virtio_vga_info);
+    virtio_pci_types_register(&virtio_vga_info);
 }
 
 type_init(virtio_vga_register_types)
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index bf64996e48..c41dc11f0d 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -64,9 +64,9 @@ static void virtio_crypto_initfn(Object *obj)
                                 TYPE_VIRTIO_CRYPTO);
 }
 
-static const TypeInfo virtio_crypto_pci_info = {
-    .name          = TYPE_VIRTIO_CRYPTO_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_crypto_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_CRYPTO_PCI,
+    .modern_only   = true,
     .instance_size = sizeof(VirtIOCryptoPCI),
     .instance_init = virtio_crypto_initfn,
     .class_init    = virtio_crypto_pci_class_init,
@@ -74,6 +74,6 @@ static const TypeInfo virtio_crypto_pci_info = {
 
 static void virtio_crypto_pci_register_types(void)
 {
-    type_register_static(&virtio_crypto_pci_info);
+    virtio_pci_types_register(&virtio_crypto_pci_info);
 }
 type_init(virtio_crypto_pci_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a954799267..0fa248d68c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1119,9 +1119,8 @@ static void virtio_9p_pci_instance_init(Object *obj)
                                 TYPE_VIRTIO_9P);
 }
 
-static const TypeInfo virtio_9p_pci_info = {
-    .name          = TYPE_VIRTIO_9P_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_9p_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_9P_PCI_PREFIX,
     .instance_size = sizeof(V9fsPCIState),
     .instance_init = virtio_9p_pci_instance_init,
     .class_init    = virtio_9p_pci_class_init,
@@ -1877,9 +1876,6 @@ static void virtio_pci_reset(DeviceState *qdev)
 static Property virtio_pci_properties[] = {
     DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
-    DEFINE_PROP_ON_OFF_AUTO("disable-legacy", VirtIOPCIProxy, disable_legacy,
-                            ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_BOOL("disable-modern", VirtIOPCIProxy, disable_modern, false),
     DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT, true),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
@@ -1939,13 +1935,104 @@ static const TypeInfo virtio_pci_info = {
     .class_init    = virtio_pci_class_init,
     .class_size    = sizeof(VirtioPCIClass),
     .abstract      = true,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { }
-    },
 };
 
+static Property virtio_pci_generic_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO("disable-legacy", VirtIOPCIProxy, disable_legacy,
+                            ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("disable-modern", VirtIOPCIProxy, disable_modern, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_pci_generic_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = virtio_pci_generic_properties;
+}
+
+static void virtio_pci_transitional_instance_init(Object *obj)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(obj);
+
+    proxy->disable_legacy = ON_OFF_AUTO_OFF;
+    proxy->disable_modern = false;
+}
+
+static void virtio_pci_1_0_instance_init(Object *obj)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(obj);
+
+    proxy->disable_legacy = ON_OFF_AUTO_ON;
+    proxy->disable_modern = false;
+}
+
+
+void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
+{
+    char *base_name = g_strdup_printf("%s-base", t->name_prefix);
+    const TypeInfo base_type_info = {
+        .name          = base_name,
+        .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
+        .instance_size = t->instance_size,
+        .instance_init = t->instance_init,
+        .class_init    = t->class_init,
+        .abstract      = true,
+    };
+
+    const TypeInfo generic_type_info = {
+        .name          = t->name_prefix,
+        .parent        = base_name,
+        .class_init    = virtio_pci_generic_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { INTERFACE_PCIE_DEVICE },
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        },
+    };
+
+    type_register(&base_type_info);
+    type_register(&generic_type_info);
+
+    if (!t->modern_only) {
+        char *non_transitional_name =
+            g_strdup_printf("%s-non-transitional", t->name_prefix);
+        char *transitional_name =
+            g_strdup_printf("%s-transitional", t->name_prefix);
+        const TypeInfo non_transitional_type_info = {
+            .name          = non_transitional_name,
+            .parent        = base_name,
+            .instance_init = virtio_pci_1_0_instance_init,
+            .interfaces = (InterfaceInfo[]) {
+                { INTERFACE_PCIE_DEVICE },
+                { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+                { }
+            },
+        };
+        const TypeInfo transitional_type_info = {
+            .name          = transitional_name,
+            .parent        = base_name,
+            .instance_init = virtio_pci_transitional_instance_init,
+            .interfaces = (InterfaceInfo[]) {
+                /*
+                 * Transitional virtio devices work only as Conventional PCI
+                 * devices because they require PIO ports.
+                 */
+                { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+                { }
+            },
+        };
+
+        type_register(&non_transitional_type_info);
+        type_register(&transitional_type_info);
+
+        g_free(non_transitional_name);
+        g_free(transitional_name);
+    }
+
+    g_free(base_name);
+}
+
 /* virtio-blk-pci */
 
 static Property virtio_blk_pci_properties[] = {
@@ -1995,9 +2082,8 @@ static void virtio_blk_pci_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static const TypeInfo virtio_blk_pci_info = {
-    .name          = TYPE_VIRTIO_BLK_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_blk_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_BLK_PCI_PREFIX,
     .instance_size = sizeof(VirtIOBlkPCI),
     .instance_init = virtio_blk_pci_instance_init,
     .class_init    = virtio_blk_pci_class_init,
@@ -2051,9 +2137,8 @@ static void vhost_user_blk_pci_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static const TypeInfo vhost_user_blk_pci_info = {
-    .name           = TYPE_VHOST_USER_BLK_PCI,
-    .parent         = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo vhost_user_blk_pci_info = {
+    .name_prefix    = TYPE_VHOST_USER_BLK_PCI_PREFIX,
     .instance_size  = sizeof(VHostUserBlkPCI),
     .instance_init  = vhost_user_blk_pci_instance_init,
     .class_init     = vhost_user_blk_pci_class_init,
@@ -2119,9 +2204,8 @@ static void virtio_scsi_pci_instance_init(Object *obj)
                                 TYPE_VIRTIO_SCSI);
 }
 
-static const TypeInfo virtio_scsi_pci_info = {
-    .name          = TYPE_VIRTIO_SCSI_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_scsi_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_SCSI_PCI_PREFIX,
     .instance_size = sizeof(VirtIOSCSIPCI),
     .instance_init = virtio_scsi_pci_instance_init,
     .class_init    = virtio_scsi_pci_class_init,
@@ -2174,9 +2258,8 @@ static void vhost_scsi_pci_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static const TypeInfo vhost_scsi_pci_info = {
-    .name          = TYPE_VHOST_SCSI_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo vhost_scsi_pci_info = {
+    .name_prefix   = TYPE_VHOST_SCSI_PCI_PREFIX,
     .instance_size = sizeof(VHostSCSIPCI),
     .instance_init = vhost_scsi_pci_instance_init,
     .class_init    = vhost_scsi_pci_class_init,
@@ -2229,9 +2312,8 @@ static void vhost_user_scsi_pci_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static const TypeInfo vhost_user_scsi_pci_info = {
-    .name          = TYPE_VHOST_USER_SCSI_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo vhost_user_scsi_pci_info = {
+    .name_prefix   = TYPE_VHOST_USER_SCSI_PCI_PREFIX,
     .instance_size = sizeof(VHostUserSCSIPCI),
     .instance_init = vhost_user_scsi_pci_instance_init,
     .class_init    = vhost_user_scsi_pci_class_init,
@@ -2277,9 +2359,8 @@ static void vhost_vsock_pci_instance_init(Object *obj)
                                 TYPE_VHOST_VSOCK);
 }
 
-static const TypeInfo vhost_vsock_pci_info = {
-    .name          = TYPE_VHOST_VSOCK_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo vhost_vsock_pci_info = {
+    .name_prefix   = TYPE_VHOST_VSOCK_PCI_PREFIX,
     .instance_size = sizeof(VHostVSockPCI),
     .instance_init = vhost_vsock_pci_instance_init,
     .class_init    = vhost_vsock_pci_class_init,
@@ -2334,9 +2415,8 @@ static void virtio_balloon_pci_instance_init(Object *obj)
                               "guest-stats-polling-interval", &error_abort);
 }
 
-static const TypeInfo virtio_balloon_pci_info = {
-    .name          = TYPE_VIRTIO_BALLOON_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_balloon_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_BALLOON_PCI_PREFIX,
     .instance_size = sizeof(VirtIOBalloonPCI),
     .instance_init = virtio_balloon_pci_instance_init,
     .class_init    = virtio_balloon_pci_class_init,
@@ -2407,9 +2487,8 @@ static void virtio_serial_pci_instance_init(Object *obj)
                                 TYPE_VIRTIO_SERIAL);
 }
 
-static const TypeInfo virtio_serial_pci_info = {
-    .name          = TYPE_VIRTIO_SERIAL_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_serial_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_SERIAL_PCI_PREFIX,
     .instance_size = sizeof(VirtIOSerialPCI),
     .instance_init = virtio_serial_pci_instance_init,
     .class_init    = virtio_serial_pci_class_init,
@@ -2462,9 +2541,8 @@ static void virtio_net_pci_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static const TypeInfo virtio_net_pci_info = {
-    .name          = TYPE_VIRTIO_NET_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_NET_PCI_PREFIX,
     .instance_size = sizeof(VirtIONetPCI),
     .instance_init = virtio_net_pci_instance_init,
     .class_init    = virtio_net_pci_class_init,
@@ -2513,9 +2591,8 @@ static void virtio_rng_initfn(Object *obj)
                                 TYPE_VIRTIO_RNG);
 }
 
-static const TypeInfo virtio_rng_pci_info = {
-    .name          = TYPE_VIRTIO_RNG_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_rng_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_RNG_PCI_PREFIX,
     .instance_size = sizeof(VirtIORngPCI),
     .instance_init = virtio_rng_initfn,
     .class_init    = virtio_rng_pci_class_init,
@@ -2605,25 +2682,28 @@ static const TypeInfo virtio_input_hid_pci_info = {
     .abstract      = true,
 };
 
-static const TypeInfo virtio_keyboard_pci_info = {
-    .name          = TYPE_VIRTIO_KEYBOARD_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_keyboard_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_KEYBOARD_PCI,
     .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .modern_only   = true,
     .class_init    = virtio_input_hid_kbd_pci_class_init,
     .instance_size = sizeof(VirtIOInputHIDPCI),
     .instance_init = virtio_keyboard_initfn,
 };
 
-static const TypeInfo virtio_mouse_pci_info = {
-    .name          = TYPE_VIRTIO_MOUSE_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_mouse_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_MOUSE_PCI,
     .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .modern_only   = true,
     .class_init    = virtio_input_hid_mouse_pci_class_init,
     .instance_size = sizeof(VirtIOInputHIDPCI),
     .instance_init = virtio_mouse_initfn,
 };
 
-static const TypeInfo virtio_tablet_pci_info = {
-    .name          = TYPE_VIRTIO_TABLET_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_tablet_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_TABLET_PCI,
     .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .modern_only   = true,
     .instance_size = sizeof(VirtIOInputHIDPCI),
     .instance_init = virtio_tablet_initfn,
 };
@@ -2637,8 +2717,8 @@ static void virtio_host_initfn(Object *obj)
                                 TYPE_VIRTIO_INPUT_HOST);
 }
 
-static const TypeInfo virtio_host_pci_info = {
-    .name          = TYPE_VIRTIO_INPUT_HOST_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_host_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_INPUT_HOST_PCI_PREFIX,
     .parent        = TYPE_VIRTIO_INPUT_PCI,
     .instance_size = sizeof(VirtIOInputHostPCI),
     .instance_init = virtio_host_initfn,
@@ -2692,36 +2772,39 @@ static const TypeInfo virtio_pci_bus_info = {
 
 static void virtio_pci_register_types(void)
 {
-    type_register_static(&virtio_rng_pci_info);
+    /* Base types: */
+    type_register_static(&virtio_pci_bus_info);
+    type_register_static(&virtio_pci_info);
     type_register_static(&virtio_input_pci_info);
     type_register_static(&virtio_input_hid_pci_info);
-    type_register_static(&virtio_keyboard_pci_info);
-    type_register_static(&virtio_mouse_pci_info);
-    type_register_static(&virtio_tablet_pci_info);
+
+    /* Implementations: */
+    virtio_pci_types_register(&virtio_rng_pci_info);
+    virtio_pci_types_register(&virtio_keyboard_pci_info);
+    virtio_pci_types_register(&virtio_mouse_pci_info);
+    virtio_pci_types_register(&virtio_tablet_pci_info);
 #ifdef CONFIG_LINUX
-    type_register_static(&virtio_host_pci_info);
+    virtio_pci_types_register(&virtio_host_pci_info);
 #endif
-    type_register_static(&virtio_pci_bus_info);
-    type_register_static(&virtio_pci_info);
 #ifdef CONFIG_VIRTFS
-    type_register_static(&virtio_9p_pci_info);
+    virtio_pci_types_register(&virtio_9p_pci_info);
 #endif
-    type_register_static(&virtio_blk_pci_info);
+    virtio_pci_types_register(&virtio_blk_pci_info);
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    type_register_static(&vhost_user_blk_pci_info);
+    virtio_pci_types_register(&vhost_user_blk_pci_info);
 #endif
-    type_register_static(&virtio_scsi_pci_info);
-    type_register_static(&virtio_balloon_pci_info);
-    type_register_static(&virtio_serial_pci_info);
-    type_register_static(&virtio_net_pci_info);
+    virtio_pci_types_register(&virtio_scsi_pci_info);
+    virtio_pci_types_register(&virtio_balloon_pci_info);
+    virtio_pci_types_register(&virtio_serial_pci_info);
+    virtio_pci_types_register(&virtio_net_pci_info);
 #ifdef CONFIG_VHOST_SCSI
-    type_register_static(&vhost_scsi_pci_info);
+    virtio_pci_types_register(&vhost_scsi_pci_info);
 #endif
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    type_register_static(&vhost_user_scsi_pci_info);
+    virtio_pci_types_register(&vhost_user_scsi_pci_info);
 #endif
 #ifdef CONFIG_VHOST_VSOCK
-    type_register_static(&vhost_vsock_pci_info);
+    virtio_pci_types_register(&vhost_vsock_pci_info);
 #endif
 }
 
diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
new file mode 100644
index 0000000000..a8d0b20b75
--- /dev/null
+++ b/tests/acceptance/virtio_version.py
@@ -0,0 +1,177 @@
+"""
+Check compatibility of virtio device types
+"""
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+import sys
+import os
+
+sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scripts"))
+from qemu import QEMUMachine
+from avocado_qemu import Test
+
+# Virtio Device IDs:
+VIRTIO_NET = 1
+VIRTIO_BLOCK = 2
+VIRTIO_CONSOLE = 3
+VIRTIO_RNG = 4
+VIRTIO_BALLOON = 5
+VIRTIO_RPMSG = 7
+VIRTIO_SCSI = 8
+VIRTIO_9P = 9
+VIRTIO_RPROC_SERIAL = 11
+VIRTIO_CAIF = 12
+VIRTIO_GPU = 16
+VIRTIO_INPUT = 18
+VIRTIO_VSOCK = 19
+VIRTIO_CRYPTO = 20
+
+PCI_VENDOR_ID_REDHAT_QUMRANET = 0x1af4
+
+# Device IDs for legacy/transitional devices:
+PCI_LEGACY_DEVICE_IDS = {
+    VIRTIO_NET:     0x1000,
+    VIRTIO_BLOCK:   0x1001,
+    VIRTIO_BALLOON: 0x1002,
+    VIRTIO_CONSOLE: 0x1003,
+    VIRTIO_SCSI:    0x1004,
+    VIRTIO_RNG:     0x1005,
+    VIRTIO_9P:      0x1009,
+    VIRTIO_VSOCK:   0x1012,
+}
+
+def pci_modern_device_id(virtio_devid):
+    return virtio_devid + 0x1040
+
+def devtype_implements(vm, devtype, implements):
+    return devtype in [d['name'] for d in vm.command('qom-list-types', implements=implements)]
+
+def get_interfaces(vm, devtype, interfaces=['pci-express-device', 'conventional-pci-device']):
+    return [i for i in interfaces if devtype_implements(vm, devtype, i)]
+
+class VirtioVersionCheck(Test):
+    """
+    Check if virtio-version-specific device types result in the
+    same device tree created by `disable-modern` and
+    `disable-legacy`.
+
+    :avocado: enable
+    :avocado: tags=x86_64
+    """
+
+    # just in case there are failures, show larger diff:
+    maxDiff = 4096
+
+    def run_device(self, devtype, opts=None, machine='pc'):
+        """
+        Run QEMU with `-device DEVTYPE`, return device info from `query-pci`
+        """
+        with QEMUMachine(self.qemu_bin) as vm:
+            vm.set_machine(machine)
+            if opts:
+                devtype += ',' + opts
+            vm.add_args('-device', '%s,id=devfortest' % (devtype))
+            vm.add_args('-S')
+            vm.launch()
+
+            pcibuses = vm.command('query-pci')
+            alldevs = [dev for bus in pcibuses for dev in bus['devices']]
+            import pprint
+            pprint.pprint(alldevs)
+            devfortest = [dev for dev in alldevs
+                          if dev['qdev_id'] == 'devfortest']
+            return devfortest[0], get_interfaces(vm, devtype)
+
+
+    def assert_devids(self, dev, devid, non_transitional=False):
+        self.assertEqual(dev['id']['vendor'], PCI_VENDOR_ID_REDHAT_QUMRANET)
+        self.assertEqual(dev['id']['device'], devid)
+        if non_transitional:
+            self.assertTrue(0x1040 <= dev['id']['device'] <= 0x107f)
+            self.assertGreaterEqual(dev['id']['subsystem'], 0x40)
+
+    def check_all_variants(self, qemu_devtype, virtio_devid):
+        """Check if a virtio device type and its variants behave as expected"""
+        # Force modern mode:
+        dev_modern,_ = self.run_device(qemu_devtype,
+                                       'disable-modern=off,disable-legacy=on')
+        self.assert_devids(dev_modern, pci_modern_device_id(virtio_devid),
+                           non_transitional=True)
+
+        # <prefix>-non-transitional device types should be 100% equivalent to
+        # <prefix>,disable-modern=off,disable-legacy=on
+        dev_1_0,nt_ifaces = self.run_device('%s-non-transitional' % (qemu_devtype))
+        self.assertEqual(dev_modern, dev_1_0)
+
+        # Force transitional mode:
+        dev_trans,_ = self.run_device(qemu_devtype,
+                                      'disable-modern=off,disable-legacy=off')
+        self.assert_devids(dev_trans, PCI_LEGACY_DEVICE_IDS[virtio_devid])
+
+        # Force legacy mode:
+        dev_legacy,_ = self.run_device(qemu_devtype,
+                                       'disable-modern=on,disable-legacy=off')
+        self.assert_devids(dev_legacy, PCI_LEGACY_DEVICE_IDS[virtio_devid])
+
+        # No options: default to transitional on PC machine-type:
+        no_opts_pc,generic_ifaces = self.run_device(qemu_devtype)
+        self.assertEqual(dev_trans, no_opts_pc)
+
+        #TODO: check if plugging on a PCI Express bus will make the
+        #      device non-transitional
+        #no_opts_q35 = self.run_device(qemu_devtype, machine='q35')
+        #self.assertEqual(dev_modern, no_opts_q35)
+
+        # <prefix>-transitional device types should be 100% equivalent to
+        # <prefix>,disable-modern=off,disable-legacy=off
+        dev_trans,trans_ifaces = self.run_device('%s-transitional' % (qemu_devtype))
+        self.assertEqual(dev_trans, dev_trans)
+
+        # ensure the interface information is correct:
+        self.assertIn('conventional-pci-device', generic_ifaces)
+        self.assertIn('pci-express-device', generic_ifaces)
+
+        self.assertIn('conventional-pci-device', nt_ifaces)
+        self.assertIn('pci-express-device', nt_ifaces)
+
+        self.assertIn('conventional-pci-device', trans_ifaces)
+        self.assertNotIn('pci-express-device', trans_ifaces)
+
+
+    def test_conventional_devs(self):
+        self.check_all_variants('virtio-net-pci', VIRTIO_NET)
+        # virtio-blk requires 'driver' parameter
+        #self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
+        self.check_all_variants('virtio-serial-pci', VIRTIO_CONSOLE)
+        self.check_all_variants('virtio-rng-pci', VIRTIO_RNG)
+        self.check_all_variants('virtio-balloon-pci', VIRTIO_BALLOON)
+        self.check_all_variants('virtio-scsi-pci', VIRTIO_SCSI)
+        # virtio-9p requires 'fsdev' parameter
+        #self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
+
+    def check_modern_only(self, qemu_devtype, virtio_devid):
+        """Check if a modern-only virtio device type behaves as expected"""
+        # Force modern mode:
+        dev_modern,_ = self.run_device(qemu_devtype,
+                                       'disable-modern=off,disable-legacy=on')
+        self.assert_devids(dev_modern, pci_modern_device_id(virtio_devid),
+                           non_transitional=True)
+
+        # No options: should be modern anyway
+        dev_no_opts,ifaces = self.run_device(qemu_devtype)
+        self.assertEqual(dev_modern, dev_no_opts)
+
+        self.assertIn('conventional-pci-device', ifaces)
+        self.assertIn('pci-express-device', ifaces)
+
+    def test_modern_only_devs(self):
+        self.check_modern_only('virtio-vga', VIRTIO_GPU)
+        self.check_modern_only('virtio-gpu-pci', VIRTIO_GPU)
+        self.check_modern_only('virtio-mouse-pci', VIRTIO_INPUT)
+        self.check_modern_only('virtio-tablet-pci', VIRTIO_INPUT)
+        self.check_modern_only('virtio-keyboard-pci', VIRTIO_INPUT)
-- 
2.18.0.rc1.1.g3f1ff2140
