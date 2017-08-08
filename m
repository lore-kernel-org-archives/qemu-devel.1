Received: from eggs.gnu.org ([2001:4830:134:3::10]:47912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df38H-000192-DW
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df38E-0007Ta-8Z
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1df38D-0007Qo-VG
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:57:06 -0400
Date: Tue, 8 Aug 2017 13:56:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808115652.GH4850@dhcp-200-186.str.redhat.com>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
	<CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
	<9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
	<20170808100243.GG4850@dhcp-200-186.str.redhat.com>
	<5a5542b7-bc68-c032-24ea-12821b8b6a1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5542b7-bc68-c032-24ea-12821b8b6a1a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Prasad Pandit <ppandit@redhat.com>

Am 08.08.2017 um 13:04 hat Paolo Bonzini geschrieben:
> On 08/08/2017 12:02, Kevin Wolf wrote:
> > Am 04.08.2017 um 13:46 hat Paolo Bonzini geschrieben:
> >> On 04/08/2017 11:58, Stefan Hajnoczi wrote:
> >>>> the root cause of this bug is related to this as well:
> >>>> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.html
> >>>>
> >>>> From commit 99723548 we started assuming (incorrectly?) that blk_
> >>>> functions always WILL have an attached BDS, but this is not always true,
> >>>> for instance, flushing the cache from an empty CDROM.
> >>>>
> >>>> Paolo, can we move the flight counter increment outside of the
> >>>> block-backend layer, is that safe?
> >>> I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
> >>> regardless of the throttling timer issue discussed below.  BB cannot
> >>> assume that the BDS graph is non-empty.
> >>
> >> Can we make bdrv_aio_* return NULL (even temporarily) if there is no
> >> attached BDS?  That would make it much easier to fix.
> > 
> > Would the proper fix be much more complicated than the following? I must
> > admit that I don't fully understand the current state of affairs with
> > respect to threading, AioContext etc. so I may well be missing
> > something.
> 
> Not much, but it's not complete either.  The issues I see are that: 1)
> blk_drain_all does not take the new counter into account;

Ok, I think this does the trick:

void blk_drain_all(void)
{
    BlockBackend *blk = NULL;

    bdrv_drain_all_begin();
    while ((blk = blk_all_next(blk)) != NULL) {
        blk_drain(blk);
    }
    bdrv_drain_all_end();
}

> 2) bdrv_drain_all callers need to be audited to see if they should be
> blk_drain_all (or more likely, only device BlockBackends should be drained).

qmp_transaction() is unclear to me. It should be changed in some way
anyway because it uses bdrv_drain_all() rather than a begin/end pair.

do_vm_stop() and vm_stop_force_state() probably want blk_drain_all().

xen_invalidate_map_cache() - wtf? Looks like the wrong layer to do this,
but I guess blk_drain_all(), too.

block_migration_cleanup() is just lazy and really means a blk_drain()
for its own BlockBackends. blk_drain_all() as the simple conversion.

migration/savevm: Migration wants blk_drain_all() to get the devices
quiesced.

qemu-io: blk_drain_all(), too.

Hm, looks like there won't be many callers of bdrv_drain_all() left. :-)

> > Note that my blk_drain() implementation doesn't necessarily drain
> > blk_bs(blk) completely, but only those requests that came from the
> > specific BlockBackend. I think this is what the callers want, but
> > if otherwise, it shouldn't be hard to change.
> 
> Yes, this should be what they want.

Apparently not; block jobs don't complete with it any more. I haven't
checked in detail, but it makes sense that they can have a BH (e.g. for
block_job_defer_to_main_loop) without a request being in flight.

So I'm including an unconditional bdrv_drain() again. Or I guess,
calling aio_poll() unconditionally and including its return value
in the loop condition would be the cleaner approach?

Kevin
