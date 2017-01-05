Received: from eggs.gnu.org ([2001:4830:134:3::10]:55704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cP5Fw-0008FQ-15
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cP5Fs-0000FS-7z
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:26:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cP5Fs-0000Cd-0I
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:26:44 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEE094DAF8
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 10:26:42 +0000 (UTC)
Date: Thu, 5 Jan 2017 10:26:37 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170105102637.GD3292@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-3-pbonzini@redhat.com>
	<20170104171823.GJ10541@redhat.com>
	<828473785.4444002.1483565184407.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <828473785.4444002.1483565184407.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 04, 2017 at 04:26:24PM -0500, Paolo Bonzini wrote:
> > > @@ -84,8 +83,8 @@ struct QIOChannel {
> > > +static void qio_channel_set_fd_handlers(QIOChannel *ioc)
> > > +{
> > > +    IOHandler *rd_handler = NULL, *wr_handler = NULL;
> > > +
> > > +    if (ioc->read_coroutine) {
> > > +	rd_handler = qio_channel_restart_read;
> > > +    }
> > > +    if (ioc->write_coroutine) {
> > > +	rd_handler = qio_channel_restart_write;
> > > +    }
> > > +
> > > +    qio_channel_set_fd_handler(ioc,
> > > +                               ioc->ctx ? ioc->ctx :
> > > iohandler_get_aio_context(),
> > > +                               rd_handler, wr_handler, ioc);
> > > +}
> > 
> > ioc->read_coroutine & ioc->write_coroutine can only be non-NULL during
> > a qio_channel_yield() caller. So it seems that calling
> > qio_channel_set_fd_handlers() from the qio_channel_set_aio_context()
> > method in the previous patch is not required, as those two callback
> > pointers will always be NULL.
> 
> Not necessarily.  You can have one coroutine calling qio_channel_yield(),
> and then the non-coroutine code can call qio_channel_set_aio_context()
> before the coroutine reenters.
> 
> This actually happens in the next patch.  Where the NBD socket is quiescent
> and no response is in flight, such as during a bdrv_drain_begin/end()
> section, the "coroutine that receives NBD headers" has yielded.  This
> is also the time when set_aio_context can be called.

Ok, that's a little surprising :-) Can you document on qio_channel_yield
that its permitted to yield and set an aio context while waiting.

> > > +    if (condition == G_IO_IN) {
> > > +        ioc->read_coroutine = qemu_coroutine_self();
> > > +    } else if (condition == G_IO_OUT) {
> > > +        ioc->write_coroutine = qemu_coroutine_self();
> > > +    } else {
> > > +        abort();
> > > +    }
> > 
> > Do we really need this to be an either/or/abort ? It looks like
> > the qio_channel_set_fd_handlers() method is happy top have both
> > read_coroutine & write_coroutine set.
> 
> The idea is that this would be called by a coroutine after a
> recv or send that returns EAGAIN (with G_IO_IN for recv and
> G_IO_OUT for send).  If not exclusive, you'd have to check
> for ioc->read_coroutine == ioc->write_coroutine in the handler.
> Not a big deal, I can do it, but it adds an edge case and I
> didn't see a use for it.

Yep, it feels unlikely. Tht said, it looks similar to the case
where you have two coroutines using the same channel, and one
does a yield(G_IO_IN) and the other does a yield(G_IO_OUT) while
the first is still waiting, which feels like a more plausible
scenario that could actually happen. So perhaps we do need to
consider it

> > If it does need to be exclusive though, can you update the API
> > docs for this method to mention that.
> 
> Sure.
> 
> Thanks for the speedy review!
> 
> Paolo

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
