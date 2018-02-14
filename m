Received: from eggs.gnu.org ([2001:4830:134:3::10]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1em1zQ-00038Q-7p
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1em1zN-0004mp-0O
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:41:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1em1zM-0004mj-RI
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:41:04 -0500
Date: Wed, 14 Feb 2018 18:40:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180214184045.GE2507@work-vm>
References: <20180208103132.28452-1-peterx@redhat.com>
	<20180208103132.28452-22-peterx@redhat.com>
	<20180213181750.GQ2378@work-vm> <20180214042000.GF4472@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214042000.GF4472@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v6 21/28] migration: setup ramstate for
 resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Feb 13, 2018 at 06:17:51PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > After we updated the dirty bitmaps of ramblocks, we also need to update
> > > the critical fields in RAMState to make sure it is ready for a resume.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/ram.c        | 40 +++++++++++++++++++++++++++++++++++++++-
> > >  migration/trace-events |  1 +
> > >  2 files changed, 40 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index a2a4b05d5c..d275875f54 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -2250,6 +2250,36 @@ static int ram_init_all(RAMState **rsp)
> > >      return 0;
> > >  }
> > >  
> > > +static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
> > > +{
> > > +    RAMBlock *block;
> > > +    long pages = 0;
> > > +
> > > +    /*
> > > +     * Postcopy is not using xbzrle/compression, so no need for that.
> > > +     * Also, since source are already halted, we don't need to care
> > > +     * about dirty page logging as well.
> > > +     */
> > > +
> > > +    RAMBLOCK_FOREACH(block) {
> > > +        pages += bitmap_count_one(block->bmap,
> > > +                                  block->used_length >> TARGET_PAGE_BITS);
> > > +    }
> > > +
> > > +    /* This may not be aligned with current bitmaps. Recalculate. */
> > > +    rs->migration_dirty_pages = pages;
> > 
> > migration_dirty_pages is uint64_t - so we should probably do the cast
> > above and keep 'pages' as uint64_t.
> 
> Sure.
> 
> > 
> > > +    rs->last_seen_block = NULL;
> > > +    rs->last_sent_block = NULL;
> > > +    rs->last_page = 0;
> > > +    rs->last_version = ram_list.version;
> > 
> > Do you need to explicitly set
> >        rs->ram_bulk_stage = false;
> > 
> > if the failure happened just after the start of postcopy and no
> > requested pages had been sent, I think it might still  be set?
> 
> Could you elaborate what would go wrong even if it's still set?

I think it might start sending all pages rather than just those
that are dirty/needed;  see migration_bitmap_find_dirty.

Dave

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
