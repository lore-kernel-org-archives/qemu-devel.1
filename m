Received: from eggs.gnu.org ([2001:4830:134:3::10]:45426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6j-0001Yw-3b
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6d-0006s2-Rt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cin6d-0006rK-JR
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:39 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49A554E326
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DFAF62D655
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 20:06:14 +0100
Message-Id: <1488308796-28832-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 04/26] qmp: Dumb down how we run QMP command
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The way we get QMP commands registered is high tech:

* qapi-commands.py generates qmp_init_marshal() that does the actual work

* it also generates the magic to register it as a MODULE_INIT_QAPI
  function, so it runs when someone calls
  module_call_init(MODULE_INIT_QAPI)

* main() calls module_call_init()

QEMU needs to register a few non-qapified commands.  Same high tech
works: monitor.c has its own qmp_init_marshal() along with the magic
to make it run in module_call_init(MODULE_INIT_QAPI).

QEMU also needs to unregister commands that are not wanted in this
build's configuration (commit 5032a16).  Simple enough:
qmp_unregister_commands_hack().  The difficulty is to make it run
after the generated qmp_init_marshal().  We can't simply run it in
monitor.c's qmp_init_marshal(), because the order in which the
registered functions run is indeterminate.  So qmp_init_marshal()
registers qmp_unregister_commands_hack() separately.  Since
registering *appends* to the list of registered functions, this will
make it run after all the functions that have been registered already.

I suspect it takes a long and expensive computer science education to
not find this silly.

Dumb it down as follows:

* Drop MODULE_INIT_QAPI entirely

* Give the generated qmp_init_marshal() external linkage.

* Call it instead of module_call_init(MODULE_INIT_QAPI)

* Except in QEMU proper, call new monitor_init_qmp_commands() that in
  turn calls the generated qmp_init_marshal(), registers the
  additional commands and unregisters the unwanted ones.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488303560-18803-5-git-send-email-armbru@redhat.com>
---
 include/monitor/monitor.h | 1 +
 include/qemu/module.h     | 2 --
 monitor.c                 | 9 ++++-----
 qga/main.c                | 2 +-
 scripts/qapi-commands.py  | 5 ++---
 tests/test-qmp-commands.c | 2 +-
 vl.c                      | 2 +-
 7 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index e64b944..d2b3aaf 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -16,6 +16,7 @@ extern Monitor *cur_mon;
 
 bool monitor_cur_is_qmp(void);
 
+void monitor_init_qmp_commands(void);
 void monitor_init(Chardev *chr, int flags);
 void monitor_cleanup(void);
 
diff --git a/include/qemu/module.h b/include/qemu/module.h
index 877cca7..56dd218 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -42,7 +42,6 @@ static void __attribute__((constructor)) do_qemu_init_ ## function(void)    \
 typedef enum {
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
-    MODULE_INIT_QAPI,
     MODULE_INIT_QOM,
     MODULE_INIT_TRACE,
     MODULE_INIT_MAX
@@ -50,7 +49,6 @@ typedef enum {
 
 #define block_init(function) module_init(function, MODULE_INIT_BLOCK)
 #define opts_init(function) module_init(function, MODULE_INIT_OPTS)
-#define qapi_init(function) module_init(function, MODULE_INIT_QAPI)
 #define type_init(function) module_init(function, MODULE_INIT_QOM)
 #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
 
diff --git a/monitor.c b/monitor.c
index f8f4a07..1cc2274 100644
--- a/monitor.c
+++ b/monitor.c
@@ -995,8 +995,10 @@ static void qmp_unregister_commands_hack(void)
 #endif
 }
 
-static void qmp_init_marshal(void)
+void monitor_init_qmp_commands(void)
 {
+    qmp_init_marshal();
+
     qmp_register_command("query-qmp-schema", qmp_query_qmp_schema,
                          QCO_NO_OPTIONS);
     qmp_register_command("device_add", qmp_device_add,
@@ -1004,12 +1006,9 @@ static void qmp_init_marshal(void)
     qmp_register_command("netdev_add", qmp_netdev_add,
                          QCO_NO_OPTIONS);
 
-    /* call it after the rest of qapi_init() */
-    register_module_init(qmp_unregister_commands_hack, MODULE_INIT_QAPI);
+    qmp_unregister_commands_hack();
 }
 
-qapi_init(qmp_init_marshal);
-
 /* set the current CPU defined by the user */
 int monitor_set_cpu(int cpu_index)
 {
diff --git a/qga/main.c b/qga/main.c
index 538e4ee..6f8c614 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1321,7 +1321,7 @@ int main(int argc, char **argv)
 
     config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
 
-    module_call_init(MODULE_INIT_QAPI);
+    qmp_init_marshal();
 
     init_dfl_pathnames();
     config_load(config);
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 09e8467..a75946f 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -208,14 +208,12 @@ def gen_register_command(name, success_response):
 def gen_registry(registry):
     ret = mcgen('''
 
-static void qmp_init_marshal(void)
+void qmp_init_marshal(void)
 {
 ''')
     ret += registry
     ret += mcgen('''
 }
-
-qapi_init(qmp_init_marshal);
 ''')
     return ret
 
@@ -308,6 +306,7 @@ fdecl.write(mcgen('''
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
 
+void qmp_init_marshal(void);
 ''',
                   prefix=prefix))
 
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index ff94481..c4e20d1 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -273,7 +273,7 @@ int main(int argc, char **argv)
     g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
     g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
 
-    module_call_init(MODULE_INIT_QAPI);
+    qmp_init_marshal();
     g_test_run();
 
     return 0;
diff --git a/vl.c b/vl.c
index e10a27b..c6020b9 100644
--- a/vl.c
+++ b/vl.c
@@ -2987,7 +2987,7 @@ int main(int argc, char **argv, char **envp)
     qemu_init_exec_dir(argv[0]);
 
     module_call_init(MODULE_INIT_QOM);
-    module_call_init(MODULE_INIT_QAPI);
+    monitor_init_qmp_commands();
 
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
-- 
2.7.4
