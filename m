Received: from eggs.gnu.org ([2001:4830:134:3::10]:55223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eQfUV-0005CH-9s
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eQfUQ-00036C-Md
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:24:55 -0500
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Sun, 17 Dec 2017 23:25:55 +0300
Message-Id: <1513542355-28203-3-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel]  [RFC v6 2/2] virtio: add `info virtio' HMP command
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

The command prints data from `query-virtio' QMP in human-readable
format.

Cc: Denis V. Lunev <den@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 hmp-commands-info.hx | 14 ++++++++++
 hmp.c                | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hmp.h                |  1 +
 3 files changed, 89 insertions(+)

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
index 35a7041..786782b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -43,6 +43,7 @@
 #include "hw/intc/intc.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
+#include "hw/virtio/virtio.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -2918,3 +2919,76 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+#define HMP_INFO_VIRTIO_INDENT 2
+#define HMP_INFO_VIRTIO_FEATURE 40
+
+static void hmp_info_virtio_print(Monitor *mon, VirtioInfo *info)
+{
+    Object *obj = object_resolve_path(info->qom_path, NULL);
+    char *path = qdev_get_dev_path(DEVICE(obj));
+    VirtioFeatureList *feat;
+    strList *status;
+
+    monitor_printf(mon, "%s at %s\n", object_get_typename(obj), path);
+    g_free(path);
+
+    monitor_printf(mon, "%*sQOM path: %s\n",
+                   HMP_INFO_VIRTIO_INDENT, "", info->qom_path);
+
+    /* device status */
+    monitor_printf(mon, "%*sstatus: 0x%02"PRIx8"\n",
+                   HMP_INFO_VIRTIO_INDENT, "", info->status);
+    for (status = info->status_names; status; status = status->next) {
+        monitor_printf(mon, "%*s%s\n",
+                       HMP_INFO_VIRTIO_INDENT * 2, "", status->value);
+    }
+
+
+    /* host and guest feature */
+    monitor_printf(mon, "%*shost features:  0x%016"PRIx64"\n",
+                   HMP_INFO_VIRTIO_INDENT, "", info->host_features);
+    monitor_printf(mon, "%*sguest features: 0x%016"PRIx64"\n",
+                   HMP_INFO_VIRTIO_INDENT, "", info->guest_features);
+
+    /* common features */
+    monitor_printf(mon, "%*scommon features:%s\n",
+                   HMP_INFO_VIRTIO_INDENT, "",
+                   info->common_features_names ? "" : " (none)");
+    for (feat = info->common_features_names; feat; feat = feat->next) {
+        monitor_printf(mon, "%*s%-*s%s\n",
+                       HMP_INFO_VIRTIO_INDENT * 2, "",
+                       HMP_INFO_VIRTIO_FEATURE, feat->value->name,
+                       feat->value->acked ? " acked" : "");
+    }
+
+    /* device features */
+    monitor_printf(mon, "%*sdevice features:%s\n",
+                   HMP_INFO_VIRTIO_INDENT, "",
+                   info->device_features_names ? "" : " (none)");
+    for (feat = info->device_features_names; feat; feat = feat->next) {
+        monitor_printf(mon, "%*s%-*s%s\n",
+                       HMP_INFO_VIRTIO_INDENT * 2, "",
+                       HMP_INFO_VIRTIO_FEATURE, feat->value->name,
+                       feat->value->acked ? " acked" : "");
+    }
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
index a6f56b1..156293e 100644
--- a/hmp.h
+++ b/hmp.h
@@ -147,5 +147,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_virtio(Monitor *mon, const QDict *qdict);
 
 #endif
-- 
2.1.4
