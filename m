Received: from eggs.gnu.org ([2001:4830:134:3::10]:39308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dwsVa-0004dc-IG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dwsVY-0000ie-H3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:14:54 -0400
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Tue, 26 Sep 2017 19:13:38 +0300
Message-Id: <1506442418-26026-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] virtio: introduce `info virtio' hmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Denis V. Lunev" <den@virtuozzo.com>

The command is intended for exposing device specific virtio feature bits
and their negotiation status. It is convenient and useful for debug
purpose.

Names of features are taken from a devices via get_feature_name() within
VirtioDeviceClass. If certain device doesn't implement it, the command
will print only hexadecimal value of feature mask.

Cc: Denis V. Lunev <den@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
The patch suggests an another approach for this:

"virtio: show guest features in 'info qtree'"
http://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg01609.html
---
 hmp-commands-info.hx           | 14 ++++++++++
 hw/block/virtio-blk.c          | 20 ++++++++++++++
 hw/char/virtio-serial-bus.c    | 15 +++++++++++
 hw/display/virtio-gpu.c        | 12 +++++++++
 hw/net/virtio-net.c            | 34 ++++++++++++++++++++++++
 hw/scsi/virtio-scsi.c          | 15 +++++++++++
 hw/virtio/virtio-balloon.c     | 15 +++++++++++
 hw/virtio/virtio-bus.c         | 59 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-bus.h |  2 ++
 include/hw/virtio/virtio.h     |  2 ++
 monitor.c                      |  1 +
 11 files changed, 189 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 4f1ece9..2550027 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -868,6 +868,20 @@ ETEXI
     },
 
 STEXI
+@item info virtio
+@findex virtio
+Display guest and host fetures for all virtio devices.
+ETEXI
+
+    {
+        .name       = "virtio",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show virtio info",
+        .cmd        = hmp_info_virtio,
+    },
+
+STEXI
 @end table
 ETEXI
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 05d1440..5856640 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1017,6 +1017,25 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_blk_get_feature_name(VirtIODevice *vdev, int feature)
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
@@ -1030,6 +1049,7 @@ static void virtio_blk_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_blk_update_config;
     vdc->set_config = virtio_blk_set_config;
     vdc->get_features = virtio_blk_get_features;
+    vdc->get_feature_name = virtio_blk_get_feature_name;
     vdc->set_status = virtio_blk_set_status;
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..a6ccb6a 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1156,6 +1156,20 @@ static Property virtio_serial_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_serial_get_feature_name(VirtIODevice *vdev,
+                                                  int feature)
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
index 3a8f1e1..860d2b3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1307,6 +1307,17 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_gpu_get_feature_name(VirtIODevice *vdev, int feature)
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
@@ -1317,6 +1328,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_gpu_get_config;
     vdc->set_config = virtio_gpu_set_config;
     vdc->get_features = virtio_gpu_get_features;
+    vdc->get_feature_name = virtio_gpu_get_feature_name;
     vdc->set_features = virtio_gpu_set_features;
 
     vdc->reset = virtio_gpu_reset;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 148071a..e1d5d5d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2154,6 +2154,39 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_net_get_feature_name(VirtIODevice *vdev, int feature)
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
@@ -2169,6 +2202,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->get_features = virtio_net_get_features;
     vdc->set_features = virtio_net_set_features;
     vdc->bad_features = virtio_net_bad_features;
+    vdc->get_feature_name = virtio_net_get_feature_name;
     vdc->reset = virtio_net_reset;
     vdc->set_status = virtio_net_set_status;
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa9971..4365c0a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -942,6 +942,20 @@ static const VMStateDescription vmstate_virtio_scsi = {
     },
 };
 
+static const char *virtio_scsi_get_feature_name(VirtIODevice *vdev, int feature)
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
@@ -964,6 +978,7 @@ static void virtio_scsi_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = virtio_scsi_device_unrealize;
     vdc->set_config = virtio_scsi_set_config;
     vdc->get_features = virtio_scsi_get_features;
+    vdc->get_feature_name = virtio_scsi_get_feature_name;
     vdc->reset = virtio_scsi_reset;
     vdc->start_ioeventfd = virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd = virtio_scsi_dataplane_stop;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 37cde38..04f4e66 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -509,6 +509,20 @@ static Property virtio_balloon_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const char *virtio_balloon_get_feature_name(VirtIODevice *vdev,
+                                                   int feature)
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
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232..7324128 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -30,6 +30,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio.h"
 #include "exec/address-spaces.h"
+#include "monitor/monitor.h"
 
 /* #define DEBUG_VIRTIO_BUS */
 
@@ -306,6 +307,64 @@ static char *virtio_bus_get_dev_path(DeviceState *dev)
     return qdev_get_dev_path(proxy);
 }
 
+static void hmp_info_virtio_print(Monitor *mon, VirtIODevice *vdev)
+{
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    const int indent = 2;
+    const int field = 32;
+    int idx;
+
+    monitor_printf(mon, "%s\n", object_get_typename(OBJECT(vdev)));
+    monitor_printf(mon, "%*shost features:  0x%016"PRIx64"\n", indent, "",
+                   vdev->host_features);
+    monitor_printf(mon, "%*sguest features: 0x%016"PRIx64"\n", indent, "",
+                   vdev->guest_features);
+    if (!vdc->get_feature_name) {
+        return;
+    }
+    for (idx = 0; idx < 64; idx++) {
+        const char *name = vdc->get_feature_name(vdev, idx);
+        const char *ack;
+
+        if (!name) {
+            continue;
+        }
+        if (!(vdev->host_features & (1 << idx))) {
+            continue;
+        }
+        ack = vdev->guest_features & (1 << idx) ? "acked" : "";
+        monitor_printf(mon, "%*s%*s%*s\n", indent, "", field, name, field, ack);
+    }
+}
+
+static void hmp_info_virtio_recursive(Monitor *mon, BusState *bus)
+{
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev = kid->child;
+        BusState *child;
+
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_DEVICE)) {
+            hmp_info_virtio_print(mon, VIRTIO_DEVICE(dev));
+        }
+        QLIST_FOREACH(child, &dev->child_bus, sibling) {
+            hmp_info_virtio_recursive(mon, child);
+        }
+    }
+}
+
+void hmp_info_virtio(Monitor *mon, const QDict *qdict)
+{
+    BusState *bus = sysbus_get_default();
+
+    if (!bus) {
+        return;
+    }
+
+    hmp_info_virtio_recursive(mon, bus);
+}
+
 static char *virtio_bus_get_fw_dev_path(DeviceState *dev)
 {
     return NULL;
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index a63c1d2..1ed91ec 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -148,5 +148,7 @@ int virtio_bus_grab_ioeventfd(VirtioBusState *bus);
 void virtio_bus_release_ioeventfd(VirtioBusState *bus);
 /* Switch from/to the generic ioeventfd handler */
 int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign);
+/* Handle `virtio info' hmp command */
+void hmp_info_virtio(Monitor *mon, const QDict *qdict);
 
 #endif /* VIRTIO_BUS_H */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 80c45c3..9b324f6 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -141,6 +141,8 @@ typedef struct VirtioDeviceClass {
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
     const VMStateDescription *vmsd;
+    /* Get the name of device specific feature */
+    const char *(*get_feature_name)(VirtIODevice *vdev, int feature);
 } VirtioDeviceClass;
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
diff --git a/monitor.c b/monitor.c
index f4856b9..779f168 100644
--- a/monitor.c
+++ b/monitor.c
@@ -78,6 +78,7 @@
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "qapi/qmp/dispatch.h"
+#include "hw/virtio/virtio-bus.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
-- 
2.1.4
