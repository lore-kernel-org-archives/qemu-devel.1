Received: from eggs.gnu.org ([2001:4830:134:3::10]:44389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI7-0004TH-5w
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI6-0003bW-6m
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1emfI6-0003bP-2L
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:02 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 16 Feb 2018 13:37:20 +0100
Message-Id: <1518784641-43151-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 8/9] QMP: add set-numa-node command
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

Command is allowed to run only in preconfig stage and
will allow to configure numa mapping for CPUs depending
on possible CPUs layout (query-hotpluggable-cpus) for
given machine instance.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c           |  5 +++++
 qapi-schema.json | 14 ++++++++++++++
 tests/qmp-test.c |  6 ++++++
 3 files changed, 25 insertions(+)

diff --git a/numa.c b/numa.c
index 04e34eb..e3b7f15 100644
--- a/numa.c
+++ b/numa.c
@@ -446,6 +446,11 @@ void parse_numa_opts(MachineState *ms)
     }
 }
 
+void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
+{
+    parse_NumaOptions(MACHINE(qdev_get_machine()), cmd, errp);
+}
+
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
 {
     int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
diff --git a/qapi-schema.json b/qapi-schema.json
index 4365dfe..a96c31f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3201,3 +3201,17 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @set-numa-node:
+#
+# Runtime equivalent of '-numa' CLI option, available at
+# preconfigure stage to configure numa mapping before initializing
+# machine.
+#
+# Since 2.12
+##
+{ 'command': 'set-numa-node', 'boxed': true,
+  'data': 'NumaOptions',
+  'runstates': [ 'preconfig' ]
+}
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 4ab0b7c..b0de2b1 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -324,6 +324,8 @@ static void test_qmp_preconfig(void)
     /* enabled commands, no error expected  */
     g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-commands' }")));
     g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-hotpluggable-cpus'}")));
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
 
     /* forbidden commands, expected error */
     g_assert(is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
@@ -347,6 +349,10 @@ static void test_qmp_preconfig(void)
     /* enabled commands, no error expected  */
     g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
 
+    /* forbidden commands, expected error */
+    g_assert(is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
+
     qtest_quit(qs);
 }
 
-- 
2.7.4
