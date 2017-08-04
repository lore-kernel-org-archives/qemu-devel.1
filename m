Received: from eggs.gnu.org ([2001:4830:134:3::10]:50130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddY9R-0008O2-51
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddY9O-0001XF-Pt
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddY9O-0001W3-Gl
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:40:06 -0400
Date: Fri, 4 Aug 2017 16:39:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804083959.GN5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-28-git-send-email-peterx@redhat.com>
	<20170803123704.GK2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803123704.GK2076@work-vm>
Subject: Re: [Qemu-devel] [RFC 27/29] migration: setup ramstate for resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Aug 03, 2017 at 01:37:04PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > After we updated the dirty bitmaps of ramblocks, we also need to update
> > the critical fields in RAMState to make sure it is ready for a resume.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/ram.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index c695b13..427bf6e 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1947,6 +1947,31 @@ static int ram_state_init(RAMState **rsp)
> >      return 0;
> >  }
> >  
> > +static void ram_state_resume_prepare(RAMState *rs)
> > +{
> > +    RAMBlock *block;
> > +    long pages = 0;
> > +
> > +    /*
> > +     * Postcopy is not using xbzrle/compression, so no need for that.
> > +     * Also, since source are already halted, we don't need to care
> > +     * about dirty page logging as well.
> > +     */
> > +
> > +    RAMBLOCK_FOREACH(block) {
> > +        pages += bitmap_count_one(block->bmap,
> > +                                  block->max_length >> TARGET_PAGE_BITS);
> 
> Again I think that needs to be block->used_length (see
> migration_bitmap_sync).

Fixing.

> 
> > +    }
> > +
> > +    /* This may not be aligned with current bitmaps. Recalculate. */
> > +    rs->migration_dirty_pages = pages;
> > +
> > +    rs->last_seen_block = NULL;
> > +    rs->last_sent_block = NULL;
> > +    rs->last_page = 0;
> > +    rs->last_version = ram_list.version;
> 
> A trace at this point with the pages count might be worthwhile.

Added.

> 
> > +}
> > +
> >  /*
> >   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
> >   * long-running RCU critical section.  When rcu-reclaims in the code
> > @@ -2842,8 +2867,16 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> >  static int ram_resume_prepare(MigrationState *s, void *opaque)
> >  {
> >      RAMState *rs = *(RAMState **)opaque;
> > +    int ret;
> >  
> > -    return ram_dirty_bitmap_sync_all(s, rs);
> > +    ret = ram_dirty_bitmap_sync_all(s, rs);
> 
> Interesting; I'd assumed you'd load directly into this
> bitmap rather than loading into the bitmap on each block.
> Do we ever get the case where a bitmap is set on the source
> bitmap but not in the loaded bitmap?

(confirmed with Dave offlist that this is not a problem, blame myself
 on using a poor function name "ram_dirty_bitmap_sync_all" which is
 too close to existng "migration_bitmap_sync")

-- 
Peter Xu
