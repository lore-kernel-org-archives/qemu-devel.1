Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiH-0002uS-Mq
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiE-0005rp-Lp
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:17 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36758)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiE-0005rG-CJ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:14 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:16:15 +0300
Message-ID: <20180725121614.12867.73655.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 15/24] replay: flush rr queue before loading
 the vmstate
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

Non-empty record/replay queue prevents saving and loading the VM state,
because it includes pending bottom halves and block coroutines.
But when the new VM state is loaded, we don't have to preserve the consistency
of the current state anymore. Therefore this patch just flushes the queue
allowing the coroutines to finish.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/sysemu/replay.h  |    2 ++
 migration/savevm.c       |   10 ++++------
 replay/replay-internal.h |    2 --
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 98d709c..84a1ec5 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -132,6 +132,8 @@ void replay_disable_events(void);
 void replay_enable_events(void);
 /*! Returns true when saving events is enabled */
 bool replay_events_enabled(void);
+/*! Flushes events queue */
+void replay_flush_events(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
 /*! Adds input event to the queue */
diff --git a/migration/savevm.c b/migration/savevm.c
index 6be4f80..834dd25 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2607,12 +2607,6 @@ int load_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!replay_can_snapshot()) {
-        error_report("Record/replay does not allow loading snapshot "
-                     "right now. Try once more later.");
-        return -EINVAL;
-    }
-
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp,
                    "Device '%s' is writable but does not support snapshots",
@@ -2646,6 +2640,10 @@ int load_snapshot(const char *name, Error **errp)
         return -EINVAL;
     }
 
+    /* Flush the record/replay queue. Now the VM state is going
+       to change. Therefore we don't need to preserve its consistency */
+    replay_flush_events();
+
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index a2221e5..08ef2ec 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -146,8 +146,6 @@ void replay_read_next_clock(unsigned int kind);
 void replay_init_events(void);
 /*! Clears internal data structures for events handling */
 void replay_finish_events(void);
-/*! Flushes events queue */
-void replay_flush_events(void);
 /*! Returns true if there are any unsaved events in the queue */
 bool replay_has_events(void);
 /*! Saves events from queue into the file */
