Received: from eggs.gnu.org ([2001:4830:134:3::10]:50432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxx-00088j-DA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxt-0006CI-1V
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxs-0006An-OR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14BF0400ADFA
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:36:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C1DF12166BA9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:43 +0200
Message-Id: <20180703213556.20619-20-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 19/32] monitor: Rename use_io_thr to
 use_io_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-20-armbru@redhat.com>
---
 monitor.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/monitor.c b/monitor.c
index ea5421399a..b3c5dcc685 100644
--- a/monitor.c
+++ b/monitor.c
@@ -207,11 +207,11 @@ struct Monitor {
     int flags;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
-    bool use_io_thr;
+    bool use_io_thread;
 
     /*
      * State used only in the thread "owning" the monitor.
-     * If @use_io_thr, this is mon_global.mon_iothread.
+     * If @use_io_thread, this is mon_global.mon_iothread.
      * Else, it's the main thread.
      * These members can be safely accessed without locks.
      */
@@ -521,7 +521,7 @@ static void monitor_json_emitter_raw(Monitor *mon,
 
 static void monitor_json_emitter(Monitor *mon, QObject *data)
 {
-    if (mon->use_io_thr) {
+    if (mon->use_io_thread) {
         /*
          * If using I/O thread, we need to queue the item so that I/O
          * thread will do the rest for us.  Take refcount so that
@@ -767,7 +767,7 @@ static void monitor_qapi_event_init(void)
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
 static void monitor_data_init(Monitor *mon, bool skip_flush,
-                              bool use_io_thr)
+                              bool use_io_thread)
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->mon_lock);
@@ -776,7 +776,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
     mon->skip_flush = skip_flush;
-    mon->use_io_thr = use_io_thr;
+    mon->use_io_thread = use_io_thread;
     mon->qmp.qmp_requests = g_queue_new();
     mon->qmp.qmp_responses = g_queue_new();
 }
@@ -1271,7 +1271,7 @@ static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
         assert(list->value < QMP_CAPABILITY__MAX);
         switch (list->value) {
         case QMP_CAPABILITY_OOB:
-            if (!mon->use_io_thr) {
+            if (!mon->use_io_thread) {
                 /*
                  * Out-of-band only works with monitors that are
                  * running on dedicated I/O thread.
@@ -4377,7 +4377,7 @@ void monitor_resume(Monitor *mon)
              * For QMP monitors that are running in I/O thread, let's
              * kick the thread in case it's sleeping.
              */
-            if (mon->use_io_thr) {
+            if (mon->use_io_thread) {
                 aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
             }
         } else {
@@ -4397,7 +4397,7 @@ static QObject *get_qmp_greeting(Monitor *mon)
     qmp_marshal_query_version(NULL, &ver, NULL);
 
     for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
-        if (!mon->use_io_thr && cap == QMP_CAPABILITY_OOB) {
+        if (!mon->use_io_thread && cap == QMP_CAPABILITY_OOB) {
             /* Monitors that are not using I/O thread won't support OOB */
             continue;
         }
@@ -4610,9 +4610,9 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     Monitor *mon = opaque;
     GMainContext *context;
 
-    if (mon->use_io_thr) {
+    if (mon->use_io_thread) {
         /*
-         * When use_io_thr is set, we use the global shared dedicated
+         * When @use_io_thread is set, we use the global shared dedicated
          * I/O thread for this monitor to handle input/output.
          */
         context = monitor_get_io_context();
@@ -4661,7 +4661,7 @@ void monitor_init(Chardev *chr, int flags)
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
-        if (mon->use_io_thr) {
+        if (mon->use_io_thread) {
             /*
              * Make sure the old iowatch is gone.  It's possible when
              * e.g. the chardev is in client mode, with wait=on.
-- 
2.17.1
