Received: from eggs.gnu.org ([209.51.188.92]:58289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3JM-0006qa-I4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw3JL-0001U1-I0
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:11:40 -0500
Date: Tue, 19 Feb 2019 12:11:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219111116.GH4727@localhost.localdomain>
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-8-kwolf@redhat.com>
	<9fe39150-f308-8f2e-0c9d-6d0a31d9329d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fe39150-f308-8f2e-0c9d-6d0a31d9329d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/12] nbd: Increase bs->in_flight during
 AioContext switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Am 18.02.2019 um 18:22 hat Paolo Bonzini geschrieben:
> On 18/02/19 17:18, Kevin Wolf wrote:
> > +            /* aio_ctx_switch is only supposed to be set if we're sitting in
> > +             * the qio_channel_yield() below. */
> > +            assert(!*aio_ctx_switch);
> >              bdrv_dec_in_flight(bs);
> >              qio_channel_yield(ioc, G_IO_IN);
> > -            bdrv_inc_in_flight(bs);
> > +            if (*aio_ctx_switch) {
> > +                /* nbd_client_attach_aio_context() already increased in_flight
> > +                 * when scheduling this coroutine for reentry */
> > +                *aio_ctx_switch = false;
> > +            } else {
> > +                bdrv_inc_in_flight(bs);
> > +            }
> 
> Hmm, my first thought would have been to do the bdrv_inc_in_flight(bs);
> unconditionally here, and in nbd_connection_entry do the opposite, like
> 
> 	if (s->aio_ctx_switch) {
> 	    s->aio_ctx_switch = false;
> 	    bdrv_dec_in_flight(bs);
> 	}
> 
> but I guess the problem is that then bdrv_drain could hang.

Yes, the important part is that in_flight can drop to 0 while we're in
qio_channel_yield().

> So my question is:
> 
> 1) is there a testcase that shows the problem with this "obvious"
> refactoring;

I haven't actually tried it out because it's "obviously" wrong, but in
any test case where no requests are running, you'd never leave this
loop, so it should trivially trigger the problem.

In other words, I think qemu-iotests 094 covers this.

> 2) maybe instead of aio_co_schedul-ing client->connection_co and having
> the s->aio_ctx_switch flag, you could go through a bottom half that does
> the bdrv_inc_in_flight and then enters client->connection_co?

That would be too easy. :-)

But I agree, that might indeed be the better solution.

I think I'd keep patch 6 anyway so that we know the exact yield that
we'll interrupt, even if it's not strictly necessary as long as we know
that nbd_receive_reply() can only yield in places that are safe to be
interrupted. While intuitively I think it's true, I don't feel like
actually auditing the code, and at some point we'd probably fail to
check that new code won't violate this invariant.

Kevin
