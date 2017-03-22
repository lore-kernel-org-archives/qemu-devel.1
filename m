Received: from eggs.gnu.org ([2001:4830:134:3::10]:45235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPQ-0008RC-Ri
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPM-0002A9-Rc
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:40 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:41 +0100
Message-Id: <1490189568-167621-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 16/23] tests: numa: add case for QMP
 command query-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/numa-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index f5da0c8..8326321 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -87,6 +87,49 @@ static void test_mon_partial(const void *data)
     g_free(cli);
 }
 
+static QList* get_cpus(QDict **resp) {
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
@@ -101,6 +144,7 @@ int main(int argc, char **argv)
     qtest_add_data_func("/numa/mon/default", args, test_mon_default);
     qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explicit);
     qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
+    qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cpus);
 
     return g_test_run();
 }
-- 
2.7.4
