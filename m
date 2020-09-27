Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D6C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6B423718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Rjjgy3n8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6B423718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVel-0003vF-G3
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b40b46794184fc18bbd39d8aa7f01ca3ee1fbb2f@lizzy.crudebyte.com>)
 id 1kMVdK-0002c0-ES
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:18:26 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:52907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b40b46794184fc18bbd39d8aa7f01ca3ee1fbb2f@lizzy.crudebyte.com>)
 id 1kMVdI-0006jf-PH
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=RpchxIRjTMmMwFMZr0cf7veocelrms95TEq16l9UbCI=; b=Rjjgy
 3n8LaAjKpQam7Z0TBI/9EcjqbYlPQmWY9dOfl3gxKaDIC7g/1mH+lcO9+Dn0TO8lzft2tXVZKWVXB
 oW6QYp1US/T7rdTwQd7uGO9KpLzcLE6OPk5z1OLyZVd6sLKt36G8y69l/tlFl1PMGC4UJUu/Y/16O
 G9yOVAnZv02POuRfBA70/FnJ2ya5duQgWDKdMzYJ5RlzXmcLV4sPvZ3PKajNJ5tmTdqoKDNgLVGZy
 3TzZoVnjoqs7QXqUQh1Ur3VrYNMxKrZ6bWZ3kkIXp+Gd6lo9OYpdOgjiR5VcHJUCo0r5xOhRU0/gk
 CUkeVlMY9e22kJBIG2+bXbdx/XaNA==;
Message-Id: <b40b46794184fc18bbd39d8aa7f01ca3ee1fbb2f.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:39:17 +0200
Subject: [PATCH 03/12] tests/qtest/qos: add qos_dump_graph()
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=b40b46794184fc18bbd39d8aa7f01ca3ee1fbb2f@lizzy.crudebyte.com;
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

This new function is purely for debugging purposes. It prints the
current qos graph to stdout and allows to identify problems in the
created qos graph e.g. when writing new qos tests.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/qgraph.c | 54 +++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/qgraph.h | 20 ++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index 61faf6b27d..e70635750e 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -805,3 +805,57 @@ void qos_delete_cmd_line(const char *name)
         node->command_line = NULL;
     }
 }
+
+#define RED(txt) (    \
+    "\033[0;91m" txt  \
+    "\033[0m"         \
+)
+
+#define GREEN(txt) (    \
+    "\033[0;92m" txt  \
+    "\033[0m"         \
+)
+
+void qos_dump_graph(void)
+{
+    GList *keys;
+    GList *l;
+    QOSGraphEdgeList *list;
+    QOSGraphEdge *e, *next;
+    QOSGraphNode *dest_node, *node;
+
+    printf("ALL QGRAPH EDGES: {\n");
+    keys = g_hash_table_get_keys(edge_table);
+    for (l = keys; l != NULL; l = l->next) {
+        const gchar *key = l->data;
+        printf("\t src='%s'\n", key);
+        list = get_edgelist(key);
+        QSLIST_FOREACH_SAFE(e, list, edge_list, next) {
+            dest_node = g_hash_table_lookup(node_table, e->dest);
+            printf("\t\t|-> dest='%s' type=%d (node=%p)",
+                   e->dest, e->type, dest_node);
+            if (!dest_node) {
+                printf(RED(" <------- ERROR !"));
+            }
+            printf("\n");
+        }
+    }
+    g_list_free(keys);
+    printf("}\n");
+
+    printf("ALL QGRAPH NODES: {\n");
+    keys = g_hash_table_get_keys(node_table);
+    for (l = keys; l != NULL; l = l->next) {
+        const gchar *key = l->data;
+        node = g_hash_table_lookup(node_table, key);
+        printf("\t name='%s' ", key);
+        if (node->qemu_name) {
+            printf("qemu_name='%s' ", node->qemu_name);
+        }
+        printf("type=%d cmd_line='%s' [%s]\n",
+               node->type, node->command_line,
+               node->available ? GREEN("available") : RED("UNAVAILBLE"));
+    }
+    g_list_free(keys);
+    printf("}\n");
+}
diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index f472949f68..07a32535f1 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -586,5 +586,25 @@ QOSGraphObject *qos_machine_new(QOSGraphNode *node, QTestState *qts);
 QOSGraphObject *qos_driver_new(QOSGraphNode *node, QOSGraphObject *parent,
                                QGuestAllocator *alloc, void *arg);
 
+/**
+ * Just for debugging purpose: prints all currently existing nodes and
+ * edges to stdout.
+ *
+ * All qtests add themselves to the overall qos graph by calling qgraph
+ * functions that add device nodes and edges between the individual graph
+ * nodes for tests. As the actual graph is assmbled at runtime by the qos
+ * subsystem, it is sometimes not obvious how the overall graph looks like.
+ * E.g. when writing new tests it may happen that those new tests are simply
+ * ignored by the qtest framework.
+ *
+ * This function allows to identify problems in the created qgraph. Keep in
+ * mind: only tests with a path down from the actual test case node (leaf) up
+ * to the graph's root node are actually executed by the qtest framework. And
+ * the qtest framework uses QMP to automatically check which QEMU drivers are
+ * actually currently available, and accordingly qos marks certain pathes as
+ * 'unavailable' in such cases (e.g. when QEMU was compiled without support for
+ * a certain feature).
+ */
+void qos_dump_graph(void);
 
 #endif
-- 
2.20.1


