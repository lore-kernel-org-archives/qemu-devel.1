Received: from eggs.gnu.org ([2001:4830:134:3::10]:44697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtv-0006pe-37
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtt-0006TP-PD
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUbtt-0006Sv-HR
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:25 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 28 Dec 2017 18:22:57 +0100
Message-Id: <1514481779-184817-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
References: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/4] HMP: add set-numa-node command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hmp.h           |  1 +
 hmp-commands.hx | 13 +++++++++++++
 hmp.c           | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/hmp.h b/hmp.h
index a6f56b1..d861038 100644
--- a/hmp.h
+++ b/hmp.h
@@ -147,5 +147,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_set_numa_node(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 6d5ebdf..17f8504 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1816,6 +1816,19 @@ Print QOM properties of object at location @var{path}
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
index 35a7041..c8ed910 100644
--- a/hmp.c
+++ b/hmp.c
@@ -43,6 +43,7 @@
 #include "hw/intc/intc.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
+#include "sysemu/numa.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -2918,3 +2919,25 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
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
-- 
2.7.4
