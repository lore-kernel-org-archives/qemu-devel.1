Received: from eggs.gnu.org ([2001:4830:134:3::10]:40437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb08d-00071q-88
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb08Y-0005aB-1T
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:01:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fb08X-0005W4-SM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:01:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C0A4401C876
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 09:01:12 +0000 (UTC)
Date: Thu, 5 Jul 2018 10:01:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180705090109.GB2538@work-vm>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705031755.3254-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/9] migration: simplify check to
 use qemu file buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Firstly, renaming the old matching_page_sizes variable to
> matching_target_page_size, which suites more to what it did (it only
> checks against target page size rather than multiple page sizes).
> Meanwhile, simplify the check logic a bit, and enhance the comments.
> Should have no functional change.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 23cea47090..fbeb23f750 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3580,7 +3580,7 @@ static int ram_load_postcopy(QEMUFile *f)
>  {
>      int flags = 0, ret = 0;
>      bool place_needed = false;
> -    bool matching_page_sizes = false;
> +    bool matching_target_page_size = false;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      /* Temporary page that is later 'placed' */
>      void *postcopy_host_page = postcopy_get_tmp_page(mis);
> @@ -3620,7 +3620,7 @@ static int ram_load_postcopy(QEMUFile *f)
>                  ret = -EINVAL;
>                  break;
>              }
> -            matching_page_sizes = block->page_size == TARGET_PAGE_SIZE;
> +            matching_target_page_size = block->page_size == TARGET_PAGE_SIZE;

That's OK, although 'matches_target_page_size' would be better wording.
('matching_target_page_size' implies we know something about the sources
target page size)

>              /*
>               * Postcopy requires that we place whole host pages atomically;
>               * these may be huge pages for RAMBlocks that are backed by
> @@ -3668,12 +3668,17 @@ static int ram_load_postcopy(QEMUFile *f)
>  
>          case RAM_SAVE_FLAG_PAGE:
>              all_zero = false;
> -            if (!place_needed || !matching_page_sizes) {
> +            if (!matching_target_page_size) {
> +                /* For huge pages, we always use temporary buffer */
>                  qemu_get_buffer(f, page_buffer, TARGET_PAGE_SIZE);
>              } else {
> -                /* Avoids the qemu_file copy during postcopy, which is
> -                 * going to do a copy later; can only do it when we
> -                 * do this read in one go (matching page sizes)
> +                /*
> +                 * For small pages that matches target page size, we
> +                 * avoid the qemu_file copy.  Instead we directly use
> +                 * the buffer of QEMUFile to place the page.  Note: we
> +                 * cannot do any QEMUFile operation before using that
> +                 * buffer to make sure the buffer is valid when
> +                 * placing the page.
>                   */
>                  qemu_get_buffer_in_place(f, (uint8_t **)&place_source,
>                                           TARGET_PAGE_SIZE);

But, yes I think that's right; since this is in ram_load_postcopy
the only time we have !place_needed is in the not-last subpage of a 
hugepage (or host page > target_page), so that's already covered
by the !matching_page_sizes check.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
