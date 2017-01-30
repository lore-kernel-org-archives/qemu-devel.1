Received: from eggs.gnu.org ([2001:4830:134:3::10]:38549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYHTt-0002wm-Bz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYHTp-00050n-UK
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:19:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYHTp-00050T-Ko
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:19:09 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7EB3C0567B3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 19:19:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170130184956.GG2450@work-vm> (David Alan Gilbert's message of
	"Mon, 30 Jan 2017 18:49:57 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-6-dgilbert@redhat.com>
	<87mvef78fq.fsf@emacs.mitica> <20170130184956.GG2450@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 30 Jan 2017 20:19:06 +0100
Message-ID: <871svke4ph.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >
>> > Unfortunately madvise DONTNEED doesn't work on hugepagetlb
>> > so use fallocate(FALLOC_FL_PUNCH_HOLE)
>> > qemu_fd_getpagesize only sets the page based off a file
>> > if the file is from hugetlbfs.
>> >
>> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>> > +#if defined(CONFIG_FALLOCATE_PUNCH_HOLE)
>> > +#include <linux/falloc.h>
>> > +#endif

I hate this in generic code :-()





I think that the function will have to be called:

qemu_ram_punch_hole(RAMBblock *, length);

Put it all together at the beggining of the file?
What I don't want is that if someone arrives with a way to do this in
other OS, we need to put yet more ifdefs.  I preffer very much that it
just have to define a function with that semantics.  Agreed that this is
a mess, but I can't think of an easier way of doing it either :-()



>> > @@ -1874,15 +1878,27 @@ int ram_discard_range(MigrationIncomingState *mis,
>> >  
>> >      if ((start + length) <= rb->used_length) {
>> >          uint8_t *host_endaddr = host_startaddr + length;
>> > -        if ((uintptr_t)host_endaddr & (qemu_host_page_size - 1)) {
>> > +        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
>> >              error_report("ram_discard_range: Unaligned end address: %p",
>> >                           host_endaddr);
>> >              goto err;
>> >          }
>> > -        errno = ENOTSUP;
>> > +        errno = ENOTSUP; /* If we are missing MADVISE etc */
>> > +
>> > +        if (rb->page_size == qemu_host_page_size) {
>> >  #if defined(CONFIG_MADVISE)
>> > -        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
>> > +            ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
>> >  #endif
>> > +        } else {
>> > +            /* Huge page case  - unfortunately it can't do DONTNEED, but
>> > +             * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
>> > +             * huge page file.
>> > +             */
>> > +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>> > +            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>> > +                            start, length);
>> > +#endif
>> > +        }
>> >          if (ret) {
>> >              error_report("ram_discard_range: Failed to discard  range "
>> >                           "%s:%" PRIx64 " +%zx (%d)",
>> 
>> Can we move this to qemu-posix or similar?
>> qemu_punch_hole() or similar and just put all the magic there?
>
> I'm trying but it's tricky.
> The problem is that:
>    a) To be able to tell which you need you need the pagesize of the
>      area
>    b) Then you need the fd if it is a hugepage
>      (You can get (a) from (b) by a syscall we already do once)
>    c) If it's normal RAM you need the memory address but...
>    d) If it's a hugepage you need the offset in the file
>
>   which is a mess; so you either have to pass all those parameters,
> or end up passing a RAMBlock* which doesn't feel like it should
> make its way into any of the os-* files.
>
>   I could move it to exec.c that already has some ifdef on OSs;
> what do you think?
>
> Dave
>
>> For the rest, I am ok with it.
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
