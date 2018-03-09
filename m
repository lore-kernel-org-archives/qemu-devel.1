Received: from eggs.gnu.org ([2001:4830:134:3::10]:41779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDtz-0008AR-OE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDty-0008Da-Pz
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDty-0008DE-KC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:22 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 16:59:55 +0800
Message-Id: <20180309090006.10018-13-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 12/23] monitor: let suspend_cnt be thread
 safe
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

Monitor code now can be run in more than one thread.  Let it be thread
safe when accessing suspend_cnt counter.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6959e963e2..71b696c8f3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -194,7 +194,7 @@ struct Monitor {
     CharBackend chr;
     int reset_seen;
     int flags;
-    int suspend_cnt;
+    int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
     bool use_io_thr;
 
@@ -3816,7 +3816,7 @@ static int monitor_can_read(void *opaque)
 {
     Monitor *mon = opaque;
 
-    return (mon->suspend_cnt == 0) ? 1 : 0;
+    return !atomic_mb_read(&mon->suspend_cnt);
 }
 
 /*
@@ -3948,7 +3948,7 @@ int monitor_suspend(Monitor *mon)
 {
     if (!mon->rs)
         return -ENOTTY;
-    mon->suspend_cnt++;
+    atomic_inc(&mon->suspend_cnt);
     return 0;
 }
 
@@ -3956,8 +3956,9 @@ void monitor_resume(Monitor *mon)
 {
     if (!mon->rs)
         return;
-    if (--mon->suspend_cnt == 0)
+    if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
         readline_show_prompt(mon->rs);
+    }
 }
 
 static QObject *get_qmp_greeting(Monitor *mon)
@@ -4022,19 +4023,19 @@ static void monitor_event(void *opaque, int event)
             monitor_resume(mon);
             monitor_flush(mon);
         } else {
-            mon->suspend_cnt = 0;
+            atomic_mb_set(&mon->suspend_cnt, 0);
         }
         break;
 
     case CHR_EVENT_MUX_OUT:
         if (mon->reset_seen) {
-            if (mon->suspend_cnt == 0) {
+            if (atomic_mb_read(&mon->suspend_cnt) == 0) {
                 monitor_printf(mon, "\n");
             }
             monitor_flush(mon);
             monitor_suspend(mon);
         } else {
-            mon->suspend_cnt++;
+            atomic_inc(&mon->suspend_cnt);
         }
         qemu_mutex_lock(&mon->out_lock);
         mon->mux_out = 1;
-- 
2.14.3
