Received: from eggs.gnu.org ([2001:4830:134:3::10]:59904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chCvI-00035X-5t
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1chCvC-00033O-QE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:16:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1chCvC-00032T-KL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:16:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC6C07FB97
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:16:18 +0000 (UTC)
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-2-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <6015f873-411f-93bb-c45b-86a3a1c25aa3@redhat.com>
Date: Fri, 24 Feb 2017 11:16:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170206173306.20603-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/16] postcopy: Transmit ram size
 summary word
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
> Replace the host page-size in the 'advise' command by a pagesize
> summary bitmap; if the VM is just using normal RAM then
> this will be exactly the same as before, however if they're using
> huge pages they'll be different, and thus:
>    a) Migration from/to old qemu's that don't understand huge pages
>       will fail early.
>    b) Migrations with different size RAMBlocks will also fail early.
> 
> This catches it very early; earlier than the detailed per-block
> check in the next patch.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/migration/migration.h |  1 +
>  migration/ram.c               | 17 +++++++++++++++++
>  migration/savevm.c            | 32 +++++++++++++++++++++-----------
>  3 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index af9135f..96c9d6e 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -366,6 +366,7 @@ void global_state_store_running(void);
>  void flush_page_queue(MigrationState *ms);
>  int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>                           ram_addr_t start, ram_addr_t len);
> +uint64_t ram_pagesize_summary(void);
>  
>  PostcopyState postcopy_state_get(void);
>  /* Set the state and return the old state */
> diff --git a/migration/ram.c b/migration/ram.c
> index ef8fadf..b405e4a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -600,6 +600,23 @@ static void migration_bitmap_sync_init(void)
>      iterations_prev = 0;
>  }
>  
> +/* Returns a summary bitmap of the page sizes of all RAMBlocks;
> + * for VMs with just normal pages this is equivalent to the
> + * host page size.  If it's got some huge pages then it's the OR
> + * of all the different page sizes.
> + */
> +uint64_t ram_pagesize_summary(void)
> +{
> +    RAMBlock *block;
> +    uint64_t summary = 0;
> +
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        summary |= block->page_size;

It should be cleaner to use "qemu_ram_pagesize(block)".

It's only cosmetic, so:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
