Received: from eggs.gnu.org ([2001:4830:134:3::10]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYH1j-00065a-5r
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYH1e-0003iZ-3e
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:50:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cYH1d-0003iO-RN
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:50:02 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5EFB64D27
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 18:50:01 +0000 (UTC)
Date: Mon, 30 Jan 2017 18:49:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170130184956.GG2450@work-vm>
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-6-dgilbert@redhat.com>
	<87mvef78fq.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mvef78fq.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH 05/15] postcopy: enhance ram_discard_range
 for hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

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
> > ---
> >  migration/ram.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index fe32836..7afabcd 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -45,6 +45,10 @@
> >  #include "qemu/rcu_queue.h"
> >  #include "migration/colo.h"
> >  
> > +#if defined(CONFIG_FALLOCATE_PUNCH_HOLE)
> > +#include <linux/falloc.h>
> > +#endif
> > +
> >  #ifdef DEBUG_MIGRATION_RAM
> >  #define DPRINTF(fmt, ...) \
> >      do { fprintf(stdout, "migration_ram: " fmt, ## __VA_ARGS__); } while (0)
> > @@ -1866,7 +1870,7 @@ int ram_discard_range(MigrationIncomingState *mis,
> >  
> >      uint8_t *host_startaddr = rb->host + start;
> >  
> > -    if ((uintptr_t)host_startaddr & (qemu_host_page_size - 1)) {
> > +    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
> >          error_report("ram_discard_range: Unaligned start address: %p",
> >                       host_startaddr);
> >          goto err;
> > @@ -1874,15 +1878,27 @@ int ram_discard_range(MigrationIncomingState *mis,
> >  
> >      if ((start + length) <= rb->used_length) {
> >          uint8_t *host_endaddr = host_startaddr + length;
> > -        if ((uintptr_t)host_endaddr & (qemu_host_page_size - 1)) {
> > +        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
> >              error_report("ram_discard_range: Unaligned end address: %p",
> >                           host_endaddr);
> >              goto err;
> >          }
> > -        errno = ENOTSUP;
> > +        errno = ENOTSUP; /* If we are missing MADVISE etc */
> > +
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
> > +#endif
> > +        }
> >          if (ret) {
> >              error_report("ram_discard_range: Failed to discard  range "
> >                           "%s:%" PRIx64 " +%zx (%d)",
> 
> Can we move this to qemu-posix or similar?
> qemu_punch_hole() or similar and just put all the magic there?

I'm trying but it's tricky.
The problem is that:
   a) To be able to tell which you need you need the pagesize of the
     area
   b) Then you need the fd if it is a hugepage
     (You can get (a) from (b) by a syscall we already do once)
   c) If it's normal RAM you need the memory address but...
   d) If it's a hugepage you need the offset in the file

  which is a mess; so you either have to pass all those parameters,
or end up passing a RAMBlock* which doesn't feel like it should
make its way into any of the os-* files.

  I could move it to exec.c that already has some ifdef on OSs;
what do you think?

Dave

> For the rest, I am ok with it.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
