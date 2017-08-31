Received: from eggs.gnu.org ([2001:4830:134:3::10]:53478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnLbQ-0002Sz-7l
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnLbM-0007hp-US
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnLbM-0007hg-LQ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:17:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB327267D5
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 09:17:27 +0000 (UTC)
Date: Thu, 31 Aug 2017 10:17:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831091723.GC17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170830135611.27678-1-berrange@redhat.com>
	<baf58715-49f6-6608-d469-062086c4fdd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <baf58715-49f6-6608-d469-062086c4fdd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: add new qio_channel_{readv, writev,
 read, write}_all functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

On Wed, Aug 30, 2017 at 02:34:59PM -0500, Eric Blake wrote:
> On 08/30/2017 08:56 AM, Daniel P. Berrange wrote:
> > These functions wait until they are able to read / write the full
> > requested data buffer(s).
> > 
> 
> Hmm, sounds like the NBD code would benefit from using this in a
> followup patch.
> 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> > 
> > This patch combines these two previous proposals:
> > 
> >  - https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01536.html
> >  - https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04041.html
> > 
> > and switches the test suite over to use the new APIs so we get
> > coverage by all the tests/test-io-channel-*  test programs
> > 
> 
> >  /**
> > + * qio_channel_readv_all:
> > + * @ioc: the channel object
> > + * @iov: the array of memory regions to read data into
> > + * @niov: the length of the @iov array
> > + * @errp: pointer to a NULL-initialized error object
> > + *
> > + * Read data from the IO channel, storing it in the
> > + * memory regions referenced by @iov. Each element
> > + * in the @iov will be fully populated with data
> > + * before the next one is used. The @niov parameter
> > + * specifies the total number of elements in @iov.
> > + *
> > + * The function will wait for all requested data
> > + * to be read, yielding from the current couroutine
> 
> s/couroutine/coroutine/
> 
> > + * if required.
> > + *
> > + * If end-of-file occurrs before all requested data
> 
> s/occurrs/occurs/
> 
> > + * has been read, an error will be reported.
> > + *
> > + * Returns: 0 if all bytes were read, or -1 on error
> > + */
> 
> > +/**
> > + * qio_channel_writev_all:
> > + * @ioc: the channel object
> > + * @iov: the array of memory regions to write data from
> > + * @niov: the length of the @iov array
> > + * @errp: pointer to a NULL-initialized error object
> > + *
> > + * Write data to the IO channel, reading it from the
> > + * memory regions referenced by @iov. Each element
> > + * in the @iov will be fully sent, before the next
> > + * one is used. The @niov parameter specifies the
> > + * total number of elements in @iov.
> > + *
> > + * The function will wait for all requested data
> > + * to be written, yielding from the current couroutine
> 
> s/couroutine/coroutine/
> 
> > +++ b/io/channel.c
> 
> > +int qio_channel_readv_all(QIOChannel *ioc,
> 
> > +    while (nlocal_iov > 0) {
> > +        ssize_t len;
> > +        len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
> > +        if (len == QIO_CHANNEL_ERR_BLOCK) {
> > +            qio_channel_wait(ioc, G_IO_IN);
> > +            continue;
> > +        } else if (len < 0) {
> > +            error_setg_errno(errp, EIO,
> > +                             "Channel was not able to read full iov");
> 
> Should we report -len instead of EIO here?

No, QIO methods never return errno values, since channel implementations
are not guaranteed to be calling commands that return errnos. eg the
TLS wrapper calls gnutls which has no errno values reported.

If fact, though, we should just not call error_setg_errno() at all,
since the qio_channel_readv method has already populated 'errp'.

> 
> > +int qio_channel_writev_all(QIOChannel *ioc,
> 
> > +    while (nlocal_iov > 0) {
> > +        ssize_t len;
> > +        len = qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
> > +        if (len == QIO_CHANNEL_ERR_BLOCK) {
> > +            qio_channel_wait(ioc, G_IO_OUT);
> > +            continue;
> > +        }
> > +        if (len < 0) {
> > +            error_setg_errno(errp, EIO,
> > +                             "Channel was not able to write full iov");
> 
> and again
> 
> With the typos fixed, and either an explanation why EIO is better or
> else a fix to preserve errno,

Again, we should not call error_setg_errno at all, since errp is
already populated.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>




Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
