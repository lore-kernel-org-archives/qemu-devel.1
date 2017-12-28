Received: from eggs.gnu.org ([2001:4830:134:3::10]:44698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtv-0006pf-3i
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtr-0006Rn-LX
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUbtr-0006RE-By
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:23 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 28 Dec 2017 18:22:56 +0100
Message-Id: <1514481779-184817-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
References: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 1/4] numa: split out NumaOptions parsing into
 parse_NumaOptions()
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

it will allow to reuse parse_NumaOptions() for parsing
configuration commands received via QMP interface

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/sysemu/numa.h |  1 +
 numa.c                | 48 +++++++++++++++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index b354521..4621312 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -23,6 +23,7 @@ struct NumaNodeMem {
 };
 
 extern NodeInfo numa_info[MAX_NODES];
+int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
 void parse_numa_opts(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
 extern QemuOptsList qemu_numa_opts;
diff --git a/numa.c b/numa.c
index 7b9c33a..d157961 100644
--- a/numa.c
+++ b/numa.c
@@ -168,28 +168,11 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     have_numa_distance = true;
 }
 
-static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
+static
+void parse_NumaOptions(MachineState *ms, NumaOptions *object, Error **errp)
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
@@ -223,6 +206,33 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
     }
 
 end:
+    if (err) {
+        error_propagate(errp, err);
+    }
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
+    parse_NumaOptions(ms, object, &err);
+
+end:
     qapi_free_NumaOptions(object);
     if (err) {
         error_report_err(err);
-- 
2.7.4
