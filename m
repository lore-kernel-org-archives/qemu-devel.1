Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dOLqc-0005ea-9q
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dOLqZ-0000rT-4F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dOLqY-0000r6-Qp
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:29:51 -0400
Date: Fri, 23 Jun 2017 11:29:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170623102941.GB2252@work-vm>
References: <1497640120-10729-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616190852eucas1p18bc3671b480012ede7cbd810b40a8263@eucas1p1.samsung.com>
	<1497640120-10729-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497640120-10729-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] migration: add bitmap for received
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> This patch adds ability to track down already received
> pages, it's necessary for calculation vCPU block time in
> postcopy migration feature, maybe for restore after
> postcopy migration failure.
> Also it's necessary to solve shared memory issue in
> postcopy livemigration. Information about received pages
> will be transferred to the software virtual bridge
> (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> already received pages. fallocate syscall is required for
> remmaped shared memory, due to remmaping itself blocks
> ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> error (struct page is exists after remmap).
> 
> Bitmap is placed into RAMBlock as another postcopy/precopy
> related bitmaps.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/exec/ram_addr.h  |  3 +++
>  migration/migration.c    |  1 +
>  migration/postcopy-ram.c | 12 ++++++---
>  migration/ram.c          | 66 +++++++++++++++++++++++++++++++++++++++++++++---
>  migration/ram.h          |  6 +++++
>  5 files changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 140efa8..67fbb39 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -47,6 +47,8 @@ struct RAMBlock {
>       * of the postcopy phase
>       */
>      unsigned long *unsentmap;
> +    /* bitmap of already received pages in postcopy */
> +    unsigned long *receivedmap;
>  };
>  
>  static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
> @@ -60,6 +62,7 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
>      return (char *)block->host + offset;
>  }
>  
> +unsigned long int ramblock_recv_bitmap_offset(void *host_addr, RAMBlock *rb);
>  long qemu_getrampagesize(void);
>  unsigned long last_ram_page(void);
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> diff --git a/migration/migration.c b/migration/migration.c
> index 71e38bc..53fbd41 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -143,6 +143,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
>          qemu_mutex_init(&mis_current.rp_mutex);
>          qemu_event_init(&mis_current.main_thread_load_event, false);
>          once = true;
> +        ramblock_recv_map_init();
>      }
>      return &mis_current;
>  }
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index d1af2c1..5d2b92d 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -562,8 +562,13 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>  }
>  
>  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> -        void *from_addr, uint64_t pagesize)
> +        void *from_addr, uint64_t pagesize, RAMBlock *rb)
>  {
> +    /* received page isn't feature of blocktime calculation,
> +     * it's more general entity, so keep it here,
> +     * but gup betwean two following operation could be high,
> +     * and in this case blocktime for such small interval will be lost */
> +    ramblock_recv_bitmap_set(host_addr, rb);

I have a fun problem here in my world with using the same bitmap for
shared memory with the vhost-user client;  for that a set bit means
that the data has already arrived and we need to do a UFFDIO_WAKE on
the client;  but that means we can't set the bit in this function until
the end after we've done the COPY/ZERO.

Dave

>      if (from_addr) {
>          struct uffdio_copy copy_struct;
>          copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
> @@ -594,7 +599,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>       * which would be slightly cheaper, but we'd have to be careful
>       * of the order of updating our page state.
>       */
> -    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize)) {
> +    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) {
>          int e = errno;
>          error_report("%s: %s copy host: %p from: %p (size: %zd)",
>                       __func__, strerror(e), host, from, pagesize);
> @@ -616,7 +621,8 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>      trace_postcopy_place_page_zero(host);
>  
>      if (qemu_ram_pagesize(rb) == getpagesize()) {
> -        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, 0, getpagesize())) {
> +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, 0, getpagesize(),
> +                                rb)) {
>              int e = errno;
>              error_report("%s: %s zero host: %p",
>                           __func__, strerror(e), host);
> diff --git a/migration/ram.c b/migration/ram.c
> index f50479d..fad4dbf 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -151,6 +151,41 @@ out:
>      return ret;
>  }
>  
> +void ramblock_recv_map_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        unsigned long pages;
> +        pages = rb->max_length >> TARGET_PAGE_BITS;
> +        assert(!rb->receivedmap);
> +        rb->receivedmap = bitmap_new(pages);
> +    }
> +}
> +
> +unsigned long int ramblock_recv_bitmap_offset(void *host_addr, RAMBlock *rb)
> +{
> +    uint64_t host_addr_offset = (uint64_t)(uintptr_t)(host_addr
> +                                                      - (void *)rb->host);
> +    return host_addr_offset >> TARGET_PAGE_BITS;
> +}
> +
> +int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb)
> +{
> +    return test_bit(ramblock_recv_bitmap_offset(host_addr, rb),
> +                    rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb)
> +{
> +    set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> +}
> +
> +void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb)
> +{
> +    clear_bit(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> +}
> +
>  /*
>   * An outstanding page request, on the source, having been received
>   * and queued
> @@ -1773,6 +1808,18 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>      return ret;
>  }
>  
> +static void ramblock_recv_bitmap_clear_range(uint64_t start, size_t length,
> +                                             RAMBlock *rb)
> +{
> +    int i, range_count;
> +    range_count = length >> TARGET_PAGE_BITS;
> +    for (i = 0; i < range_count; i++) {
> +        ramblock_recv_bitmap_clear((void *)((uint64_t)(intptr_t)rb->host +
> +                                            start), rb);
> +        start += TARGET_PAGE_SIZE;
> +    }
> +}
> +
>  /**
>   * ram_discard_range: discard dirtied pages at the beginning of postcopy
>   *
> @@ -1797,6 +1844,7 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
>          goto err;
>      }
>  
> +    ramblock_recv_bitmap_clear_range(start, length, rb);
>      ret = ram_block_discard_range(rb, start, length);
>  
>  err:
> @@ -2324,8 +2372,14 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
>  
>  static int ram_load_cleanup(void *opaque)
>  {
> +    RAMBlock *rb;
>      xbzrle_load_cleanup();
>      compress_threads_load_cleanup();
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        g_free(rb->receivedmap);
> +        rb->receivedmap = NULL;
> +    }
>      return 0;
>  }
>  
> @@ -2513,6 +2567,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
>          uint8_t ch;
> +        RAMBlock *rb;
>  
>          addr = qemu_get_be64(f);
>          flags = addr & ~TARGET_PAGE_MASK;
> @@ -2520,15 +2575,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> -            RAMBlock *block = ram_block_from_stream(f, flags);
> +            rb = ram_block_from_stream(f, flags);
>  
> -            host = host_from_ram_block_offset(block, addr);
> +            host = host_from_ram_block_offset(rb, addr);
>              if (!host) {
>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret = -EINVAL;
>                  break;
>              }
> -            trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
> +            trace_ram_load_loop(rb->idstr, (uint64_t)addr, flags, host);
>          }
>  
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> @@ -2582,10 +2637,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  
>          case RAM_SAVE_FLAG_ZERO:
>              ch = qemu_get_byte(f);
> +            ramblock_recv_bitmap_set(host, rb);
>              ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
>              break;
>  
>          case RAM_SAVE_FLAG_PAGE:
> +            ramblock_recv_bitmap_set(host, rb);
>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;
>  
> @@ -2596,10 +2653,13 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                  ret = -EINVAL;
>                  break;
>              }
> +
> +            ramblock_recv_bitmap_set(host, rb);
>              decompress_data_with_multi_threads(f, host, len);
>              break;
>  
>          case RAM_SAVE_FLAG_XBZRLE:
> +            ramblock_recv_bitmap_set(host, rb);
>              if (load_xbzrle(f, addr, host) < 0) {
>                  error_report("Failed to decompress XBZRLE page at "
>                               RAM_ADDR_FMT, addr);
> diff --git a/migration/ram.h b/migration/ram.h
> index c081fde..98d68df 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -52,4 +52,10 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>  int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>  
>  void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> +
> +void ramblock_recv_map_init(void);
> +int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb);
> +void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb);
> +void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb);
> +
>  #endif
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
