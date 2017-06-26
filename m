Received: from eggs.gnu.org ([2001:4830:134:3::10]:33970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPZ82-0001ac-Jj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPZ7z-000645-C9
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dPZ7z-00063p-2t
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:52:51 -0400
Date: Mon, 26 Jun 2017 19:52:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170626185242.GD2136@work-vm>
References: <1498466120-5836-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170626083552eucas1p2db6a8bd9188a95d72aad188d6b633dd9@eucas1p2.samsung.com>
	<1498466120-5836-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498466120-5836-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] migration: add bitmap for received
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
>  include/exec/ram_addr.h  | 10 ++++++++
>  migration/migration.c    |  1 +
>  migration/postcopy-ram.c | 20 ++++++++++++----
>  migration/ram.c          | 59 +++++++++++++++++++++++++++++++++++++++++++++---
>  migration/ram.h          |  6 +++++
>  5 files changed, 88 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 140efa8..4170656 100644
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
> @@ -60,6 +62,14 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
>      return (char *)block->host + offset;
>  }
>  
> +static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
> +                                                            RAMBlock *rb)
> +{
> +    uint64_t host_addr_offset =
> +            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
> +    return host_addr_offset >> TARGET_PAGE_BITS;
> +}
> +
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
> index 293db97..372c691 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -562,22 +562,31 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>  }
>  
>  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> -        void *from_addr, uint64_t pagesize)
> +                               void *from_addr, uint64_t pagesize, RAMBlock *rb)
>  {
> +    int ret;
>      if (from_addr) {
>          struct uffdio_copy copy_struct;
>          copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
>          copy_struct.src = (uint64_t)(uintptr_t)from_addr;
>          copy_struct.len = pagesize;
>          copy_struct.mode = 0;
> -        return ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> +        ret = ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
>      } else {
>          struct uffdio_zeropage zero_struct;
>          zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
>          zero_struct.range.len = pagesize;
>          zero_struct.mode = 0;
> -        return ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> +        ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> +    }
> +    /* received page isn't feature of blocktime calculation,
> +     * it's more general entity, so keep it here,
> +     * but gup betwean two following operation could be high,
> +     * and in this case blocktime for such small interval will be lost */
> +    if (!ret) {
> +        ramblock_recv_bitmap_set(host_addr, rb);
>      }
> +    return ret;
>  }
>  
>  /*
> @@ -594,7 +603,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>       * which would be slightly cheaper, but we'd have to be careful
>       * of the order of updating our page state.
>       */
> -    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize)) {
> +    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) {
>          int e = errno;
>          error_report("%s: %s copy host: %p from: %p (size: %zd)",
>                       __func__, strerror(e), host, from, pagesize);
> @@ -616,7 +625,8 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>      trace_postcopy_place_page_zero(host);
>  
>      if (qemu_ram_pagesize(rb) == getpagesize()) {
> -        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpagesize())) {
> +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpagesize(),
> +                                rb)) {
>              int e = errno;
>              error_report("%s: %s zero host: %p",
>                           __func__, strerror(e), host);
> diff --git a/migration/ram.c b/migration/ram.c
> index f50479d..37299ed 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -151,6 +151,34 @@ out:
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
> @@ -1773,6 +1801,18 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>      return ret;
>  }
>  
> +static void ramblock_recv_bitmap_clear_range(uint64_t start, size_t length,
> +                                             RAMBlock *rb)
> +{
> +    int i, range_count;
> +    long nr_bit = start >> TARGET_PAGE_BITS;
> +    range_count = length >> TARGET_PAGE_BITS;
> +    for (i = 0; i < range_count; i++) {
> +        clear_bit(nr_bit, rb->receivedmap);
> +        nr_bit += 1;
> +    }

Can you just use the bitmap_clear(map,start,nr) function in bitmap.h for
that loop?

The rest looks OK (although I'd bet we probably need something special
for RDMA, but that's normal for RDMA).

Dave

> +}
> +
>  /**
>   * ram_discard_range: discard dirtied pages at the beginning of postcopy
>   *
> @@ -1797,6 +1837,7 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
>          goto err;
>      }
>  
> +    ramblock_recv_bitmap_clear_range(start, length, rb);
>      ret = ram_block_discard_range(rb, start, length);
>  
>  err:
> @@ -2324,8 +2365,14 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
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
> @@ -2513,6 +2560,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
>          uint8_t ch;
> +        RAMBlock *rb = NULL;
>  
>          addr = qemu_get_be64(f);
>          flags = addr & ~TARGET_PAGE_MASK;
> @@ -2520,15 +2568,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
> @@ -2582,10 +2630,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
> @@ -2596,10 +2646,13 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
