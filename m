Received: from eggs.gnu.org ([2001:4830:134:3::10]:47279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqvMe-0004Sy-Lr
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqvMZ-0007P3-Hv
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:37:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqvMZ-0007Om-CA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:37:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE579EAEA0
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 06:37:10 +0000 (UTC)
Date: Wed, 28 Feb 2018 14:37:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228063701.GT18962@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-2-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/29] migrate: Update
 ram_block_discard_range for shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Fri, Feb 16, 2018 at 01:15:57PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The choice of call to discard a block is getting more complicated
> for other cases.   We use fallocate PUNCH_HOLE in any file cases;
> it works for both hugepage and for tmpfs.
> We use the DONTNEED for non-hugepage cases either where they're
> anonymous or where they're private.
> 
> Care should be taken when trying other backing files.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c       | 60 ++++++++++++++++++++++++++++++++++++++++++++++--------------
>  trace-events |  3 ++-
>  2 files changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index e8d7b335b6..b1bb477776 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3702,6 +3702,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>      }
>  
>      if ((start + length) <= rb->used_length) {
> +        bool need_madvise, need_fallocate;
>          uint8_t *host_endaddr = host_startaddr + length;
>          if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
>              error_report("ram_block_discard_range: Unaligned end address: %p",
> @@ -3711,29 +3712,60 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>  
>          errno = ENOTSUP; /* If we are missing MADVISE etc */
>  
> -        if (rb->page_size == qemu_host_page_size) {
> -#if defined(CONFIG_MADVISE)
> -            /* Note: We need the madvise MADV_DONTNEED behaviour of definitely
> -             * freeing the page.
> -             */
> -            ret = madvise(host_startaddr, length, MADV_DONTNEED);
> -#endif
> -        } else {
> -            /* Huge page case  - unfortunately it can't do DONTNEED, but
> -             * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
> -             * huge page file.
> +        /* The logic here is messy;
> +         *    madvise DONTNEED fails for hugepages
> +         *    fallocate works on hugepages and shmem
> +         */
> +        need_madvise = (rb->page_size == qemu_host_page_size);
> +        need_fallocate = rb->fd != -1;
> +        if (need_fallocate) {
> +            /* For a file, this causes the area of the file to be zero'd
> +             * if read, and for hugetlbfs also causes it to be unmapped
> +             * so a userfault will trigger.
>               */
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>              ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                              start, length);
> +            if (ret) {
> +                ret = -errno;
> +                error_report("ram_block_discard_range: Failed to fallocate "
> +                             "%s:%" PRIx64 " +%zx (%d)",
> +                             rb->idstr, start, length, ret);
> +                goto err;
> +            }
> +#else
> +            ret = -ENOSYS;
> +            error_report("ram_block_discard_range: fallocate not available/file"
> +                         "%s:%" PRIx64 " +%zx (%d)",
> +                         rb->idstr, start, length, ret);
> +            goto err;
>  #endif
>          }
> -        if (ret) {
> -            ret = -errno;
> -            error_report("ram_block_discard_range: Failed to discard range "
> +        if (need_madvise) {
> +            /* For normal RAM this causes it to be unmapped,
> +             * for shared memory it causes the local mapping to disappear
> +             * and to fall back on the file contents (which we just
> +             * fallocate'd away).
> +             */
> +#if defined(CONFIG_MADVISE)
> +            ret =  madvise(host_startaddr, length, MADV_DONTNEED);
> +            if (ret) {
> +                ret = -errno;
> +                error_report("ram_block_discard_range: Failed to discard range "
> +                             "%s:%" PRIx64 " +%zx (%d)",
> +                             rb->idstr, start, length, ret);
> +                goto err;
> +            }
> +#else
> +            ret = -ENOSYS;
> +            error_report("ram_block_discard_range: MADVISE not available"
>                           "%s:%" PRIx64 " +%zx (%d)",
>                           rb->idstr, start, length, ret);
> +            goto err;
> +#endif
>          }
> +        trace_ram_block_discard_range(rb->idstr, host_startaddr,
> +                                      need_madvise, need_fallocate, ret);

Nit: worth to log the length too if it's named as "range"?

Either with/without:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
