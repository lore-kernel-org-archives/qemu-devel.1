Received: from eggs.gnu.org ([2001:4830:134:3::10]:48637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNlCk-0003uu-7W
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNlCg-0006PU-5O
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:22:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNlCf-0006PO-Ta
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:22:14 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497640120-10729-4-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Fri, 16 Jun 2017 22:08:40 +0300")
References: <1497640120-10729-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616190852eucas1p18bc3671b480012ede7cbd810b40a8263@eucas1p1.samsung.com>
	<1497640120-10729-4-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 21:22:07 +0200
Message-ID: <87h8z9jgdc.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
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

Hi

A few commets.

Happy with all the changes that you did.

> @@ -60,6 +62,7 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
>     return (char *)block->host + offset;
> }
> 
> +unsigned long int ramblock_recv_bitmap_offset(void *host_addr, RAMBlock *rb);
>  long qemu_getrampagesize(void);
>  unsigned long last_ram_page(void);
> RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,

I think we shouldn't export it at all.  But if we do, we should export
it with the other functions.


> +unsigned long int ramblock_recv_bitmap_offset(void *host_addr, RAMBlock *rb)

I think this function can be made static, as nothing else should use it, no?

> +{
> +    uint64_t host_addr_offset = (uint64_t)(uintptr_t)(host_addr
> +                                                      - (void *)rb->host);

Intdentation is weird:

uint64_t host_addr_offset =
    (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);


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
> +    set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb),
> rb->receivedmap);

Line is too long?

> +static void ramblock_recv_bitmap_clear_range(uint64_t start, size_t length,
> +                                             RAMBlock *rb)
> +{
> +    int i, range_count;
> +    range_count = length >> TARGET_PAGE_BITS;
> +    for (i = 0; i < range_count; i++) {
> +        ramblock_recv_bitmap_clear((void *)((uint64_t)(intptr_t)rb->host +
> +                                            start), rb);
> +        start += TARGET_PAGE_SIZE;

bitmap_clear(dst, pos, nbits)		Clear specified bit area

Looks like the right operation here, no?

> +
> +void ramblock_recv_map_init(void);
> +int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb);
> +void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb);
> +void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb);
> +
>  #endif

Later, Juan.
