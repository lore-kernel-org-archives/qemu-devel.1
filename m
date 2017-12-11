Received: from eggs.gnu.org ([2001:4830:134:3::10]:46580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOOYj-0004hR-Ia
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOOYd-0005fp-S9
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:55:53 -0500
References: <20171211122146.162430-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a26d11cb-4ba6-3bd7-2b00-7fc698cc6cd9@redhat.com>
Date: Mon, 11 Dec 2017 14:55:44 +0100
MIME-Version: 1.0
In-Reply-To: <20171211122146.162430-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/1] s390-ccw-virtio: allow
 for systems larger that 7.999TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 11.12.2017 13:21, Christian Borntraeger wrote:
> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
> limiting the memory per slot to 8TB-4k. As memory slots on s390/kvm mus=
t
> be a multiple of 1MB we need start a new memory region if we cross
> 8TB-1M.
>=20
> With that (and optimistic overcommitment in the kernel) I was able to
> start a 24TB guest on a 1TB system.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 8425534..073f6ed 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -154,14 +154,36 @@ static void virtio_ccw_register_hcalls(void)
>                                     virtio_ccw_hcall_early_printk);
>  }
> =20
> +/*
> + * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> + * as the dirty bitmap must be managed by bitops that take an int as
> + * position indicator. If we have a guest beyond that we will split of=
f
> + * new subregions. The split must happen on a segment boundary (1MB).
> + */
> +#define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
> +#define SEG_MSK (~0xfffffULL)
> +#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) =
& SEG_MSK)

Just wondering if we could get into trouble when calculating

KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE

on a host with sizeof(long) =3D=3D 4

could it wrap? (e.g. crazy mingw stuff)

>  static void s390_memory_init(ram_addr_t mem_size)
>  {
>      MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> +    ram_addr_t chunk, offset =3D 0;
> +    unsigned int number =3D 0;
> +    gchar *name;
> =20
>      /* allocate RAM for core */
> -    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_si=
ze);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    name =3D g_strdup_printf("s390.ram");
> +    while (mem_size) {
> +        MemoryRegion *ram =3D g_new(MemoryRegion, 1);

I'd add an empty line here.

Reviewed-by: David Hildenbrand <david@redhat.com>

> +        /* KVM does not allow memslots >=3D 8 TB */
> +        chunk =3D MIN(mem_size, KVM_SLOT_MAX_BYTES);
> +        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> +        memory_region_add_subregion(sysmem, offset, ram);
> +        mem_size -=3D chunk;
> +        offset +=3D chunk;
> +        g_free(name);
> +        name =3D g_strdup_printf("s390.ram.%u", ++number);
> +    }
> +    g_free(name);
> =20
>      /* Initialize storage key device */
>      s390_skeys_init();
>=20


--=20

Thanks,

David / dhildenb
