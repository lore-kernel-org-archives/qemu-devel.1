Received: from eggs.gnu.org ([2001:4830:134:3::10]:58236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2ZyH-0006YW-9C
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2ZyE-0005pc-70
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:40:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e2ZyE-0005ol-1F
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:40:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62A0E820F7
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 09:40:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 12 Oct 2017 11:39:58 +0200
Message-Id: <1507801198-98182-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] numa: fixup parsed NumaNodeOptions earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

numa 'mem' option with suffix or without one is possible
only on CLI/HMP. Instead of fixing up special suffix less
CLI case deep in parse_numa_node() do it earlier right
after option is parsed into NumaNodeOptions with OptVisistor
so that the rest of the code would use valid values in
NumaNodeOptions and won't have to reparse QemuOpts.

It will help to isolate CLI/HMP parts in parse_numa() and
split out parsed NumaNodeOptions processing into separate
function that could be reused by QMP handler where we have
only NumaNodeOptions and don't need any fixups.

While at it reuse qemu_strtosz_MiB() instead of manually
checking for suffixes.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/numa.c b/numa.c
index 17ea514..fb4c35a 100644
--- a/numa.c
+++ b/numa.c
@@ -38,6 +38,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
+#include "qemu/cutils.h"
 
 QemuOptsList qemu_numa_opts = {
     .name = "numa",
@@ -142,7 +143,7 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp)
 }
 
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
-                            QemuOpts *opts, Error **errp)
+                            Error **errp)
 {
     uint16_t nodenr;
     uint16List *cpus = NULL;
@@ -199,13 +200,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     }
 
     if (node->has_mem) {
-        uint64_t mem_size = node->mem;
-        const char *mem_str = qemu_opt_get(opts, "mem");
-        /* Fix up legacy suffix-less format */
-        if (g_ascii_isdigit(mem_str[strlen(mem_str) - 1])) {
-            mem_size <<= 20;
-        }
-        numa_info[nodenr].node_mem = mem_size;
+        numa_info[nodenr].node_mem = node->mem;
     }
     if (node->has_memdev) {
         Object *o;
@@ -290,9 +285,15 @@ int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
         goto end;
     }
 
+    /* Fix up legacy suffix-less format */
+    if ((object->type == NUMA_OPTIONS_TYPE_NODE) && object->u.node.has_mem) {
+        const char *mem_str = qemu_opt_get(opts, "mem");
+        qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
+    }
+
     switch (object->type) {
     case NUMA_OPTIONS_TYPE_NODE:
-        parse_numa_node(ms, &object->u.node, opts, &err);
+        parse_numa_node(ms, &object->u.node, &err);
         if (err) {
             goto end;
         }
-- 
2.7.4
