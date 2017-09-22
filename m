Received: from eggs.gnu.org ([2001:4830:134:3::10]:55779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvJlH-00049M-AX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvJlC-00053O-Fj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dvJlC-00052Q-9c
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F418267DB
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:56:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 22 Sep 2017 16:56:12 +0800
Message-Id: <1506070572-7549-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1506070572-7549-1-git-send-email-peterx@redhat.com>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] iothread: delay the context release to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

When gcontext is used with iothread, the context will be destroyed
during iothread_stop().  That's not good since sometimes we would like
to keep the resources until iothread is destroyed, but we may want to
stop the thread before that point.

Delay the destruction of gcontext to iothread finalize.  Then we can do:

  iothread_stop(thread);
  some_cleanup_on_resources();
  iothread_destroy(thread);

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 iothread.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/iothread.c b/iothread.c
index 894756b..b95369b 100644
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
