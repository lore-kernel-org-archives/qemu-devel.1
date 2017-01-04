Received: from eggs.gnu.org ([2001:4830:134:3::10]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOt4o-000316-7p
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOt4j-0000vS-9R
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:26:30 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:54599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cOt4j-0000uk-07
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:26:25 -0500
Date: Wed, 4 Jan 2017 16:26:24 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <828473785.4444002.1483565184407.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170104171823.GJ10541@redhat.com>
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-3-pbonzini@redhat.com>
	<20170104171823.GJ10541@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

> > @@ -84,8 +83,8 @@ struct QIOChannel {
> >      unsigned int features; /* bitmask of QIOChannelFeatures */
> >      char *name;
> >      AioContext *ctx;
> > -    QIOChannelRestart *read_coroutine;
> > -    QIOChannelRestart *write_coroutine;
> > +    Coroutine *read_coroutine;
> > +    Coroutine *write_coroutine;
> 
> Seems this ought to have been squashed into the previous patch

Yeah, sent this last thing before Christmas and it shows. :)

> > +static void qio_channel_set_fd_handlers(QIOChannel *ioc)
> > +{
> > +    IOHandler *rd_handler = NULL, *wr_handler = NULL;
> > +
> > +    if (ioc->read_coroutine) {
> > +	rd_handler = qio_channel_restart_read;
> > +    }
> > +    if (ioc->write_coroutine) {
> > +	rd_handler = qio_channel_restart_write;
> > +    }
> > +
> > +    qio_channel_set_fd_handler(ioc,
> > +                               ioc->ctx ? ioc->ctx :
> > iohandler_get_aio_context(),
> > +                               rd_handler, wr_handler, ioc);
> > +}
> 
> ioc->read_coroutine & ioc->write_coroutine can only be non-NULL during
> a qio_channel_yield() caller. So it seems that calling
> qio_channel_set_fd_handlers() from the qio_channel_set_aio_context()
> method in the previous patch is not required, as those two callback
> pointers will always be NULL.

Not necessarily.  You can have one coroutine calling qio_channel_yield(),
and then the non-coroutine code can call qio_channel_set_aio_context()
before the coroutine reenters.

This actually happens in the next patch.  Where the NBD socket is quiescent
and no response is in flight, such as during a bdrv_drain_begin/end()
section, the "coroutine that receives NBD headers" has yielded.  This
is also the time when set_aio_context can be called.

> > +    if (condition == G_IO_IN) {
> > +        ioc->read_coroutine = qemu_coroutine_self();
> > +    } else if (condition == G_IO_OUT) {
> > +        ioc->write_coroutine = qemu_coroutine_self();
> > +    } else {
> > +        abort();
> > +    }
> 
> Do we really need this to be an either/or/abort ? It looks like
> the qio_channel_set_fd_handlers() method is happy top have both
> read_coroutine & write_coroutine set.

The idea is that this would be called by a coroutine after a
recv or send that returns EAGAIN (with G_IO_IN for recv and
G_IO_OUT for send).  If not exclusive, you'd have to check
for ioc->read_coroutine == ioc->write_coroutine in the handler.
Not a big deal, I can do it, but it adds an edge case and I
didn't see a use for it.

> If it does need to be exclusive though, can you update the API
> docs for this method to mention that.

Sure.

Thanks for the speedy review!

Paolo
