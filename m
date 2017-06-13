Received: from eggs.gnu.org ([2001:4830:134:3::10]:53650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKkD4-0005Vq-OQ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKkD1-0001u6-Je
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKkD1-0001tV-AY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:42:07 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497346593-8791-3-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Tue, 13 Jun 2017 12:36:33 +0300")
References: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170613093801eucas1p1e2b34c1a72b7150a28007d5b187da82e@eucas1p1.samsung.com>
	<1497346593-8791-3-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Tue, 13 Jun 2017 13:42:02 +0200
Message-ID: <87tw3kjer9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:

Hi

I think that it would make things clearer if we do a s/copied/received/
As what we are tracking here are the pages that have already been
received.


> This patch adds ability to track down already copied
> pages, it's necessary for calculation vCPU block time in
> postcopy migration feature, maybe for restore after
> postcopy migration failure.
> Also it's necessary to solve shared memory issue in
> postcopy livemigration. Information about copied pages
> will be transferred to the software virtual bridge
> (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> already copied pages. fallocate syscall is required for
> remmaped shared memory, due to remmaping itself blocks
> ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> error (struct page is exists after remmap).
>
> Bitmap is placed into RAMBlock as another postcopy/precopy
> related bitmaps.

Why are we not using the TARGET_PAGE_SIZE as units of the bitmap?


> copied bitmap is not releasing due to ramblocks is not releasing
> too.

RAMBlocks are used for other reasons, not only migration.  This bitmaps
can be released on the ram_load_cleanup() function.  See my patches on
list about how to use it.

> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/exec/ram_addr.h       |  3 +++
>  include/migration/migration.h |  3 +++
>  migration/postcopy-ram.c      |  7 ++++++
>  migration/ram.c               | 54 ++++++++++++++++++++++++++++++++++++++++++-
>  migration/ram.h               |  5 ++++
>  migration/savevm.c            |  1 +
>  6 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 140efa8..56cdf16 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -47,6 +47,9 @@ struct RAMBlock {
>       * of the postcopy phase
>       */
>      unsigned long *unsentmap;
> +    /* bitmap of already copied pages in postcopy */
       /* bitmap of already received pages */

Why do we want to use it only for postcopy?  And not in the general case?

> +    unsigned long *copiedmap;

       unsigned long *receivedmap;

> +    size_t nr_copiedmap;

I think we don't need it, just use on its only use:

   rb->max_length >> qemu_page_target_bits()?

>  };
>  
>  static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 79b5484..8005c11 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -226,4 +226,7 @@ void savevm_skip_configuration(void);
>  int global_state_store(void);
>  void global_state_store_running(void);
>  
> +size_t get_copiedmap_size(RAMBlock *rb);
> +void movecopiedmap(void *dst, RAMBlock *rb, size_t len);
> +
>  #endif

After my last PULL Request, this needs to be into:

   include/migration/misc.h

And we can rename the functions to:

size_t received_map_pages(RAMBlock *rb);
void received_map_copy(void *dst, RAMBlock *rb, size_t len);


> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index f6244ee..e13b22e 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -576,6 +576,13 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>      copy_struct.len = pagesize;
>      copy_struct.mode = 0;
>  
> +
> +    /* copied page isn't feature of blocktime calculation,
> +     * it's more general entity, so keep it here,
> +     * but gup betwean two following operation could be high,
> +     * and in this case blocktime for such small interval will be lost */
> +    set_copiedmap_by_addr(host, rb);
> 
>      /* copy also acks to the kernel waking the stalled thread up
>       * TODO: We can inhibit that ack and only do it if it was requested
>       * which would be slightly cheaper, but we'd have to be careful
> diff --git a/migration/ram.c b/migration/ram.c
> index 4ed7c2c..8466e59 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -149,6 +149,58 @@ out:
>      return ret;
>  }
>  
> +void init_copiedmap(void)

received_map_init(void);

> +{
> +    RAMBlock *rb;
> +    RAMBLOCK_FOREACH(rb) {
> +        unsigned long pages;
> +        pages = rb->max_length >> find_first_bit(&rb->page_size,
> +                8 * sizeof(rb->page_size));
> +        /* need for destination, bitmap_new calls
> +         * g_try_malloc0 and this function
> +         * Attempts to allocate @n_bytes, initialized to 0'sh */
> +        rb->copiedmap = bitmap_new(pages);
> +        rb->nr_copiedmap = pages;
> +    }
> +}
> +
> +static unsigned long int get_copied_bit_offset(void *host_addr,
> RAMBlock *rb)


received_map_get_offset(...)

> +{
> +    uint64_t host_addr_offset = (uint64_t)(uintptr_t)(host_addr
> +                                                      
> +    int page_shift = find_first_bit(&rb->page_size, 8 * sizeof(rb->page_size));

with my suggesiton this becomes:

uint64_t offset = (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
return offset >> qemu_target_page_bits();

I wonder that we don't have a function to pass an absolute address to an
relative page :p


> +int test_copiedmap_by_addr(void *host_addr, RAMBlock *rb)

  int receive_map_test_addr(...) ?
  
> +{
> +    return test_bit(get_copied_bit_offset(host_addr, rb), rb->copiedmap);
> +}
> +
> +void set_copiedmap_by_addr(void *host_addr, RAMBlock *rb)

void receive_map_set_addr()


> @@ -1852,11 +1904,11 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
>  {
>      int ret = -1;
>  
> -    trace_ram_discard_range(rbname, start, length);
>  
>      rcu_read_lock();
>      RAMBlock *rb = qemu_ram_block_by_name(rbname);
>  
> +    trace_ram_discard_range(rbname, start, length);

Why is that bit included in this patch?  I think this is independent of
the rest of the patch, no?

Thanks for the effort.

Later, Juan.
