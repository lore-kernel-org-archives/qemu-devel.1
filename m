Received: from eggs.gnu.org ([2001:4830:134:3::10]:39310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIha-0002KI-L6
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIhX-0004jR-K6
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:15:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36672)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIhX-0004iJ-BA
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:15:31 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:15:32 +0300
Message-ID: <20180725121532.12867.30203.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 13/24] replay: refine replay-time module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch removes refactoring artifacts from the replay/replay-time.c

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-time.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/replay/replay-time.c b/replay/replay-time.c
index 6a7565e..40030b8 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -17,14 +17,12 @@
 
 int64_t replay_save_clock(ReplayClockKind kind, int64_t clock)
 {
+    g_assert(replay_file);
+    g_assert(replay_mutex_locked());
 
-    if (replay_file) {
-        g_assert(replay_mutex_locked());
-
-        replay_save_instructions();
-        replay_put_event(EVENT_CLOCK + kind);
-        replay_put_qword(clock);
-    }
+    replay_save_instructions();
+    replay_put_event(EVENT_CLOCK + kind);
+    replay_put_qword(clock);
 
     return clock;
 }
@@ -46,20 +44,15 @@ void replay_read_next_clock(ReplayClockKind kind)
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
