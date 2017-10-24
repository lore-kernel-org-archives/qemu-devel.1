Received: from eggs.gnu.org ([2001:4830:134:3::10]:42480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e73Kh-00054f-BW
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e73Kf-0000vk-0i
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:43 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25804 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.dakinevich@virtuozzo.com>)
	id 1e73Ke-0000un-CD
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:40 -0400
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Tue, 24 Oct 2017 20:50:03 +0300
Message-Id: <1508867404-18046-2-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel] [RFC v5 1/2] virtio: introduce `query-virtio' QMP
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
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The command is intended for gathering virtio information such as status,
feature bits, negotiation status. It is convenient and useful for debug
purpose.

The commands returns generic virtio information for virtio such as
common feature names and status bits names and information for all
attached to current machine devices.

Cc: Denis V. Lunev <den@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 hw/virtio/Makefile.objs |   3 +
 hw/virtio/virtio-qmp.c  | 223 +++++++++++++++++++++++
 hw/virtio/virtio-stub.c |   9 +
 qapi-schema.json        | 466 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 701 insertions(+)
 create mode 100644 hw/virtio/virtio-qmp.c
 create mode 100644 hw/virtio/virtio-stub.c

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
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
new file mode 100644
index 0000000..8192c33
--- /dev/null
+++ b/hw/virtio/virtio-qmp.c
@@ -0,0 +1,223 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qmp-commands.h"
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-blk.h"
+#include "hw/virtio/virtio-serial.h"
+#include "hw/virtio/virtio-balloon.h"
+#include "hw/virtio/virtio-scsi.h"
+#ifdef CONFIG_VIRTFS
+#include "hw/9pfs/virtio-9p.h"
+#endif
+#include "hw/virtio/virtio-gpu.h"
+
+#define qmp_query_virtio_features(__vdev, __info, __offset, __count,\
+                                  __name_kind, __name_type, __name_field) ({ \
+    unsigned __idx; \
+    for (__idx = (__count); __idx--; ) { \
+        unsigned int __fbit = __idx + (__offset); \
+        bool __host = virtio_host_has_feature(__vdev, __fbit); \
+        bool __guest = virtio_vdev_has_feature(__vdev, __fbit); \
+        VirtioFeatureList *__feature; \
+ \
+        if (!__host && !__guest) { \
+            continue; \
+        } \
+ \
+        __feature = g_new0(VirtioFeatureList, 1); \
+        __feature->value = g_new0(VirtioFeature, 1); \
+        __feature->value->name = g_new0(VirtioFeatureName, 1); \
+ \
+        __feature->value->host = __host; \
+        __feature->value->guest = __guest; \
+ \
+        __feature->value->name->type = (__name_kind); \
+        __feature->value->name->u.__name_field.data = (__name_type)__idx; \
+ \
+        __feature->next = (__info)->features; \
+        (__info)->features = __feature; \
+    } \
+})
+
+#define qmp_query_virtio_features_common(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), VIRTIO_FEATURE_OTHER__MAX, \
+        VIRTIO_FEATURE_COMMON__MAX, VIRTIO_FEATURE_NAME_KIND_COMMON, \
+        VirtioFeatureCommon, common)
+
+#define qmp_query_virtio_features_net(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_NET__MAX, VIRTIO_FEATURE_NAME_KIND_NET, \
+        VirtioFeatureNet, net)
+
+#define qmp_query_virtio_features_blk(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_BLK__MAX, VIRTIO_FEATURE_NAME_KIND_BLK, \
+        VirtioFeatureBlk, blk)
+
+#define qmp_query_virtio_features_serial(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_SERIAL__MAX, VIRTIO_FEATURE_NAME_KIND_SERIAL, \
+        VirtioFeatureSerial, serial)
+
+#define qmp_query_virtio_features_balloon(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_BALLOON__MAX, VIRTIO_FEATURE_NAME_KIND_BALLOON, \
+        VirtioFeatureBalloon, balloon)
+
+#define qmp_query_virtio_features_scsi(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_SCSI__MAX, VIRTIO_FEATURE_NAME_KIND_SCSI, \
+        VirtioFeatureScsi, scsi)
+
+#ifdef CONFIG_VIRTFS
+#define qmp_query_virtio_features_virtfs(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_VIRTFS__MAX, VIRTIO_FEATURE_NAME_KIND_VIRTFS, \
+        VirtioFeatureVirtfs, virtfs)
+#endif
+
+#define qmp_query_virtio_features_gpu(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_GPU__MAX, VIRTIO_FEATURE_NAME_KIND_GPU, \
+        VirtioFeatureGpu, gpu)
+
+#define qmp_query_virtio_features_other(__vdev, __info) \
+    qmp_query_virtio_features((__vdev), (__info), 0, \
+        VIRTIO_FEATURE_OTHER__MAX, VIRTIO_FEATURE_NAME_KIND_OTHER, \
+        VirtioFeatureOther, other)
+
+
+static VirtioInfoList *qmp_query_virtio_one(VirtIODevice *vdev)
+{
+    VirtioInfoList *list;
+    VirtioInfo *info;
+    unsigned int idx;
+
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_COMMON__MAX != 40);
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_NET__MAX != 24);
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_BLK__MAX != 24);
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_SCSI__MAX != 24);
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_BALLOON__MAX != 24);
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_SERIAL__MAX != 24);
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_GPU__MAX != 24);
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURE_OTHER__MAX != 24);
+
+    list = g_new0(VirtioInfoList, 1);
+    list->value = g_new0(VirtioInfo, 1);
+
+    info = list->value;
+    info->qom_path = object_get_canonical_path(OBJECT(vdev));
+    info->status = vdev->status;
+    info->host_features = vdev->host_features;
+    info->guest_features = vdev->guest_features;
+
+    /* device status */
+    for (idx = VIRTIO_STATUS__MAX; idx--; ) {
+        VirtioStatusList *status;
+
+        if (!(vdev->status & (1 << idx))) {
+            continue;
+        }
+
+        status = g_new0(VirtioStatusList, 1);
+        status->value = (VirtioStatus)idx;
+
+        status->next = info->status_names;
+        info->status_names = status;
+    }
+
+    /* device-specific features */
+    if (object_dynamic_cast(OBJECT(vdev), TYPE_VIRTIO_NET)) {
+        qmp_query_virtio_features_net(vdev, info);
+    } else if (object_dynamic_cast(OBJECT(vdev), TYPE_VIRTIO_BLK)) {
+        qmp_query_virtio_features_blk(vdev, info);
+    } else if (object_dynamic_cast(OBJECT(vdev), TYPE_VIRTIO_SERIAL)) {
+        qmp_query_virtio_features_serial(vdev, info);
+    } else if (object_dynamic_cast(OBJECT(vdev), TYPE_VIRTIO_BALLOON)) {
+        qmp_query_virtio_features_balloon(vdev, info);
+    } else if (object_dynamic_cast(OBJECT(vdev), TYPE_VIRTIO_SCSI)) {
+        qmp_query_virtio_features_scsi(vdev, info);
+#ifdef CONFIG_VIRTFS
+    } else if (object_dynamic_cast(OBJECT(vdev), TYPE_VIRTIO_9P)) {
+        qmp_query_virtio_features_virtfs(vdev, info);
+#endif
+    } else if (object_dynamic_cast(OBJECT(vdev), TYPE_VIRTIO_GPU)) {
+        qmp_query_virtio_features_gpu(vdev, info);
+    } else {
+        qmp_query_virtio_features_other(vdev, info);
+    }
+
+    /* common features */
+    qmp_query_virtio_features_common(vdev, info);
+
+    return list;
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
diff --git a/qapi-schema.json b/qapi-schema.json
index a9dd043..b1645f3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3200,3 +3200,469 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @VirtioStatus:
+#
+# Virtio device status bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioStatus',
+    'data': [
+        'acknowledge',
+        'driver',
+        'driver-ok',
+        'features-ok',
+        'status-reserved-4',
+        'status-reserved-5',
+        'needs-reset',
+        'failed'
+    ]
+}
+
+##
+# @VirtioFeatureCommon:
+#
+# Virtio feature bits common to all devices
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureCommon',
+    'data': [
+        'notify-on-empty',
+        'common-reserved-25',
+        'common-reserved-26',
+        'any-layout',
+        'indirect-desc',
+        'event-idx',
+        'bad-feature',
+        'common-reserved-31',
+        'version-1',
+        'iommu-platform',
+        'common-reserved-34',
+        'common-reserved-35',
+        'common-reserved-36',
+        'common-reserved-37',
+        'common-reserved-38',
+        'common-reserved-39',
+        'common-reserved-40',
+        'common-reserved-41',
+        'common-reserved-42',
+        'common-reserved-43',
+        'common-reserved-44',
+        'common-reserved-45',
+        'common-reserved-46',
+        'common-reserved-47',
+        'common-reserved-48',
+        'common-reserved-49',
+        'common-reserved-50',
+        'common-reserved-51',
+        'common-reserved-52',
+        'common-reserved-53',
+        'common-reserved-54',
+        'common-reserved-55',
+        'common-reserved-56',
+        'common-reserved-57',
+        'common-reserved-58',
+        'common-reserved-59',
+        'common-reserved-60',
+        'common-reserved-61',
+        'common-reserved-62',
+        'common-reserved-63'
+    ]
+}
+
+##
+# @VirtioFeatureNet:
+#
+# Virtio network device feature bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureNet',
+    'data': [
+        'csum',
+        'guest-csum',
+        'ctrl-guest-offloads',
+        'mtu',
+        'net-reserved-4',
+        'mac',
+        'gso',
+        'guest-tso4',
+        'guest-tso6',
+        'guest-ecn',
+        'guest-ufo',
+        'host-tso4',
+        'host-tso6',
+        'host-ecn',
+        'host-ufo',
+        'mrg-rxbuf',
+        'status',
+        'ctrl-vq',
+        'ctrl-rx',
+        'ctrl-vlan',
+        'ctrl-rx-extra',
+        'guest-announce',
+        'mq',
+        'ctrl-mac-addr'
+    ]
+}
+
+##
+# @VirtioFeatureBlk:
+#
+# Virtio block device feature bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureBlk',
+    'data': [
+        'barrier',
+        'size-max',
+        'seg-max',
+        'blk-reserved-3',
+        'geometry',
+        'ro',
+        'blk-size',
+        'scsi',
+        'blk-reserved-8',
+        'flush',
+        'topology',
+        'config-wce',
+        'mq',
+        'blk-reserved-13',
+        'blk-reserved-14',
+        'blk-reserved-15',
+        'blk-reserved-16',
+        'blk-reserved-17',
+        'blk-reserved-18',
+        'blk-reserved-19',
+        'blk-reserved-20',
+        'blk-reserved-21',
+        'blk-reserved-22',
+        'blk-reserved-23'
+    ]
+}
+
+##
+# @VirtioFeatureSerial:
+#
+# Virtio serial device (console) feature bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureSerial',
+    'data': [
+        'size',
+        'multiport',
+        'emerg-write',
+        'serial-reserved-3',
+        'serial-reserved-4',
+        'serial-reserved-5',
+        'serial-reserved-6',
+        'serial-reserved-7',
+        'serial-reserved-8',
+        'serial-reserved-9',
+        'serial-reserved-10',
+        'serial-reserved-11',
+        'serial-reserved-12',
+        'serial-reserved-13',
+        'serial-reserved-14',
+        'serial-reserved-15',
+        'serial-reserved-16',
+        'serial-reserved-17',
+        'serial-reserved-18',
+        'serial-reserved-19',
+        'serial-reserved-20',
+        'serial-reserved-21',
+        'serial-reserved-22',
+        'serial-reserved-23'
+    ]
+}
+
+##
+# @VirtioFeatureBalloon:
+#
+# Virtio balloon feature bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureBalloon',
+    'data': [
+        'must-tell-host',
+        'stats-vq',
+        'deflate-on-oom',
+        'balloon-reserved-3',
+        'balloon-reserved-4',
+        'balloon-reserved-5',
+        'balloon-reserved-6',
+        'balloon-reserved-7',
+        'balloon-reserved-8',
+        'balloon-reserved-9',
+        'balloon-reserved-10',
+        'balloon-reserved-11',
+        'balloon-reserved-12',
+        'balloon-reserved-13',
+        'balloon-reserved-14',
+        'balloon-reserved-15',
+        'balloon-reserved-16',
+        'balloon-reserved-17',
+        'balloon-reserved-18',
+        'balloon-reserved-19',
+        'balloon-reserved-20',
+        'balloon-reserved-21',
+        'balloon-reserved-22',
+        'balloon-reserved-23'
+    ]
+}
+
+##
+# @VirtioFeatureScsi:
+#
+# Virtio scsi controller feature bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureScsi',
+    'data': [
+        'inout',
+        'hotplug',
+        'change',
+        't10-pi',
+        'scsi-reserved-4',
+        'scsi-reserved-5',
+        'scsi-reserved-6',
+        'scsi-reserved-7',
+        'scsi-reserved-8',
+        'scsi-reserved-9',
+        'scsi-reserved-10',
+        'scsi-reserved-11',
+        'scsi-reserved-12',
+        'scsi-reserved-13',
+        'scsi-reserved-14',
+        'scsi-reserved-15',
+        'scsi-reserved-16',
+        'scsi-reserved-17',
+        'scsi-reserved-18',
+        'scsi-reserved-19',
+        'scsi-reserved-20',
+        'scsi-reserved-21',
+        'scsi-reserved-22',
+        'scsi-reserved-23'
+    ]
+}
+
+##
+# @VirtioFeatureVirtfs:
+#
+# Virtio virtfs (9p) feature bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureVirtfs',
+    'data': [
+        'mount-tag',
+        'virtfs-reserved-1',
+        'virtfs-reserved-2',
+        'virtfs-reserved-3',
+        'virtfs-reserved-4',
+        'virtfs-reserved-5',
+        'virtfs-reserved-6',
+        'virtfs-reserved-7',
+        'virtfs-reserved-8',
+        'virtfs-reserved-9',
+        'virtfs-reserved-10',
+        'virtfs-reserved-11',
+        'virtfs-reserved-12',
+        'virtfs-reserved-13',
+        'virtfs-reserved-14',
+        'virtfs-reserved-15',
+        'virtfs-reserved-16',
+        'virtfs-reserved-17',
+        'virtfs-reserved-18',
+        'virtfs-reserved-19',
+        'virtfs-reserved-20',
+        'virtfs-reserved-21',
+        'virtfs-reserved-22',
+        'virtfs-reserved-23'
+    ]
+}
+
+##
+# @VirtioFeatureGpu:
+#
+# Virtio GPU device feature bits
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureGpu',
+    'data': [
+        'virgl',
+        'gpu-reserved-1',
+        'gpu-reserved-2',
+        'gpu-reserved-3',
+        'gpu-reserved-4',
+        'gpu-reserved-5',
+        'gpu-reserved-6',
+        'gpu-reserved-7',
+        'gpu-reserved-8',
+        'gpu-reserved-9',
+        'gpu-reserved-10',
+        'gpu-reserved-11',
+        'gpu-reserved-12',
+        'gpu-reserved-13',
+        'gpu-reserved-14',
+        'gpu-reserved-15',
+        'gpu-reserved-16',
+        'gpu-reserved-17',
+        'gpu-reserved-18',
+        'gpu-reserved-19',
+        'gpu-reserved-20',
+        'gpu-reserved-21',
+        'gpu-reserved-22',
+        'gpu-reserved-23'
+    ]
+}
+
+##
+# @VirtioFeatureOther:
+#
+# Feature bits of other virtio devices
+#
+# Since: 2.11
+#
+##
+{
+    'enum': 'VirtioFeatureOther',
+    'data': [
+        'other-reserved-0',
+        'other-reserved-1',
+        'other-reserved-2',
+        'other-reserved-3',
+        'other-reserved-4',
+        'other-reserved-5',
+        'other-reserved-6',
+        'other-reserved-7',
+        'other-reserved-8',
+        'other-reserved-9',
+        'other-reserved-10',
+        'other-reserved-11',
+        'other-reserved-12',
+        'other-reserved-13',
+        'other-reserved-14',
+        'other-reserved-15',
+        'other-reserved-16',
+        'other-reserved-17',
+        'other-reserved-18',
+        'other-reserved-19',
+        'other-reserved-20',
+        'other-reserved-21',
+        'other-reserved-22',
+        'other-reserved-23'
+    ]
+}
+
+##
+# @VirtioFeatureName:
+#
+# Since: 2.11
+#
+##
+{
+    'union': 'VirtioFeatureName',
+    'data': {
+        'common': 'VirtioFeatureCommon',
+        'net': 'VirtioFeatureNet',
+        'blk': 'VirtioFeatureBlk',
+        'serial': 'VirtioFeatureSerial',
+        'balloon': 'VirtioFeatureBalloon',
+        'scsi': 'VirtioFeatureScsi',
+        'virtfs': 'VirtioFeatureVirtfs',
+        'gpu': 'VirtioFeatureGpu',
+        'other': 'VirtioFeatureOther'
+    }
+}
+
+##
+# @VirtioFeature:
+#
+# Feature bit with negotiation status
+#
+# @host: true if host exposes the feature
+#
+# @guest: true if guest acknowledges the feature
+#
+# Since: 2.11
+#
+##
+{
+    'struct': 'VirtioFeature',
+    'data': {
+        'host': 'bool',
+        'guest': 'bool',
+        'name': 'VirtioFeatureName'
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
+# @status-names: names of checked bits in status bitmask
+#
+# @host-features: bitmask of features, exposed by device
+#
+# @guest-features: bitmask of features, acknowledged by guest
+#
+# @features: negotiation status and names of device features
+#
+##
+{
+    'struct': 'VirtioInfo',
+    'data': {
+        'qom-path': 'str',
+        'status': 'uint8',
+        'status-names': ['VirtioStatus'],
+        'host-features': 'uint64',
+        'guest-features': 'uint64',
+        'features': ['VirtioFeature']
+    }
+}
+
+##
+# @query-virtio:
+#
+# Returns virtio information such as device status and features
+#
+# Since: 2.11
+#
+##
+{
+    'command': 'query-virtio',
+    'data': { '*path': 'str' },
+    'returns': ['VirtioInfo']
+}
-- 
2.1.4
