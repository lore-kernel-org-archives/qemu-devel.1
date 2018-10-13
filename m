Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gBA4r-0003e6-A2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 22:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gBA4o-0002hs-1B
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 22:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gBA4n-0002eU-P0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 22:54:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 12 Oct 2018 23:54:35 -0300
Message-Id: <20181013025435.25785-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: Provide version-specific variants of
 virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The current virtio-*-pci device types actually represent 3
different types of devices:
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
where they were is plugged.

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
- virtio-*-pci-0.9: legacy virtio device
  - Supports Conventional PCI buses only, because
    it has a PIO BAR
- virtio-*-pci-1.0-transitional: virtio-1.0 device supporting legacy drivers
  - Supports Conventional PCI buses only, because
    it has a PIO BAR
- virtio-*-pci-1.0: modern-only
  - Supports both Conventional PCI and PCI Express buses

All the types above will inherit from an abstract
"virtio-*-pci-base" type, so existing code that doesn't care
about the virtio version can use "virtio-*-pci-base" on type
casts.

A simple test script (tests/acceptance/virtio_version.py) is
included, to check if the new device types are equivalent to
using the `disable-legacy` and `disable-modern` options.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Reference to previous discussion that originated this idea:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg558389.html
---
 hw/virtio/virtio-pci.h             |  93 +++++++++---
 hw/display/virtio-gpu-pci.c        |   8 +-
 hw/display/virtio-vga.c            |  11 +-
 hw/virtio/virtio-crypto-pci.c      |   8 +-
 hw/virtio/virtio-pci.c             | 225 +++++++++++++++++++++--------
 tests/acceptance/virtio_version.py | 138 ++++++++++++++++++
 6 files changed, 390 insertions(+), 93 deletions(-)
 create mode 100644 tests/acceptance/virtio_version.py

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..f1cfb60277 100644
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
 
@@ -352,9 +362,13 @@ struct VirtIOInputPCI {
 };
 
 #define TYPE_VIRTIO_INPUT_HID_PCI "virtio-input-hid-pci"
-#define TYPE_VIRTIO_KEYBOARD_PCI  "virtio-keyboard-pci"
-#define TYPE_VIRTIO_MOUSE_PCI     "virtio-mouse-pci"
-#define TYPE_VIRTIO_TABLET_PCI    "virtio-tablet-pci"
+
+#define TYPE_VIRTIO_KEYBOARD_PCI_PREFIX  "virtio-keyboard-pci"
+#define TYPE_VIRTIO_KEYBOARD_PCI (TYPE_VIRTIO_KEYBOARD_PCI_PREFIX "-base")
+#define TYPE_VIRTIO_MOUSE_PCI_PREFIX     "virtio-mouse-pci"
+#define TYPE_VIRTIO_MOUSE_PCI (TYPE_VIRTIO_MOUSE_PCI_PREFIX "-base")
+#define TYPE_VIRTIO_TABLET_PCI_PREFIX    "virtio-tablet-pci"
+#define TYPE_VIRTIO_TABLET_PCI (TYPE_VIRTIO_TABLET_PCI_PREFIX "-base")
 #define VIRTIO_INPUT_HID_PCI(obj) \
         OBJECT_CHECK(VirtIOInputHIDPCI, (obj), TYPE_VIRTIO_INPUT_HID_PCI)
 
@@ -365,7 +379,8 @@ struct VirtIOInputHIDPCI {
 
 #ifdef CONFIG_LINUX
 
-#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
+#define TYPE_VIRTIO_INPUT_HOST_PCI_PREFIX "virtio-input-host-pci"
+#define TYPE_VIRTIO_INPUT_HOST_PCI (TYPE_VIRTIO_INPUT_HOST "-base")
 #define VIRTIO_INPUT_HOST_PCI(obj) \
         OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_PCI)
 
@@ -379,7 +394,8 @@ struct VirtIOInputHostPCI {
 /*
  * virtio-gpu-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_GPU_PCI "virtio-gpu-pci"
+#define TYPE_VIRTIO_GPU_PCI_PREFIX "virtio-gpu-pci"
+#define TYPE_VIRTIO_GPU_PCI (TYPE_VIRTIO_GPU_PCI_PREFIX "-base")
 #define VIRTIO_GPU_PCI(obj) \
         OBJECT_CHECK(VirtIOGPUPCI, (obj), TYPE_VIRTIO_GPU_PCI)
 
@@ -392,7 +408,8 @@ struct VirtIOGPUPCI {
 /*
  * vhost-vsock-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VHOST_VSOCK_PCI "vhost-vsock-pci"
+#define TYPE_VHOST_VSOCK_PCI_PREFIX "vhost-vsock-pci"
+#define TYPE_VHOST_VSOCK_PCI (TYPE_VHOST_VSOCK_PCI_PREFIX "-base")
 #define VHOST_VSOCK_PCI(obj) \
         OBJECT_CHECK(VHostVSockPCI, (obj), TYPE_VHOST_VSOCK_PCI)
 
@@ -405,7 +422,8 @@ struct VHostVSockPCI {
 /*
  * virtio-crypto-pci: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_CRYPTO_PCI "virtio-crypto-pci"
+#define TYPE_VIRTIO_CRYPTO_PCI_PREFIX "virtio-crypto-pci"
+#define TYPE_VIRTIO_CRYPTO_PCI (TYPE_VIRTIO_CRYPTO_PCI_PREFIX "-base")
 #define VIRTIO_CRYPTO_PCI(obj) \
         OBJECT_CHECK(VirtIOCryptoPCI, (obj), TYPE_VIRTIO_CRYPTO_PCI)
 
@@ -417,4 +435,45 @@ struct VirtIOCryptoPCI {
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
 
+/**
+ * VirtioPCIDeviceTypeInfo:
+ *
+ * Template for virtio PCI device types.  See virtio_register_types()
+ * for details.
+ */
+typedef struct VirtioPCIDeviceTypeInfo {
+    /* Prefix for the subclass names */
+    const char *name_prefix;
+    /* Parent type.  If NULL, TYPE_VIRTIO_PCI is used */
+    const char *parent;
+    /*
+     * If modern_only is true, only <name_prefix> and <name_prefix>-1.0
+     * types will be registered.
+     */
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
+ * in 4 flavors:
+ * - <name_prefix>-0.9: legacy virtio devices
+ *   - Supports Conventional PCI buses only
+ * - <name_prefix>-1.0-transitional: modern device supporting legacy drivers
+ *   - Supports Conventional PCI buses only
+ * - <name_prefix>-1.0: modern-only
+ *   - Supports Conventional PCI and PCI Express buses
+ * - <name_prefix>: virtio version configurable, legacy driver support
+ *                  automatically selected when device is plugged
+ *   - Supports Conventional PCI and PCI Express buses
+ *
+ * All the types above will inherit from "<name_prefix>-base", so generic
+ * code can use "<name_prefix>-base" on type casts.
+ */
+void virtio_register_types(const VirtioPCIDeviceTypeInfo *t);
+
 #endif
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index cece4aa495..a0fb6e46da 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -69,9 +69,9 @@ static void virtio_gpu_initfn(Object *obj)
                                 TYPE_VIRTIO_GPU);
 }
 
-static const TypeInfo virtio_gpu_pci_info = {
-    .name = TYPE_VIRTIO_GPU_PCI,
-    .parent = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_gpu_pci_info = {
+    .name_prefix = TYPE_VIRTIO_GPU_PCI_PREFIX,
+    .modern_only = true,
     .instance_size = sizeof(VirtIOGPUPCI),
     .instance_init = virtio_gpu_initfn,
     .class_init = virtio_gpu_pci_class_init,
@@ -79,6 +79,6 @@ static const TypeInfo virtio_gpu_pci_info = {
 
 static void virtio_gpu_pci_register_types(void)
 {
-    type_register_static(&virtio_gpu_pci_info);
+    virtio_register_types(&virtio_gpu_pci_info);
 }
 type_init(virtio_gpu_pci_register_types)
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index ab2e369b28..07d6e4b247 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -8,7 +8,8 @@
 /*
  * virtio-vga: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_VGA "virtio-vga"
+#define TYPE_VIRTIO_VGA_PREFIX "virtio-vga"
+#define TYPE_VIRTIO_VGA (TYPE_VIRTIO_VGA_PREFIX "-base")
 #define VIRTIO_VGA(obj) \
         OBJECT_CHECK(VirtIOVGA, (obj), TYPE_VIRTIO_VGA)
 
@@ -207,9 +208,9 @@ static void virtio_vga_inst_initfn(Object *obj)
                                 TYPE_VIRTIO_GPU);
 }
 
-static TypeInfo virtio_vga_info = {
-    .name          = TYPE_VIRTIO_VGA,
-    .parent        = TYPE_VIRTIO_PCI,
+static VirtioPCIDeviceTypeInfo virtio_vga_info = {
+    .name_prefix   = TYPE_VIRTIO_VGA_PREFIX,
+    .modern_only   = true,
     .instance_size = sizeof(struct VirtIOVGA),
     .instance_init = virtio_vga_inst_initfn,
     .class_init    = virtio_vga_class_init,
@@ -217,7 +218,7 @@ static TypeInfo virtio_vga_info = {
 
 static void virtio_vga_register_types(void)
 {
-    type_register_static(&virtio_vga_info);
+    virtio_register_types(&virtio_vga_info);
 }
 
 type_init(virtio_vga_register_types)
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index bf64996e48..1de0f88c51 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -64,9 +64,9 @@ static void virtio_crypto_initfn(Object *obj)
                                 TYPE_VIRTIO_CRYPTO);
 }
 
-static const TypeInfo virtio_crypto_pci_info = {
-    .name          = TYPE_VIRTIO_CRYPTO_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_crypto_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_CRYPTO_PCI_PREFIX,
+    .modern_only   = true,
     .instance_size = sizeof(VirtIOCryptoPCI),
     .instance_init = virtio_crypto_initfn,
     .class_init    = virtio_crypto_pci_class_init,
@@ -74,6 +74,6 @@ static const TypeInfo virtio_crypto_pci_info = {
 
 static void virtio_crypto_pci_register_types(void)
 {
-    type_register_static(&virtio_crypto_pci_info);
+    virtio_register_types(&virtio_crypto_pci_info);
 }
 type_init(virtio_crypto_pci_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..6e2141e009 100644
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
@@ -1940,12 +1936,119 @@ static const TypeInfo virtio_pci_info = {
     .class_size    = sizeof(VirtioPCIClass),
     .abstract      = true,
     .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     },
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
+static void virtio_pci_0_9_instance_init(Object *obj)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(obj);
+
+    proxy->disable_legacy = ON_OFF_AUTO_OFF;
+    proxy->disable_modern = true;
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
+void virtio_register_types(const VirtioPCIDeviceTypeInfo *t)
+{
+    const TypeInfo base_type_info = {
+        .name          = g_strdup_printf("%s-base", t->name_prefix),
+        .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
+        .instance_size = t->instance_size,
+        .instance_init = t->instance_init,
+        .class_init    = t->class_init,
+        .abstract      = true,
+    };
+
+    const TypeInfo generic_type_info = {
+        .name          = t->name_prefix,
+        .parent        = base_type_info.name,
+        .class_init    = virtio_pci_generic_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { INTERFACE_PCIE_DEVICE },
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        },
+    };
+
+    const TypeInfo virtio_1_0_type_info = {
+        .name          = g_strdup_printf("%s-1.0", t->name_prefix),
+        .parent        = base_type_info.name,
+        .instance_init = virtio_pci_1_0_instance_init,
+        .interfaces = (InterfaceInfo[]) {
+            { INTERFACE_PCIE_DEVICE },
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        },
+    };
+
+    const TypeInfo virtio_1_0_transitional_type_info = {
+        .name          = g_strdup_printf("%s-1.0-transitional", t->name_prefix),
+        .parent        = base_type_info.name,
+        .instance_init = virtio_pci_transitional_instance_init,
+        .interfaces = (InterfaceInfo[]) {
+            /*
+             * Transitional virtio devices work only as conventional PCI devices
+             * because they require PIO ports.
+             */
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        },
+    };
+
+    const TypeInfo virtio_0_9_type_info = {
+        .name          = g_strdup_printf("%s-0.9", t->name_prefix),
+        .parent        = base_type_info.name,
+        .instance_init = virtio_pci_0_9_instance_init,
+        .interfaces = (InterfaceInfo[]) {
+            /*
+             * Transitional virtio devices work only as conventional PCI devices
+             * because they require PIO ports.
+             */
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { }
+        },
+    };
+
+    type_register(&base_type_info);
+    type_register(&generic_type_info);
+    type_register(&virtio_1_0_type_info);
+    if (!t->modern_only) {
+        type_register(&virtio_1_0_transitional_type_info);
+        type_register(&virtio_0_9_type_info);
+    }
+}
+
 /* virtio-blk-pci */
 
 static Property virtio_blk_pci_properties[] = {
@@ -1995,9 +2098,8 @@ static void virtio_blk_pci_instance_init(Object *obj)
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
@@ -2051,9 +2153,8 @@ static void vhost_user_blk_pci_instance_init(Object *obj)
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
@@ -2119,9 +2220,8 @@ static void virtio_scsi_pci_instance_init(Object *obj)
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
@@ -2174,9 +2274,8 @@ static void vhost_scsi_pci_instance_init(Object *obj)
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
@@ -2229,9 +2328,8 @@ static void vhost_user_scsi_pci_instance_init(Object *obj)
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
@@ -2277,9 +2375,8 @@ static void vhost_vsock_pci_instance_init(Object *obj)
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
@@ -2334,9 +2431,8 @@ static void virtio_balloon_pci_instance_init(Object *obj)
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
@@ -2407,9 +2503,8 @@ static void virtio_serial_pci_instance_init(Object *obj)
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
@@ -2462,9 +2557,8 @@ static void virtio_net_pci_instance_init(Object *obj)
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
@@ -2513,9 +2607,8 @@ static void virtio_rng_initfn(Object *obj)
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
@@ -2605,25 +2698,28 @@ static const TypeInfo virtio_input_hid_pci_info = {
     .abstract      = true,
 };
 
-static const TypeInfo virtio_keyboard_pci_info = {
-    .name          = TYPE_VIRTIO_KEYBOARD_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_keyboard_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_KEYBOARD_PCI_PREFIX,
     .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .modern_only   = true,
     .class_init    = virtio_input_hid_kbd_pci_class_init,
     .instance_size = sizeof(VirtIOInputHIDPCI),
     .instance_init = virtio_keyboard_initfn,
 };
 
-static const TypeInfo virtio_mouse_pci_info = {
-    .name          = TYPE_VIRTIO_MOUSE_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_mouse_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_MOUSE_PCI_PREFIX,
     .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .modern_only   = true,
     .class_init    = virtio_input_hid_mouse_pci_class_init,
     .instance_size = sizeof(VirtIOInputHIDPCI),
     .instance_init = virtio_mouse_initfn,
 };
 
-static const TypeInfo virtio_tablet_pci_info = {
-    .name          = TYPE_VIRTIO_TABLET_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_tablet_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_TABLET_PCI_PREFIX,
     .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .modern_only   = true,
     .instance_size = sizeof(VirtIOInputHIDPCI),
     .instance_init = virtio_tablet_initfn,
 };
@@ -2637,8 +2733,8 @@ static void virtio_host_initfn(Object *obj)
                                 TYPE_VIRTIO_INPUT_HOST);
 }
 
-static const TypeInfo virtio_host_pci_info = {
-    .name          = TYPE_VIRTIO_INPUT_HOST_PCI,
+static const VirtioPCIDeviceTypeInfo virtio_host_pci_info = {
+    .name_prefix   = TYPE_VIRTIO_INPUT_HOST_PCI_PREFIX,
     .parent        = TYPE_VIRTIO_INPUT_PCI,
     .instance_size = sizeof(VirtIOInputHostPCI),
     .instance_init = virtio_host_initfn,
@@ -2692,36 +2788,39 @@ static const TypeInfo virtio_pci_bus_info = {
 
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
+    virtio_register_types(&virtio_rng_pci_info);
+    virtio_register_types(&virtio_keyboard_pci_info);
+    virtio_register_types(&virtio_mouse_pci_info);
+    virtio_register_types(&virtio_tablet_pci_info);
 #ifdef CONFIG_LINUX
-    type_register_static(&virtio_host_pci_info);
+    virtio_register_types(&virtio_host_pci_info);
 #endif
-    type_register_static(&virtio_pci_bus_info);
-    type_register_static(&virtio_pci_info);
 #ifdef CONFIG_VIRTFS
-    type_register_static(&virtio_9p_pci_info);
+    virtio_register_types(&virtio_9p_pci_info);
 #endif
-    type_register_static(&virtio_blk_pci_info);
+    virtio_register_types(&virtio_blk_pci_info);
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    type_register_static(&vhost_user_blk_pci_info);
+    virtio_register_types(&vhost_user_blk_pci_info);
 #endif
-    type_register_static(&virtio_scsi_pci_info);
-    type_register_static(&virtio_balloon_pci_info);
-    type_register_static(&virtio_serial_pci_info);
-    type_register_static(&virtio_net_pci_info);
+    virtio_register_types(&virtio_scsi_pci_info);
+    virtio_register_types(&virtio_balloon_pci_info);
+    virtio_register_types(&virtio_serial_pci_info);
+    virtio_register_types(&virtio_net_pci_info);
 #ifdef CONFIG_VHOST_SCSI
-    type_register_static(&vhost_scsi_pci_info);
+    virtio_register_types(&vhost_scsi_pci_info);
 #endif
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    type_register_static(&vhost_user_scsi_pci_info);
+    virtio_register_types(&vhost_user_scsi_pci_info);
 #endif
 #ifdef CONFIG_VHOST_VSOCK
-    type_register_static(&vhost_vsock_pci_info);
+    virtio_register_types(&vhost_vsock_pci_info);
 #endif
 }
 
diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
new file mode 100644
index 0000000000..e1e0038530
--- /dev/null
+++ b/tests/acceptance/virtio_version.py
@@ -0,0 +1,138 @@
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
+    def run_device(self, devtype, opts=None):
+        """
+        Run QEMU with `-device DEVTYPE`, return device info from `query-pci`
+        """
+        with QEMUMachine(self.qemu_bin) as vm:
+            vm.set_machine('pc')
+            if opts:
+                devtype += ',' + opts
+            vm.add_args('-device', '%s,id=devfortest' % (devtype))
+            vm.add_args('-S')
+            vm.launch()
+
+            pcibuses = vm.command('query-pci')
+            alldevs = [dev for bus in pcibuses for dev in bus['devices']]
+            devfortest = [dev for dev in alldevs
+                          if dev['qdev_id'] == 'devfortest']
+            return devfortest[0]
+
+
+    def assert_devids(self, dev, devid, non_transitional=False):
+        self.assertEqual(dev['id']['vendor'], PCI_VENDOR_ID_REDHAT_QUMRANET)
+        self.assertEqual(dev['id']['device'], devid)
+        if non_transitional:
+            self.assertTrue(0x1040 <= dev['id']['device'] <= 0x107f)
+            self.assertGreaterEqual(dev['id']['subsystem'], 0x40)
+
+    def check_modern_variants(self, qemu_devtype, virtio_devid):
+        # Force modern mode:
+        dev_modern = self.run_device(qemu_devtype,
+                                     'disable-modern=off,disable-legacy=on')
+        self.assert_devids(dev_modern, pci_modern_device_id(virtio_devid),
+                           non_transitional=True)
+
+        dev_1_0 = self.run_device('%s-1.0' % (qemu_devtype))
+        self.assertEqual(dev_modern, dev_1_0)
+
+    def check_all_variants(self, qemu_devtype, virtio_devid):
+        self.check_modern_variants(qemu_devtype, virtio_devid)
+
+        # Force transitional mode:
+        dev_trans = self.run_device(qemu_devtype,
+                                    'disable-modern=off,disable-legacy=off')
+        self.assert_devids(dev_trans, PCI_LEGACY_DEVICE_IDS[virtio_devid])
+
+        # Force legacy mode:
+        dev_legacy = self.run_device(qemu_devtype,
+                                     'disable-modern=on,disable-legacy=off')
+        self.assert_devids(dev_legacy, PCI_LEGACY_DEVICE_IDS[virtio_devid])
+
+        # No options: default to transitional on PC machine-type:
+        dev_no_opts = self.run_device(qemu_devtype)
+        self.assertEqual(dev_trans, dev_no_opts)
+
+        # <prefix>-0.9 and <prefix>-1.0-transitional device types:
+        dev_0_9 = self.run_device('%s-0.9' % (qemu_devtype))
+        self.assertEqual(dev_legacy, dev_0_9)
+        dev_1_0_trans = self.run_device('%s-1.0-transitional' % (qemu_devtype))
+        self.assertEqual(dev_trans, dev_1_0_trans)
+
+    def testConventionalDevs(self):
+        self.check_all_variants('virtio-net-pci', VIRTIO_NET)
+        # virtio-blk requires 'driver' parameter
+        #self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
+        self.check_all_variants('virtio-serial-pci', VIRTIO_CONSOLE)
+        self.check_all_variants('virtio-rng-pci', VIRTIO_RNG)
+        self.check_all_variants('virtio-balloon-pci', VIRTIO_BALLOON)
+        self.check_all_variants('virtio-scsi-pci', VIRTIO_SCSI)
+
+        # virtio-9p requires 'fsdev' parameter
+        #self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
+        self.check_modern_variants('virtio-vga', VIRTIO_GPU)
+        self.check_modern_variants('virtio-gpu-pci', VIRTIO_GPU)
+        self.check_modern_variants('virtio-mouse-pci', VIRTIO_INPUT)
+        self.check_modern_variants('virtio-tablet-pci', VIRTIO_INPUT)
+        self.check_modern_variants('virtio-keyboard-pci', VIRTIO_INPUT)
-- 
2.18.0.rc1.1.g3f1ff2140
