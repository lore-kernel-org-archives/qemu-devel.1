Received: from eggs.gnu.org ([2001:4830:134:3::10]:39328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UO0-0003y4-ER
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UNw-0006Ld-Hj
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:07:12 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42192)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UNw-0006LI-9d
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:07:08 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:07:08 +0300
Message-ID: <20171031110708.5836.96266.stgit@pasha-VirtualBox>
In-Reply-To: <20171031110641.5836.43266.stgit@pasha-VirtualBox>
References: <20171031110641.5836.43266.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 05/26] replay: fixed replay_enable_events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru

This patch fixes assignment to internal events_enabled variable.
Now it is set only in record/replay mode. This affects the behavior
of the external functions that check this flag.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 replay/replay-events.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 768b505..e858254 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -67,7 +67,9 @@ static void replay_run_event(Event *event)
 
 void replay_enable_events(void)
 {
-    events_enabled = true;
+    if (replay_mode != REPLAY_MODE_NONE) {
+        events_enabled = true;
+    }
 }
 
 bool replay_has_events(void)
@@ -141,7 +143,7 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 
 void replay_bh_schedule_event(QEMUBH *bh)
 {
-    if (replay_mode != REPLAY_MODE_NONE && events_enabled) {
+    if (events_enabled) {
         uint64_t id = replay_get_current_step();
         replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
     } else {
@@ -161,7 +163,7 @@ void replay_add_input_sync_event(void)
 
 void replay_block_event(QEMUBH *bh, uint64_t id)
 {
-    if (replay_mode != REPLAY_MODE_NONE && events_enabled) {
+    if (events_enabled) {
         replay_add_event(REPLAY_ASYNC_EVENT_BLOCK, bh, NULL, id);
     } else {
         qemu_bh_schedule(bh);
