Received: from eggs.gnu.org ([2001:4830:134:3::10]:33031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWEr-0006rQ-4k
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWEq-0002Ok-41
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fEWEp-0002Nk-Tl
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83A1881A88A6
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:38:47 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri,  4 May 2018 10:37:40 +0200
Message-Id: <1525423069-61903-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v7 02/11] numa: split out NumaOptions parsing
 into set_numa_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

it will allow to reuse set_numa_options() for parsing
configuration commands received via QMP interface

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v5:
  - (Eduardo Habkost <ehabkost@redhat.com>)
    * drop if (err) guard around error_propagate()
    * s/parse_NumaOptions/set_numa_options/
---
 include/sysemu/numa.h |  1 +
 numa.c                | 46 +++++++++++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 21713b7..7a0ae75 100644
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
index d0abd7c..63e3989 100644
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
@@ -224,6 +207,31 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
     }
 
 end:
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
+end:
     qapi_free_NumaOptions(object);
     if (err) {
         error_report_err(err);
-- 
2.7.4
