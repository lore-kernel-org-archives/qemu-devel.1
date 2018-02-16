Received: from eggs.gnu.org ([2001:4830:134:3::10]:44400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI8-0004U6-OK
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI7-0003cA-NJ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1emfI7-0003c6-In
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:03 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 16 Feb 2018 13:37:21 +0100
Message-Id: <1518784641-43151-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 9/9] tests: functional tests for QMP command
 set-numa-node
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

 * start QEMU with 2 unmapped cpus,
 * while in preconfig state
    * add 2 numa nodes
    * assign cpus to them
 * exit preconfig and in running state check that cpus
   are mapped correctly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/numa-test.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 68aca9c..11c2842 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -260,6 +260,76 @@ static void aarch64_numa_cpu(const void *data)
     g_free(cli);
 }
 
+static bool is_err(QDict *response)
+{
+    const char *desc = NULL;
+    QDict *error = qdict_get_qdict(response, "error");
+    if (error) {
+        desc = qdict_get_try_str(error, "desc");
+    }
+    QDECREF(response);
+    return !!desc;
+}
+
+static void pc_dynamic_cpu_cfg(const void *data)
+{
+    QObject *e;
+    QDict *resp;
+    QList *cpus;
+    QTestState *qs;
+
+    qs = qtest_startf("%s %s", data ? (char *)data : "",
+                              "-nodefaults -preconfig -smp 2");
+
+    /* create 2 numa nodes */
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
+
+    /* map 2 cpus in non default reverse order
+     * i.e socket1->node0, socket0->node1
+     */
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'cpu', 'node-id': 0, 'socket-id': 1 } }")));
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'cpu', 'node-id': 1, 'socket-id': 0 } }")));
+
+    /* let machine initialization to complete and run */
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'cont' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    /* check that CPUs are mapped as expected */
+    resp = qtest_qmp(qs, "{ 'execute': 'query-hotpluggable-cpus'}");
+    g_assert(qdict_haskey(resp, "return"));
+    cpus = qdict_get_qlist(resp, "return");
+    g_assert(cpus);
+    while ((e = qlist_pop(cpus))) {
+        const QDict *cpu, *props;
+        int64_t socket, node;
+
+        cpu = qobject_to_qdict(e);
+        g_assert(qdict_haskey(cpu, "props"));
+        props = qdict_get_qdict(cpu, "props");
+
+        g_assert(qdict_haskey(props, "node-id"));
+        node = qdict_get_int(props, "node-id");
+        g_assert(qdict_haskey(props, "socket-id"));
+        socket = qdict_get_int(props, "socket-id");
+
+        if (socket == 0) {
+            g_assert_cmpint(node, ==, 1);
+        } else if (socket == 1) {
+            g_assert_cmpint(node, ==, 0);
+        } else {
+            g_assert(false);
+        }
+        qobject_decref(e);
+    }
+
+    qtest_quit(qs);
+}
+
 int main(int argc, char **argv)
 {
     const char *args = NULL;
@@ -278,6 +348,7 @@ int main(int argc, char **argv)
 
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
         qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
+        qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_cfg);
     }
 
     if (!strcmp(arch, "ppc64")) {
-- 
2.7.4
