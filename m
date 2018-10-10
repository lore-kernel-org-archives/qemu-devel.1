Received: from eggs.gnu.org ([2001:4830:134:3::10]:34016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaO-00028e-7V
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaM-0002ml-H9
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:35 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44166)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaK-0002kc-G2
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:31:34 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 10 Oct 2018 16:34:42 +0300
Message-ID: <20181010133442.24538.3050.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 12/19] replay: refine replay-time module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, war2jordan@live.com, pavel.dovgaluk@ispras.ru, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.comdovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

This patch removes refactoring artifacts from the replay/replay-time.c

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-time.c |   32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/replay/replay-time.c b/replay/replay-time.c
index 17caf35..8986054 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -17,16 +17,15 @@
 
 int64_t replay_save_clock(ReplayClockKind kind, int64_t clock, int64_t raw_icount)
 {
-    if (replay_file) {
-        g_assert(replay_mutex_locked());
+    g_assert(replay_file);
+    g_assert(replay_mutex_locked());
 
-        /* Due to the caller's locking requirements we get the icount from it instead
-         * of using replay_save_instructions().
-         */
-        replay_advance_current_step(raw_icount);
-        replay_put_event(EVENT_CLOCK + kind);
-        replay_put_qword(clock);
-    }
+    /* Due to the caller's locking requirements we get the icount from it instead
+     * of using replay_save_instructions().
+     */
+    replay_advance_current_step(raw_icount);
+    replay_put_event(EVENT_CLOCK + kind);
+    replay_put_qword(clock);
 
     return clock;
 }
@@ -48,20 +47,15 @@ void replay_read_next_clock(ReplayClockKind kind)
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
