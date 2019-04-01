Received: from eggs.gnu.org ([209.51.188.92]:42644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46y-0003UN-Tb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46x-0004rE-3F
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46w-0004o2-BL
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4iV3114707
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:49 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksvqgywa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:46 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:50 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:56 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-23-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 22/97] aio: Do aio_notify_accept only during
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
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

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
(cherry picked from commit b37548fcd1b8ac2e88e185a395bef851f3fc4e65)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
