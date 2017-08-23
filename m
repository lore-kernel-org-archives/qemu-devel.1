Received: from eggs.gnu.org ([2001:4830:134:3::10]:41754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkYJo-0002kH-Ad
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkYJn-00048b-DZ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:15:48 -0400
References: <20170822125113.5025-1-stefanha@redhat.com>
	<8b6f5029-44e8-c14b-6730-6db69ce73f7e@redhat.com>
	<20170823144553.GE16760@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c4ee8ba-c179-0a8c-0fe3-ffa1be38e0a5@redhat.com>
Date: Wed, 23 Aug 2017 18:15:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170823144553.GE16760@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

On 23/08/2017 16:45, Stefan Hajnoczi wrote:
> That depends on the BDRV_POLL_WHILE() allowing all request coroutines to
> terminate before we call nbd_client_detach_aio_context():
> 
>     qio_channel_shutdown(client->ioc,
>                          QIO_CHANNEL_SHUTDOWN_BOTH,
>                          NULL);
>     BDRV_POLL_WHILE(bs, client->read_reply_co);
> 
>     nbd_client_detach_aio_context(bs);
> 
> I'm not sure we have any guarantee that request coroutines will have
> terminated.

Ok, I see my confusion, it's only because of the "receiving" flag which
actually means "waiting for reply".  Your patch is okay.

Paolo

> Once nbd_client_detach_aio_context() is called
> ioc->read_coroutine/write_coroutine are set to NULL.  At that point any
> remaining coroutine doing I/O on ioc will be in trouble.
