Received: from eggs.gnu.org ([2001:4830:134:3::10]:57629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5p-0005o2-Gr
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5o-0004B8-MZ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:25 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39892)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5o-0004Ar-Ey
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:24 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 13:48:24 +0300
Message-ID: <20171031104824.3079.91614.stgit@pasha-VirtualBox>
In-Reply-To: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
References: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFCPATCH08/20] replay: make safe vmstop at
 record/replay
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

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch disables bdrv flush/drain in record/replay mode.
When block request is in the replay queue it cannot be processed
with drain/flush until it is found in the log.
Therefore vm should just stop leaving unfinished operations
in the queue.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpus.c             |    7 ++++---
 migration/savevm.c |    4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index 114c29b..c728f3a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -942,9 +942,10 @@ static int do_vm_stop(RunState state)
         qapi_event_send_stop(&error_abort);
     }
 
-    bdrv_drain_all();
-    replay_disable_events();
-    ret = bdrv_flush_all();
+    if (!replay_events_enabled()) {
+        bdrv_drain_all();
+        ret = bdrv_flush_all();
+    }
 
     return ret;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 20cebe1..41a13c0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2143,8 +2143,8 @@ int save_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
 
     if (!replay_can_snapshot()) {
-        monitor_printf(mon, "Record/replay does not allow making snapshot "
-                        "right now. Try once more later.\n");
+        error_report("Record/replay does not allow making snapshot "
+                     "right now. Try once more later.\n");
         return ret;
     }
 
