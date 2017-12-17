Received: from eggs.gnu.org ([2001:4830:134:3::10]:55207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eQfUR-00059b-FD
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eQfUM-000343-Pv
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:24:51 -0500
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Sun, 17 Dec 2017 23:25:54 +0300
Message-Id: <1513542355-28203-2-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v6 1/2] virtio: introduce `query-virtio' QMP
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
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Denis V. Lunev" <den@virtuozzo.com>, Amit Shah <amit@kernel.org>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The command is intended for gathering virtio information such as status,
feature bits, negotiation status. It is convenient and useful for debug
purpose.

The commands returns generic virtio information for virtio such as
common feature names and status bits names and information for all
attached to current machine devices.

To retrieve names of device-specific features `tell_feature_name'
callback in VirtioDeviceClass also was introduced.

Cc: Denis V. Lunev <den@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 hw/block/virtio-blk.c       |  20 +++++++
 hw/char/virtio-serial-bus.c |  14 +++++
 hw/display/virtio-gpu.c     |  12 ++++
 hw/net/virtio-net.c         |  34 +++++++++++
 hw/scsi/virtio-scsi.c       |  15 +++++
 hw/virtio/Makefile.objs     |   3 +
 hw/virtio/virtio-balloon.c  |  14 +++++
 hw/virtio/virtio-qmp.c      | 134 ++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-stub.c     |   9 +++
 hw/virtio/virtio.c          |  41 ++++++++++++++
 include/hw/virtio/virtio.h  |   6 ++
 qapi-schema.json            |  70 +++++++++++++++++++++++
 12 files changed, 372 insertions(+)
 create mode 100644 hw/virtio/virtio-qmp.c
 create mode 100644 hw/virtio/virtio-stub.c

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 05d1440..2ffd949 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1017,6 +1017,25 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_blk_tell_feature_name(VirtIODevice *vdev,
+                                                unsigned fbit)
+{
+#define FBIT(fbit) case fbit: return #fbit
+    switch (fbit) {
+    FBIT(VIRTIO_BLK_F_BARRIER);
+    FBIT(VIRTIO_BLK_F_SIZE_MAX);
+    FBIT(VIRTIO_BLK_F_SEG_MAX);
+    FBIT(VIRTIO_BLK_F_RO);
+    FBIT(VIRTIO_BLK_F_BLK_SIZE);
+    FBIT(VIRTIO_BLK_F_SCSI);
+    FBIT(VIRTIO_BLK_F_TOPOLOGY);
+    FBIT(VIRTIO_BLK_F_FLUSH);
+    FBIT(VIRTIO_BLK_F_MQ);
+    }
+#undef FBIT
+    return NULL;
+}
+
 static void virtio_blk_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1030,6 +1049,7 @@ static void virtio_blk_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_blk_update_config;
     vdc->set_config = virtio_blk_set_config;
     vdc->get_features = virtio_blk_get_features;
+    vdc->tell_feature_name = virtio_blk_tell_feature_name;
     vdc->set_status = virtio_blk_set_status;
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..1d4678b 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1156,6 +1156,19 @@ static Property virtio_serial_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_serial_tell_feature_name(VirtIODevice *vdev,
+                                                   unsigned fbit)
+{
+#define FBIT(fbit) case fbit: return #fbit
+    switch (fbit) {
+    FBIT(VIRTIO_CONSOLE_F_SIZE);
+    FBIT(VIRTIO_CONSOLE_F_MULTIPORT);
+    FBIT(VIRTIO_CONSOLE_F_EMERG_WRITE);
+    };
+#undef FBIT
+    return NULL;
+}
+
 static void virtio_serial_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1170,6 +1183,7 @@ static void virtio_serial_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_serial_device_realize;
     vdc->unrealize = virtio_serial_device_unrealize;
     vdc->get_features = get_features;
+    vdc->tell_feature_name = virtio_serial_tell_feature_name;
     vdc->get_config = get_config;
     vdc->set_config = set_config;
     vdc->set_status = set_status;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 274e365..1906b68 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1317,6 +1317,17 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_gpu_tell_feature_name(VirtIODevice *vdev,
+                                                unsigned fbit)
+{
+#define FBIT(fbit) case fbit: return #fbit
+    switch (fbit) {
+    FBIT(VIRTIO_GPU_F_VIRGL);
+    };
+#undef FBIT
+    return NULL;
+}
+
 static void virtio_gpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1327,6 +1338,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_gpu_get_config;
     vdc->set_config = virtio_gpu_set_config;
     vdc->get_features = virtio_gpu_get_features;
+    vdc->tell_feature_name = virtio_gpu_tell_feature_name;
     vdc->set_features = virtio_gpu_set_features;
 
     vdc->reset = virtio_gpu_reset;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b0..0fbd055 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2163,6 +2163,39 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_net_tell_feature_name(VirtIODevice *vdev,
+                                               unsigned fbit)
+{
+#define FBIT(fbit) case fbit: return #fbit
+    switch (fbit) {
+    FBIT(VIRTIO_NET_F_CSUM);
+    FBIT(VIRTIO_NET_F_GUEST_CSUM);
+    FBIT(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS);
+    FBIT(VIRTIO_NET_F_MTU);
+    FBIT(VIRTIO_NET_F_MAC);
+    FBIT(VIRTIO_NET_F_GSO);
+    FBIT(VIRTIO_NET_F_GUEST_TSO4);
+    FBIT(VIRTIO_NET_F_GUEST_TSO6);
+    FBIT(VIRTIO_NET_F_GUEST_ECN);
+    FBIT(VIRTIO_NET_F_GUEST_UFO);
+    FBIT(VIRTIO_NET_F_HOST_TSO4);
+    FBIT(VIRTIO_NET_F_HOST_TSO6);
+    FBIT(VIRTIO_NET_F_HOST_ECN);
+    FBIT(VIRTIO_NET_F_HOST_UFO);
+    FBIT(VIRTIO_NET_F_MRG_RXBUF);
+    FBIT(VIRTIO_NET_F_STATUS);
+    FBIT(VIRTIO_NET_F_CTRL_VQ);
+    FBIT(VIRTIO_NET_F_CTRL_RX);
+    FBIT(VIRTIO_NET_F_CTRL_VLAN);
+    FBIT(VIRTIO_NET_F_CTRL_RX_EXTRA);
+    FBIT(VIRTIO_NET_F_GUEST_ANNOUNCE);
+    FBIT(VIRTIO_NET_F_MQ);
+    FBIT(VIRTIO_NET_F_CTRL_MAC_ADDR);
+    };
+#undef FBIT
+    return NULL;
+}
+
 static void virtio_net_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2178,6 +2211,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->get_features = virtio_net_get_features;
     vdc->set_features = virtio_net_set_features;
     vdc->bad_features = virtio_net_bad_features;
+    vdc->tell_feature_name = virtio_net_tell_feature_name;
     vdc->reset = virtio_net_reset;
     vdc->set_status = virtio_net_set_status;
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa9971..4be5df8 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -942,6 +942,20 @@ static const VMStateDescription vmstate_virtio_scsi = {
     },
 };
 
+static const char *virtio_scsi_tell_feature_name(VirtIODevice *vdev,
+                                                 unsigned fbit)
+{
+#define FBIT(fbit) case fbit: return #fbit
+    switch (fbit) {
+    FBIT(VIRTIO_SCSI_F_INOUT);
+    FBIT(VIRTIO_SCSI_F_HOTPLUG);
+    FBIT(VIRTIO_SCSI_F_CHANGE);
+    FBIT(VIRTIO_SCSI_F_T10_PI);
+    };
+#undef FBIT
+    return NULL;
+}
+
 static void virtio_scsi_common_class_init(ObjectClass *klass, void *data)
 {
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
@@ -964,6 +978,7 @@ static void virtio_scsi_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = virtio_scsi_device_unrealize;
     vdc->set_config = virtio_scsi_set_config;
     vdc->get_features = virtio_scsi_get_features;
+    vdc->tell_feature_name = virtio_scsi_tell_feature_name;
     vdc->reset = virtio_scsi_reset;
     vdc->start_ioeventfd = virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd = virtio_scsi_dataplane_stop;
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 765d363..3524aa7 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -3,12 +3,15 @@ common-obj-y += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-y += virtio-bus.o
 common-obj-y += virtio-mmio.o
+common-obj-y += virtio-qmp.o
 
 obj-y += virtio.o virtio-balloon.o 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 obj-y += virtio-crypto.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
+else
+obj-y += virtio-stub.o
 endif
 
 common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 37cde38..d97c8ce 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -509,6 +509,19 @@ static Property virtio_balloon_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_balloon_tell_feature_name(VirtIODevice *vdev,
+                                                    unsigned fbit)
+{
+#define FBIT(fbit) case fbit: return #fbit
+    switch (fbit) {
+    FBIT(VIRTIO_BALLOON_F_MUST_TELL_HOST);
+    FBIT(VIRTIO_BALLOON_F_STATS_VQ);
+    FBIT(VIRTIO_BALLOON_F_DEFLATE_ON_OOM);
+    };
+#undef FBIT
+    return NULL;
+}
+
 static void virtio_balloon_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -523,6 +536,7 @@ static void virtio_balloon_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_balloon_get_config;
     vdc->set_config = virtio_balloon_set_config;
     vdc->get_features = virtio_balloon_get_features;
+    vdc->tell_feature_name = virtio_balloon_tell_feature_name;
     vdc->set_status = virtio_balloon_set_status;
     vdc->vmsd = &vmstate_virtio_balloon_device;
 }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
new file mode 100644
index 0000000..6eaef9a
--- /dev/null
+++ b/hw/virtio/virtio-qmp.c
@@ -0,0 +1,134 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qmp-commands.h"
+
+#include "hw/virtio/virtio.h"
+
+static VirtioInfoList *qmp_query_virtio_one(VirtIODevice *vdev)
+{
+    VirtioInfoList *info_list;
+    VirtioInfo *info;
+    unsigned int idx;
+
+    info_list = g_new0(VirtioInfoList, 1);
+    info_list->value = g_new0(VirtioInfo, 1);
+
+    info = info_list->value;
+    info->qom_path = object_get_canonical_path(OBJECT(vdev));
+    info->status = vdev->status;
+    info->host_features = vdev->host_features;
+    info->guest_features = vdev->guest_features;
+
+    for (idx = 8; idx--; ) {
+        const char *name = virtio_tell_status_name(vdev, idx);
+        strList *status;
+
+        if (!name) {
+            continue;
+        }
+        if (!(vdev->status & (1 << idx))) {
+            continue;
+        }
+
+        status = g_new(strList, 1);
+        status->value = g_strdup(name);
+
+        status->next = info->status_names;
+        info->status_names = status;
+    }
+
+    for (idx = 64; idx--; ) {
+        const char *name = virtio_tell_device_feature_name(vdev, idx);
+        VirtioFeatureList **head = &info->device_features_names;
+        VirtioFeatureList *feature;
+
+        if (!name) {
+            name = virtio_tell_common_feature_name(vdev, idx);
+            head = &info->common_features_names;
+        }
+        if (!name) {
+            continue;
+        }
+        if (!virtio_host_has_feature(vdev, idx)) {
+            continue;
+        }
+
+        feature = g_new0(VirtioFeatureList, 1);
+        feature->value = g_new0(VirtioFeature, 1);
+
+        feature->value->name = g_strdup(name);
+        feature->value->acked = virtio_vdev_has_feature(vdev, idx);
+
+        feature->next = *head;
+        *head = feature;
+    }
+
+    return info_list;
+}
+
+typedef struct QueryVirtioEntry {
+    VirtIODevice *vdev;
+    QTAILQ_ENTRY(QueryVirtioEntry) link;
+} QueryVirtioEntry;
+
+typedef QTAILQ_HEAD(, QueryVirtioEntry) QueryVirtioHead;
+
+static void qmp_query_virtio_recursive(QueryVirtioHead *head, BusState *bus)
+{
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev = kid->child;
+        BusState *child;
+
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_DEVICE)) {
+            QueryVirtioEntry *entry = g_new0(QueryVirtioEntry, 1);
+
+            entry->vdev = VIRTIO_DEVICE(dev);
+            QTAILQ_INSERT_TAIL(head, entry, link);
+        }
+        QLIST_FOREACH(child, &dev->child_bus, sibling) {
+            qmp_query_virtio_recursive(head, child);
+        }
+    }
+}
+
+VirtioInfoList *qmp_query_virtio(bool has_path, const char *path, Error **errp)
+{
+    BusState *bus = sysbus_get_default();
+    VirtioInfoList *list = NULL;
+
+    if (!bus) {
+        return NULL;
+    }
+
+    if (has_path) {
+        Object *obj = object_resolve_path(path, NULL);
+        if (!obj) {
+            return NULL;
+        }
+        if (!object_dynamic_cast(OBJECT(obj), TYPE_VIRTIO_DEVICE)) {
+            return NULL;
+        }
+
+        list = qmp_query_virtio_one(VIRTIO_DEVICE(obj));
+    } else {
+        QueryVirtioHead head;
+        QueryVirtioEntry *query, *tmp;
+
+        QTAILQ_INIT(&head);
+        qmp_query_virtio_recursive(&head, bus);
+
+        QTAILQ_FOREACH_SAFE(query, &head, link, tmp) {
+            VirtioInfoList *entry = qmp_query_virtio_one(query->vdev);
+
+            QTAILQ_REMOVE(&head, query, link);
+            g_free(query);
+
+            entry->next = list;
+            list = entry;
+        }
+    }
+
+    return list;
+}
diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
new file mode 100644
index 0000000..185d4bd
--- /dev/null
+++ b/hw/virtio/virtio-stub.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "qmp-commands.h"
+#include "qapi/qmp/qerror.h"
+
+VirtioInfoList *qmp_query_virtio(bool has_path, const char *path, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ad564b0..23b33db 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2198,6 +2198,47 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     return 0;
 }
 
+const char *virtio_tell_status_name(VirtIODevice *vdev, unsigned sbit)
+{
+#define SBIT(sbit) case sbit: return #sbit
+    switch (1 << sbit) {
+    SBIT(VIRTIO_CONFIG_S_ACKNOWLEDGE);
+    SBIT(VIRTIO_CONFIG_S_DRIVER);
+    SBIT(VIRTIO_CONFIG_S_DRIVER_OK);
+    SBIT(VIRTIO_CONFIG_S_FEATURES_OK);
+    SBIT(VIRTIO_CONFIG_S_NEEDS_RESET);
+    SBIT(VIRTIO_CONFIG_S_FAILED);
+    }
+#undef SBIT
+    return NULL;
+}
+
+const char *virtio_tell_common_feature_name(VirtIODevice *vdev, unsigned fbit)
+{
+#define FBIT(fbit) case fbit: return #fbit
+    switch (fbit) {
+    FBIT(VIRTIO_F_NOTIFY_ON_EMPTY);
+    FBIT(VIRTIO_F_ANY_LAYOUT);
+    FBIT(VIRTIO_RING_F_INDIRECT_DESC);
+    FBIT(VIRTIO_RING_F_EVENT_IDX);
+    FBIT(VIRTIO_F_BAD_FEATURE);
+    FBIT(VIRTIO_F_VERSION_1);
+    FBIT(VIRTIO_F_IOMMU_PLATFORM);
+    }
+#undef FBIT
+    return NULL;
+}
+
+const char *virtio_tell_device_feature_name(VirtIODevice *vdev, unsigned fbit)
+{
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+
+    if (vdc->tell_feature_name) {
+        return vdc->tell_feature_name(vdev, fbit);
+    }
+    return NULL;
+}
+
 void virtio_cleanup(VirtIODevice *vdev)
 {
     qemu_del_vm_change_state_handler(vdev->vmstate);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 098bdaa..25f47da 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -141,6 +141,8 @@ typedef struct VirtioDeviceClass {
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
     const VMStateDescription *vmsd;
+    /* Tells the name of device specific feature */
+    const char *(*tell_feature_name)(VirtIODevice *vdev, unsigned fbit);
 } VirtioDeviceClass;
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
@@ -292,6 +294,10 @@ void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
 VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
 VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
 
+const char *virtio_tell_status_name(VirtIODevice *vdev, unsigned sbit);
+const char *virtio_tell_common_feature_name(VirtIODevice *vdev, unsigned fbit);
+const char *virtio_tell_device_feature_name(VirtIODevice *vdev, unsigned fbit);
+
 static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
 {
     assert(fbit < 64);
diff --git a/qapi-schema.json b/qapi-schema.json
index 1845795..51cd0f3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3200,3 +3200,73 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @VirtioFeature:
+#
+# Virtio feature bit with negotiation status
+#
+# @name: name of feature bit
+#
+# @acked: negotiation status, `true' if guest acknowledged the feature
+#
+# Since: 2.12
+##
+{
+    'struct': 'VirtioFeature',
+    'data': {
+        'name': 'str',
+        'acked': 'bool'
+    }
+}
+
+##
+# @VirtioInfo:
+#
+# Information about virtio device
+#
+# @qom-path: QOM path of the device
+#
+# @status: status bitmask
+#
+# @host-features: bitmask of features, exposed by device
+#
+# @guest-features: bitmask of features, acknowledged by guest
+#
+# @status-names: names of checked bits in status bitmask
+#
+# @common-features-names: names exposed features and negotiation status,
+# that are common to all devices
+#
+# @device-features-names: names exposed features and negotiation status,
+# that are specific to this device
+#
+# Since: 2.12
+##
+{
+    'struct': 'VirtioInfo',
+    'data': {
+        'qom-path': 'str',
+
+        'status': 'uint8',
+        'host-features': 'uint64',
+        'guest-features': 'uint64',
+
+        'status-names': ['str'],
+        'common-features-names': ['VirtioFeature'],
+        'device-features-names': ['VirtioFeature']
+    }
+}
+
+##
+# @query-virtio:
+#
+# Returns virtio information such as device status and features
+#
+# Since: 2.12
+##
+{
+    'command': 'query-virtio',
+    'data': {'*path': 'str'},
+    'returns': ['VirtioInfo']
+}
-- 
2.1.4
