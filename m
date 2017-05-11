Received: from eggs.gnu.org ([2001:4830:134:3::10]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tch-0002tH-Ey
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcg-00081d-8j
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcg-00081D-00
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:40 -0300
Message-Id: <20170511191843.13784-27-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 26/29] tests: check -numa node,
 cpu=props_list usecase
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
Message-Id: <1494415802-227633-19-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/numa-test.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 27226877af..c3475d6d5e 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -131,6 +131,144 @@ static void test_query_cpus(const void *data)
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
@@ -147,5 +285,18 @@ int main(int argc, char **argv)
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
2.11.0.259.g40922b1
