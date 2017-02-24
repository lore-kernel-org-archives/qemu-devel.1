Received: from eggs.gnu.org ([2001:4830:134:3::10]:38471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chICH-00036B-BG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chICC-0007qG-BI
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:54:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1chICC-0007pc-38
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:54:12 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 097DC624B0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 15:54:12 +0000 (UTC)
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-11-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <004abfc6-21ea-6ffe-4cd5-be73c9ddc146@redhat.com>
Date: Fri, 24 Feb 2017 16:54:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170206173306.20603-11-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/16] postcopy: Load huge pages in one
 go
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
> The existing postcopy RAM load loop already ensures that it
> glues together whole host-pages from the target page size chunks sent
> over the wire.  Modify the definition of host page that it uses
> to be the RAM block page size and thus be huge pages where appropriate.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index ff448ef..88d9444 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2342,7 +2342,7 @@ static int ram_load_postcopy(QEMUFile *f)
>  {
>      int flags = 0, ret = 0;
>      bool place_needed = false;
> -    bool matching_page_sizes = qemu_host_page_size == TARGET_PAGE_SIZE;
> +    bool matching_page_sizes = false;

The false value is not obvious.
Is gcc smart enough to detect you use "matching_page_sizes" (in the
"switch ()") only when it has been really initialized (in the "if ()")?

>      MigrationIncomingState *mis = migration_incoming_get_current();
>      /* Temporary page that is later 'placed' */
>      void *postcopy_host_page = postcopy_get_tmp_page(mis);
> @@ -2372,8 +2372,11 @@ static int ram_load_postcopy(QEMUFile *f)
>                  ret = -EINVAL;
>                  break;
>              }
> +            matching_page_sizes = block->page_size == TARGET_PAGE_SIZE;
>              /*
> -             * Postcopy requires that we place whole host pages atomically.
> +             * Postcopy requires that we place whole host pages atomically;
> +             * these may be huge pages for RAMBlocks that are backed by
> +             * hugetlbfs.
>               * To make it atomic, the data is read into a temporary page
>               * that's moved into place later.
>               * The migration protocol uses,  possibly smaller, target-pages
> @@ -2381,9 +2384,9 @@ static int ram_load_postcopy(QEMUFile *f)
>               * of a host page in order.
>               */
>              page_buffer = postcopy_host_page +
> -                          ((uintptr_t)host & ~qemu_host_page_mask);
> +                          ((uintptr_t)host & (block->page_size - 1));
>              /* If all TP are zero then we can optimise the place */
> -            if (!((uintptr_t)host & ~qemu_host_page_mask)) {
> +            if (!((uintptr_t)host & (block->page_size - 1))) {
>                  all_zero = true;
>              } else {
>                  /* not the 1st TP within the HP */
> @@ -2401,7 +2404,7 @@ static int ram_load_postcopy(QEMUFile *f)
>               * page
>               */
>              place_needed = (((uintptr_t)host + TARGET_PAGE_SIZE) &
> -                                     ~qemu_host_page_mask) == 0;
> +                                     (block->page_size - 1)) == 0;
>              place_source = postcopy_host_page;
>          }
>          last_host = host;
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
