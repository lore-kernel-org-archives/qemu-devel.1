Received: from eggs.gnu.org ([2001:4830:134:3::10]:46293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dALsk-0001yH-OL
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dALsh-0005rO-Mm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dALsh-0005rB-Dd
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:42:11 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 15 May 2017 14:41:47 -0500
Message-Id: <20170515194149.16288-4-eblake@redhat.com>
In-Reply-To: <20170515194149.16288-1-eblake@redhat.com>
References: <20170515194149.16288-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v8 3/5] shutdown: Preserve shutdown cause
 through replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

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

---
v8: hoist earlier in series, tweaks minor enough to keep R-b
v7: rebase to context
v6: new patch
---
 include/sysemu/replay.h  | 3 ++-
 replay/replay-internal.h | 3 ++-
 vl.c                     | 2 +-
 replay/replay.c          | 7 ++++---
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
diff --git a/vl.c b/vl.c
index 2060038..4641fdf 100644
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
-- 
2.9.4
