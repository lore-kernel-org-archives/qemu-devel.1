Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A8CC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9B523718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="PmZjNk0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9B523718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVbS-00086R-Ow
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e19ada89f61345a2260f2b6ebd07fda9ed6458ce@lizzy.crudebyte.com>)
 id 1kMVaF-0006wg-W8
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:15:16 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:45003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e19ada89f61345a2260f2b6ebd07fda9ed6458ce@lizzy.crudebyte.com>)
 id 1kMVaD-0006Mz-Kz
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=u38o6Urrjnc7Jg5615IWWJbb5xaiKnTL1nkmnv3/K9c=; b=PmZjN
 k0LK2vP+JqanH5bn77zJ89uC9JByY/m9klei9Wo1k0ESGnMDYxVUctplxoreyqi3dX40wJQ1i2MYk
 HyfI45UKukZrzNOqv61aBVuWDD9oql58zJPufC6/F5HssyUWSm/jleb51osIX3fGG1sT935SzGp40
 y7km85xP4luGxL7wZIbCEgwiP9bMxoyMA8u09bgTiqcrL7tIe4ewrYQefYWUJwjrHmpT44tHHfiTU
 VRnVmqEXnuqjZGulTwlMsomss4rP91MHkZELCIu/gE4g4bW+E8R1GGelfLrhNfNRN88nLiqD3egAE
 EvnTeBRQTHA3AMYafSDNHQG92t5sg==;
Message-Id: <e19ada89f61345a2260f2b6ebd07fda9ed6458ce.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:39:00 +0200
Subject: [PATCH 02/12] tests/qtest/qgraph: add qos_node_create_driver_named()
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=e19ada89f61345a2260f2b6ebd07fda9ed6458ce@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far the qos subsystem of the qtest framework had the limitation
that only one instance of the same official QEMU (QMP) driver name
could be created for qtests. That's because a) the created qos
node names must always be unique, b) the node name must match the
official QEMU driver name being instantiated and c) all nodes are
in a global space shared by all tests.

This patch removes this limitation by introducing a new function
qos_node_create_driver_named() which allows test case authors to
specify a node name being different from the actual associated
QEMU driver name. It fills the new 'qemu_name' field of
QOSGraphNode for that purpose.

build_driver_cmd_line() and qos_graph_node_set_availability() had
to be adjusted to correctly deal with either accessing node name
vs. node's qemu_name correctly.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/qgraph.c | 53 ++++++++++++++++++++++++++++++++++---
 tests/qtest/libqos/qgraph.h | 16 +++++++++++
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index e42f3eaafa..61faf6b27d 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -287,7 +287,8 @@ static void build_machine_cmd_line(QOSGraphNode *node, const char *args)
  */
 static void build_driver_cmd_line(QOSGraphNode *node)
 {
-    node->command_line = g_strconcat(" -device ", node->name, NULL);
+    const char *name = node->qemu_name ?: node->name;
+    node->command_line = g_strconcat(" -device ", name, NULL);
 }
 
 /* qos_print_cb(): callback prints all path found by the DFS algorithm. */
@@ -632,6 +633,15 @@ void qos_node_create_driver(const char *name, QOSCreateDriverFunc function)
     node->u.driver.constructor = function;
 }
 
+void qos_node_create_driver_named(const char *name, const char *qemu_name,
+                                  QOSCreateDriverFunc function)
+{
+    QOSGraphNode *node = create_node(name, QNODE_DRIVER);
+    node->qemu_name = g_strdup(qemu_name);
+    build_driver_cmd_line(node);
+    node->u.driver.constructor = function;
+}
+
 void qos_node_contains(const char *container, const char *contained,
                        QOSGraphEdgeOptions *opts, ...)
 {
@@ -664,7 +674,7 @@ void qos_node_consumes(const char *consumer, const char *interface,
     add_edge(interface, consumer, QEDGE_CONSUMED_BY, opts);
 }
 
-void qos_graph_node_set_availability(const char *node, bool av)
+static void qos_graph_node_set_availability_explicit(const char *node, bool av)
 {
     QOSGraphEdgeList *elist;
     QOSGraphNode *n = search_node(node);
@@ -679,9 +689,46 @@ void qos_graph_node_set_availability(const char *node, bool av)
     }
     QSLIST_FOREACH_SAFE(e, elist, edge_list, next) {
         if (e->type == QEDGE_CONTAINS || e->type == QEDGE_PRODUCES) {
-            qos_graph_node_set_availability(e->dest, av);
+            qos_graph_node_set_availability_explicit(e->dest, av);
+        }
+    }
+}
+
+/*
+ * Behaves as qos_graph_node_set_availability_explicit(), except that the
+ * former always matches by node name only, whereas this function matches both
+ * by node name and node's optional 'qemu_name' field.
+ */
+void qos_graph_node_set_availability(const char *node, bool av)
+{
+    GList *l;
+    QOSGraphEdgeList *elist;
+    QOSGraphEdge *e, *next;
+    QOSGraphNode *n;
+    GList *keys = g_hash_table_get_keys(node_table);
+
+    for (l = keys; l != NULL; l = l->next) {
+        const gchar *key = l->data;
+        n = g_hash_table_lookup(node_table, key);
+        /*
+         * node's 'qemu_name' is set if there is more than one device with
+         * the same QEMU (QMP) device name
+         */
+        const char *node_name = n->qemu_name ?: n->name;
+        if (g_strcmp0(node_name, node) == 0) {
+            n->available = av;
+            elist = get_edgelist(n->name);
+            if (elist) {
+                QSLIST_FOREACH_SAFE(e, elist, edge_list, next) {
+                    if (e->type == QEDGE_CONTAINS || e->type == QEDGE_PRODUCES)
+                    {
+                        qos_graph_node_set_availability_explicit(e->dest, av);
+                    }
+                }
+            }
         }
     }
+    g_list_free(keys);
 }
 
 void qos_graph_foreach_test_path(QOSTestCallback fn)
diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index 5f63d352ca..f472949f68 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -452,6 +452,22 @@ void qos_node_create_machine_args(const char *name,
  */
 void qos_node_create_driver(const char *name, QOSCreateDriverFunc function);
 
+/**
+ * Behaves as qos_node_create_driver() with the extension of allowing to
+ * specify a different node name vs. associated QEMU device name.
+ *
+ * Use this function instead of qos_node_create_driver() if you need to create
+ * several instances of the same QEMU device. You are free to choose a custom
+ * node name, however the chosen node name must always be unique.
+ *
+ * @param name: custom, unique name of the node to be created
+ * @param qemu_name: actual (official) QEMU driver name the node shall be
+ *                   associated with
+ * @param function: driver constructor
+ */
+void qos_node_create_driver_named(const char *name, const char *qemu_name,
+                                  QOSCreateDriverFunc function);
+
 /**
  * qos_node_contains(): creates one or more edges of type QEDGE_CONTAINS
  * and adds them to the edge list mapped to @container in the
-- 
2.20.1


