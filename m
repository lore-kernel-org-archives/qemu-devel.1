Received: from eggs.gnu.org ([2001:4830:134:3::10]:33985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48An-0004Yq-Sv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e48Am-00072b-O8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e48Am-000726-GE
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:23:24 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 16 Oct 2017 18:22:52 +0200
Message-Id: <1508170976-96869-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 2/6] numa: split out NumaOptions parsing into
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
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

it will allow to reuse parse_NumaOptions() for parsing
configuration commands received via QMP interface

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/sysemu/numa.h |  1 +
 numa.c                | 48 +++++++++++++++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index c19e456..aad4230 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -30,6 +30,7 @@ struct NumaNodeMem {
 };
 
 extern NodeInfo numa_info[MAX_NODES];
+int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
diff --git a/numa.c b/numa.c
index 18af4ff..d8e7dc0 100644
--- a/numa.c
+++ b/numa.c
@@ -254,28 +254,11 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
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
@@ -310,6 +293,33 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
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
