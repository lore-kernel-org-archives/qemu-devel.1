Received: from eggs.gnu.org ([2001:4830:134:3::10]:40672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dKlMB-0005EB-2x
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dKlM6-0002un-U8
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:55:39 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dKlM6-0002uB-Km
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:55:34 -0400
Received: by mail-wr0-x236.google.com with SMTP id q97so142192072wrb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 05:55:34 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Tue, 13 Jun 2017 14:55:15 +0200
Message-Id: <20170613125515.30416-2-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20170613125515.30416-1-vadim.galitsyn@profitbricks.com>
References: <20170613125515.30416-1-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Commands above provide the following memory information in bytes:

  * base-memory - amount of static memory specified
    with '-m' option at the start of the QEMU process.

  * hot-plug-memory - amount of memory that was hot-plugged.

  * ballooned-actual-memory - size of the memory that remains
    available to the guest after ballooning, as reported by the
    guest. If the guest has not reported its memory, this value
    equals to @base-memory + @hot-plug-memory. If ballooning
    is not enabled, zero value is reported.

NOTE:

    Parameter @ballooned-actual-memory reports the same as
    "info balloon" command when ballooning is enabled. The idea
    to have it in scope of this command(s) comes from
    https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html.

Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hmp-commands-info.hx | 15 +++++++++++++++
 hmp.c                | 14 ++++++++++++++
 hmp.h                |  1 +
 qapi-schema.json     | 27 +++++++++++++++++++++++++++
 qmp.c                | 29 +++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ae16901..bc37525 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -834,5 +834,20 @@ STEXI
 ETEXI
 
 STEXI
+@item info memory
+@findex memory
+Display total memory size in bytes (static, hotplugged, ballooned)
+ETEXI
+
+    {
+        .name       = "memory",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show memory size information in bytes (static, "
+                      "hotplugged, ballooned)",
+        .cmd        = hmp_info_memory,
+    },
+
+STEXI
 @end table
 ETEXI
diff --git a/hmp.c b/hmp.c
index 8c72c58..81e383f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2817,3 +2817,17 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
     qapi_free_GuidInfo(info);
 }
+
+void hmp_info_memory(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    MemoryInfo *info = qmp_query_memory(&err);
+    if (info) {
+        monitor_printf(mon, "base-memory: %lu\n", info->base_memory);
+        monitor_printf(mon, "hot-plug-memory: %lu\n", info->hot_plug_memory);
+        monitor_printf(mon, "ballooned-actual-memory: %lu\n",
+                       info->ballooned_actual_memory);
+        g_free(info);
+    }
+    hmp_handle_error(mon, &err);
+}
diff --git a/hmp.h b/hmp.h
index d8b94ce..c422aa2 100644
--- a/hmp.h
+++ b/hmp.h
@@ -143,5 +143,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
+void hmp_info_memory(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi-schema.json b/qapi-schema.json
index 4b50b65..33cd7cb 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4325,6 +4325,33 @@
             '*unavailable-features': [ 'str' ], 'typename': 'str' } }
 
 ##
+# @MemoryInfo:
+#
+# Memory information in bytes.
+#
+# @base-memory: size of static memory which was specified on Qemu start.
+#
+# @hot-plug-memory: size of hot-plugged memory.
+#
+# @ballooned-actual-memory: amount of guest memory available after ballooning.
+#
+# Since: 2.10.0
+##
+{ 'struct': 'MemoryInfo',
+  'data'  : { 'base-memory': 'int', 'hot-plug-memory': 'int',
+              'ballooned-actual-memory': 'int' } }
+
+##
+# @query-memory:
+#
+# Return memory size information which includes
+# static, hotplugged and ballooned memory.
+#
+# Since: 2.10.0
+##
+{ 'command': 'query-memory', 'returns': 'MemoryInfo' }
+
+##
 # @query-cpu-definitions:
 #
 # Return a list of supported virtual CPU definitions
diff --git a/qmp.c b/qmp.c
index 7ee9bcf..59fe57e 100644
--- a/qmp.c
+++ b/qmp.c
@@ -712,3 +712,32 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
 
     return head;
 }
+
+MemoryInfo *qmp_query_memory(Error **errp)
+{
+    MemoryInfo *mem_info = g_malloc0(sizeof(MemoryInfo));
+    BalloonInfo *balloon_info;
+    Error *local_err = NULL;
+
+    mem_info->base_memory = ram_size;
+    mem_info->hot_plug_memory = pc_existing_dimms_capacity(&local_err);
+    if (local_err) {
+        error_setg(errp, "could not get hot-plug memory info: %s",
+                   error_get_pretty(local_err));
+        g_free(mem_info);
+        return NULL;
+    }
+
+    /* In case if it is not possible to get balloon info, just ignore it. */
+    balloon_info = qmp_query_balloon(&local_err);
+    if (local_err) {
+        mem_info->ballooned_actual_memory = 0;
+        error_free(local_err);
+    } else {
+        mem_info->ballooned_actual_memory = balloon_info->actual;
+    }
+
+    qapi_free_BalloonInfo(balloon_info);
+
+    return mem_info;
+}
-- 
2.1.4
