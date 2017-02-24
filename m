Received: from eggs.gnu.org ([2001:4830:134:3::10]:55526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFnH-0003X6-RQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFnE-0000yd-Ks
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:20:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1chFnE-0000xs-Dt
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:20:16 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 972CC80462
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 13:20:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170206173306.20603-6-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 6 Feb 2017 17:32:55 +0000")
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-6-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Feb 2017 14:20:07 +0100
Message-ID: <87o9xrk9o8.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Unfortunately madvise DONTNEED doesn't work on hugepagetlb
> so use fallocate(FALLOC_FL_PUNCH_HOLE)
> qemu_fd_getpagesize only sets the page based off a file
> if the file is from hugetlbfs.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But ...


> ---
>  exec.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/exec.c b/exec.c
> index e040cdf..c25f6b3 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3324,9 +3324,20 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>  
>          errno = ENOTSUP; /* If we are missing MADVISE etc */
>  
> +        if (rb->page_size == qemu_host_page_size) {
>  #if defined(CONFIG_MADVISE)
> -        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
> +            ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
>  #endif
> +        } else {
> +            /* Huge page case  - unfortunately it can't do DONTNEED, but
> +             * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
> +             * huge page file.
> +             */
> +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> +            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +                            start, length);


Why can't we use fallocate() when !CONFIG_MADVISE?

or even ...

         if (rb->page_size == qemu_host_page_size) {
#if defined(CONFIG_MADVISE)
            ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
#endif
          }

          if (ret == -1) {
              /* Huge page case  - unfortunately it can't do DONTNEED, but
               * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
               * huge page file.
               */
#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
           ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                            start, length);
#endif
          }
