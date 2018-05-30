Received: from eggs.gnu.org ([2001:4830:134:3::10]:46139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9y-0004Wg-8A
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9x-0008Ua-4f
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOA9w-0008UK-V6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:19 -0300
Message-Id: <20180530230528.30166-4-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/12] numa: split out NumaOptions parsing into
 set_numa_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it will allow to reuse set_numa_options() for parsing
configuration commands received via QMP interface

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1525423069-61903-3-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h |  1 +
 numa.c                | 46 +++++++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 21713b7e2f..7a0ae751aa 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -22,6 +22,7 @@ struct NumaNodeMem {
 };
 
 extern NodeInfo numa_info[MAX_NODES];
+int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
diff --git a/numa.c b/numa.c
index ad1d7934f2..53bd65a05d 100644
--- a/numa.c
+++ b/numa.c
@@ -169,28 +169,11 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     have_numa_distance = true;
 }
 
-static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
+static
+void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
-    NumaOptions *object = NULL;
-    MachineState *ms = opaque;
     Error *err = NULL;
 
-    {
-        Visitor *v = opts_visitor_new(opts);
-        visit_type_NumaOptions(v, NULL, &object, &err);
-        visit_free(v);
-    }
-
-    if (err) {
-        goto end;
-    }
-
-    /* Fix up legacy suffix-less format */
-    if ((object->type == NUMA_OPTIONS_TYPE_NODE) && object->u.node.has_mem) {
-        const char *mem_str = qemu_opt_get(opts, "mem");
-        qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
-    }
-
     switch (object->type) {
     case NUMA_OPTIONS_TYPE_NODE:
         parse_numa_node(ms, &object->u.node, &err);
@@ -223,6 +206,31 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
         abort();
     }
 
+end:
+    error_propagate(errp, err);
+}
+
+int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
+{
+    NumaOptions *object = NULL;
+    MachineState *ms = MACHINE(opaque);
+    Error *err = NULL;
+    Visitor *v = opts_visitor_new(opts);
+
+    visit_type_NumaOptions(v, NULL, &object, &err);
+    visit_free(v);
+    if (err) {
+        goto end;
+    }
+
+    /* Fix up legacy suffix-less format */
+    if ((object->type == NUMA_OPTIONS_TYPE_NODE) && object->u.node.has_mem) {
+        const char *mem_str = qemu_opt_get(opts, "mem");
+        qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
+    }
+
+    set_numa_options(ms, object, &err);
+
 end:
     qapi_free_NumaOptions(object);
     if (err) {
-- 
2.17.1
