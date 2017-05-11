Received: from eggs.gnu.org ([2001:4830:134:3::10]:38009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcW-0002lV-GV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcU-0007xG-3S
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcT-0007wZ-MA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:34 -0300
Message-Id: <20170511191843.13784-21-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 20/29] tests: numa: add case for QMP command
 query-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <1494415802-227633-13-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c            | 14 --------------
 tests/numa-test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/numa.c b/numa.c
index c89fc2d4a5..f16a6a8ade 100644
--- a/numa.c
+++ b/numa.c
@@ -737,20 +737,6 @@ MemdevList *qmp_query_memdev(Error **errp)
     return list;
 }
 
-int numa_get_node_for_cpu(int idx)
-{
-    int i;
-
-    assert(idx < max_cpus);
-
-    for (i = 0; i < nb_numa_nodes; i++) {
-        if (test_bit(idx, numa_info[i].node_cpu)) {
-            break;
-        }
-    }
-    return i;
-}
-
 void ram_block_notifier_add(RAMBlockNotifier *n)
 {
     QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
diff --git a/tests/numa-test.c b/tests/numa-test.c
index f5da0c845b..27226877af 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -87,6 +87,50 @@ static void test_mon_partial(const void *data)
     g_free(cli);
 }
 
+static QList *get_cpus(QDict **resp)
+{
+    *resp = qmp("{ 'execute': 'query-cpus' }");
+    g_assert(*resp);
+    g_assert(qdict_haskey(*resp, "return"));
+    return  qdict_get_qlist(*resp, "return");
+}
+
+static void test_query_cpus(const void *data)
+{
+    char *cli;
+    QDict *resp;
+    QList *cpus;
+    const QObject *e;
+
+    cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
+    qtest_start(cli);
+    cpus = get_cpus(&resp);
+    g_assert(cpus);
+
+    while ((e = qlist_pop(cpus))) {
+        QDict *cpu, *props;
+        int64_t cpu_idx, node;
+
+        cpu = qobject_to_qdict(e);
+        g_assert(qdict_haskey(cpu, "CPU"));
+        g_assert(qdict_haskey(cpu, "props"));
+
+        cpu_idx = qdict_get_int(cpu, "CPU");
+        props = qdict_get_qdict(cpu, "props");
+        g_assert(qdict_haskey(props, "node-id"));
+        node = qdict_get_int(props, "node-id");
+        if (cpu_idx >= 0 && cpu_idx < 4) {
+            g_assert_cmpint(node, ==, 0);
+        } else {
+            g_assert_cmpint(node, ==, 1);
+        }
+    }
+
+    QDECREF(resp);
+    qtest_end();
+    g_free(cli);
+}
+
 int main(int argc, char **argv)
 {
     const char *args = NULL;
@@ -101,6 +145,7 @@ int main(int argc, char **argv)
     qtest_add_data_func("/numa/mon/default", args, test_mon_default);
     qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explicit);
     qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
+    qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cpus);
 
     return g_test_run();
 }
-- 
2.11.0.259.g40922b1
