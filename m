Received: from eggs.gnu.org ([2001:4830:134:3::10]:57087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CL8-0003vs-0T
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CL4-0006na-Ue
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:42:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42398)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d6CL4-0006mh-MN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:42:18 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 04 May 2017 11:42:22 +0300
Message-ID: <20170504084221.7488.13443.stgit@PASHA-ISP>
In-Reply-To: <20170504084135.7488.24715.stgit@PASHA-ISP>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v9 08/10] replay: make safe vmstop at
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

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
index 740b8dc3f8..f21e7f3166 100644
--- a/cpus.c
+++ b/cpus.c
@@ -932,9 +932,10 @@ static int do_vm_stop(RunState state)
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
