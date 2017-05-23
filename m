Received: from eggs.gnu.org ([2001:4830:134:3::10]:38808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xd-0005oD-Gh
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xX-00014q-Kn
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD8xX-00013v-CU
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61F2E7249C
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 12:30:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 23 May 2017 14:30:34 +0200
Message-Id: <1495542638-12335-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1495542638-12335-1-git-send-email-armbru@redhat.com>
References: <1495542638-12335-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] shutdown: Preserve shutdown cause through
 replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

With the recent addition of ShutdownCause, we want to be able to pass
a cause through any shutdown request, and then faithfully replay that
cause when later replaying the same sequence.  The easiest way is to
expand the reply event mechanism to track a series of values for
EVENT_SHUTDOWN, one corresponding to each value of ShutdownCause.

We are free to change the replay stream as needed, since there are
already no guarantees about being able to use a replay stream by
any other version of qemu than the one that generated it.

The cause is not actually fed back until the next patch changes the
signature for requesting a shutdown; a TODO marks that upcoming change.

Yes, this uses the gcc/clang extension of a ranged case label,
but this is not the first time we've used non-C99 constructs.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170515214114.15442-4-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/replay.h  | 3 ++-
 replay/replay-internal.h | 3 ++-
 replay/replay.c          | 7 ++++---
 vl.c                     | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index f1c0712..fa14d0e 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -13,6 +13,7 @@
  */
 
 #include "qapi-types.h"
+#include "sysemu.h"
 
 /* replay clock kinds */
 enum ReplayClockKind {
@@ -98,7 +99,7 @@ int64_t replay_read_clock(ReplayClockKind kind);
 /* Events */
 
 /*! Called when qemu shutdown is requested. */
-void replay_shutdown_request(void);
+void replay_shutdown_request(ShutdownCause cause);
 /*! Should be called at check points in the execution.
     These check points are skipped, if they were not met.
     Saves checkpoint in the SAVE mode and validates in the PLAY mode.
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index ed66ed8..3ebb199 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -22,8 +22,9 @@ enum ReplayEvents {
     EVENT_EXCEPTION,
     /* for async events */
     EVENT_ASYNC,
-    /* for shutdown request */
+    /* for shutdown requests, range allows recovery of ShutdownCause */
     EVENT_SHUTDOWN,
+    EVENT_SHUTDOWN_LAST = EVENT_SHUTDOWN + SHUTDOWN_CAUSE__MAX,
     /* for character device write event */
     EVENT_CHAR_WRITE,
     /* for character device read all event */
diff --git a/replay/replay.c b/replay/replay.c
index f810628..bf94e81 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -49,8 +49,9 @@ bool replay_next_event_is(int event)
             res = true;
         }
         switch (replay_state.data_kind) {
-        case EVENT_SHUTDOWN:
+        case EVENT_SHUTDOWN ... EVENT_SHUTDOWN_LAST:
             replay_finish_event();
+            /* TODO - pass replay_state.data_kind - EVENT_SHUTDOWN as cause */
             qemu_system_shutdown_request();
             break;
         default:
@@ -170,11 +171,11 @@ bool replay_has_interrupt(void)
     return res;
 }
 
-void replay_shutdown_request(void)
+void replay_shutdown_request(ShutdownCause cause)
 {
     if (replay_mode == REPLAY_MODE_RECORD) {
         replay_mutex_lock();
-        replay_put_event(EVENT_SHUTDOWN);
+        replay_put_event(EVENT_SHUTDOWN + cause);
         replay_mutex_unlock();
     }
 }
diff --git a/vl.c b/vl.c
index d90ae3f..909519f 100644
--- a/vl.c
+++ b/vl.c
@@ -1821,8 +1821,8 @@ void qemu_system_killed(int signal, pid_t pid)
 void qemu_system_shutdown_request(void)
 {
     trace_qemu_system_shutdown_request();
-    replay_shutdown_request();
     /* TODO - add a parameter to allow callers to specify reason */
+    replay_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
     shutdown_requested = SHUTDOWN_CAUSE_HOST_ERROR;
     qemu_notify_event();
 }
-- 
2.7.4
