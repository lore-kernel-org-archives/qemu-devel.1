Received: from eggs.gnu.org ([2001:4830:134:3::10]:52261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafd-0003zj-D1
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafc-0001PD-F9
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafc-0001P0-6F
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DB29448D68
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:06:03 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:24 -0400
Message-Id: <1495649128-10529-9-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 08/12] announce_timer: Add ability to reset an
 existing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

It is now potentially possible to issue annouce-self command in a tight
loop.  Instead of doing nother, we can reset the timeout pararameters,
especially since each instance may provide it's own values.  This
allows the user to  extend or cut short currently runnig timer.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 include/migration/vmstate.h |  1 +
 migration/savevm.c          | 41 +++++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 689b685..6dfdac3 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1057,6 +1057,7 @@ void vmstate_register_ram_global(struct MemoryRegion *memory);
 
 typedef struct AnnounceTimer {
     QEMUTimer *tm;
+    QemuMutex active_lock;
     struct AnnounceTimer **entry;
     AnnounceParameters params;
     QEMUClockType type;
diff --git a/migration/savevm.c b/migration/savevm.c
index dcba8bd..e43658f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -220,20 +220,29 @@ static void qemu_announce_self_iter(NICState *nic, void *opaque)
 
 AnnounceTimer *announce_timers[QEMU_ANNOUNCE__MAX];
 
+static void qemu_announce_timer_destroy(AnnounceTimer *timer)
+{
+    timer_del(timer->tm);
+    timer_free(timer->tm);
+    qemu_mutex_destroy(&timer->active_lock);
+    g_free(timer);
+}
+
 static void qemu_announce_self_once(void *opaque)
 {
     AnnounceTimer *timer = (AnnounceTimer *)opaque;
 
+    qemu_mutex_lock(&timer->active_lock);
     qemu_foreach_nic(qemu_announce_self_iter, NULL);
 
-    if (--timer->round) {
+    if (--timer->round ) {
         timer_mod(timer->tm, qemu_clock_get_ms(timer->type) +
                   self_announce_delay(timer));
+        qemu_mutex_unlock(&timer->active_lock);
     } else {
-            *(timer->entry) = NULL;
-            timer_del(timer->tm);
-            timer_free(timer->tm);
-            g_free(timer);
+        *(timer->entry) = NULL;
+        qemu_mutex_unlock(&timer->active_lock);
+        qemu_announce_timer_destroy(timer);
     }
 }
 
@@ -242,6 +251,7 @@ AnnounceTimer *qemu_announce_timer_new(AnnounceParameters *params,
 {
     AnnounceTimer *timer = g_new(AnnounceTimer, 1);
 
+    qemu_mutex_init(&timer->active_lock);
     timer->params = *params;
     timer->round = params->rounds;
     timer->type = type;
@@ -259,6 +269,21 @@ AnnounceTimer *qemu_announce_timer_create(AnnounceParameters *params,
     return timer;
 }
 
+static void qemu_announce_timer_update(AnnounceTimer *timer,
+                                       AnnounceParameters *params)
+{
+    qemu_mutex_lock(&timer->active_lock);
+
+    /* Update timer paramenter with any new values.
+     * Reset the number of rounds to run, and stop the current timer.
+     */
+    timer->params = *params;
+    timer->round = params->rounds;
+    timer_del(timer->tm);
+
+    qemu_mutex_unlock(&timer->active_lock);
+}
+
 void qemu_announce_self(AnnounceParameters *params, AnnounceType type)
 {
     AnnounceTimer *timer;
@@ -270,11 +295,7 @@ void qemu_announce_self(AnnounceParameters *params, AnnounceType type)
         announce_timers[type] = timer;
         timer->entry = &announce_timers[type];
     } else {
-        /* For now, don't do anything.  If we want to reset the timer,
-         * we'll need to add locking to each announce timer to prevent
-         * races between timeout handling and a reset.
-         */
-        return;
+        qemu_announce_timer_update(timer, params);
     }
     qemu_announce_self_once(timer);
 }
-- 
2.7.4
