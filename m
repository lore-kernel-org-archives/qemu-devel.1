Received: from eggs.gnu.org ([209.51.188.92]:39939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1Im-0001IX-6Z
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1Ik-0000hl-Jl
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:15:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx1Ij-0000M3-Vj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:15:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C0826699D
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 03:14:48 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 22 Feb 2019 11:14:12 +0800
Message-Id: <20190222031413.20250-4-peterx@redhat.com>
In-Reply-To: <20190222031413.20250-1-peterx@redhat.com>
References: <20190222031413.20250-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] iothread: create main loop unconditionally
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

Since we've have the gcontext always there, create the main loop
altogether.  The iothread_run() is even cleaner.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 iothread.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/iothread.c b/iothread.c
index 6fa87876e0..9abdbace66 100644
--- a/iothread.c
+++ b/iothread.c
@@ -66,17 +66,8 @@ static void *iothread_run(void *opaque)
          * changed in previous aio_poll()
          */
         if (iothread->running && atomic_read(&iothread->run_gcontext)) {
-            GMainLoop *loop;
-
             g_main_context_push_thread_default(iothread->worker_context);
-            iothread->main_loop =
-                g_main_loop_new(iothread->worker_context, TRUE);
-            loop = iothread->main_loop;
-
             g_main_loop_run(iothread->main_loop);
-            iothread->main_loop = NULL;
-            g_main_loop_unref(loop);
-
             g_main_context_pop_thread_default(iothread->worker_context);
         }
     }
@@ -141,6 +132,8 @@ static void iothread_instance_finalize(Object *obj)
     if (iothread->worker_context) {
         g_main_context_unref(iothread->worker_context);
         iothread->worker_context = NULL;
+        g_main_loop_unref(iothread->main_loop);
+        iothread->main_loop = NULL;
     }
     qemu_sem_destroy(&iothread->init_done_sem);
 }
@@ -153,6 +146,7 @@ static void iothread_init_gcontext(IOThread *iothread)
     source = aio_get_g_source(iothread_get_aio_context(iothread));
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
+    iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
 }
 
 static void iothread_complete(UserCreatable *obj, Error **errp)
-- 
2.17.1
