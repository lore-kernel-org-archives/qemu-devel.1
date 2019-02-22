Received: from eggs.gnu.org ([209.51.188.92]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1Ju-0002Az-09
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1Jt-0002JW-1s
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:16:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx1Js-0000Pi-OD
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:16:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A998D99CE8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 03:14:52 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 22 Feb 2019 11:14:13 +0800
Message-Id: <20190222031413.20250-5-peterx@redhat.com>
In-Reply-To: <20190222031413.20250-1-peterx@redhat.com>
References: <20190222031413.20250-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] iothread: push gcontext earlier in the
 thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>

We were pushing the context until right before running the gmainloop.
Now since we have everything unconditionally, we can move this
earlier.

One benefit is that now it's done even before init_done_sem, so as
long as the iothread user calls iothread_create() and completes, we
know that the thread stack is ready.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 iothread.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/iothread.c b/iothread.c
index 9abdbace66..7b7cba5d04 100644
--- a/iothread.c
+++ b/iothread.c
@@ -53,7 +53,7 @@ static void *iothread_run(void *opaque)
     IOThread *iothread = opaque;
 
     rcu_register_thread();
-
+    g_main_context_push_thread_default(iothread->worker_context);
     my_iothread = iothread;
     iothread->thread_id = qemu_get_thread_id();
     qemu_sem_post(&iothread->init_done_sem);
@@ -66,12 +66,11 @@ static void *iothread_run(void *opaque)
          * changed in previous aio_poll()
          */
         if (iothread->running && atomic_read(&iothread->run_gcontext)) {
-            g_main_context_push_thread_default(iothread->worker_context);
             g_main_loop_run(iothread->main_loop);
-            g_main_context_pop_thread_default(iothread->worker_context);
         }
     }
 
+    g_main_context_pop_thread_default(iothread->worker_context);
     rcu_unregister_thread();
     return NULL;
 }
-- 
2.17.1
