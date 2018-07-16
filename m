Received: from eggs.gnu.org ([2001:4830:134:3::10]:33992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47r-0001pv-Q3
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47o-0007w2-PE
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ff47o-0007vX-EK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 127438315E
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-125.ams2.redhat.com
	[10.36.116.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE7AA2026D65
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 16:05:11 +0200
Message-Id: <20180716140514.1490-3-armbru@redhat.com>
In-Reply-To: <20180716140514.1490-1-armbru@redhat.com>
References: <20180716140514.1490-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] cli qmp: Mark --preconfig,
 exit-preconfig experimental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Committing to the current --preconfig / exit-preconfig interface
before it has seen any use is premature.  Mark both as experimental,
the former in documentation, the latter by renaming it to
x-exit-preconfig.

See the previous commit for more detailed rationale.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180705091402.26244-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
[Straightforward conflict with commit 514337c142f resolved]
---
 hmp.c             | 2 +-
 qapi/misc.json    | 6 +++---
 qemu-options.hx   | 9 +++++----
 qemu-tech.texi    | 8 ++++----
 qmp.c             | 2 +-
 tests/numa-test.c | 2 +-
 tests/qmp-test.c  | 6 +++---
 7 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/hmp.c b/hmp.c
index 4555b503ac..2aafb50e8e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1076,7 +1076,7 @@ void hmp_exit_preconfig(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    qmp_exit_preconfig(&err);
+    qmp_x_exit_preconfig(&err);
     hmp_handle_error(mon, &err);
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index f1860418e8..d450cfef21 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1205,7 +1205,7 @@
 { 'command': 'cont' }
 
 ##
-# @exit-preconfig:
+# @x-exit-preconfig:
 #
 # Exit from "preconfig" state
 #
@@ -1221,11 +1221,11 @@
 #
 # Example:
 #
-# -> { "execute": "exit-preconfig" }
+# -> { "execute": "x-exit-preconfig" }
 # <- { "return": {} }
 #
 ##
-{ 'command': 'exit-preconfig', 'allow-preconfig': true }
+{ 'command': 'x-exit-preconfig', 'allow-preconfig': true }
 
 ##
 # @system_wakeup:
diff --git a/qemu-options.hx b/qemu-options.hx
index 654e69cc3b..371c4271a4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3303,16 +3303,17 @@ Run the emulation in single step mode.
 ETEXI
 
 DEF("preconfig", 0, QEMU_OPTION_preconfig, \
-    "--preconfig     pause QEMU before machine is initialized\n",
+    "--preconfig     pause QEMU before machine is initialized (experimental)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item --preconfig
 @findex --preconfig
 Pause QEMU for interactive configuration before the machine is created,
 which allows querying and configuring properties that will affect
-machine initialization. Use the QMP command 'exit-preconfig' to exit
-the preconfig state and move to the next state (ie. run guest if -S
-isn't used or pause the second time if -S is used).
+machine initialization.  Use QMP command 'x-exit-preconfig' to exit
+the preconfig state and move to the next state (i.e. run guest if -S
+isn't used or pause the second time if -S is used).  This option is
+experimental.
 ETEXI
 
 DEF("S", 0, QEMU_OPTION_S, \
diff --git a/qemu-tech.texi b/qemu-tech.texi
index f843341ffa..7c3d1f05e1 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -336,9 +336,9 @@ additionally configure the machine (by hotplugging devices) in runtime before
 allowing VM code to run.
 
 However, at the -S pause point, it's impossible to configure options that affect
-initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. That's
-when the --preconfig command line option should be used. It allows pausing QEMU
-before the initial VM creation, in a new preconfig state, where additional
+initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. The
+experimental --preconfig command line option  allows pausing QEMU
+before the initial VM creation, in a ``preconfig'' state, where additional
 queries and configuration can be performed via QMP before moving on to
 the resulting configuration startup. In the preconfig state, QEMU only allows
 a limited set of commands over the QMP monitor, where the commands do not
@@ -348,7 +348,7 @@ depend on an initialized machine, including but not limited to:
 @item query-qmp-schema
 @item query-commands
 @item query-status
-@item exit-preconfig
+@item x-exit-preconfig
 @end table
 
 @node Bibliography
diff --git a/qmp.c b/qmp.c
index 5170403e5d..e7c0a2fd60 100644
--- a/qmp.c
+++ b/qmp.c
@@ -129,7 +129,7 @@ void qmp_cpu_add(int64_t id, Error **errp)
     }
 }
 
-void qmp_exit_preconfig(Error **errp)
+void qmp_x_exit_preconfig(Error **errp)
 {
     if (!runstate_check(RUN_STATE_PRECONFIG)) {
         error_setg(errp, "The command is permitted only in '%s' state",
diff --git a/tests/numa-test.c b/tests/numa-test.c
index b7a6ef8815..893f826acb 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -285,7 +285,7 @@ static void pc_dynamic_cpu_cfg(const void *data)
         " 'arguments': { 'type': 'cpu', 'node-id': 1, 'socket-id': 0 } }")));
 
     /* let machine initialization to complete and run */
-    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'exit-preconfig' }")));
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconfig' }")));
     qtest_qmp_eventwait(qs, "RESUME");
 
     /* check that CPUs are mapped as expected */
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index ceaf4a6789..b9774084f8 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -453,7 +453,7 @@ static void test_qmp_preconfig(void)
     qobject_unref(rsp);
 
     /* exit preconfig state */
-    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'exit-preconfig' }")));
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconfig' }")));
     qtest_qmp_eventwait(qs, "RESUME");
 
     /* check that query-status returns running state */
@@ -463,8 +463,8 @@ static void test_qmp_preconfig(void)
     g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "running");
     qobject_unref(rsp);
 
-    /* check that exit-preconfig returns error after exiting preconfig */
-    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'exit-preconfig' }")));
+    /* check that x-exit-preconfig returns error after exiting preconfig */
+    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconfig' }")));
 
     /* enabled commands, no error expected  */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
-- 
2.17.1
