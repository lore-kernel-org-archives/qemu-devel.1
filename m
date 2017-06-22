Received: from eggs.gnu.org ([2001:4830:134:3::10]:55904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO7HW-0000xP-O1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO7HT-0002zf-HI
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dO7HT-0002yr-7q
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:56:39 -0400
Date: Thu, 22 Jun 2017 19:56:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170622185633.GH2100@work-vm>
References: <20170614203000.19984-1-ehabkost@redhat.com>
	<20170614203000.19984-4-ehabkost@redhat.com>
	<20170622121457.GC2624@work-vm>
	<20170622172702.GB20956@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622172702.GB20956@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 3/5] memory: Add RAM_NONPERSISTENT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Thu, Jun 22, 2017 at 01:14:58PM +0100, Dr. David Alan Gilbert wrote:
> > * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > > The new flag will make qemu_ram_free() discard the contents of the
> > > block.  It will be used to let QEMU be configured to avoid flushing file
> > > contents to disk when exiting.  As MADV_REMOVE is not always supported,
> > > the new code will try MADV_NOTNEEDED in case MADV_REMOVE fails.
> > 
> > I'd like to understand what semantics you're trying to achieve and thus
> > why you prefer REMOVE to DONTNEED.   If you're trying to avoid changes
> > being written back then doesn't a DONTNEED get rid of any changes that
> > have yet to be written?  Or are there changes that have already been
> > queued that REMOVE will kill off?
> > 
> 
> Generally speaking, it look(ed) like REMOVE is a superset of DONTNEED:
> DONTNEED will free and zero pages only on anonymous private mappings;
> REMOVE will free resources and zero pages on additional cases.

IMHO these calls are all pretty badly defined, and I think there
are a few combinations of requirements that are missing.
(For example I don't think I've found an equivalent to MADV_DONTNEED
for the case of shared hugetlbfs where you want to drop the
current pages from your mapping to cause it to repopulate from the
shared file).

> One case where I can think REMOVE would be useful is tmpfs when swapping
> is involved: with REMOVE, the host can drop swap contents or avoid
> writing memory contents to swap even if we are using a shared tmpfs
> mapping.

Yes.

> Other filesystems might have similar cases where unnecessary I/O
> operations might be performed even after madvise(MADV_DONTNEED) is
> called.  MADV_REMOVE lets us simply tell the kernel to drop the data.
> 
> I'm CCing Zack Cornelius, who initially suggested MADV_REMOVE, in case
> he can describe more specific use cases.
> 
> 
> > If you're just trying to save-time in writeback, it's interesting to
> > note my requirement is that by the time I exit this function the
> > process of throwing away the memory contents must be complete;
> > I think your requirements are a lot lazier as to when it happens.
> 
> This is a very good point.  I was assuming that REMOVE is a superset of
> DONTNEED, but based on the manpage it doesn't seem to be guaranteed.
> Probably I shouldn't try to reuse ram_block_discard_range() and write a
> separate helper for madvise(MADV_REMOVE), as the requirements are
> different.
> 
> 
> > > The new flag will also indicate that ram_block_discard_range() can use
> > > MADV_REMOVE when discarding memory pages.  I have considered calling
> > > MADV_REMOVE unconditionally (as destroying the RAM contents seems to be
> > > OK every time ram_block_discard_range() is called), but for safety I
> > > decided to restrict the new code to blocks having RAM_NONPERSISTENT set.
> > 
> > The manpage on MADV_REMOVE is confusing; it says it doesn't work on Huge
> > TLB pages, but says it does work on anything that can do
> > FALLOC_FL_PUNCH_HOLE - which as far as I can tell hugetlbfs does.
> 
> Yes, it's confusing.  I need to do some testing to find out if HugeTLBFS
> supports MADV_REMOVE today.  But my use case is just an optimization, so
> it won't be a big deal if it doesn't cover every case in the first
> version.
> 
> > 
> > I've got some code in my shared-postcopy world that has this function do
> > the following which is kind of similar:
> > 
> >         /* The logic here is messy;
> >          *    madvise DONTNEED fails for hugepages
> >          *    fallocate works on hugepages and shmem
> >          */
> >         need_madvise = (rb->page_size == qemu_host_page_size) &&
> >                        (rb->fd == -1 || !(rb->flags & RAM_SHARED));
> >         need_fallocate = rb->fd != -1;
> 
> This looks safer to me.  I was bothered by the missing check for
> (rb->fd != -1) in the current code.
> 
> >         if (ret == -1 && need_fallocate) {
> > #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> >             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> >                             start, length);
> > #endif
> >         }
> >         if (need_madvise && (!need_fallocate || (ret == 0))) {
> 
> I'm confused by the (ret == 0) check here.  Do you still want to call
> madvise() if fallocate() succeeded?

Hmm now I'm confused by that check as well;  <checks notes>
if we Demorgan the right side we get:
          if (need_madvice && !(need_fallocate && (ret != 0)) {

   ie we skip the DONTNEED in the case that we wanted an fallocate but
it failed, so that we preserve the error and fail the function.

I'm not at all sure the combinations cover all the shared cases.

> > #if defined(CONFIG_MADVISE)
> >             ret =  madvise(host_startaddr, length, MADV_DONTNEED);
> >             fprintf(stderr, "%s: Did madvise for %p got %d\n", __func__, host_startaddr, ret);
> > #endif
> >         }
> 
> 
> Anyway, now I'm considering simply not touching
> ram_block_discard_range() and adding a new helper, because the
> requirements are different.  Maybe in the future we can make the two
> functions share code, if we decide FALLOC_FL_PUNCH_HOLE will be useful
> for RAM_NONPERSISTENT too.

OK, let me know if you figure out any more of the semantics of these
functions.

> (BTW, I will probably rename "persistent=no"/RAM_NONPERSISTENT to
> something more explicit about data being dropped, like
> "free-on-exit=yes" or "disposable=yes").

Yes please.

Dave

> 
> > 
> > Dave
> > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  exec.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/exec.c b/exec.c
> > > index 585d6ed6d7..a6e9ed4ece 100644
> > > --- a/exec.c
> > > +++ b/exec.c
> > > @@ -102,6 +102,11 @@ static MemoryRegion io_mem_unassigned;
> > >   */
> > >  #define RAM_RESIZEABLE (1 << 2)
> > >  
> > > +/* RAMBlock contents are not persistent, and we can discard memory contents
> > > + * when freeing the memory block.
> > > + */
> > > +#define RAM_NONPERSISTENT (1 << 3)
> > > +
> > >  #endif
> > >  
> > >  #ifdef TARGET_PAGE_BITS_VARY
> > > @@ -2061,6 +2066,10 @@ void qemu_ram_free(RAMBlock *block)
> > >          ram_block_notify_remove(block->host, block->max_length);
> > >      }
> > >  
> > > +    if (block->flags & RAM_NONPERSISTENT) {
> > > +        ram_block_discard_range(block, 0, block->max_length);
> > > +    }
> > > +
> > >      qemu_mutex_lock_ramlist();
> > >      QLIST_REMOVE_RCU(block, next);
> > >      ram_list.mru_block = NULL;
> > > @@ -3537,7 +3546,13 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
> > >              /* Note: We need the madvise MADV_DONTNEED behaviour of definitely
> > >               * freeing the page.
> > >               */
> > > -            ret = madvise(host_startaddr, length, MADV_DONTNEED);
> > > +            if (rb->flags & RAM_NONPERSISTENT) {
> > > +                ret = madvise(host_startaddr, length, MADV_REMOVE);
> > > +            }
> > > +            /* Fallback to MADV_DONTNEED if MADV_REMOVE fails */
> > > +            if (ret || !(rb->flags & RAM_NONPERSISTENT)) {
> > > +                ret = madvise(host_startaddr, length, MADV_DONTNEED);
> > > +            }
> > >  #endif
> > >          } else {
> > >              /* Huge page case  - unfortunately it can't do DONTNEED, but
> > > -- 
> > > 2.11.0.259.g40922b1
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
> 
> -- 
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
