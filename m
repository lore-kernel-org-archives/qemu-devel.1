Received: from eggs.gnu.org ([2001:4830:134:3::10]:50542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOLwz-0004AC-3s
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOLwu-0003aU-5Q
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:08:45 -0500
References: <20171207145816.87347-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5c40255e-1998-63f9-6fce-648b88424bc4@redhat.com>
Date: Mon, 11 Dec 2017 12:08:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171207145816.87347-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC v2] s390x: start a new memory region if
 the old one exceeds KVM_MEM_MAX_NR_PAGES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

[resending as I noticed that I dropped the ccs when I sent this last week]

On 07.12.2017 15:58, Christian Borntraeger wrote:
> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
> limiting the memory per slot to 8TB-4k. Lets start a new memory region
> if we cross that boundary.
>
> With that (and optimistic overcommitment in the kernel) I was able to
> start  a 24TB guest on a 1TB system.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---

This should not harm migration I guess. And it's easier than the other
alternatives we discussed.

>  hw/s390x/s390-virtio-ccw.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 8425534..3630f6a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -154,14 +154,41 @@ static void virtio_ccw_register_hcalls(void)
>                                     virtio_ccw_hcall_early_printk);
>  }
>
> +/*
> + * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> + * as the dirty bitmap must be managed by bitops that take an int as
> + * position indicator. If we have a guest beyond that we will split off
> + * new subregions.
> + */
> +#define KVM_SLOT_MAX ((((1UL << 31) - 1) * 4096) & ~0xfffffUL )

KVM_SLOT_MAX_BYTES ?

(4096 -> TARGET_PAGE_SIZE, 0xfffff -> ? )

> +
>  static void s390_memory_init(ram_addr_t mem_size)
>  {
>      MemoryRegion *sysmem = get_system_memory();
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
> +    ram_addr_t chunk, offset;
> +    unsigned int number;
> +    gchar *name;
>
>      /* allocate RAM for core */
> -    memory_region_allocate_system_memory(ram, NULL, "s390.ram",
mem_size);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    offset = 0;
> +    number = 0;

you can initialize these directly

> +    name = g_strdup_printf("s390.ram");
> +    while (mem_size) {
> +        MemoryRegion *ram = g_new(MemoryRegion, 1);
> +        chunk = mem_size;
> +        /* KVM does not allow memslots >= 8 TB */
> +        if (chunk > KVM_SLOT_MAX) {
> +            chunk = KVM_SLOT_MAX;
> +        }

chunk = MIN() ...

> +        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> +        memory_region_add_subregion(sysmem, offset, ram);
> +        mem_size -= chunk;
> +        offset += chunk;
> +	number++;
> +        g_free(name);
> +        name = g_strdup_printf("s390.ram.%u", number);

you could directly use number++ here, when initializing number to 1.
(then also the strange indentation of number++ above is gone  )

> +    }
> +    g_free(name);
>
>      /* Initialize storage key device */
>      s390_skeys_init();
>


-- 

Thanks,

David / dhildenb
