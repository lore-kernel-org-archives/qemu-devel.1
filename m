Received: from eggs.gnu.org ([2001:4830:134:3::10]:51472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dzMcD-0005Ke-NO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dzMcC-0000Nc-1f
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:48:01 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:19160 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.dakinevich@virtuozzo.com>)
	id 1dzMcB-0000Iz-LI
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:47:59 -0400
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Tue,  3 Oct 2017 15:47:41 +0300
Message-Id: <1507034861-4661-3-git-send-email-jan.dakinevich@virtuozzo.com>
In-Reply-To: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 2/2] virtio: add `info virtio' HMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>

The command prints data from `query-virtio' QMP in human-readable
format.

Cc: Denis V. Lunev <den@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 hmp-commands-info.hx | 14 ++++++++++
 hmp.c                | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hmp.h                |  1 +
 3 files changed, 94 insertions(+)

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
 
diff --git a/hmp.c b/hmp.c
index ace729d..c4dd280 100644
--- a/hmp.c
+++ b/hmp.c
@@ -43,6 +43,7 @@
 #include "hw/intc/intc.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
+#include "hw/virtio/virtio.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -2894,3 +2895,81 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+#define HMP_INFO_VIRTIO_INDENT 2
+#define HMP_INFO_VIRTIO_FIELD 32
+
+static void hmp_info_virtio_print_status(Monitor *mon, VirtioInfo *info,
+                                         VirtioInfoDevice *device)
+{
+    VirtioInfoBitList *lbit;
+    const char *comma = "";
+
+    for (lbit = info->status_names; lbit; lbit = lbit->next) {
+        if (!(device->status & (1ull << lbit->value->bit))) {
+            continue;
+        }
+        monitor_printf(mon, "%s%s", comma, lbit->value->name);
+        comma = ",";
+    }
+    monitor_printf(mon, "\n");
+}
+
+static void hmp_info_virtio_print_features(Monitor *mon,
+                                           VirtioInfoBitList *list,
+                                           VirtioInfoDevice *device)
+{
+    VirtioInfoBitList *lbit;
+
+    for (lbit = list; lbit; lbit = lbit->next) {
+        const char *ack = virtio_has_feature(device->guest_features,
+                                             lbit->value->bit) ? "acked" : "";
+        if (!virtio_has_feature(device->host_features, lbit->value->bit)) {
+            continue;
+        }
+        monitor_printf(mon, "%*s%*s%*s\n", HMP_INFO_VIRTIO_INDENT, "",
+                       HMP_INFO_VIRTIO_FIELD, lbit->value->name,
+                       HMP_INFO_VIRTIO_FIELD, ack);
+    }
+}
+
+static void hmp_info_virtio_print(Monitor *mon, VirtioInfo *info,
+                                  VirtioInfoDevice *device)
+{
+    Object *obj = object_resolve_path(device->qom_path, NULL);
+    char *path = qdev_get_dev_path(DEVICE(obj));
+
+    monitor_printf(mon, "%s at %s\n", object_get_typename(obj), path);
+    g_free(path);
+
+    monitor_printf(mon, "%*sstatus:           0x%02"PRIx64" ",
+                   HMP_INFO_VIRTIO_INDENT, "", device->status);
+    hmp_info_virtio_print_status(mon, info, device);
+
+    monitor_printf(mon, "%*shost features:    0x%016"PRIx64"\n",
+                   HMP_INFO_VIRTIO_INDENT, "", device->host_features);
+    monitor_printf(mon, "%*sguest features:   0x%016"PRIx64"\n",
+                   HMP_INFO_VIRTIO_INDENT, "", device->guest_features);
+
+    monitor_printf(mon, "%*scommon features:\n", HMP_INFO_VIRTIO_INDENT, "");
+    hmp_info_virtio_print_features(mon, info->feature_names, device);
+
+    monitor_printf(mon, "%*sspecific features:\n", HMP_INFO_VIRTIO_INDENT, "");
+    hmp_info_virtio_print_features(mon, device->feature_names, device);
+}
+
+void hmp_info_virtio(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    VirtioInfo *info;
+    VirtioInfoDeviceList *ldevice;
+
+    info = qmp_query_virtio(&err);
+    if (err) {
+        return;
+    }
+
+    for (ldevice = info->devices; ldevice; ldevice = ldevice->next) {
+        hmp_info_virtio_print(mon, info, ldevice->value);
+    }
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
