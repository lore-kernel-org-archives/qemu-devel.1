Received: from eggs.gnu.org ([2001:4830:134:3::10]:46270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAAF-0004kv-Rv
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAAE-0000E8-Kc
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOAAE-0000Cc-Ca
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:28 -0300
Message-Id: <20180530230528.30166-13-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] tests: functional tests for QMP command
 set-numa-node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

 * start QEMU with 2 unmapped cpus,
 * while in preconfig state
    * add 2 numa nodes
    * assign cpus to them
 * exit preconfig and in running state check that cpus
   are mapped correctly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1526556607-268163-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/libqtest.h  |  9 +++++++
 tests/libqtest.c  |  7 ++++++
 tests/numa-test.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/qmp-test.c  |  7 ------
 4 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index cbe8df4473..ac52872cbe 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -972,4 +972,13 @@ void qtest_qmp_device_add(const char *driver, const char *id, const char *fmt,
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
index 43fb97e035..e0ca19dbfe 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1098,3 +1098,10 @@ void qtest_qmp_device_del(const char *id)
     qobject_unref(response1);
     qobject_unref(response2);
 }
+
+bool qmp_rsp_is_err(QDict *rsp)
+{
+    QDict *error = qdict_get_qdict(rsp, "error");
+    qobject_unref(rsp);
+    return !!error;
+}
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 169213fc1c..b7a6ef8815 100644
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
+                              "-nodefaults --preconfig -smp 2");
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
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'exit-preconfig' }")));
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
+        cpu = qobject_to(QDict, e);
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
+        qobject_unref(e);
+    }
+    qobject_unref(resp);
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
index 2ee441cdb3..a49cbc6fde 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -392,13 +392,6 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
 
-static bool qmp_rsp_is_err(QDict *rsp)
-{
-    QDict *error = qdict_get_qdict(rsp, "error");
-    qobject_unref(rsp);
-    return !!error;
-}
-
 static void test_qmp_preconfig(void)
 {
     QDict *rsp, *ret;
-- 
2.17.1
