Received: from eggs.gnu.org ([2001:4830:134:3::10]:45378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJa-0000pg-By
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJZ-00061y-AG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJZ-00061Z-3k
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABFA2814F0D2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:15 -0500
Message-Id: <20180312183628.394722-25-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 24/36] monitor: let suspend/resume work even
 with QMPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

This patches allows QMP monitors to be suspended/resumed.

One thing to mention is that for QMPs that are using IOThreads, we need
an explicit kick for the IOThread in case it is sleeping.

Meanwhile, we need to take special care on non-interactive HMPs.
Currently only gdbserver is using that.  For these monitors, we still
don't allow suspend/resume operations.

Since at it, add traces for the operations.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-14-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c    | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 trace-events |  1 +
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index 608faf35c25..6b225e9fc5c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -250,6 +250,21 @@ static inline bool monitor_is_qmp(const Monitor *mon)
     return (mon->flags & MONITOR_USE_CONTROL);
 }

+/**
+ * Whether @mon is using readline?  Note: not all HMP monitors use
+ * readline, e.g., gdbserver has a non-interactive HMP monitor, so
+ * readline is not used there.
+ */
+static inline bool monitor_uses_readline(const Monitor *mon)
+{
+    return mon->flags & MONITOR_USE_READLINE;
+}
+
+static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
+{
+    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
+}
+
 /**
  * Is the current monitor, if any, a QMP monitor?
  */
@@ -3946,19 +3961,45 @@ static void monitor_command_cb(void *opaque, const char *cmdline,

 int monitor_suspend(Monitor *mon)
 {
-    if (!mon->rs)
+    if (monitor_is_hmp_non_interactive(mon)) {
         return -ENOTTY;
+    }
+
     atomic_inc(&mon->suspend_cnt);
+
+    if (monitor_is_qmp(mon)) {
+        /*
+         * Kick iothread to make sure this takes effect.  It'll be
+         * evaluated again in prepare() of the watch object.
+         */
+        aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
+    }
+
+    trace_monitor_suspend(mon, 1);
     return 0;
 }

 void monitor_resume(Monitor *mon)
 {
-    if (!mon->rs)
+    if (monitor_is_hmp_non_interactive(mon)) {
         return;
+    }
+
     if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
-        readline_show_prompt(mon->rs);
+        if (monitor_is_qmp(mon)) {
+            /*
+             * For QMP monitors that are running in IOThread, let's
+             * kick the thread in case it's sleeping.
+             */
+            if (mon->use_io_thr) {
+                aio_notify(iothread_get_aio_context(mon_global.mon_iothread));
+            }
+        } else {
+            assert(mon->rs);
+            readline_show_prompt(mon->rs);
+        }
     }
+    trace_monitor_suspend(mon, -1);
 }

 static QObject *get_qmp_greeting(Monitor *mon)
diff --git a/trace-events b/trace-events
index 89fcad0fd13..fe10c3b487c 100644
--- a/trace-events
+++ b/trace-events
@@ -47,6 +47,7 @@ monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
 handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
+monitor_suspend(void *ptr, int cnt) "mon %p: %d"

 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.14.3
