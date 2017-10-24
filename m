Received: from eggs.gnu.org ([2001:4830:134:3::10]:42476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e73Kh-00054d-AE
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1e73Ke-0000vd-Rs
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:43 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:9536 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.dakinevich@virtuozzo.com>)
	id 1e73Ke-0000um-C5
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:49:40 -0400
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Tue, 24 Oct 2017 20:50:04 +0300
Message-Id: <1508867404-18046-3-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1508867404-18046-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel]  [RFC v5 2/2] virtio: add `info virtio' HMP command
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

The command prints data from `query-virtio' QMP in human-readable
format.

Cc: Denis V. Lunev <den@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 hmp-commands-info.hx |  14 ++++++
 hmp.c                | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hmp.h                |   1 +
 3 files changed, 137 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 54c3e5e..292280a 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -868,6 +868,20 @@ enabled) memory in bytes.
 ETEXI
 
 STEXI
+@item info virtio
+@findex virtio
+Display guest and host fetures for all virtio devices.
+ETEXI
+
+    {
+        .name       = "virtio",
+        .args_type  = "path:s?",
+        .params     = "[path]",
+        .help       = "show virtio info",
+        .cmd        = hmp_info_virtio,
+    },
+
+STEXI
 @end table
 ETEXI
 
diff --git a/hmp.c b/hmp.c
index ec61329..440e48c 100644
--- a/hmp.c
+++ b/hmp.c
@@ -43,6 +43,7 @@
 #include "hw/intc/intc.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
+#include "hw/virtio/virtio.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -2901,3 +2902,124 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+#define HMP_INFO_VIRTIO_INDENT 2
+#define HMP_INFO_VIRTIO_ITEM 16
+#define HMP_INFO_VIRTIO_FIELD 24
+
+static void hmp_info_virtio_print_status(Monitor *mon, VirtioInfo *info)
+{
+    VirtioStatusList *status;
+    const char *space = " ";
+
+    monitor_printf(mon, "%*s%-*s0x%02"PRIx8"", HMP_INFO_VIRTIO_INDENT, "",
+                   HMP_INFO_VIRTIO_ITEM, "status:", info->status);
+
+    for (status = info->status_names; status; status = status->next) {
+        monitor_printf(mon, "%s%s", space, VirtioStatus_str(status->value));
+        space = ",";
+    }
+
+    monitor_printf(mon, "\n");
+}
+
+static void hmp_info_virtio_print_features(Monitor *mon, VirtioInfo *info)
+{
+    VirtioFeatureList *head;
+
+    monitor_printf(mon, "%*s%-*s0x%016"PRIx64"\n", HMP_INFO_VIRTIO_INDENT, "",
+                   HMP_INFO_VIRTIO_ITEM, "host features:",
+                   info->host_features);
+    monitor_printf(mon, "%*s%-*s0x%016"PRIx64"\n", HMP_INFO_VIRTIO_INDENT, "",
+                   HMP_INFO_VIRTIO_ITEM, "guest features:",
+                   info->guest_features);
+
+    if (info->features) {
+        monitor_printf(mon, "%*s%-*s\n", HMP_INFO_VIRTIO_INDENT, "",
+                       HMP_INFO_VIRTIO_ITEM, "feature names:");
+        monitor_printf(mon, "%*s%-*s%-*s%-*s%-*s\n", HMP_INFO_VIRTIO_INDENT, "",
+                       HMP_INFO_VIRTIO_FIELD, "TYPE",
+                       HMP_INFO_VIRTIO_FIELD, "NAME",
+                       HMP_INFO_VIRTIO_FIELD, "HOST",
+                       HMP_INFO_VIRTIO_FIELD, "GUEST");
+    }
+
+    for (head = info->features; head; head = head->next) {
+        VirtioFeature *feature = head->value;
+        const char *type = VirtioFeatureNameKind_str(feature->name->type);
+        const char *host = feature->host ? "true" : "false";
+        const char *guest = feature->guest ? "true" : "false";
+        const char *name;
+
+        switch (feature->name->type) {
+        case VIRTIO_FEATURE_NAME_KIND_COMMON:
+            name = VirtioFeatureCommon_str(feature->name->u.common.data);
+            break;
+        case VIRTIO_FEATURE_NAME_KIND_NET:
+            name = VirtioFeatureNet_str(feature->name->u.net.data);
+            break;
+        case VIRTIO_FEATURE_NAME_KIND_BLK:
+            name = VirtioFeatureBlk_str(feature->name->u.blk.data);
+            break;
+        case VIRTIO_FEATURE_NAME_KIND_SERIAL:
+            name = VirtioFeatureSerial_str(feature->name->u.serial.data);
+            break;
+        case VIRTIO_FEATURE_NAME_KIND_BALLOON:
+            name = VirtioFeatureBalloon_str(feature->name->u.balloon.data);
+            break;
+        case VIRTIO_FEATURE_NAME_KIND_SCSI:
+            name = VirtioFeatureScsi_str(feature->name->u.scsi.data);
+            break;
+        case VIRTIO_FEATURE_NAME_KIND_VIRTFS:
+            name = VirtioFeatureVirtfs_str(feature->name->u.virtfs.data);
+            break;
+        case VIRTIO_FEATURE_NAME_KIND_GPU:
+            name = VirtioFeatureGpu_str(feature->name->u.gpu.data);
+            break;
+        default:
+        case VIRTIO_FEATURE_NAME_KIND_OTHER:
+            name = VirtioFeatureOther_str(feature->name->u.other.data);
+            break;
+        }
+
+        monitor_printf(mon, "%*s%-*s%-*s%-*s%-*s\n", HMP_INFO_VIRTIO_INDENT, "",
+                       HMP_INFO_VIRTIO_FIELD, type,
+                       HMP_INFO_VIRTIO_FIELD, name,
+                       HMP_INFO_VIRTIO_FIELD, host,
+                       HMP_INFO_VIRTIO_FIELD, guest);
+    }
+}
+
+static void hmp_info_virtio_print(Monitor *mon, VirtioInfo *info)
+{
+    Object *obj = object_resolve_path(info->qom_path, NULL);
+    char *path = qdev_get_dev_path(DEVICE(obj));
+
+    monitor_printf(mon, "%s at %s\n", object_get_typename(obj), path);
+    g_free(path);
+
+    monitor_printf(mon, "%*s%-*s%s\n", HMP_INFO_VIRTIO_INDENT, "",
+                   HMP_INFO_VIRTIO_ITEM, "QOM path:", info->qom_path);
+
+    hmp_info_virtio_print_status(mon, info);
+    hmp_info_virtio_print_features(mon, info);
+}
+
+void hmp_info_virtio(Monitor *mon, const QDict *qdict)
+{
+    const char *path = qdict_get_try_str(qdict, "path");
+    Error *err = NULL;
+    VirtioInfoList *head, *info;
+
+
+    head = qmp_query_virtio(!!path, path, &err);
+    if (err) {
+        return;
+    }
+
+    for (info = head; info; info = info->next) {
+        hmp_info_virtio_print(mon, info->value);
+    }
+
+    qapi_free_VirtioInfoList(head);
+}
diff --git a/hmp.h b/hmp.h
index 3605003..3e8f30a 100644
--- a/hmp.h
+++ b/hmp.h
@@ -146,5 +146,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_virtio(Monitor *mon, const QDict *qdict);
 
 #endif
-- 
2.1.4
