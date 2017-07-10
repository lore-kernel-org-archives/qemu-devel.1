Received: from eggs.gnu.org ([2001:4830:134:3::10]:55505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUVXZ-00062T-8c
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dUVXU-0007mt-Fr
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dUVXU-0007lW-74
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:03:36 -0400
Date: Mon, 10 Jul 2017 18:03:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170710100323.GA21344@pxdev.xzpeter.org>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170628190047.26159-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC 02/29] migrate: Update
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
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com

On Wed, Jun 28, 2017 at 08:00:20PM +0100, Dr. David Alan Gilbert (git) wrote:
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
>  exec.c       | 28 ++++++++++++++++------------
>  trace-events |  3 +++
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 69fc5c9b07..4e61226a16 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3557,6 +3557,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>      }
>  
>      if ((start + length) <= rb->used_length) {
> +        bool need_madvise, need_fallocate;
>          uint8_t *host_endaddr = host_startaddr + length;
>          if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
>              error_report("ram_block_discard_range: Unaligned end address: %p",
> @@ -3566,23 +3567,26 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
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
> -             */
> +        /* The logic here is messy;
> +         *    madvise DONTNEED fails for hugepages
> +         *    fallocate works on hugepages and shmem
> +         */
> +        need_madvise = (rb->page_size == qemu_host_page_size) &&
> +                       (rb->fd == -1 || !(rb->flags & RAM_SHARED));
> +        need_fallocate = rb->fd != -1;
> +        if (ret == -1 && need_fallocate) {

(ret will always be -1 when reach here?)

>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>              ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                              start, length);
>  #endif
>          }
> +        if (need_madvise && (!need_fallocate || (ret == 0))) {
> +#if defined(CONFIG_MADVISE)
> +            ret =  madvise(host_startaddr, length, MADV_DONTNEED);
> +#endif
> +        }
> +        trace_ram_block_discard_range(rb->idstr, host_startaddr,
> +                                      need_madvise, need_fallocate, ret);

How about make the check easier by:

  if (rb->page_size != qemu_host_page_size ||
      rb->flags & RAM_SHARED) {
      /* Either huge pages or shared memory will contain rb->fd */
      assert(rb->fd);
      fallocate(rb->fd, ...);
  } else {
      madvise();
  }

Thanks,

-- 
Peter Xu
