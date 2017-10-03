Received: from eggs.gnu.org ([2001:4830:134:3::10]:51601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dzMcN-0005QN-Ts
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dzMcI-0000bp-R7
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:48:11 -0400
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Tue,  3 Oct 2017 15:47:40 +0300
Message-Id: <1507034861-4661-2-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 1/2] virtio: introduce `query-virtio' QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org

The command is intended for gathering virtio information such as status,
feature bits, negotiation status. It is convenient and useful for debug
purpose.

The commands returns generic virtio information for virtio such as
common feature names and status bits names and information for all
attached to current machine devices.

To retrieve names of device-specific features `get_feature_name'
callback in VirtioDeviceClass also was introduced.

Cc: Denis V. Lunev <den@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 hw/block/virtio-blk.c       |  21 +++++++++
 hw/char/virtio-serial-bus.c |  15 +++++++
 hw/display/virtio-gpu.c     |  13 ++++++
 hw/net/virtio-net.c         |  35 +++++++++++++++
 hw/scsi/virtio-scsi.c       |  16 +++++++
 hw/virtio/Makefile.objs     |   2 +
 hw/virtio/virtio-balloon.c  |  15 +++++++
 hw/virtio/virtio-stub.c     |   9 ++++
 hw/virtio/virtio.c          | 101 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h  |   2 +
 qapi-schema.json            |   1 +
 qapi/virtio.json            |  94 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 324 insertions(+)
 create mode 100644 hw/virtio/virtio-stub.c
 create mode 100644 qapi/virtio.json

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 05d1440..c77f651 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1017,6 +1017,26 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_blk_get_feature_name(VirtIODevice *vdev,
+                                               unsigned feature)
+{
+    static const char *names[] = {
+        [VIRTIO_BLK_F_BARRIER] = "barrier",
+        [VIRTIO_BLK_F_SIZE_MAX] = "size_max",
+        [VIRTIO_BLK_F_SEG_MAX] = "seg_max",
+        [VIRTIO_BLK_F_RO] = "ro",
+        [VIRTIO_BLK_F_BLK_SIZE] = "blk_size",
+        [VIRTIO_BLK_F_SCSI] = "scsi",
+        [VIRTIO_BLK_F_TOPOLOGY] = "topology",
+        [VIRTIO_BLK_F_FLUSH] = "flush",
+        [VIRTIO_BLK_F_MQ] = "mq",
+    };
+    if (feature >= ARRAY_SIZE(names)) {
+        return NULL;
+    }
+    return names[feature];
+}
+
 static void virtio_blk_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1030,6 +1050,7 @@ static void virtio_blk_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_blk_update_config;
     vdc->set_config = virtio_blk_set_config;
     vdc->get_features = virtio_blk_get_features;
+    vdc->get_feature_name = virtio_blk_get_feature_name;
     vdc->set_status = virtio_blk_set_status;
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..41f4466 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1156,6 +1156,20 @@ static Property virtio_serial_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_serial_get_feature_name(VirtIODevice *vdev,
+                                                  unsigned feature)
+{
+    static const char *names[] = {
+        [VIRTIO_CONSOLE_F_SIZE] = "size",
+        [VIRTIO_CONSOLE_F_MULTIPORT] = "multiport",
+        [VIRTIO_CONSOLE_F_EMERG_WRITE] = "emerg_write",
+    };
+    if (feature >= ARRAY_SIZE(names)) {
+        return NULL;
+    }
+    return names[feature];
+}
+
 static void virtio_serial_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1170,6 +1184,7 @@ static void virtio_serial_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_serial_device_realize;
     vdc->unrealize = virtio_serial_device_unrealize;
     vdc->get_features = get_features;
+    vdc->get_feature_name = virtio_serial_get_feature_name;
     vdc->get_config = get_config;
     vdc->set_config = set_config;
     vdc->set_status = set_status;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3a8f1e1..49aa214 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1307,6 +1307,18 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_gpu_get_feature_name(VirtIODevice *vdev,
+                                               unsigned feature)
+{
+    static const char *names[] = {
+        [VIRTIO_GPU_F_VIRGL] = "virgl",
+    };
+    if (feature >= ARRAY_SIZE(names)) {
+        return NULL;
+    }
+    return names[feature];
+}
+
 static void virtio_gpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1317,6 +1329,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_gpu_get_config;
     vdc->set_config = virtio_gpu_set_config;
     vdc->get_features = virtio_gpu_get_features;
+    vdc->get_feature_name = virtio_gpu_get_feature_name;
     vdc->set_features = virtio_gpu_set_features;
 
     vdc->reset = virtio_gpu_reset;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 148071a..f4d20a85 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2154,6 +2154,40 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_net_get_feature_name(VirtIODevice *vdev,
+                                               unsigned feature)
+{
+    static const char *names[] = {
+        [VIRTIO_NET_F_CSUM] = "csum",
+        [VIRTIO_NET_F_GUEST_CSUM] = "guest_csum",
+        [VIRTIO_NET_F_CTRL_GUEST_OFFLOADS] = "ctrl_guest_offloads",
+        [VIRTIO_NET_F_MTU] = "mtu",
+        [VIRTIO_NET_F_MAC] = "mac",
+        [VIRTIO_NET_F_GSO] = "gso",
+        [VIRTIO_NET_F_GUEST_TSO4] = "guest_tso4",
+        [VIRTIO_NET_F_GUEST_TSO6] = "guest_tso6",
+        [VIRTIO_NET_F_GUEST_ECN] = "guest_ecn",
+        [VIRTIO_NET_F_GUEST_UFO] = "guest_ufo",
+        [VIRTIO_NET_F_HOST_TSO4] = "host_tso4",
+        [VIRTIO_NET_F_HOST_TSO6] = "host_tso6",
+        [VIRTIO_NET_F_HOST_ECN] = "host_ecn",
+        [VIRTIO_NET_F_HOST_UFO] = "host_ufo",
+        [VIRTIO_NET_F_MRG_RXBUF] = "mrg_rxbuf",
+        [VIRTIO_NET_F_STATUS] = "status",
+        [VIRTIO_NET_F_CTRL_VQ] = "ctrl_vq",
+        [VIRTIO_NET_F_CTRL_RX] = "ctrl_rx",
+        [VIRTIO_NET_F_CTRL_VLAN] = "ctrl_vlan",
+        [VIRTIO_NET_F_CTRL_RX_EXTRA] = "ctrl_rx_extra",
+        [VIRTIO_NET_F_GUEST_ANNOUNCE] = "guest_announce",
+        [VIRTIO_NET_F_MQ] = "mq",
+        [VIRTIO_NET_F_CTRL_MAC_ADDR] = "ctrl_mac_addr",
+    };
+    if (feature >= ARRAY_SIZE(names)) {
+        return NULL;
+    }
+    return names[feature];
+}
+
 static void virtio_net_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2169,6 +2203,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->get_features = virtio_net_get_features;
     vdc->set_features = virtio_net_set_features;
     vdc->bad_features = virtio_net_bad_features;
+    vdc->get_feature_name = virtio_net_get_feature_name;
     vdc->reset = virtio_net_reset;
     vdc->set_status = virtio_net_set_status;
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa9971..b53cf8b 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -942,6 +942,21 @@ static const VMStateDescription vmstate_virtio_scsi = {
     },
 };
 
+static const char *virtio_scsi_get_feature_name(VirtIODevice *vdev,
+                                                unsigned feature)
+{
+    static const char *names[] = {
+        [VIRTIO_SCSI_F_INOUT] = "inout",
+        [VIRTIO_SCSI_F_HOTPLUG] = "hotplug",
+        [VIRTIO_SCSI_F_CHANGE] = "change",
+        [VIRTIO_SCSI_F_T10_PI] = "t10_pi",
+    };
+    if (feature >= ARRAY_SIZE(names)) {
+        return NULL;
+    }
+    return names[feature];
+}
+
 static void virtio_scsi_common_class_init(ObjectClass *klass, void *data)
 {
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
@@ -964,6 +979,7 @@ static void virtio_scsi_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = virtio_scsi_device_unrealize;
     vdc->set_config = virtio_scsi_set_config;
     vdc->get_features = virtio_scsi_get_features;
+    vdc->get_feature_name = virtio_scsi_get_feature_name;
     vdc->reset = virtio_scsi_reset;
     vdc->start_ioeventfd = virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd = virtio_scsi_dataplane_stop;
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 765d363..73f3527 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -9,6 +9,8 @@ obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 obj-y += virtio-crypto.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
+else
+obj-y += virtio-stub.o
 endif
 
 common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 37cde38..b396eb1 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -509,6 +509,20 @@ static Property virtio_balloon_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_balloon_get_feature_name(VirtIODevice *vdev,
+                                                   unsigned feature)
+{
+    static const char *names[] = {
+        [VIRTIO_BALLOON_F_MUST_TELL_HOST] = "must_tell_host",
+        [VIRTIO_BALLOON_F_STATS_VQ] = "stats_vq",
+        [VIRTIO_BALLOON_F_DEFLATE_ON_OOM] = "deflate_on_oom",
+    };
+    if (feature >= ARRAY_SIZE(names)) {
+        return NULL;
+    }
+    return names[feature];
+}
+
 static void virtio_balloon_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -523,6 +537,7 @@ static void virtio_balloon_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_balloon_get_config;
     vdc->set_config = virtio_balloon_set_config;
     vdc->get_features = virtio_balloon_get_features;
+    vdc->get_feature_name = virtio_balloon_get_feature_name;
     vdc->set_status = virtio_balloon_set_status;
     vdc->vmsd = &vmstate_virtio_balloon_device;
 }
diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
new file mode 100644
index 0000000..51a99de
--- /dev/null
+++ b/hw/virtio/virtio-stub.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "qmp-commands.h"
+#include "qapi/qmp/qerror.h"
+
+VirtioInfo *qmp_query_virtio(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3129d25..f182aa7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qmp-commands.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "trace.h"
@@ -2665,6 +2666,106 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
     return virtio_bus_ioeventfd_enabled(vbus);
 }
 
+static void virtio_info_bit_list_add(VirtioInfoBitList **list, unsigned bit,
+    const char *name)
+{
+    VirtioInfoBitList *info = g_new0(VirtioInfoBitList, 1);
+
+    info->next = *list;
+    *list = info;
+
+    info->value = g_new0(VirtioInfoBit, 1);
+    info->value->bit = bit;
+    info->value->name = g_strdup(name);
+}
+
+static void virtio_info_device_list_add(VirtioInfoDeviceList **list,
+                                        VirtIODevice *vdev)
+{
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    VirtioInfoDeviceList *device;
+    unsigned idx;
+
+    device = g_new0(VirtioInfoDeviceList, 1);
+    device->value = g_new0(VirtioInfoDevice, 1);
+    device->next = *list;
+
+    *list = device;
+
+    device->value->qom_path = object_get_canonical_path(OBJECT(vdev));
+    device->value->host_features = vdev->host_features;
+    device->value->guest_features = vdev->guest_features;
+    device->value->status = vdev->status;
+
+    if (!vdc->get_feature_name) {
+        return;
+    }
+
+    for (idx = 64; idx--; ) {
+        const char *name = vdc->get_feature_name(vdev, idx);
+        if (!name) {
+            continue;
+        }
+        virtio_info_bit_list_add(&device->value->feature_names, idx, name);
+    }
+}
+
+static void qmp_query_virtio_recursive(VirtioInfo *info, BusState *bus)
+{
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev = kid->child;
+        BusState *child;
+
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_DEVICE)) {
+            virtio_info_device_list_add(&info->devices, VIRTIO_DEVICE(dev));
+        }
+        QLIST_FOREACH(child, &dev->child_bus, sibling) {
+            qmp_query_virtio_recursive(info, child);
+        }
+    }
+}
+
+VirtioInfo *qmp_query_virtio(Error **errp)
+{
+    BusState *bus = sysbus_get_default();
+    VirtioInfo *info = g_new0(VirtioInfo, 1);
+
+    /* Common features */
+    virtio_info_bit_list_add(&info->feature_names, VIRTIO_F_IOMMU_PLATFORM,
+                             "iommu_platform");
+    virtio_info_bit_list_add(&info->feature_names, VIRTIO_F_VERSION_1,
+                             "version_1");
+    virtio_info_bit_list_add(&info->feature_names, VIRTIO_RING_F_EVENT_IDX,
+                             "event_idx");
+    virtio_info_bit_list_add(&info->feature_names, VIRTIO_RING_F_INDIRECT_DESC,
+                             "indirect_desc");
+    virtio_info_bit_list_add(&info->feature_names, VIRTIO_F_ANY_LAYOUT,
+                             "any_layout");
+    virtio_info_bit_list_add(&info->feature_names, VIRTIO_F_NOTIFY_ON_EMPTY,
+                             "notify_on_empty");
+
+    /* Status bits */
+    virtio_info_bit_list_add(&info->status_names, 7 /* VIRTIO_CONFIG_S_FAILED */,
+                             "failed");
+    virtio_info_bit_list_add(&info->status_names, 6 /* VIRTIO_CONFIG_S_NEEDS_RESET */,
+                             "needs_reset");
+    virtio_info_bit_list_add(&info->status_names, 3 /* VIRTIO_CONFIG_S_FEATURES_OK */,
+                             "features_ok");
+    virtio_info_bit_list_add(&info->status_names, 2 /* VIRTIO_CONFIG_S_DRIVER_OK */,
+                             "driver_ok");
+    virtio_info_bit_list_add(&info->status_names, 1 /* VIRTIO_CONFIG_S_DRIVER */,
+                             "driver");
+    virtio_info_bit_list_add(&info->status_names, 0 /* VIRTIO_CONFIG_S_ACKNOWLEDGE */,
+                             "acknowledge");
+
+    if (bus) {
+        qmp_query_virtio_recursive(info, bus);
+    }
+    return info;
+}
+
 static const TypeInfo virtio_device_info = {
     .name = TYPE_VIRTIO_DEVICE,
     .parent = TYPE_DEVICE,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 80c45c3..3ea2cd0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -141,6 +141,8 @@ typedef struct VirtioDeviceClass {
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
     const VMStateDescription *vmsd;
+    /* Get the name of device specific feature */
+    const char *(*get_feature_name)(VirtIODevice *vdev, unsigned feature);
 } VirtioDeviceClass;
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
diff --git a/qapi-schema.json b/qapi-schema.json
index a3ba1c9..78762b1 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -92,6 +92,7 @@
 { 'include': 'qapi/transaction.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
+{ 'include': 'qapi/virtio.json' }
 
 ##
 # = Miscellanea
diff --git a/qapi/virtio.json b/qapi/virtio.json
new file mode 100644
index 0000000..b8b52ac
--- /dev/null
+++ b/qapi/virtio.json
@@ -0,0 +1,94 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = Virtio devices
+##
+
+{ 'include': 'common.json' }
+
+##
+# @VirtioInfoBit:
+#
+# Named virtio bit
+#
+# @bit: bit number
+#
+# @name: bit name
+#
+# Since: 2.11.0
+#
+##
+{
+    'struct': 'VirtioInfoBit',
+    'data': {
+        'bit': 'uint64',
+        'name': 'str'
+    }
+}
+
+##
+# @VirtioInfoDevice:
+#
+# Information about specific virtio device
+#
+# @qom_path: QOM path of the device
+#
+# @feature-names: names of device-specific features
+#
+# @host-features: bitmask of features, provided by devices
+#
+# @guest-features: bitmask of features, acknowledged by guest
+#
+# @status: virtio device status bitmask
+#
+# Since: 2.11.0
+#
+##
+{
+    'struct': 'VirtioInfoDevice',
+    'data': {
+        'qom_path': 'str',
+        'feature-names': ['VirtioInfoBit'],
+        'host-features': 'uint64',
+        'guest-features': 'uint64',
+        'status': 'uint64'
+    }
+}
+
+##
+# @VirtioInfo:
+#
+# Information about virtio devices
+#
+# @feature-names: names of common virtio features
+#
+# @status-names: names of bits which represents virtio device status
+#
+# @devices: list of per-device virtio information
+#
+# Since: 2.11.0
+#
+##
+{
+    'struct': 'VirtioInfo',
+    'data': {
+        'feature-names': ['VirtioInfoBit'],
+        'status-names': ['VirtioInfoBit'],
+        'devices': ['VirtioInfoDevice']
+    }
+}
+
+
+##
+# @query-virtio:
+#
+# Returns generic and per-device virtio information
+#
+# Since: 2.11.0
+#
+##
+{
+    'command': 'query-virtio',
+    'returns': 'VirtioInfo'
+}
-- 
2.1.4
