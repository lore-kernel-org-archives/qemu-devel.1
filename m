Received: from eggs.gnu.org ([2001:4830:134:3::10]:55631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0nff-0001jP-Dr
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0nfe-0006EN-7z
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:21:15 -0400
Date: Wed, 19 Apr 2017 12:20:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170419112056.GC2099@work-vm>
References: <20170412091819.GB4955@noname.str.redhat.com>
	<20170418144725.GJ21261@stefanha-x1.localdomain>
	<20170418153256.GE9236@noname.redhat.com>
	<20170419111328.GB2099@work-vm> <8737d4hchf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8737d4hchf.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [Qemu-block] migrate -b problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> >> Am 18.04.2017 um 16:47 hat Stefan Hajnoczi geschrieben:
> >> > On Wed, Apr 12, 2017 at 11:18:19AM +0200, Kevin Wolf wrote:
> >> > > after getting assertion failure reports for block migration in the last
> >> > > minute, we just hacked around it by commenting out op blocker assertions
> >> > > for the 2.9 release, but now we need to see how to fix things properly.
> >> > > Luckily, get_maintainer.pl doesn't report me, but only you. :-)
> >> > > 
> >> > > The main problem I see with the block migration code (on the
> >> > > destination) is that it abuses the BlockBackend that belongs to the
> >> > > guest device to make its own writes to the image file. If the guest
> >> > > isn't allowed to write to the image (which it now isn't during incoming
> >> > > migration since it would conflict with the newer style of block
> >> > > migration using an NBD server), writing to this BlockBackend doesn't
> >> > > work any more.
> >> > > 
> >> > > So what should really happen is that incoming block migration creates
> >> > > its own BlockBackend for writing to the image. Now we don't want to do
> >> > > this anew for every incoming block, but ideally we'd just create all
> >> > > necessary BlockBackends upfront and then keep using them throughout the
> >> > > whole migration. Is there a way to get some setup/teardown callbacks
> >> > > at the start/end of the migration that could initialise and free such
> >> > > global data?
> >> > 
> >> > It can be done in the beginning of block_load() similar to
> >> > block_mig_state.bmds_list, which is created in init_blk_migration() at
> >> > save time.
> >> 
> >> The difference is that block_load() is the counterpart for
> >> block_save_iterate(), not for init_blk_migration(). That is, it is
> >> called for each chunk of block migration data, which is interleaved with
> >> normal RAM migration chunks.
> >> 
> >> So we can either create each BlockBackend the first time we need it in
> >> block_load(), or create BlockBackends for all existing device BBs and
> >> BDSes the first time block_load() is called. We still need some place
> >> to actually free the BlockBackends again when the migration completes.
> >> 
> >> Dave suggested migration state notifiers, which looked like an option,
> >> but at least the existing migration states aren't enough, because the
> >> BlockBackends need to go away before blk_resume_after_migration() is
> >> called, but MIGRATION_STATUS_COMPLETED is set only afterwards.
> >> 
> >> > We can also move the if (blk != blk_prev) blk_invalidate_cache() code
> >> > out of the load loop.  It should be done once when setting up
> >> > BlockBackends.
> >> 
> >> Same problem as above, while saving has setup/cleanup callbacks, we only
> >> have the iterate callback for loading.
> >
> >
> > Yes, and while we have the notifier chain for the source on migration state
> > changes we don't have the notifier on the destination.
> >
> > If we just add a load_cleanup  member to SaveVMHandlers and call all of them
> > at the end of an inbound migration would that be enough?
> > (And define 'end')
> 
> We already have a setup() one, that should be enough, no?
> We also need a cleanup() one, that is what I am going to add.

We need it on the *destination* there's no setup call on the destination is there?

Dave

> Anything else that is needed for this particular problem?
> 
> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
