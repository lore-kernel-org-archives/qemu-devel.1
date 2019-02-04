Received: from eggs.gnu.org ([209.51.188.92]:50546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gqiYT-0004nb-5Y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gqiYS-0004bd-4B
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:01:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gqiYR-0004b3-UF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:01:12 -0500
Date: Mon, 4 Feb 2019 10:53:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190204105332.73a30073@w520.home>
In-Reply-To: <20190117215300.29694-2-brijesh.singh@amd.com>
References: <20190117215300.29694-1-brijesh.singh@amd.com>
	<20190117215300.29694-2-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] memory: Fix the memory region type
 assignment order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 17 Jan 2019 21:53:16 +0000
"Singh, Brijesh" <brijesh.singh@amd.com> wrote:

> Currently, a callback registered through the RAMBlock notifier
> is not able to get the memory region type (i.e callback is not
> able to use memory_region_is_ram_device function). This is
> because mr->ram assignment happens _after_ the memory is allocated
> whereas the callback is executed during allocation.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
> Sugegsted-by: Alex Williamson <alex.williamson@redhat.com>

s/Sugegsted/Suggested/

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  memory.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/memory.c b/memory.c
> index 61d66e4441..9ec15349dd 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1652,10 +1652,17 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
>                                         uint64_t size,
>                                         void *ptr)
>  {
> -    memory_region_init_ram_ptr(mr, owner, name, size, ptr);
> +    memory_region_init(mr, owner, name, size);
> +    mr->ram = true;
> +    mr->terminates = true;
>      mr->ram_device = true;
>      mr->ops = &ram_device_mem_ops;
>      mr->opaque = mr;
> +    mr->destructor = memory_region_destructor_ram;
> +    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> +    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
> +    assert(ptr != NULL);
> +    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
>  }
>  
>  void memory_region_init_alias(MemoryRegion *mr,

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
