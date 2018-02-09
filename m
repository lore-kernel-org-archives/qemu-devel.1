Received: from eggs.gnu.org ([2001:4830:134:3::10]:49253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekCOa-0000mN-DF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekCOY-00022w-8M
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:23:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ekCOY-00022E-3z
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:23:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D045C26EDA
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 17:23:24 +0000 (UTC)
Date: Fri, 9 Feb 2018 18:23:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209172314.GA3129@localhost.localdomain>
References: <20180208171807.24267-1-stefanha@redhat.com>
	<20180208171807.24267-2-stefanha@redhat.com>
	<ea22850e-f1b3-bcdd-db48-b6060e468296@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea22850e-f1b3-bcdd-db48-b6060e468296@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: add BlockBackend->in_flight
 counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Am 09.02.2018 um 17:28 hat Paolo Bonzini geschrieben:
> On 08/02/2018 18:18, Stefan Hajnoczi wrote:
> > +    BlockDriverState *bs = blk_bs(blk);
> > +
> > +    if (bs) {
> > +        bdrv_drained_begin(bs);
> > +    }
> > +
> > +    /* We may have aio requests like -ENOMEDIUM in flight */
> > +    while (atomic_mb_read(&blk->in_flight) > 0) {
> > +        aio_poll(blk_get_aio_context(blk), true);
> > +    }
> > +
> > +    if (bs) {
> > +        bdrv_drained_end(bs);
> 
> This only works if you are in the default AioContext, otherwise you can
> run handlers for one AioContexts in two threads.

Should aio_poll() assert that it's called in the right thread to make
sure we obey the rules?

> bdrv_dec_in_flight uses bdrv_wakeup and BDRV_POLL_WHILE to ensure that
> this doesn't happen, so there would be more code that you have to copy
> into block-backend.c.

Instead of copying, can't we generalise it into a POLL_WHILE(ctx,
wakeup, cond) and make BDRV_POLL_WHILE() a wrapper for that?

Kevin
