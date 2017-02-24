Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chGAx-0005ch-FZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chGAv-0001fB-9G
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:44:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chGAv-0001ep-0c
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:44:45 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 231A6C04BD28
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 13:44:45 +0000 (UTC)
Date: Fri, 24 Feb 2017 13:44:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170224134440.GE8830@work-vm>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-6-dgilbert@redhat.com>
	<87o9xrk9o8.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9xrk9o8.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH v2 05/16] postcopy: enhance
 ram_block_discard_range for hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, aarcange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Unfortunately madvise DONTNEED doesn't work on hugepagetlb
> > so use fallocate(FALLOC_FL_PUNCH_HOLE)
> > qemu_fd_getpagesize only sets the page based off a file
> > if the file is from hugetlbfs.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> But ...
> 
> 
> > ---
> >  exec.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/exec.c b/exec.c
> > index e040cdf..c25f6b3 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -3324,9 +3324,20 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
> >  
> >          errno = ENOTSUP; /* If we are missing MADVISE etc */
> >  
> > +        if (rb->page_size == qemu_host_page_size) {
> >  #if defined(CONFIG_MADVISE)
> > -        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
> > +            ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
> >  #endif
> > +        } else {
> > +            /* Huge page case  - unfortunately it can't do DONTNEED, but
> > +             * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
> > +             * huge page file.
> > +             */
> > +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > +            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > +                            start, length);
> 
> 
> Why can't we use fallocate() when !CONFIG_MADVISE?
> 
> or even ...
> 
>          if (rb->page_size == qemu_host_page_size) {
> #if defined(CONFIG_MADVISE)
>             ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
> #endif
>           }
> 
>           if (ret == -1) {
>               /* Huge page case  - unfortunately it can't do DONTNEED, but
>                * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
>                * huge page file.
>                */
> #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                             start, length);
> #endif
>           }

The fallocate only works where we have an fd, e.g. in the hugepage case;
the madvise only works where we have anonymous memory.  So if we don't have
madvise, we can't use fallocate for normal anonymous memory.

Actually, it's much more complicated than that - I've got another patch
that adds support for postcopy with memory that's backed by tmpfs with shared=true
and that also uses fallocate;  I'm trying to decide if it also needs
the madvise.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
