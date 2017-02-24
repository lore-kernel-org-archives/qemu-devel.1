Received: from eggs.gnu.org ([2001:4830:134:3::10]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chJ4c-00057P-94
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chJ4Y-0005XP-7p
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:50:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chJ4X-0005Wr-Uq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:50:22 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EA4B80462
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 16:50:22 +0000 (UTC)
Date: Fri, 24 Feb 2017 16:50:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170224165016.GO8830@work-vm>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-5-dgilbert@redhat.com>
	<ca1995cc-e72b-7ac4-09c9-95dd73e35bcc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1995cc-e72b-7ac4-09c9-95dd73e35bcc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/16] exec: ram_block_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, aarcange@redhat.com

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 06/02/2017 18:32, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Create ram_block_discard_range in exec.c to replace
> > postcopy_ram_discard_range and most of ram_discard_range.
> > 
> > Those two routines are a bit of a weird combination, and
> > ram_discard_range is about to get more complex for hugepages.
> > It's OS dependent code (so shouldn't be in migration/ram.c) but
> > it needs quite a bit of the innards of RAMBlock so doesn't belong in
> > the os*.c.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  exec.c                    | 59 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/exec/cpu-common.h |  1 +
> >  2 files changed, 60 insertions(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index 8b9ed73..e040cdf 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -45,6 +45,12 @@
> >  #include "exec/address-spaces.h"
> >  #include "sysemu/xen-mapcache.h"
> >  #include "trace-root.h"
> > +
> > +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > +#include <fcntl.h>
> > +#include <linux/falloc.h>
> > +#endif
> > +
> >  #endif
> >  #include "exec/cpu-all.h"
> >  #include "qemu/rcu_queue.h"
> > @@ -3286,4 +3292,57 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
> >      rcu_read_unlock();
> >      return ret;
> >  }
> > +
> > +/*
> > + * Unmap pages of memory from start to start+length such that
> > + * they a) read as 0, b) Trigger whatever fault mechanism
> > + * the OS provides for postcopy.
> > + * The pages must be unmapped by the end of the function.
> > + * Returns: 0 on success, none-0 on failure
> > + *
> > + */
> > +int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
> > +{
> > +    int ret = -1;
> > +
> > +    rcu_read_lock();
> > +    uint8_t *host_startaddr = rb->host + start;
> > +
> > +    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
> > +        error_report("ram_block_discard_range: Unaligned start address: %p",
> > +                     host_startaddr);
> > +        goto err;
> > +    }
> > +
> > +    if ((start + length) <= rb->used_length) {
> > +        uint8_t *host_endaddr = host_startaddr + length;
> > +        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
> > +            error_report("ram_block_discard_range: Unaligned end address: %p",
> > +                         host_endaddr);
> > +            goto err;
> > +        }
> > +
> > +        errno = ENOTSUP; /* If we are missing MADVISE etc */
> > +
> > +#if defined(CONFIG_MADVISE)
> > +        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
> > +#endif
> > +        if (ret) {
> > +            ret = -errno;
> > +            error_report("ram_block_discard_range: Failed to discard range "
> > +                         "%s:%" PRIx64 " +%zx (%d)",
> > +                         rb->idstr, start, length, ret);
> > +        }
> > +    } else {
> > +        error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu64
> > +                     "/%zx/" RAM_ADDR_FMT")",
> > +                     rb->idstr, start, length, rb->used_length);
> > +    }
> > +
> > +err:
> > +    rcu_read_unlock();
> > +
> > +    return ret;
> > +}
> 
> I really looks like a copy'n'paste from ram_discard_range(). It could be
> clearer if you remove the code from ram_discard_range() and call this
> function instead.

Yes, flattened into the latter commit.

> I think you don't need the "#if defined(CONFIG_MADVISE)" as you use
> qemu_madvise() (or you should use madvise() directly if you want to
> avoid the posix_madvise()).

Yes, changed to CONFIG_MADVISE + madvise()

I need to avoid posix_madvise because it doesn't do the same thing.

> [perhaps qemu_madvise() should set errno to ENOTSUP instead of EINVAL]

The difficulty is with how it fiddles with it's QEMU_MADV_* macros,
when it finds one that doesn't exist it gets defined as -1 or the like
which then fails that way.

Dave

> 
> Laurent
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
