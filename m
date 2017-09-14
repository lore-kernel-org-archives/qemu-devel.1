Received: from eggs.gnu.org ([2001:4830:134:3::10]:60656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsViI-0007Px-6h
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsViH-00032Z-3k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsViG-000311-Rc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:57 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:47 +0100
Message-Id: <20170914150447.19352-8-dgilbert@redhat.com>
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] hmp: introduce 'info memory_size_summary'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>

Add 'info memory_size_summary' command which is a sibling
of QMP command query-memory-size-summary. It provides the
following memory information in bytes:

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
Message-Id: <20170829153022.27004-4-vadim.galitsyn@profitbricks.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fixed up comments from Igor's review
---
 hmp-commands-info.hx | 16 ++++++++++++++++
 hmp.c                | 18 ++++++++++++++++++
 hmp.h                |  1 +
 3 files changed, 35 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 4ab7fcee98..1c6772597d 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -851,6 +851,22 @@ ETEXI
     },
 
 STEXI
+@item info memory_size_summary
+@findex memory_size_summary
+Display the amount of initially allocated and present hotpluggable (if
+enabled) memory in bytes.
+ETEXI
+
+    {
+        .name       = "memory_size_summary",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the amount of initially allocated and "
+                      "present hotpluggable (if enabled) memory in bytes.",
+        .cmd        = hmp_info_memory_size_summary,
+    },
+
+STEXI
 @end table
 ETEXI
 
diff --git a/hmp.c b/hmp.c
index cd046c6d71..0fb2bc7043 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2862,3 +2862,21 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
     qapi_free_GuidInfo(info);
 }
+
+void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    MemoryInfo *info = qmp_query_memory_size_summary(&err);
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
+    hmp_handle_error(mon, &err);
+}
diff --git a/hmp.h b/hmp.h
index 1ff455295e..3605003e4c 100644
--- a/hmp.h
+++ b/hmp.h
@@ -145,5 +145,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
+void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 
 #endif
-- 
2.13.5
