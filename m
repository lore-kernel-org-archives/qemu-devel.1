Received: from eggs.gnu.org ([2001:4830:134:3::10]:45568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPu-0000VJ-9X
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPq-0002K5-GG
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:35:10 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:48 +0100
Message-Id: <1490189568-167621-24-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 23/23] tests: check -numa node,
 cpu=props_list usecase
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
 tests/numa-test.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 8326321..d371923 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -130,6 +130,144 @@ static void test_query_cpus(const void *data)
     g_free(cli);
 }
 
+static void pc_numa_cpu(const void *data)
+{
+    char *cli;
+    QDict *resp;
+    QList *cpus;
+    const QObject *e;
+
+    cli = make_cli(data, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
+        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-numa cpu,node-id=1,socket-id=0 "
+        "-numa cpu,node-id=0,socket-id=1,core-id=0 "
+        "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
+        "-numa cpu,node-id=1,socket-id=1,core-id=1,thread-id=1");
+    qtest_start(cli);
+    cpus = get_cpus(&resp);
+    g_assert(cpus);
+
+    while ((e = qlist_pop(cpus))) {
+        QDict *cpu, *props;
+        int64_t socket, core, thread, node;
+
+        cpu = qobject_to_qdict(e);
+        g_assert(qdict_haskey(cpu, "props"));
+        props = qdict_get_qdict(cpu, "props");
+
+        g_assert(qdict_haskey(props, "node-id"));
+        node = qdict_get_int(props, "node-id");
+        g_assert(qdict_haskey(props, "socket-id"));
+        socket = qdict_get_int(props, "socket-id");
+        g_assert(qdict_haskey(props, "core-id"));
+        core = qdict_get_int(props, "core-id");
+        g_assert(qdict_haskey(props, "thread-id"));
+        thread = qdict_get_int(props, "thread-id");
+
+        if (socket == 0) {
+            g_assert_cmpint(node, ==, 1);
+        } else if (socket == 1 && core == 0) {
+            g_assert_cmpint(node, ==, 0);
+        } else if (socket == 1 && core == 1 && thread == 0) {
+            g_assert_cmpint(node, ==, 0);
+        } else if (socket == 1 && core == 1 && thread == 1) {
+            g_assert_cmpint(node, ==, 1);
+        } else {
+            g_assert(false);
+        }
+    }
+
+    QDECREF(resp);
+    qtest_end();
+    g_free(cli);
+}
+
+static void spapr_numa_cpu(const void *data)
+{
+    char *cli;
+    QDict *resp;
+    QList *cpus;
+    const QObject *e;
+
+    cli = make_cli(data, "-smp 4,cores=4 "
+        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-numa cpu,node-id=0,core-id=0 "
+        "-numa cpu,node-id=0,core-id=1 "
+        "-numa cpu,node-id=0,core-id=2 "
+        "-numa cpu,node-id=1,core-id=3");
+    qtest_start(cli);
+    cpus = get_cpus(&resp);
+    g_assert(cpus);
+
+    while ((e = qlist_pop(cpus))) {
+        QDict *cpu, *props;
+        int64_t core, node;
+
+        cpu = qobject_to_qdict(e);
+        g_assert(qdict_haskey(cpu, "props"));
+        props = qdict_get_qdict(cpu, "props");
+
+        g_assert(qdict_haskey(props, "node-id"));
+        node = qdict_get_int(props, "node-id");
+        g_assert(qdict_haskey(props, "core-id"));
+        core = qdict_get_int(props, "core-id");
+
+        if (core >= 0 && core < 3) {
+            g_assert_cmpint(node, ==, 0);
+        } else if (core == 3) {
+            g_assert_cmpint(node, ==, 1);
+        } else {
+            g_assert(false);
+        }
+    }
+
+    QDECREF(resp);
+    qtest_end();
+    g_free(cli);
+}
+
+static void aarch64_numa_cpu(const void *data)
+{
+    char *cli;
+    QDict *resp;
+    QList *cpus;
+    const QObject *e;
+
+    cli = make_cli(data, "-smp 2 "
+        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-numa cpu,node-id=1,thread-id=0 "
+        "-numa cpu,node-id=0,thread-id=1");
+    qtest_start(cli);
+    cpus = get_cpus(&resp);
+    g_assert(cpus);
+
+    while ((e = qlist_pop(cpus))) {
+        QDict *cpu, *props;
+        int64_t thread, node;
+
+        cpu = qobject_to_qdict(e);
+        g_assert(qdict_haskey(cpu, "props"));
+        props = qdict_get_qdict(cpu, "props");
+
+        g_assert(qdict_haskey(props, "node-id"));
+        node = qdict_get_int(props, "node-id");
+        g_assert(qdict_haskey(props, "thread-id"));
+        thread = qdict_get_int(props, "thread-id");
+
+        if (thread == 0) {
+            g_assert_cmpint(node, ==, 1);
+        } else if (thread == 1) {
+            g_assert_cmpint(node, ==, 0);
+        } else {
+            g_assert(false);
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
@@ -146,5 +284,18 @@ int main(int argc, char **argv)
     qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
     qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cpus);
 
+    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
+        qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
+    }
+
+    if (!strcmp(arch, "ppc64")) {
+        qtest_add_data_func("/numa/spapr/cpu/explicit", args, spapr_numa_cpu);
+    }
+
+    if (!strcmp(arch, "aarch64")) {
+        qtest_add_data_func("/numa/aarch64/cpu/explicit", args,
+                            aarch64_numa_cpu);
+    }
+
     return g_test_run();
 }
-- 
2.7.4
