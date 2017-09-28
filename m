Received: from eggs.gnu.org ([2001:4830:134:3::10]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxOnc-0003X7-0r
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxOnY-0002ep-UR
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxOnY-0002d1-OL
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:43:36 -0400
Date: Thu, 28 Sep 2017 10:43:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170928024327.GD17044@pxdev.xzpeter.org>
References: <20170926054439.GB25267@pxdev.xzpeter.org>
	<20170926084337.GB16834@stefanha-x1.localdomain>
	<20170926091150.GC3828@pxdev.xzpeter.org>
	<20170926111343.GE31924@lemon.lan>
	<20170927121753.GB14579@stefanha-x1.localdomain>
	<20170927123646.GA8521@lemon.lan>
	<49ed96f4-74e3-6e2b-72d1-0f6741ed2469@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49ed96f4-74e3-6e2b-72d1-0f6741ed2469@redhat.com>
Subject: Re: [Qemu-devel] A glib warning encountered with internal iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Sep 27, 2017 at 03:14:40PM +0200, Paolo Bonzini wrote:
> On 27/09/2017 14:36, Fam Zheng wrote:
> > On Wed, 09/27 13:17, Stefan Hajnoczi wrote:
> >> On Tue, Sep 26, 2017 at 07:13:43PM +0800, Fam Zheng wrote:
> >>> On Tue, 09/26 17:11, Peter Xu wrote:
> >>>  void aio_context_unref(AioContext *ctx)
> >>>  {
> >>> +    assert(ctx->refcnt > 0);
> >>> +    if (--ctx->refcnt == 0) {
> >>> +        aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
> >>> +    }
> >>
> >> This isn't a general solution because Linux AIO also has a file
> >> descriptor that is removed in aio_ctx_finalize().
> > 
> > Right. Another option is to move everything in aio_context_finalize() into the
> > "if (--ctx->refcnt == 0) { ... }" block, before calling g_source_unref().
> 
> I think I prefer Stefan's solution.  If the GSource has been ref'ed
> independent of the AioContext object, it may be a problem to free it early.

Stefan's patch works for me.  I'll put Stefan's patch into iothread
series and repost soon.

Thanks Stefan (and all)!

-- 
Peter Xu
