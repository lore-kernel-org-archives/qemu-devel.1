Received: from eggs.gnu.org ([2001:4830:134:3::10]:43081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chITb-000109-15
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chITW-0005f8-Uh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:12:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1chITW-0005es-Nq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:12:06 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EAA8C04B93B
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 16:12:06 +0000 (UTC)
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-16-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <9e7a02a9-5463-0de8-16d4-c5585d741e58@redhat.com>
Date: Fri, 24 Feb 2017 17:12:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170206173306.20603-16-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/16] postcopy: Check for
 userfault+hugepage feature
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
> We need extra Linux kernel support (~4.11) to support userfaults
> on hugetlbfs; check for them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/postcopy-ram.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 6b30b43..102fb61 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -81,6 +81,17 @@ static bool ufd_version_check(int ufd)
>          return false;
>      }
>  
> +    if (getpagesize() != ram_pagesize_summary()) {
> +        bool have_hp = false;
> +        /* We've got a huge page */
> +#ifdef UFFD_FEATURE_MISSING_HUGETLBFS
> +        have_hp = api_struct.features & UFFD_FEATURE_MISSING_HUGETLBFS;
> +#endif
> +        if (!have_hp) {
> +            error_report("Userfault on this host does not support huge pages");
> +            return false;
> +        }
> +    }
>      return true;
>  }
>  
> @@ -115,7 +126,6 @@ bool postcopy_ram_supported_by_host(void)
>      if (!ufd_version_check(ufd)) {
>          goto out;
>      }
> -    /* TODO: Only allow huge pages if the kernel supports it */
>  
>      /*
>       * userfault and mlock don't go together; we'll put it back later if
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
