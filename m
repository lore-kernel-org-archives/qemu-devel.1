Received: from eggs.gnu.org ([2001:4830:134:3::10]:42093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chIOj-0004U9-EF
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chIOf-0003oy-CX
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:07:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1chIOf-0003os-6W
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:07:05 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BFF181235
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 16:07:05 +0000 (UTC)
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-14-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <fea3dbcc-679c-797a-b844-97c32cce147d@redhat.com>
Date: Fri, 24 Feb 2017 17:07:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170206173306.20603-14-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/16] postcopy: Allow hugepages
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

On 06/02/2017 18:33, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Allow huge pages in postcopy.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/postcopy-ram.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 03cbd6e..6b30b43 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -85,24 +85,6 @@ static bool ufd_version_check(int ufd)
>  }
>  
>  /*
> - * Check for things that postcopy won't support; returns 0 if the block
> - * is fine.
> - */
> -static int check_range(const char *block_name, void *host_addr,
> -                      ram_addr_t offset, ram_addr_t length, void *opaque)
> -{
> -    RAMBlock *rb = qemu_ram_block_by_name(block_name);
> -
> -    if (qemu_ram_pagesize(rb) > getpagesize()) {
> -        error_report("Postcopy doesn't support large page sizes yet (%s)",
> -                     block_name);
> -        return -E2BIG;
> -    }
> -
> -    return 0;
> -}
> -
> -/*
>   * Note: This has the side effect of munlock'ing all of RAM, that's
>   * normally fine since if the postcopy succeeds it gets turned back on at the
>   * end.
> @@ -122,12 +104,6 @@ bool postcopy_ram_supported_by_host(void)
>          goto out;
>      }
>  
> -    /* Check for anything about the RAMBlocks we don't support */
> -    if (qemu_ram_foreach_block(check_range, NULL)) {
> -        /* check_range will have printed its own error */
> -        goto out;
> -    }
> -
>      ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
>      if (ufd == -1) {
>          error_report("%s: userfaultfd not available: %s", __func__,
> @@ -139,6 +115,7 @@ bool postcopy_ram_supported_by_host(void)
>      if (!ufd_version_check(ufd)) {
>          goto out;
>      }
> +    /* TODO: Only allow huge pages if the kernel supports it */
>  
>      /*
>       * userfault and mlock don't go together; we'll put it back later if
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
