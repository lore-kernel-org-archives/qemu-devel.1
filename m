Received: from eggs.gnu.org ([209.51.188.92]:40264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0R-0000cc-Rk
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0Q-0002AX-0H
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:03 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47134)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0O-00028a-0G
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:01 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Mon, 22 Apr 2019 14:20:58 +0300
Message-ID: <155593205889.21079.14799791777208991110.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.1 14/24] replay: refine replay-time module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch removes refactoring artifacts from the replay/replay-time.c

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-time.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/replay/replay-time.c b/replay/replay-time.c
index 0df1693337..60f47b73a7 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -15,18 +15,19 @@
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 
-int64_t replay_save_clock(ReplayClockKind kind, int64_t clock, int64_t raw_icount)
+int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
+                          int64_t raw_icount)
 {
-    if (replay_file) {
-        g_assert(replay_mutex_locked());
+    g_assert(replay_file);
+    g_assert(replay_mutex_locked());
 
-        /* Due to the caller's locking requirements we get the icount from it
-         * instead of using replay_save_instructions().
-         */
-        replay_advance_current_step(raw_icount);
-        replay_put_event(EVENT_CLOCK + kind);
-        replay_put_qword(clock);
-    }
+    /*
+     * Due to the caller's locking requirements we get the icount from it
+     * instead of using replay_save_instructions().
+     */
+    replay_advance_current_step(raw_icount);
+    replay_put_event(EVENT_CLOCK + kind);
+    replay_put_qword(clock);
 
     return clock;
 }
@@ -48,20 +49,15 @@ void replay_read_next_clock(ReplayClockKind kind)
 /*! Reads next clock event from the input. */
 int64_t replay_read_clock(ReplayClockKind kind)
 {
+    int64_t ret;
     g_assert(replay_file && replay_mutex_locked());
 
     replay_account_executed_instructions();
 
-    if (replay_file) {
-        int64_t ret;
-        if (replay_next_event_is(EVENT_CLOCK + kind)) {
-            replay_read_next_clock(kind);
-        }
-        ret = replay_state.cached_clock[kind];
-
-        return ret;
+    if (replay_next_event_is(EVENT_CLOCK + kind)) {
+        replay_read_next_clock(kind);
     }
+    ret = replay_state.cached_clock[kind];
 
-    error_report("REPLAY INTERNAL ERROR %d", __LINE__);
-    exit(1);
+    return ret;
 }
