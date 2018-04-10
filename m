Received: from eggs.gnu.org ([2001:4830:134:3::10]:34315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tE1-0003GZ-NV
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tDx-0002Va-IN
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5tDx-0002V7-E1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FBB07C3B1
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 13:22:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 10 Apr 2018 08:21:59 -0500
Message-Id: <20180410132200.187832-3-eblake@redhat.com>
In-Reply-To: <20180410132200.187832-1-eblake@redhat.com>
References: <20180410132200.187832-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] iothread: workaround glib bug which hangs
 qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Free the AIO context earlier than the GMainContext (if we have) to
workaround a glib2 bug that GSource context pointer is not cleared even
if the context has already been destroyed (while it should).

The patch itself only changed the order to destroy the objects, no
functional change at all. Without this workaround, we can encounter
qmp-test hang with oob (and possibly any other use case when iothread is
used with GMainContexts):

  #0  0x00007f35ffe45334 in __lll_lock_wait () from /lib64/libpthread.so.0
  #1  0x00007f35ffe405d8 in _L_lock_854 () from /lib64/libpthread.so.0
  #2  0x00007f35ffe404a7 in pthread_mutex_lock () from /lib64/libpthread.so.0
  #3  0x00007f35fc5b9c9d in g_source_unref_internal (source=0x24f0600, context=0x7f35f0000960, have_lock=0) at gmain.c:1685
  #4  0x0000000000aa6672 in aio_context_unref (ctx=0x24f0600) at /root/qemu/util/async.c:497
  #5  0x000000000065851c in iothread_instance_finalize (obj=0x24f0380) at /root/qemu/iothread.c:129
  #6  0x0000000000962d79 in object_deinit (obj=0x24f0380, type=0x242e960) at /root/qemu/qom/object.c:462
  #7  0x0000000000962e0d in object_finalize (data=0x24f0380) at /root/qemu/qom/object.c:476
  #8  0x0000000000964146 in object_unref (obj=0x24f0380) at /root/qemu/qom/object.c:924
  #9  0x0000000000965880 in object_finalize_child_property (obj=0x24ec640, name=0x24efca0 "mon_iothread", opaque=0x24f0380) at /root/qemu/qom/object.c:1436
  #10 0x0000000000962c33 in object_property_del_child (obj=0x24ec640, child=0x24f0380, errp=0x0) at /root/qemu/qom/object.c:436
  #11 0x0000000000962d26 in object_unparent (obj=0x24f0380) at /root/qemu/qom/object.c:455
  #12 0x0000000000658f00 in iothread_destroy (iothread=0x24f0380) at /root/qemu/iothread.c:365
  #13 0x00000000004c67a8 in monitor_cleanup () at /root/qemu/monitor.c:4663
  #14 0x0000000000669e27 in main (argc=16, argv=0x7ffc8b1ae2f8, envp=0x7ffc8b1ae380) at /root/qemu/vl.c:4749

The glib2 bug is fixed in commit 26056558b ("gmain: allow
g_source_get_context() on destroyed sources", 2012-07-30), so the first
good version is glib2 2.33.10. But we still support building with
glib as old as 2.28, so we need the workaround.

Let's make sure we destroy the GSources first before its owner context
until we drop support for glib older than 2.33.10.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180409083956.1780-1-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 iothread.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/iothread.c b/iothread.c
index e675c384422..aff12812576 100644
--- a/iothread.c
+++ b/iothread.c
@@ -117,16 +117,26 @@ static void iothread_instance_finalize(Object *obj)
     IOThread *iothread = IOTHREAD(obj);

     iothread_stop(iothread);
+    /*
+     * Before glib2 2.33.10, there is a glib2 bug that GSource context
+     * pointer may not be cleared even if the context has already been
+     * destroyed (while it should).  Here let's free the AIO context
+     * earlier to bypass that glib bug.
+     *
+     * We can remove this comment after the minimum supported glib2
+     * version boosts to 2.33.10.  Before that, let's free the
+     * GSources first before destroying any GMainContext.
+     */
+    if (iothread->ctx) {
+        aio_context_unref(iothread->ctx);
+        iothread->ctx = NULL;
+    }
     if (iothread->worker_context) {
         g_main_context_unref(iothread->worker_context);
         iothread->worker_context = NULL;
     }
     qemu_cond_destroy(&iothread->init_done_cond);
     qemu_mutex_destroy(&iothread->init_done_lock);
-    if (!iothread->ctx) {
-        return;
-    }
-    aio_context_unref(iothread->ctx);
 }

 static void iothread_complete(UserCreatable *obj, Error **errp)
-- 
2.14.3
