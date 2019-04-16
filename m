Received: from eggs.gnu.org ([209.51.188.92]:39058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hGLxr-0000q9-Tq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hGLxq-0000dZ-QT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:09:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hGLxp-0000ca-7K
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:09:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GB7l5W055580
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:09:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rwcb546yv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:09:17 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 16 Apr 2019 12:09:15 +0100
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 16 Apr 2019 13:09:08 +0200
MIME-Version: 1.0
In-Reply-To: <1555334842-195718-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390: do not call
 memory_region_allocate_system_memory() multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

This fails with more than 8TB, e.g.  "-m 9T "

[pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=0, userspace_addr=0x3ffc8500000}) = 0
[pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=9895604649984, userspace_addr=0x3ffc8500000}) = -1 EINVAL (Invalid argument)

seems that the 2nd memslot gets the full size (and not 9TB-size of first slot).


On 15.04.19 15:27, Igor Mammedov wrote:
> s390 was trying to solve limited memslot size issue by abusing
> memory_region_allocate_system_memory(), which breaks API contract
> where the function might be called only once.
> 
> s390 should have used memory aliases to fragment inital memory into
> smaller chunks to satisfy KVM's memslot limitation. But its a bit
> late now, since allocated pieces are transfered in migration stream
> separately, so it's not possible to just replace broken layout with
> correct one. Previous patch made MemoryRegion alases migratable and
> this patch switches to use them to split big initial RAM chunk into
> smaller pieces up to KVM_SLOT_MAX_BYTES each and registers aliases
> for migration.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> A don't have access to a suitable system to test it, so I've simulated
> it with smaller chunks on x84 host. Ping-pong migration between old
> and new QEMU worked fine.  KVM part should be fine as memslots
> using mapped MemoryRegions (in this case it would be aliases) as
> far as I know but is someone could test it on big enough host it
> would be nice.
> ---
>  hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d11069b..12ca3a9 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -161,20 +161,30 @@ static void virtio_ccw_register_hcalls(void)
>  static void s390_memory_init(ram_addr_t mem_size)
>  {
>      MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      ram_addr_t chunk, offset = 0;
>      unsigned int number = 0;
>      gchar *name;
>  
>      /* allocate RAM for core */
> +    memory_region_allocate_system_memory(ram, NULL, "s390.whole.ram", mem_size);
> +    /*
> +     * memory_region_allocate_system_memory() registers allocated RAM for
> +     * migration, however for compat reasons the RAM should be passed over
> +     * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
> +     * allocated RAM so it won't be migrated directly. Aliases will take
> +     * of segmenting RAM into legacy chunks.
> +     */
> +    vmstate_unregister_ram(ram, NULL);
>      name = g_strdup_printf("s390.ram");
>      while (mem_size) {
> -        MemoryRegion *ram = g_new(MemoryRegion, 1);
> -        uint64_t size = mem_size;
> +        MemoryRegion *alias = g_new(MemoryRegion, 1);
>  
>          /* KVM does not allow memslots >= 8 TB */
> -        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
> -        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> -        memory_region_add_subregion(sysmem, offset, ram);
> +        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> +        memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
> +        vmstate_register_ram_global(alias);
> +        memory_region_add_subregion(sysmem, offset, alias);
>          mem_size -= chunk;
>          offset += chunk;
>          g_free(name);
> 
