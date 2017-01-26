Received: from eggs.gnu.org ([2001:4830:134:3::10]:34299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWapK-0006gk-Ay
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWapJ-0002sN-6S
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:34:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWapI-0002sE-UE
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:34:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 194E53A768C
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 03:34:21 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu, 26 Jan 2017 11:34:06 +0800
Message-Id: <20170126033406.6433-3-famz@redhat.com>
In-Reply-To: <20170126033406.6433-1-famz@redhat.com>
References: <20170126033406.6433-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] virtio-scsi: Implement fc_host feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

This patch add qdev properties to allow enabling the fc_host feature of
virtio-scsi, and fill config fields.

For migration, the destination QEMU should be started with the same
wwnn and wwpn, and a inverted primary_active. When migration is done,
the config change interrupt will allow guest to discover the toggling.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi.c           | 72 +++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-scsi.h | 10 ++++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ce19eff..c303f46 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -656,6 +656,11 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
     virtio_stw_p(vdev, &scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
     virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
+    stq_be_p(&scsiconf->primary_wwpn, s->conf.primary_wwpn);
+    stq_be_p(&scsiconf->primary_wwnn, s->conf.primary_wwnn);
+    stq_be_p(&scsiconf->secondary_wwpn, s->conf.secondary_wwpn);
+    stq_be_p(&scsiconf->secondary_wwnn, s->conf.secondary_wwnn);
+    scsiconf->primary_active =  s->conf.primary_active;
 }
 
 static void virtio_scsi_set_config(VirtIODevice *vdev,
@@ -870,18 +875,68 @@ void virtio_scsi_common_realize(DeviceState *dev, Error **errp,
     }
 }
 
+static void virtio_scsi_vm_state_change(void *opaque, int running,
+                                        RunState state)
+{
+    VirtIOSCSI *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    if (!running || !s->config_change_pending) {
+        return;
+    }
+    s->config_change_pending = false;
+    virtio_notify_config(vdev);
+}
+
 static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     Error *err = NULL;
 
+    if (vs->conf.fc_host) {
+        if (!strcmp(vs->conf.fc_host, "off")) {
+            vs->conf.primary_wwpn = 0;
+            vs->conf.primary_wwnn = 0;
+            vs->conf.secondary_wwpn = 0;
+            vs->conf.secondary_wwnn = 0;
+        } else if (!strcmp(vs->conf.fc_host, "primary") ||
+                   !strcmp(vs->conf.fc_host, "secondary")) {
+            virtio_add_feature(&vdev->host_features, VIRTIO_SCSI_F_FC_HOST);
+            vs->conf.primary_active = !strcmp(vs->conf.fc_host, "primary");
+            if (!vs->conf.primary_wwpn) {
+                error_setg(errp, "fc_host enabled but primary_wwpn not set");
+                return;
+            }
+            if (!vs->conf.primary_wwnn) {
+                error_setg(errp, "fc_host enabled but primary_wwnn not set");
+                return;
+            }
+            if (!vs->conf.secondary_wwpn) {
+                error_setg(errp, "fc_host enabled but secondary_wwpn not set");
+                return;
+            }
+            if (!vs->conf.secondary_wwnn) {
+                error_setg(errp, "fc_host enabled but secondary_wwnn not set");
+                return;
+            }
+            s->vm_state_change =
+                qemu_add_vm_change_state_handler(virtio_scsi_vm_state_change, s);
+            s->config_change_pending = runstate_check(RUN_STATE_INMIGRATE);
+        } else {
+            error_setg(errp, "Invalid fc_host option. "
+                             "Must be 'off', 'primary' or 'secondary'");
+            return;
+        }
+    }
+
     virtio_scsi_common_realize(dev, &err, virtio_scsi_handle_ctrl,
                                virtio_scsi_handle_event,
                                virtio_scsi_handle_cmd);
     if (err != NULL) {
         error_propagate(errp, err);
-        return;
+        goto fail;
     }
 
     scsi_bus_new(&s->bus, sizeof(s->bus), dev,
@@ -893,11 +948,14 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
         scsi_bus_legacy_handle_cmdline(&s->bus, &err);
         if (err != NULL) {
             error_propagate(errp, err);
-            return;
+            goto fail;
         }
     }
 
     virtio_scsi_dataplane_setup(s, errp);
+    return;
+fail:
+    qemu_del_vm_change_state_handler(s->vm_state_change);
 }
 
 static void virtio_scsi_instance_init(Object *obj)
@@ -921,6 +979,11 @@ void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp)
 
 static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
 {
+    VirtIOSCSI *s = VIRTIO_SCSI(dev);
+
+    if (s->vm_state_change) {
+        qemu_del_vm_change_state_handler(s->vm_state_change);
+    }
     virtio_scsi_common_unrealize(dev, errp);
 }
 
@@ -934,6 +997,11 @@ static Property virtio_scsi_properties[] = {
                                            VIRTIO_SCSI_F_HOTPLUG, true),
     DEFINE_PROP_BIT("param_change", VirtIOSCSI, host_features,
                                                 VIRTIO_SCSI_F_CHANGE, true),
+    DEFINE_PROP_UINT64("primary_wwpn", VirtIOSCSI, parent_obj.conf.primary_wwpn, 0),
+    DEFINE_PROP_UINT64("primary_wwnn", VirtIOSCSI, parent_obj.conf.primary_wwnn, 0),
+    DEFINE_PROP_UINT64("secondary_wwpn", VirtIOSCSI, parent_obj.conf.secondary_wwpn, 0),
+    DEFINE_PROP_UINT64("secondary_wwnn", VirtIOSCSI, parent_obj.conf.secondary_wwnn, 0),
+    DEFINE_PROP_STRING("fc_host", VirtIOSCSI, parent_obj.conf.fc_host),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 7375196..a0eb080 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -53,6 +53,13 @@ struct VirtIOSCSIConf {
     char *wwpn;
     uint32_t boot_tpgt;
     IOThread *iothread;
+
+    char *fc_host;
+    bool primary_active;
+    uint64_t primary_wwnn;
+    uint64_t primary_wwpn;
+    uint64_t secondary_wwnn;
+    uint64_t secondary_wwpn;
 };
 
 struct VirtIOSCSI;
@@ -83,6 +90,9 @@ typedef struct VirtIOSCSI {
     bool dataplane_stopping;
     bool dataplane_fenced;
     uint32_t host_features;
+
+    bool config_change_pending;
+    VMChangeStateEntry *vm_state_change;
 } VirtIOSCSI;
 
 typedef struct VirtIOSCSIReq {
-- 
2.9.3
