Received: from eggs.gnu.org ([2001:4830:134:3::10]:45004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWuv-0003vt-9D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWuu-0005pr-F1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:46:01 -0400
Date: Wed, 23 Aug 2017 15:45:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170823144553.GE16760@stefanha-x1.localdomain>
References: <20170822125113.5025-1-stefanha@redhat.com>
	<8b6f5029-44e8-c14b-6730-6db69ce73f7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6f5029-44e8-c14b-6730-6db69ce73f7e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd-client: avoid spurious
 qio_channel_yield() re-entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

On Tue, Aug 22, 2017 at 03:23:32PM +0200, Paolo Bonzini wrote:
> On 22/08/2017 14:51, Stefan Hajnoczi wrote:
> > This should fix the issue that Dave is seeing but I'm concerned that
> > there are more problems in nbd-client.c.  We don't have good
> > abstractions for writing coroutine socket I/O code.  Something like Go's
> > channels would avoid manual low-level coroutine calls.  There is
> > currently no way to cancel qio_channel_yield() so requests doing I/O may
> > remain in-flight indefinitely and nbd-client.c doesn't join them...
> 
> The idea was that shutdown(2) would force them to reenter...

That depends on the BDRV_POLL_WHILE() allowing all request coroutines to
terminate before we call nbd_client_detach_aio_context():

    qio_channel_shutdown(client->ioc,
                         QIO_CHANNEL_SHUTDOWN_BOTH,
                         NULL);
    BDRV_POLL_WHILE(bs, client->read_reply_co);

    nbd_client_detach_aio_context(bs);

I'm not sure we have any guarantee that request coroutines will have
terminated.

Once nbd_client_detach_aio_context() is called
ioc->read_coroutine/write_coroutine are set to NULL.  At that point any
remaining coroutine doing I/O on ioc will be in trouble.

Stefan
