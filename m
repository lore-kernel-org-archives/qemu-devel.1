Received: from eggs.gnu.org ([2001:4830:134:3::10]:42594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1au-0004SR-BI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ar-0006fJ-JB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ar-0006e0-61
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B799C40250FF
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:05 +0200
Message-Id: <20180702162218.13678-20-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 19/32] monitor: Rename use_io_thr to
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
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/monitor.c b/monitor.c
index fd83a57dda..10b6634d3e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -206,11 +206,11 @@ struct Monitor {
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
@@ -520,7 +520,7 @@ static void monitor_json_emitter_raw(Monitor *mon,
 
 static void monitor_json_emitter(Monitor *mon, QObject *data)
 {
-    if (mon->use_io_thr) {
+    if (mon->use_io_thread) {
         /*
          * If using I/O thread, we need to queue the item so that I/O
          * thread will do the rest for us.  Take refcount so that
@@ -766,7 +766,7 @@ static void monitor_qapi_event_init(void)
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
 static void monitor_data_init(Monitor *mon, bool skip_flush,
-                              bool use_io_thr)
+                              bool use_io_thread)
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->mon_lock);
@@ -775,7 +775,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
     mon->skip_flush = skip_flush;
-    mon->use_io_thr = use_io_thr;
+    mon->use_io_thread = use_io_thread;
     mon->qmp.qmp_requests = g_queue_new();
     mon->qmp.qmp_responses = g_queue_new();
 }
@@ -1270,7 +1270,7 @@ static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
         assert(list->value < QMP_CAPABILITY__MAX);
         switch (list->value) {
         case QMP_CAPABILITY_OOB:
-            if (!mon->use_io_thr) {
+            if (!mon->use_io_thread) {
                 /*
                  * Out-of-band only works with monitors that are
                  * running on dedicated I/O thread.
@@ -4376,7 +4376,7 @@ void monitor_resume(Monitor *mon)
              * For QMP monitors that are running in I/O thread, let's
              * kick the thread in case it's sleeping.
              */
-            if (mon->use_io_thr) {
+            if (mon->use_io_thread) {
                 aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
             }
         } else {
@@ -4396,7 +4396,7 @@ static QObject *get_qmp_greeting(Monitor *mon)
     qmp_marshal_query_version(NULL, &ver, NULL);
 
     for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
-        if (!mon->use_io_thr && cap == QMP_CAPABILITY_OOB) {
+        if (!mon->use_io_thread && cap == QMP_CAPABILITY_OOB) {
             /* Monitors that are not using I/O thread won't support OOB */
             continue;
         }
@@ -4609,9 +4609,9 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
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
@@ -4660,7 +4660,7 @@ void monitor_init(Chardev *chr, int flags)
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
