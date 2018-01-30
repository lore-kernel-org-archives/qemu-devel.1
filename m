Received: from eggs.gnu.org ([2001:4830:134:3::10]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egY09-0002ft-S3
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egY08-0007ug-Uf
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:39:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 30 Jan 2018 15:38:35 +0000
Message-Id: <20180130153835.7372-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] vl: pause vcpus before stopping iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Commit dce8921b2baaf95974af8176406881872067adfa ("iothread: Stop threads
before main() quits") introduced iothread_stop_all() to avoid the
following virtio-scsi assertion failure:

  assert(blk_get_aio_context(d->conf.blk) == s->ctx);

Back then the assertion failed because when bdrv_close_all() made
d->conf.blk NULL, blk_get_aio_context() returned the global AioContext
instead of s->ctx.

The same assertion can still fail today when vcpus submit new I/O
requests after iothread_stop_all() has moved the BDS to the global
AioContext.

This patch hardens the iothread_stop_all() approach by pausing vcpus
before calling iothread_stop_all().

Note that the assertion failure is a race condition.  It is not possible
to reproduce it reliably.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index e517a8d995..011f22ae20 100644
--- a/vl.c
+++ b/vl.c
@@ -4765,10 +4765,10 @@ int main(int argc, char **argv, char **envp)
     os_setup_post();
 
     main_loop();
+
     replay_disable_events();
+    pause_all_vcpus();
     iothread_stop_all();
-
-    pause_all_vcpus();
     bdrv_close_all();
     res_free();
 
-- 
2.14.3
