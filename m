Received: from eggs.gnu.org ([2001:4830:134:3::10]:54483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqyaz-0007W8-RA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqyav-0003Lz-Hh
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:04:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqyav-0003Li-B3
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:04:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF6AD402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 10:04:06 +0000 (UTC)
Date: Wed, 28 Feb 2018 18:03:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228100356.GE27381@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-18-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-18-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 17/29] vhost+postcopy: Send requests to
 source for shared pages
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

On Fri, Feb 16, 2018 at 01:16:13PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Send requests back to the source for shared page requests.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.h    |  2 ++
>  migration/postcopy-ram.c | 31 ++++++++++++++++++++++++++++---
>  migration/postcopy-ram.h |  3 +++
>  migration/trace-events   |  2 ++
>  4 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index d158e62cf2..457bf37ec2 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -46,6 +46,8 @@ struct MigrationIncomingState {
>      int       userfault_quit_fd;
>      QEMUFile *to_src_file;
>      QemuMutex rp_mutex;    /* We send replies from multiple threads */
> +    /* RAMBlock of last request sent to source */
> +    RAMBlock *last_rb;
>      void     *postcopy_tmp_page;
>      void     *postcopy_tmp_zero_page;
>      /* PostCopyFD's for external userfaultfds & handlers of shared memory */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index d118b78bf5..277ff749a0 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -534,6 +534,31 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
>      return 0;
>  }
>  
> +/*
> + * Callback from shared fault handlers to ask for a page,
> + * the page must be specified by a RAMBlock and an offset in that rb
> + */
> +int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> +                                 uint64_t client_addr, uint64_t rb_offset)
> +{
> +    size_t pagesize = qemu_ram_pagesize(rb);
> +    uint64_t aligned_rbo = rb_offset & ~(pagesize - 1);
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(rb),
> +                                       rb_offset);
> +    /* TODO: Check bitmap to see if we already have the page */
> +    if (rb != mis->last_rb) {
> +        mis->last_rb = rb;
> +        migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
> +                                  aligned_rbo, pagesize);
> +    } else {
> +        /* Save some space */
> +        migrate_send_rp_req_pages(mis, NULL, aligned_rbo, pagesize);
> +    }
> +    return 0;
> +}
> +

So IIUC this can only be called within the page fault thread or there
can be race.  Is there a way to guarantee this?  Or do we need a
comment for that?

>  /*
>   * Handle faults detected by the USERFAULT markings
>   */
> @@ -544,9 +569,9 @@ static void *postcopy_ram_fault_thread(void *opaque)
>      int ret;
>      size_t index;
>      RAMBlock *rb = NULL;
> -    RAMBlock *last_rb = NULL; /* last RAMBlock we sent part of */
>  
>      trace_postcopy_ram_fault_thread_entry();
> +    mis->last_rb = NULL; /* last RAMBlock we sent part of */
>      qemu_sem_post(&mis->fault_thread_sem);
>  
>      struct pollfd *pfd;
> @@ -634,8 +659,8 @@ static void *postcopy_ram_fault_thread(void *opaque)
>               * Send the request to the source - we want to request one
>               * of our host page sizes (which is >= TPS)
>               */
> -            if (rb != last_rb) {
> -                last_rb = rb;
> +            if (rb != mis->last_rb) {
> +                mis->last_rb = rb;
>                  migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
>                                           rb_offset, qemu_ram_pagesize(rb));
>              } else {
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index dbc2ee1f2b..4c63f20df4 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -162,5 +162,8 @@ struct PostCopyFD {
>   */
>  void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
>  void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
> +/* Callback from shared fault handlers to ask for a page */
> +int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> +                                 uint64_t client_addr, uint64_t offset);
>  
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index 1e617ad7a6..7c910b5479 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -198,6 +198,8 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
>  postcopy_ram_incoming_cleanup_entry(void) ""
>  postcopy_ram_incoming_cleanup_exit(void) ""
>  postcopy_ram_incoming_cleanup_join(void) ""
> +postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset 0x%"PRIx64
> +
>  save_xbzrle_page_skipping(void) ""
>  save_xbzrle_page_overflow(void) ""
>  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> -- 
> 2.14.3
> 

-- 
Peter Xu
