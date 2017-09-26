Received: from eggs.gnu.org ([2001:4830:134:3::10]:49862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwhrT-0002uy-RI
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwhrQ-0000Ed-PJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwhrQ-0000ER-JR
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:52:44 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 26 Sep 2017 12:52:12 +0800
Message-Id: <1506401532-25274-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1506401532-25274-1-git-send-email-peterx@redhat.com>
References: <1506401532-25274-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/4] iothread: delay the context release to
 finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, peterx@redhat.com, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

When gcontext is used with iothread, the context will be destroyed
during iothread_stop().  That's not good since sometimes we would like
to keep the resources until iothread is destroyed, but we may want to
stop the thread before that point.

Delay the destruction of gcontext to iothread finalize.  Then we can do:

  iothread_stop(thread);
  some_cleanup_on_resources();
  iothread_destroy(thread);

We may need this patch if we want to run chardev IOs in iothreads and
hopefully clean them up correctly.  For more specific information,
please see 2b316774f6 ("qemu-char: do not operate on sources from
finalize callbacks").

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 iothread.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/iothread.c b/iothread.c
index b3c092b..27a4288 100644
--- a/iothread.c
+++ b/iothread.c
@@ -71,8 +71,6 @@ static void *iothread_run(void *opaque)
             g_main_loop_unref(loop);
 
             g_main_context_pop_thread_default(iothread->worker_context);
-            g_main_context_unref(iothread->worker_context);
-            iothread->worker_context = NULL;
         }
     }
 
@@ -117,6 +115,10 @@ static void iothread_instance_finalize(Object *obj)
     IOThread *iothread = IOTHREAD(obj);
 
     iothread_stop(iothread);
+    if (iothread->worker_context) {
+        g_main_context_unref(iothread->worker_context);
+        iothread->worker_context = NULL;
+    }
     qemu_cond_destroy(&iothread->init_done_cond);
     qemu_mutex_destroy(&iothread->init_done_lock);
     if (!iothread->ctx) {
-- 
2.7.4
