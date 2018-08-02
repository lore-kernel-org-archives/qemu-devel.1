Received: from eggs.gnu.org ([2001:4830:134:3::10]:37169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEwz-0004mC-Sw
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEww-0001LW-RE
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  2 Aug 2018 17:50:26 +0300
Message-Id: <cd7d54f6646eb206567eeba9a102fa4264c39bec.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 4/4] throttle-groups: Don't allow timers
 without throttled requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Commit 6fccbb475bc6effc313ee9481726a1748b6dae57 fixed a bug caused by
QEMU attempting to remove a throttle group member with no pending
requests but an active timer set. This was the result of a previous
bdrv_drained_begin() call processing the throttled requests but
leaving the timer untouched.

Although the commit does solve the problem, the situation shouldn't
happen in the first place. If we try to drain a throttle group member
which has a timer set, we should cancel the timer instead of ignoring
it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/throttle-groups.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index d46c56b31e..5d8213a443 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -36,6 +36,7 @@
 
 static void throttle_group_obj_init(Object *obj);
 static void throttle_group_obj_complete(UserCreatable *obj, Error **errp);
+static void timer_cb(ThrottleGroupMember *tgm, bool is_write);
 
 /* The ThrottleGroup structure (with its ThrottleState) is shared
  * among different ThrottleGroupMembers and it's independent from
@@ -424,15 +425,31 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write
     rd->tgm = tgm;
     rd->is_write = is_write;
 
+    /* This function is called when a timer is fired or when
+     * throttle_group_restart_tgm() is called. Either way, there can
+     * be no timer pending on this tgm at this point */
+    assert(!timer_pending(tgm->throttle_timers.timers[is_write]));
+
     co = qemu_coroutine_create(throttle_group_restart_queue_entry, rd);
     aio_co_enter(tgm->aio_context, co);
 }
 
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 {
+    int i;
+
     if (tgm->throttle_state) {
-        throttle_group_restart_queue(tgm, 0);
-        throttle_group_restart_queue(tgm, 1);
+        for (i = 0; i < 2; i++) {
+            QEMUTimer *t = tgm->throttle_timers.timers[i];
+            if (timer_pending(t)) {
+                /* If there's a pending timer on this tgm, fire it now */
+                timer_del(t);
+                timer_cb(tgm, i);
+            } else {
+                /* Else run the next request from the queue manually */
+                throttle_group_restart_queue(tgm, i);
+            }
+        }
     }
 }
 
@@ -567,16 +584,11 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
         return;
     }
 
-    assert(tgm->pending_reqs[0] == 0 && tgm->pending_reqs[1] == 0);
-    assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
-    assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
-
     qemu_mutex_lock(&tg->lock);
     for (i = 0; i < 2; i++) {
-        if (timer_pending(tgm->throttle_timers.timers[i])) {
-            tg->any_timer_armed[i] = false;
-            schedule_next_request(tgm, i);
-        }
+        assert(tgm->pending_reqs[i] == 0);
+        assert(qemu_co_queue_empty(&tgm->throttled_reqs[i]));
+        assert(!timer_pending(tgm->throttle_timers.timers[i]));
         if (tg->tokens[i] == tgm) {
             token = throttle_group_next_tgm(tgm);
             /* Take care of the case where this is the last tgm in the group */
-- 
2.11.0
