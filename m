Received: from eggs.gnu.org ([2001:4830:134:3::10]:35295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emG3Z-0001zn-D6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emG3Y-00007L-El
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:42:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Feb 2018 09:42:08 +0000
Message-Id: <20180215094210.27770-2-stefanha@redhat.com>
In-Reply-To: <20180215094210.27770-1-stefanha@redhat.com>
References: <20180215094210.27770-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 1/3] vl: pause vcpus before stopping iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

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
Message-id: 20180201110708.8080-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 vl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 21878496ec..7a5554bc41 100644
--- a/vl.c
+++ b/vl.c
@@ -4767,10 +4767,18 @@ int main(int argc, char **argv, char **envp)
 
     main_loop();
     replay_disable_events();
+
+    /* The ordering of the following is delicate.  Stop vcpus to prevent new
+     * I/O requests being queued by the guest.  Then stop IOThreads (this
+     * includes a drain operation and completes all request processing).  At
+     * this point emulated devices are still associated with their IOThreads
+     * (if any) but no longer have any work to do.  Only then can we close
+     * block devices safely because we know there is no more I/O coming.
+     */
+    pause_all_vcpus();
     iothread_stop_all();
-
-    pause_all_vcpus();
     bdrv_close_all();
+
     res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
-- 
2.14.3
