Received: from eggs.gnu.org ([2001:4830:134:3::10]:37766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDZI-0001R0-PF
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDZD-0001Bp-U8
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:48:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDZD-0001BI-N6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:48:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:44 +0800
Message-Id: <20171219084557.9801-15-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 14/27] monitor: let suspend_cnt be thread safe
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index cf1e5d881c..844508d134 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3862,7 +3862,7 @@ static int monitor_can_read(void *opaque)
 {
     Monitor *mon = opaque;
 
-    return (mon->suspend_cnt == 0) ? 1 : 0;
+    return (atomic_mb_read(&mon->suspend_cnt) == 0) ? 1 : 0;
 }
 
 /*
@@ -3994,7 +3994,7 @@ int monitor_suspend(Monitor *mon)
 {
     if (!mon->rs)
         return -ENOTTY;
-    mon->suspend_cnt++;
+    atomic_inc(&mon->suspend_cnt);
     return 0;
 }
 
@@ -4002,8 +4002,9 @@ void monitor_resume(Monitor *mon)
 {
     if (!mon->rs)
         return;
-    if (--mon->suspend_cnt == 0)
+    if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
         readline_show_prompt(mon->rs);
+    }
 }
 
 static QObject *get_qmp_greeting(Monitor *mon)
@@ -4068,19 +4069,19 @@ static void monitor_event(void *opaque, int event)
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
