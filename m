Received: from eggs.gnu.org ([2001:4830:134:3::10]:33985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM6BD-000420-Mu
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM6BC-0002B3-UE
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:54:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM6BC-0002Af-OJ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:54:06 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Dec 2017 13:51:49 +0800
Message-Id: <20171205055200.16305-16-peterx@redhat.com>
In-Reply-To: <20171205055200.16305-1-peterx@redhat.com>
References: <20171205055200.16305-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v5 15/26] monitor: let suspend_cnt be thread safe
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
index 35d8925636..6ac1b2065d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3874,7 +3874,7 @@ static int monitor_can_read(void *opaque)
 {
     Monitor *mon = opaque;
 
-    return (mon->suspend_cnt == 0) ? 1 : 0;
+    return (atomic_read(&mon->suspend_cnt) == 0) ? 1 : 0;
 }
 
 /*
@@ -4003,7 +4003,7 @@ int monitor_suspend(Monitor *mon)
 {
     if (!mon->rs)
         return -ENOTTY;
-    mon->suspend_cnt++;
+    atomic_inc(&mon->suspend_cnt);
     return 0;
 }
 
@@ -4011,8 +4011,9 @@ void monitor_resume(Monitor *mon)
 {
     if (!mon->rs)
         return;
-    if (--mon->suspend_cnt == 0)
+    if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
         readline_show_prompt(mon->rs);
+    }
 }
 
 static QObject *get_qmp_greeting(void)
@@ -4078,19 +4079,19 @@ static void monitor_event(void *opaque, int event)
             monitor_resume(mon);
             monitor_flush(mon);
         } else {
-            mon->suspend_cnt = 0;
+            atomic_set(&mon->suspend_cnt, 0);
         }
         break;
 
     case CHR_EVENT_MUX_OUT:
         if (mon->reset_seen) {
-            if (mon->suspend_cnt == 0) {
+            if (atomic_read(&mon->suspend_cnt) == 0) {
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
