Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dxBHx-0000Q2-82
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dxBHt-0001jR-8J
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:18:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dxBHs-0001il-UK
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:18:01 -0400
Date: Wed, 27 Sep 2017 13:17:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170927121753.GB14579@stefanha-x1.localdomain>
References: <20170926054439.GB25267@pxdev.xzpeter.org>
	<20170926084337.GB16834@stefanha-x1.localdomain>
	<20170926091150.GC3828@pxdev.xzpeter.org>
	<20170926111343.GE31924@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926111343.GE31924@lemon.lan>
Subject: Re: [Qemu-devel] A glib warning encountered with internal iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Sep 26, 2017 at 07:13:43PM +0800, Fam Zheng wrote:
> On Tue, 09/26 17:11, Peter Xu wrote:
>  void aio_context_unref(AioContext *ctx)
>  {
> +    assert(ctx->refcnt > 0);
> +    if (--ctx->refcnt == 0) {
> +        aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
> +    }

This isn't a general solution because Linux AIO also has a file
descriptor that is removed in aio_ctx_finalize().

Here is a different approach.  Does it work for you?

BTW I'm not a glib expert so maybe we're abusing the API and missing the
obvious way to structure our code :).

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2d51239ec6..5946ac09f0 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -223,7 +223,14 @@ void aio_set_fd_handler(AioContext *ctx,
             return;
         }

-        g_source_remove_poll(&ctx->source, &node->pfd);
+        /* If the GSource is in the process of being destroyed then
+         * g_source_remove_poll() causes an assertion failure.  Skip
+         * removal in that case, because glib cleans up its state during
+         * destruction anyway.
+         */
+        if (!g_source_is_destroyed(&ctx->source)) {
+            g_source_remove_poll(&ctx->source, &node->pfd);
+        }

         /* If the lock is held, just mark the node as deleted */
         if (qemu_lockcnt_count(&ctx->list_lock)) {
