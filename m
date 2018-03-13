Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsif-0006Jh-Hr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsib-00044h-6a
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:33 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsia-000444-Vx
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:29 -0400
Received: by mail-wr0-x242.google.com with SMTP id z12so2563700wrg.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:04 +0100
Message-Id: <20180313224719.4954-55-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 54/69] replay: fixed replay_enable_events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch fixes assignment to internal events_enabled variable.
Now it is set only in record/replay mode. This affects the behavior
of the external functions that check this flag.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180227095209.1060.45884.stgit@pasha-VirtualBox>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 768b505f3d..e858254074 100644
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
-- 
2.14.3
