Received: from eggs.gnu.org ([2001:4830:134:3::10]:34218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwnoK-000382-EV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwnoG-0004Va-I8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:13:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwnoG-0004Ty-BL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:13:52 -0400
Date: Tue, 26 Sep 2017 19:13:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170926111343.GE31924@lemon.lan>
References: <20170926054439.GB25267@pxdev.xzpeter.org>
	<20170926084337.GB16834@stefanha-x1.localdomain>
	<20170926091150.GC3828@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926091150.GC3828@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] A glib warning encountered with internal iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 09/26 17:11, Peter Xu wrote:
> If glib unset the flag after calling the destructor, it'll be fine.
> But it's not doing it that way.  And with above implementation of
> glib, I don't see a good way to solve this problem via ordering of
> glib calls... :(

Does this work?

---

diff --git a/include/block/aio.h b/include/block/aio.h
index e9aeeaec94..3237d2be7c 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -147,6 +147,9 @@ struct AioContext {
     int epollfd;
     bool epoll_enabled;
     bool epoll_available;
+
+    /* Protected by BQL */
+    int refcnt;
 };
 
 /**
diff --git a/util/async.c b/util/async.c
index 355af73ee7..c5464611e3 100644
--- a/util/async.c
+++ b/util/async.c
@@ -293,7 +293,6 @@ aio_ctx_finalize(GSource     *source)
     }
     qemu_lockcnt_unlock(&ctx->list_lock);
 
-    aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
     event_notifier_cleanup(&ctx->notifier);
     qemu_rec_mutex_destroy(&ctx->lock);
     qemu_lockcnt_destroy(&ctx->list_lock);
@@ -429,6 +428,8 @@ AioContext *aio_context_new(Error **errp)
     ctx->poll_grow = 0;
     ctx->poll_shrink = 0;
 
+    ctx->refcnt = 1;
+
     return ctx;
 fail:
     g_source_destroy(&ctx->source);
@@ -476,11 +477,17 @@ void aio_co_enter(AioContext *ctx, struct Coroutine *co)
 
 void aio_context_ref(AioContext *ctx)
 {
+    assert(ctx->refcnt > 0);
+    ctx->refcnt++;
     g_source_ref(&ctx->source);
 }
 
 void aio_context_unref(AioContext *ctx)
 {
+    assert(ctx->refcnt > 0);
+    if (--ctx->refcnt == 0) {
+        aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
+    }
     g_source_unref(&ctx->source);
 }
 
