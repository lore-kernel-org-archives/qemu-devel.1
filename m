Received: from eggs.gnu.org ([2001:4830:134:3::10]:48532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOLql-0000DA-Hq
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOLqh-0006vJ-FN
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:02:19 -0500
Date: Mon, 11 Dec 2017 12:02:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171211120200.18d1ced8.cohuck@redhat.com>
In-Reply-To: <20171207145816.87347-1-borntraeger@de.ibm.com>
References: <20171207145816.87347-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu,  7 Dec 2017 15:58:16 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
> limiting the memory per slot to 8TB-4k. Lets start a new memory region

s/Lets/Let's/ :)

> if we cross that boundary.
> 
> With that (and optimistic overcommitment in the kernel) I was able to
> start  a 24TB guest on a 1TB system.

extra whitespace after 'start'

> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
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

extra space before closing bracket

What feels a bit awkward here is that we are working from a value that
is not externalized by KVM. If we expect that value to never get
smaller than it is now, we should be fine, though.

Another slightly awkward thing is that tcg is influenced by a kvm
detail. Should not matter, though, as it simply means that we may have
more memory regions. And I really don't expect 8TB+ tcg guests to
become a common use case :)

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
> -    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    offset = 0;
> +    number = 0;
> +    name = g_strdup_printf("s390.ram");
> +    while (mem_size) {
> +        MemoryRegion *ram = g_new(MemoryRegion, 1);
> +        chunk = mem_size;
> +        /* KVM does not allow memslots >= 8 TB */
> +        if (chunk > KVM_SLOT_MAX) {
> +            chunk = KVM_SLOT_MAX;
> +        }
> +        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> +        memory_region_add_subregion(sysmem, offset, ram);
> +        mem_size -= chunk;
> +        offset += chunk;
> +	number++;

odd indentation

> +        g_free(name);
> +        name = g_strdup_printf("s390.ram.%u", number);
> +    }
> +    g_free(name);
>  
>      /* Initialize storage key device */
>      s390_skeys_init();

The approach looks reasonable to me. I don't know how I can test it
(beyond sanity checking) on my machines, though.

Feedback from others would be appreciated.
