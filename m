Received: from eggs.gnu.org ([2001:4830:134:3::10]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFw-0007ME-4O
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFu-0005bD-PT
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1evNFu-0005aT-KQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:46 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 12 Mar 2018 14:11:15 +0100
Message-Id: <1520860275-101576-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 9/9] tests: functional tests for QMP command
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
v4:
  * drop duplicate is_err() and reuse qmp_rsp_is_err() wich is moved
    to generic file libqtest.c. (Eric Blake <eblake@redhat.com>)
---
 tests/libqtest.h  |  9 ++++++++
 tests/libqtest.c  |  7 +++++++
 tests/numa-test.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/qmp-test.c  |  7 -------
 4 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 8111694..2e1f9b2 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -969,4 +969,13 @@ void qtest_qmp_device_add(const char *driver, const char *id, const char *fmt,
  */
 void qtest_qmp_device_del(const char *id);
 
+/**
+ * qmp_rsp_is_err:
+ * @rsp: QMP response to check for error
+ *
+ * Test @rsp for error and discard @rsp.
+ * Returns 'true' if there is error in @rsp and 'false' otherwise.
+ */
+bool qmp_rsp_is_err(QDict *rsp);
+
 #endif
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 13c9100..a7e91c5 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1096,3 +1096,10 @@ void qtest_qmp_device_del(const char *id)
     QDECREF(response1);
     QDECREF(response2);
 }
+
+bool qmp_rsp_is_err(QDict *rsp)
+{
+    QDict *error = qdict_get_qdict(rsp, "error");
+    QDECREF(rsp);
+    return !!error;
+}
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 68aca9c..4955927 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -260,6 +260,66 @@ static void aarch64_numa_cpu(const void *data)
     g_free(cli);
 }
 
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
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
+
+    /* map 2 cpus in non default reverse order
+     * i.e socket1->node0, socket0->node1
+     */
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'cpu', 'node-id': 0, 'socket-id': 1 } }")));
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'cpu', 'node-id': 1, 'socket-id': 0 } }")));
+
+    /* let machine initialization to complete and run */
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'cont' }")));
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
+    QDECREF(resp);
+
+    qtest_quit(qs);
+}
+
 int main(int argc, char **argv)
 {
     const char *args = NULL;
@@ -278,6 +338,7 @@ int main(int argc, char **argv)
 
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
         qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
+        qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_cfg);
     }
 
     if (!strcmp(arch, "ppc64")) {
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index cff880f..fad5bc6 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -305,13 +305,6 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
 
-static bool qmp_rsp_is_err(QDict *rsp)
-{
-    QDict *error = qdict_get_qdict(rsp, "error");
-    QDECREF(rsp);
-    return !!error;
-}
-
 static void test_qmp_preconfig(void)
 {
     QDict *rsp, *ret;
-- 
2.7.4
