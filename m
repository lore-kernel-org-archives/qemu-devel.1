Received: from eggs.gnu.org ([2001:4830:134:3::10]:45348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJZ-0000oY-HI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJY-00061L-KU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJY-000614-Gq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DD7576FB9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:14 -0500
Message-Id: <20180312183628.394722-24-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 23/36] monitor: let suspend_cnt be thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Peter Xu <peterx@redhat.com>

Monitor code now can be run in more than one thread.  Let it be thread
safe when accessing suspend_cnt counter.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-13-peterx@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/monitor.c b/monitor.c
index a3412359ca8..608faf35c25 100644
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
