Received: from eggs.gnu.org ([2001:4830:134:3::10]:38202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJsn-00082O-3o
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJsm-0006yF-0T
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJsl-0006y8-Nb
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:50 +0800
Message-Id: <20171116130610.23582-8-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 07/27] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

There are many places for monitor init its globals, at least:

- monitor_init_qmp_commands() at the very beginning
- single function to init monitor_lock
- in the first entry of monitor_init() using "is_first_init"

Unify them a bit.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/monitor/monitor.h |  2 +-
 monitor.c                 | 25 ++++++++++---------------
 vl.c                      |  3 ++-
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 83ea4a1aaf..3a5128ab1b 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -16,7 +16,7 @@ extern Monitor *cur_mon;
 
 bool monitor_cur_is_qmp(void);
 
-void monitor_init_qmp_commands(void);
+void monitor_init_globals(void);
 void monitor_init(Chardev *chr, int flags);
 void monitor_cleanup(void);
 
diff --git a/monitor.c b/monitor.c
index 322dfb5f31..ac5313023b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1001,7 +1001,7 @@ static void qmp_unregister_commands_hack(void)
 #endif
 }
 
-void monitor_init_qmp_commands(void)
+static void monitor_init_qmp_commands(void)
 {
     /*
      * Two command lists:
@@ -4034,6 +4034,14 @@ static void sortcmdlist(void)
     qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
 }
 
+void monitor_init_globals(void)
+{
+    monitor_init_qmp_commands();
+    monitor_qapi_event_init();
+    sortcmdlist();
+    qemu_mutex_init(&monitor_lock);
+}
+
 /* These functions just adapt the readline interface in a typesafe way.  We
  * could cast function pointers but that discards compiler checks.
  */
@@ -4074,23 +4082,10 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
     }
 }
 
-static void __attribute__((constructor)) monitor_lock_init(void)
-{
-    qemu_mutex_init(&monitor_lock);
-}
-
 void monitor_init(Chardev *chr, int flags)
 {
-    static int is_first_init = 1;
-    Monitor *mon;
-
-    if (is_first_init) {
-        monitor_qapi_event_init();
-        sortcmdlist();
-        is_first_init = 0;
-    }
+    Monitor *mon = g_malloc(sizeof(*mon));
 
-    mon = g_malloc(sizeof(*mon));
     monitor_data_init(mon, false);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
diff --git a/vl.c b/vl.c
index 7372424fa7..f1c6ef6d95 100644
--- a/vl.c
+++ b/vl.c
@@ -3144,7 +3144,6 @@ int main(int argc, char **argv, char **envp)
     qemu_init_exec_dir(argv[0]);
 
     module_call_init(MODULE_INIT_QOM);
-    monitor_init_qmp_commands();
 
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -4692,6 +4691,8 @@ int main(int argc, char **argv, char **envp)
 
     parse_numa_opts(current_machine);
 
+    monitor_init_globals();
+
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
         exit(1);
-- 
2.13.6
