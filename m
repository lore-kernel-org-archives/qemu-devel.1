Received: from eggs.gnu.org ([2001:4830:134:3::10]:44944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhw9v-0000lJ-Qa
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhw9t-0008H1-6A
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:47 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dhw9t-0008F8-03
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:45 -0400
Received: by mail-wr0-x229.google.com with SMTP id x43so12497541wrb.3
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 04:06:44 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Wed, 16 Aug 2017 13:06:26 +0200
Message-Id: <1502881586-25044-3-git-send-email-vadim.galitsyn@profitbricks.com>
In-Reply-To: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
References: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH v6 3/3] hmp: introduce 'info
 memory_size_summary' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

This command is an equivalent of QMP command query-memory-size-summary.
It provides the following memory information in bytes:

  * base-memory - size of "base" memory specified with command line option -m.

  * plugged-memory - amount of memory that was hot-plugged.
    If target does not have CONFIG_MEM_HOTPLUG enabled, no
    value is reported.

Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hmp-commands-info.hx | 16 ++++++++++++++++
 hmp.c                | 16 ++++++++++++++++
 hmp.h                |  1 +
 3 files changed, 33 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238..04c9db8 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -850,6 +850,22 @@ ETEXI
     },
 
 STEXI
+@item info memory_size_summary
+@findex memory_size_summary
+Display the amount of initially allocated and hot-plugged (if
+enabled) memory in bytes.
+ETEXI
+
+    {
+        .name       = "memory_size_summary",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the amount of initially allocated and "
+                      "hot-plugged (if enabled) memory in bytes.",
+        .cmd        = hmp_info_memory_size_summary,
+    },
+
+STEXI
 @end table
 ETEXI
 
diff --git a/hmp.c b/hmp.c
index fd80dce..3615e71 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2868,3 +2868,19 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
     qapi_free_GuidInfo(info);
 }
+
+void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
+{
+    MemoryInfo *info = qmp_query_memory_size_summary(&error_abort);
+    if (info) {
+        monitor_printf(mon, "base memory: %" PRIu64 "\n",
+                       info->base_memory);
+
+        if (info->has_plugged_memory) {
+            monitor_printf(mon, "plugged memory: %" PRIu64 "\n",
+                           info->plugged_memory);
+        }
+
+        qapi_free_MemoryInfo(info);
+    }
+}
diff --git a/hmp.h b/hmp.h
index 1ff4552..3605003 100644
--- a/hmp.h
+++ b/hmp.h
@@ -145,5 +145,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
+void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 
 #endif
-- 
2.1.4
