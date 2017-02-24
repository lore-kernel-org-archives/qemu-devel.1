Received: from eggs.gnu.org ([2001:4830:134:3::10]:41500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chGjk-00063h-Ms
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chGjh-0001Y8-HU
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1chGjh-0001Xb-BP
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:20:41 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A3C54E4C5
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 14:20:41 +0000 (UTC)
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-6-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a31280f1-3dd1-b6dc-add0-36ab27f9be1e@redhat.com>
Date: Fri, 24 Feb 2017 15:20:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170206173306.20603-6-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

On 06/02/2017 18:32, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Unfortunately madvise DONTNEED doesn't work on hugepagetlb
> so use fallocate(FALLOC_FL_PUNCH_HOLE)
> qemu_fd_getpagesize only sets the page based off a file
> if the file is from hugetlbfs.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index e040cdf..c25f6b3 100644
> --- a/exec.c
> +++ b/exec.c

You should move here the "#include" from PATCH 04/16

+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+#include <fcntl.h>
+#include <linux/falloc.h>
+#endif

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
> +#endif
> +        }
>          if (ret) {
>              ret = -errno;
>              error_report("ram_block_discard_range: Failed to discard range "
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
