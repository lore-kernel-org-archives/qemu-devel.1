Received: from eggs.gnu.org ([2001:4830:134:3::10]:58567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3cJ1-0000b1-Ux
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3cIx-0007AI-3K
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:54:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f3cIw-0007AA-U3
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:53:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73FE38182D24
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 06:53:58 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Apr 2018 14:53:46 +0800
Message-Id: <20180404065346.3252-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] iothread: workaround glib bug which
 hangs qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Free the AIO context earlier than the GMainContext (if we have) to
workaround a possible Glib bug.  No functional change at all.

We encountered a qmp-test hang with oob:

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

With glib version 2.28.8-9 (current default version on centos6) we might
encounter above with the old code. It is verified that glib version
2.50.3-3 won't trigger that bug again, but since we are still supporting
glib 2.28.8-9, we may want this workaround.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 iothread.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/iothread.c b/iothread.c
index e675c38442..d41d661cdf 100644
--- a/iothread.c
+++ b/iothread.c
@@ -117,16 +117,26 @@ static void iothread_instance_finalize(Object *obj)
     IOThread *iothread = IOTHREAD(obj);
 
     iothread_stop(iothread);
+    /*
+     * With glib version 2.28.8-9 (current default version on centos6)
+     * we might encounter problem of qmp-test OOB hang if we unref the
+     * AIO context later than the GMainContext below.  Let's free the
+     * AIO context earlier to bypass that possible glib bug.
+     *
+     * It is verified that glib version 2.50.3-3 (or even earlier)
+     * won't trigger that bug again, but since we are still supporting
+     * glib 2.28.8-9, we need this workaround.
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
