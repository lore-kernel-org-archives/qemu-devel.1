Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48B0-0004jx-UK
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48Az-0007Hj-Tx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e48Az-0007HA-K9
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:37 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 16 Oct 2017 18:22:55 +0200
Message-Id: <1508170976-96869-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 5/6] HMP: add set-numa-node command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hmp.h           |  1 +
 hmp-commands.hx | 13 +++++++++++++
 hmp.c           | 23 +++++++++++++++++++++++
 numa.c          | 19 +++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/hmp.h b/hmp.h
index 3605003..6e87f46 100644
--- a/hmp.h
+++ b/hmp.h
@@ -146,5 +146,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_set_numa_node(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19..1f95b3f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1837,6 +1837,19 @@ Print QOM properties of object at location @var{path}
 ETEXI
 
     {
+        .name       = "set-numa-node",
+        .args_type  = "numa:O",
+        .params     = "see -numa CLI option for possible options",
+        .help       = "assign CPU to numa node",
+        .cmd        = hmp_set_numa_node,
+    },
+
+STEXI
+@item qom-set @var{path} @var{property} @var{value}
+Set QOM property @var{property} of object at location @var{path} to value @var{value}
+ETEXI
+
+    {
         .name       = "qom-set",
         .args_type  = "path:s,property:s,value:s",
         .params     = "path property value",
diff --git a/hmp.c b/hmp.c
index 739d330..69bae5b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -43,6 +43,7 @@
 #include "hw/intc/intc.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
+#include "sysemu/numa.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -2896,3 +2897,25 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, &err);
 }
+
+void hmp_set_numa_node(Monitor *mon, const QDict *qdict)
+{
+    QemuOpts *opts;
+    Error *err = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    opts = qemu_opts_from_qdict(qemu_find_opts("numa"), qdict, &err);
+    if (err) {
+        goto end;
+    }
+
+    parse_numa(ms, opts, &err);
+    if (err) {
+        goto end;
+    }
+
+end:
+    if (err) {
+        hmp_handle_error(mon, &err);
+    }
+}
diff --git a/numa.c b/numa.c
index d8e7dc0..a530d9c 100644
--- a/numa.c
+++ b/numa.c
@@ -47,6 +47,12 @@ QemuOptsList qemu_numa_opts = {
     .desc = { { 0 } } /* validated with OptsVisitor */
 };
 
+static enum {
+    NUMA_DISABLED, /* no numa was configured */
+    NUMA_ENABLED,  /* numa configuration is in process */
+    NUMA_COMPLETE, /* configuration is complete and can't be altered */
+} numa_is_configured;
+
 static int have_memdevs = -1;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
@@ -259,6 +265,18 @@ void parse_NumaOptions(MachineState *ms, NumaOptions *object, Error **errp)
 {
     Error *err = NULL;
 
+    if (numa_is_configured == NUMA_COMPLETE) {
+        error_setg(&err, "NUMA configuration is finalized and can't be changed,"
+                   " use CLI option or set-numa-node HMP/QMP command at"
+                   " preconfig stage");
+        goto end;
+    } else if (runstate_check(RUN_STATE_PRELAUNCH)) {
+        numa_is_configured = NUMA_ENABLED;
+    } else {
+        error_setg(&err, "NUMA is not enabled at start/preconfig stage");
+        goto end;
+    }
+
     switch (object->type) {
     case NUMA_OPTIONS_TYPE_NODE:
         parse_numa_node(ms, &object->u.node, &err);
@@ -512,6 +530,7 @@ void numa_complete_configuration(MachineState *ms)
     } else {
         numa_set_mem_node_id(0, ram_size, 0);
     }
+    numa_is_configured = NUMA_COMPLETE;
 }
 
 void parse_numa_opts(MachineState *ms)
-- 
2.7.4
