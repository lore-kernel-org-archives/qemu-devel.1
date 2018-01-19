Received: from eggs.gnu.org ([2001:4830:134:3::10]:53997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSH5-0000zO-Qd
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSH1-0005Ax-Fa
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:43:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53622)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSH1-0005Ap-6x
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:43:43 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Fri, 19 Jan 2018 11:43:44 +0300
Message-ID: <20180119084344.7100.74280.stgit@pasha-VirtualBox>
In-Reply-To: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 09/23] replay: make safe vmstop at
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch disables bdrv flush/drain in record/replay mode.
When block request is in the replay queue it cannot be processed
with drain/flush until it is found in the log.
Therefore vm should just stop leaving unfinished operations
in the queue.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpus.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cpus.c b/cpus.c
index 2cb0af9..7b6ce74 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1004,9 +1004,10 @@ static int do_vm_stop(RunState state)
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
