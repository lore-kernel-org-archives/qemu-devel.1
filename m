Received: from eggs.gnu.org ([209.51.188.92]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2Fc-0006QD-3U
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2Fb-0003Eh-DP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:08 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57812)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gk2Fb-0003EW-6M
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:38:07 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 17 Jan 2019 10:38:10 +0300
Message-ID: <20190117073810.5399.71824.stgit@pasha-VirtualBox>
In-Reply-To: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v10 14/24] replay: refine replay-time module
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

This patch removes refactoring artifacts from the replay/replay-time.c

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-time.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/replay/replay-time.c b/replay/replay-time.c
index 0df1693..60f47b7 100644
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
