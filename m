Received: from eggs.gnu.org ([2001:4830:134:3::10]:47508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00Mz-0001FF-Lg
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00Mv-0000ei-2K
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:29 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55906)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1g00Mu-0000Uh-NS
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:19:24 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 12 Sep 2018 11:18:59 +0300
Message-ID: <20180912081859.3228.79735.stgit@pasha-VirtualBox>
In-Reply-To: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 12/25] replay: flush events when exiting
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

This patch adds events processing when emulation finishes instead
of just cleaning the queue. Now the bdrv coroutines will be in consistent
state when emulator closes. It allows correct polling of the block layer
at exit.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-events.c   |   14 +-------------
 replay/replay-internal.h |    2 --
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/replay/replay-events.c b/replay/replay-events.c
index 707de38..0964a82 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -94,18 +94,6 @@ void replay_disable_events(void)
     }
 }
 
-void replay_clear_events(void)
-{
-    g_assert(replay_mutex_locked());
-
-    while (!QTAILQ_EMPTY(&events_list)) {
-        Event *event = QTAILQ_FIRST(&events_list);
-        QTAILQ_REMOVE(&events_list, event, events);
-
-        g_free(event);
-    }
-}
-
 /*! Adds specified async event to the queue */
 void replay_add_event(ReplayAsyncEventKind event_kind,
                       void *opaque,
@@ -308,7 +296,7 @@ void replay_init_events(void)
 void replay_finish_events(void)
 {
     events_enabled = false;
-    replay_clear_events();
+    replay_flush_events();
 }
 
 bool replay_events_enabled(void)
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index f9cad9d..b824b7a 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -148,8 +148,6 @@ void replay_init_events(void);
 void replay_finish_events(void);
 /*! Flushes events queue */
 void replay_flush_events(void);
-/*! Clears events list before loading new VM state */
-void replay_clear_events(void);
 /*! Returns true if there are any unsaved events in the queue */
 bool replay_has_events(void);
 /*! Saves events from queue into the file */
