Received: from eggs.gnu.org ([2001:4830:134:3::10]:56920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFL-00077C-6t
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFC-00011h-4V
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFB-000109-Gr
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:37 +0800
Message-Id: <20180815031248.14908-7-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 06/17] aio: Do aio_notify_accept only during
 blocking aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

An aio_notify() pairs with an aio_notify_accept(). The former should
happen in the main thread or a vCPU thread, and the latter should be
done in the IOThread.

There is one rare case that the main thread or vCPU thread may "steal"
the aio_notify() event just raised by itself, in bdrv_set_aio_context()
[1]. The sequence is like this:

    main thread                     IO Thread
    ===============================================================
    bdrv_drained_begin()
      aio_disable_external(ctx)
                                    aio_poll(ctx, true)
                                      ctx->notify_me += 2
    ...
    bdrv_drained_end()
      ...
        aio_notify()
    ...
    bdrv_set_aio_context()
      aio_poll(ctx, false)
[1]     aio_notify_accept(ctx)
                                      ppoll() /* Hang! */

[1] is problematic. It will clear the ctx->notifier event so that
the blocked ppoll() will not return.

(For the curious, this bug was noticed when booting a number of VMs
simultaneously in RHV.  One or two of the VMs will hit this race
condition, making the VIRTIO device unresponsive to I/O commands. When
it hangs, Seabios is busy waiting for a read request to complete (read
MBR), right after initializing the virtio-blk-pci device, using 100%
guest CPU. See also https://bugzilla.redhat.com/show_bug.cgi?id=1562750
for the original bug analysis.)

aio_notify() only injects an event when ctx->notify_me is set,
correspondingly aio_notify_accept() is only useful when ctx->notify_me
_was_ set. Move the call to it into the "blocking" branch. This will
effectively skip [1] and fix the hang.

Furthermore, blocking aio_poll is only allowed on home thread
(in_aio_context_home_thread), because otherwise two blocking
aio_poll()'s can steal each other's ctx->notifier event and cause
hanging just like described above.

Cc: qemu-stable@nongnu.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180809132259.18402-3-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 util/aio-posix.c | 4 ++--
 util/aio-win32.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index b5c7f463aa..b5c609b68b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -591,6 +591,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * so disable the optimization now.
      */
     if (blocking) {
+        assert(in_aio_context_home_thread(ctx));
         atomic_add(&ctx->notify_me, 2);
     }
 
@@ -633,6 +634,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     if (blocking) {
         atomic_sub(&ctx->notify_me, 2);
+        aio_notify_accept(ctx);
     }
 
     /* Adjust polling time */
@@ -676,8 +678,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         }
     }
 
-    aio_notify_accept(ctx);
-
     /* if we have any readable fds, dispatch event */
     if (ret > 0) {
         for (i = 0; i < npfd; i++) {
diff --git a/util/aio-win32.c b/util/aio-win32.c
index e676a8d9b2..c58957cc4b 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -373,11 +373,12 @@ bool aio_poll(AioContext *ctx, bool blocking)
         ret = WaitForMultipleObjects(count, events, FALSE, timeout);
         if (blocking) {
             assert(first);
+            assert(in_aio_context_home_thread(ctx));
             atomic_sub(&ctx->notify_me, 2);
+            aio_notify_accept(ctx);
         }
 
         if (first) {
-            aio_notify_accept(ctx);
             progress |= aio_bh_poll(ctx);
             first = false;
         }
-- 
2.17.1
