Received: from eggs.gnu.org ([2001:4830:134:3::10]:45299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJW-0000jn-Pc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJV-0005zO-Mw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJV-0005z8-IC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24B9076FB9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:09 -0500
Message-Id: <20180312183628.394722-19-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 18/36] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Peter Xu <peterx@redhat.com>

There are many places where the monitor initializes its globals:

- monitor_init_qmp_commands() at the very beginning
- single function to init monitor_lock
- in the first entry of monitor_init() using "is_first_init"

Unify them a bit.

monitor_lock is not used before monitor_init() (as confirmed by code
analysis and gdb watchpoints); so we are safe delaying what was a
constructor-time initialization of the mutex into the later first call
to monitor_init().

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-8-peterx@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/monitor/monitor.h |  2 +-
 vl.c                      |  7 ++++++-
 monitor.c                 | 25 ++++++++++---------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index d1024d4bdc3..0cb0538a315 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -16,7 +16,7 @@ extern Monitor *cur_mon;

 bool monitor_cur_is_qmp(void);

-void monitor_init_qmp_commands(void);
+void monitor_init_globals(void);
 void monitor_init(Chardev *chr, int flags);
 void monitor_cleanup(void);

diff --git a/vl.c b/vl.c
index 3ef04ce991f..2e4fac7e4a0 100644
--- a/vl.c
+++ b/vl.c
@@ -3065,7 +3065,6 @@ int main(int argc, char **argv, char **envp)
     qemu_init_exec_dir(argv[0]);

     module_call_init(MODULE_INIT_QOM);
-    monitor_init_qmp_commands();

     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -4535,6 +4534,12 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);

+    /*
+     * Note: qtest_enabled() (which is used in monitor_qapi_event_init())
+     * depends on configure_accelerator() above.
+     */
+    monitor_init_globals();
+
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
         exit(1);
diff --git a/monitor.c b/monitor.c
index 83e98741b4c..71d53be1ddd 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1003,7 +1003,7 @@ static void qmp_unregister_commands_hack(void)
 #endif
 }

-void monitor_init_qmp_commands(void)
+static void monitor_init_qmp_commands(void)
 {
     /*
      * Two command lists:
@@ -3985,6 +3985,14 @@ static void sortcmdlist(void)
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
@@ -4025,23 +4033,10 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
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
+    Monitor *mon = g_malloc(sizeof(*mon));

-    if (is_first_init) {
-        monitor_qapi_event_init();
-        sortcmdlist();
-        is_first_init = 0;
-    }
-
-    mon = g_malloc(sizeof(*mon));
     monitor_data_init(mon, false);

     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
-- 
2.14.3
