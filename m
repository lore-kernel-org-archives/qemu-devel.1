Received: from eggs.gnu.org ([2001:4830:134:3::10]:38830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO10s-000086-5F
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dO10o-0004t5-W2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:15:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dO10o-0004sY-NW
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4D37142868
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:15:01 +0000 (UTC)
Date: Thu, 22 Jun 2017 13:14:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170622121457.GC2624@work-vm>
References: <20170614203000.19984-1-ehabkost@redhat.com>
	<20170614203000.19984-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614203000.19984-4-ehabkost@redhat.com>
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> The new flag will make qemu_ram_free() discard the contents of the
> block.  It will be used to let QEMU be configured to avoid flushing file
> contents to disk when exiting.  As MADV_REMOVE is not always supported,
> the new code will try MADV_NOTNEEDED in case MADV_REMOVE fails.

I'd like to understand what semantics you're trying to achieve and thus
why you prefer REMOVE to DONTNEED.   If you're trying to avoid changes
being written back then doesn't a DONTNEED get rid of any changes that
have yet to be written?  Or are there changes that have already been
queued that REMOVE will kill off?

If you're just trying to save-time in writeback, it's interesting to
note my requirement is that by the time I exit this function the
process of throwing away the memory contents must be complete;
I think your requirements are a lot lazier as to when it happens.

> The new flag will also indicate that ram_block_discard_range() can use
> MADV_REMOVE when discarding memory pages.  I have considered calling
> MADV_REMOVE unconditionally (as destroying the RAM contents seems to be
> OK every time ram_block_discard_range() is called), but for safety I
> decided to restrict the new code to blocks having RAM_NONPERSISTENT set.

The manpage on MADV_REMOVE is confusing; it says it doesn't work on Huge
TLB pages, but says it does work on anything that can do
FALLOC_FL_PUNCH_HOLE - which as far as I can tell hugetlbfs does.

I've got some code in my shared-postcopy world that has this function do
the following which is kind of similar:

        /* The logic here is messy;
         *    madvise DONTNEED fails for hugepages
         *    fallocate works on hugepages and shmem
         */
        need_madvise = (rb->page_size == qemu_host_page_size) &&
                       (rb->fd == -1 || !(rb->flags & RAM_SHARED));
        need_fallocate = rb->fd != -1;
        if (ret == -1 && need_fallocate) {
#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                            start, length);
#endif
        }
        if (need_madvise && (!need_fallocate || (ret == 0))) {
#if defined(CONFIG_MADVISE)
            ret =  madvise(host_startaddr, length, MADV_DONTNEED);
            fprintf(stderr, "%s: Did madvise for %p got %d\n", __func__, host_startaddr, ret);
#endif
        }

Dave

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  exec.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index 585d6ed6d7..a6e9ed4ece 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -102,6 +102,11 @@ static MemoryRegion io_mem_unassigned;
>   */
>  #define RAM_RESIZEABLE (1 << 2)
>  
> +/* RAMBlock contents are not persistent, and we can discard memory contents
> + * when freeing the memory block.
> + */
> +#define RAM_NONPERSISTENT (1 << 3)
> +
>  #endif
>  
>  #ifdef TARGET_PAGE_BITS_VARY
> @@ -2061,6 +2066,10 @@ void qemu_ram_free(RAMBlock *block)
>          ram_block_notify_remove(block->host, block->max_length);
>      }
>  
> +    if (block->flags & RAM_NONPERSISTENT) {
> +        ram_block_discard_range(block, 0, block->max_length);
> +    }
> +
>      qemu_mutex_lock_ramlist();
>      QLIST_REMOVE_RCU(block, next);
>      ram_list.mru_block = NULL;
> @@ -3537,7 +3546,13 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>              /* Note: We need the madvise MADV_DONTNEED behaviour of definitely
>               * freeing the page.
>               */
> -            ret = madvise(host_startaddr, length, MADV_DONTNEED);
> +            if (rb->flags & RAM_NONPERSISTENT) {
> +                ret = madvise(host_startaddr, length, MADV_REMOVE);
> +            }
> +            /* Fallback to MADV_DONTNEED if MADV_REMOVE fails */
> +            if (ret || !(rb->flags & RAM_NONPERSISTENT)) {
> +                ret = madvise(host_startaddr, length, MADV_DONTNEED);
> +            }
>  #endif
>          } else {
>              /* Huge page case  - unfortunately it can't do DONTNEED, but
> -- 
> 2.11.0.259.g40922b1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
