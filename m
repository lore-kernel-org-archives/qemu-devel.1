Received: from eggs.gnu.org ([2001:4830:134:3::10]:54536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7q4r-0007VG-QJ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7q4o-0003ew-MV
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:20:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7q4o-0003eq-Dl
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:20:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  8 May 2017 16:19:52 -0500
Message-Id: <20170508211953.28017-5-eblake@redhat.com>
In-Reply-To: <20170508211953.28017-1-eblake@redhat.com>
References: <20170508211953.28017-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 4/5] shutdown: Preserve shutdown cause
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

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: rebase to context
v6: new patch
---
 include/sysemu/replay.h  |  3 ++-
 include/sysemu/sysemu.h  |  1 +
 replay/replay-internal.h |  3 ++-
 vl.c                     |  3 +--
 replay/replay.c          | 10 +++++-----
 5 files changed, 11 insertions(+), 9 deletions(-)

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
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index fe197aa..e0cbab1 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -46,6 +46,7 @@ typedef enum ShutdownCause {
                                      turns that into a shutdown */
     SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
                                      that into a shutdown */
+    SHUTDOWN_CAUSE__MAX,
 } ShutdownCause;

 void vm_start(void);
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
index 2d546460..65487d9 100644
--- a/vl.c
+++ b/vl.c
@@ -1820,8 +1820,7 @@ void qemu_system_killed(int signal, pid_t pid)
 void qemu_system_shutdown_request(ShutdownCause reason)
 {
     trace_qemu_system_shutdown_request(reason);
-    /* FIXME - add a parameter to let replay preserve reason */
-    replay_shutdown_request();
+    replay_shutdown_request(reason);
     shutdown_requested = reason;
     qemu_notify_event();
 }
diff --git a/replay/replay.c b/replay/replay.c
index 604fa4f..ff58a5a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -49,10 +49,10 @@ bool replay_next_event_is(int event)
             res = true;
         }
         switch (replay_state.data_kind) {
-        case EVENT_SHUTDOWN:
+        case EVENT_SHUTDOWN ... EVENT_SHUTDOWN_LAST:
             replay_finish_event();
-            /* FIXME - store actual reason */
-            qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
+            qemu_system_shutdown_request(replay_state.data_kind -
+                                         EVENT_SHUTDOWN);
             break;
         default:
             /* clock, time_t, checkpoint and other events */
@@ -171,11 +171,11 @@ bool replay_has_interrupt(void)
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
2.9.3
