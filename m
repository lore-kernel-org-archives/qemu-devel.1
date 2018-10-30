Received: from eggs.gnu.org ([2001:4830:134:3::10]:37707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVL-00031O-5H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVI-0005ri-FY
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHZVI-0005j4-3a
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Oct 2018 20:16:14 +0100
Message-Id: <20181030191620.32168-3-armbru@redhat.com>
In-Reply-To: <20181030191620.32168-1-armbru@redhat.com>
References: <20181030191620.32168-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] monitor: delay monitor iothread creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>

From: Wolfgang Bumiller <w.bumiller@proxmox.com>

Commit d32749deb615 moved the call to monitor_init_globals()
to before os_daemonize(), making it an unsuitable place to
spawn the monitor iothread as it won't be inherited over the
fork() in os_daemonize().

We now spawn the thread the first time we instantiate a
monitor which actually has use_io_thread == true.
Instantiation of monitors happens only after os_daemonize().
We still need to create the qmp_dispatcher_bh when not using
iothreads, so this now still happens in
monitor_init_globals().

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Fixes: d32749deb615 ("monitor: move init global earlier")
Message-Id: <20180925081507.11873-3-w.bumiller@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>
[This fixes a crash on shutdown with --daemonize]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/monitor.c b/monitor.c
index 66f149c1dc..d39390c2f2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -708,9 +708,14 @@ static void monitor_qapi_event_init(void)
 
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
+static void monitor_iothread_init(void);
+
 static void monitor_data_init(Monitor *mon, bool skip_flush,
                               bool use_io_thread)
 {
+    if (use_io_thread && !mon_iothread) {
+        monitor_iothread_init();
+    }
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->mon_lock);
     qemu_mutex_init(&mon->qmp.qmp_queue_lock);
@@ -4461,15 +4466,6 @@ static AioContext *monitor_get_aio_context(void)
 static void monitor_iothread_init(void)
 {
     mon_iothread = iothread_create("mon_iothread", &error_abort);
-
-    /*
-     * The dispatcher BH must run in the main loop thread, since we
-     * have commands assuming that context.  It would be nice to get
-     * rid of those assumptions.
-     */
-    qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
-                                   monitor_qmp_bh_dispatcher,
-                                   NULL);
 }
 
 void monitor_init_globals(void)
@@ -4479,7 +4475,15 @@ void monitor_init_globals(void)
     sortcmdlist();
     qemu_mutex_init(&monitor_lock);
     qemu_mutex_init(&mon_fdsets_lock);
-    monitor_iothread_init();
+
+    /*
+     * The dispatcher BH must run in the main loop thread, since we
+     * have commands assuming that context.  It would be nice to get
+     * rid of those assumptions.
+     */
+    qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
+                                   monitor_qmp_bh_dispatcher,
+                                   NULL);
 }
 
 /* These functions just adapt the readline interface in a typesafe way.  We
@@ -4624,7 +4628,9 @@ void monitor_cleanup(void)
      * we need to unregister from chardev below in
      * monitor_data_destroy(), and chardev is not thread-safe yet
      */
-    iothread_stop(mon_iothread);
+    if (mon_iothread) {
+        iothread_stop(mon_iothread);
+    }
 
     /* Flush output buffers and destroy monitors */
     qemu_mutex_lock(&monitor_lock);
@@ -4639,9 +4645,10 @@ void monitor_cleanup(void)
     /* QEMUBHs needs to be deleted before destroying the I/O thread */
     qemu_bh_delete(qmp_dispatcher_bh);
     qmp_dispatcher_bh = NULL;
-
-    iothread_destroy(mon_iothread);
-    mon_iothread = NULL;
+    if (mon_iothread) {
+        iothread_destroy(mon_iothread);
+        mon_iothread = NULL;
+    }
 }
 
 QemuOptsList qemu_mon_opts = {
-- 
2.17.2
