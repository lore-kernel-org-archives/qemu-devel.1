Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fLNb6-00010c-7B
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fLNb3-0000Ea-0S
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:50:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36148)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fLNb2-0000EM-Jt
	for qemu-devel@nongnu.org; Wed, 23 May 2018 02:50:04 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 23 May 2018 09:50:05 +0300
Message-ID: <20180523065005.26016.65708.stgit@pasha-VirtualBox>
In-Reply-To: <20180523064941.26016.74274.stgit@pasha-VirtualBox>
References: <20180523064941.26016.74274.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 04/19] replay: don't drain/flush bdrv queue
 while RR is working
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

In record/replay mode bdrv queue is controlled by replay mechanism.
It does not allow saving or loading the snapshots
when bdrv queue is not empty. Stopping the VM is not blocked by nonempty
queue, but flushing the queue is still impossible there,
because it may cause deadlocks in replay mode.
This patch disables bdrv_drain_all and bdrv_flush_all in
record/replay mode.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 block/io.c |   22 ++++++++++++++++++++++
 cpus.c     |    2 --
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index ca96b48..853d5a4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -32,6 +32,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "sysemu/replay.h"
 
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
 
@@ -408,6 +409,13 @@ void bdrv_drain_all_begin(void)
     BdrvNextIterator it;
     GSList *aio_ctxs = NULL, *ctx;
 
+    /* bdrv queue is managed by record/replay,
+       waiting for finishing the I/O requests may
+       be infinite */
+    if (replay_events_enabled()) {
+        return;
+    }
+
     /* BDRV_POLL_WHILE() for a node can only be called from its own I/O thread
      * or the main loop AioContext. We potentially use BDRV_POLL_WHILE() on
      * nodes in several different AioContexts, so make sure we're in the main
@@ -459,6 +467,13 @@ void bdrv_drain_all_end(void)
     BlockDriverState *bs;
     BdrvNextIterator it;
 
+    /* bdrv queue is managed by record/replay,
+       waiting for finishing the I/O requests may
+       be endless */
+    if (replay_events_enabled()) {
+        return;
+    }
+
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
@@ -1841,6 +1856,13 @@ int bdrv_flush_all(void)
     BlockDriverState *bs = NULL;
     int result = 0;
 
+    /* bdrv queue is managed by record/replay,
+       creating new flush request for stopping
+       the VM may break the determinism */
+    if (replay_events_enabled()) {
+        return result;
+    }
+
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
         int ret;
diff --git a/cpus.c b/cpus.c
index d1f1629..b3bf018 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1016,7 +1016,6 @@ static int do_vm_stop(RunState state, bool send_stop)
     }
 
     bdrv_drain_all();
-    replay_disable_events();
     ret = bdrv_flush_all();
 
     return ret;
@@ -2063,7 +2062,6 @@ int vm_prepare_start(void)
     /* We are sending this now, but the CPUs will be resumed shortly later */
     qapi_event_send_resume(&error_abort);
 
-    replay_enable_events();
     cpu_enable_ticks();
     runstate_set(RUN_STATE_RUNNING);
     vm_state_notify(1, RUN_STATE_RUNNING);
