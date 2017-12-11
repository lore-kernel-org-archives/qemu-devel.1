Received: from eggs.gnu.org ([2001:4830:134:3::10]:50254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eOOh9-0006S9-MY
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eOOh0-0004Un-2c
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:04:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52826
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eOOgz-0004UX-UD
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:04:26 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBE4JCj174190
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:04:25 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2essfgf7ks-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:04:23 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Dec 2017 14:04:18 -0000
References: <20171211122146.162430-1-borntraeger@de.ibm.com>
	<a26d11cb-4ba6-3bd7-2b00-7fc698cc6cd9@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Dec 2017 15:04:13 +0100
MIME-Version: 1.0
In-Reply-To: <a26d11cb-4ba6-3bd7-2b00-7fc698cc6cd9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <585800a9-cab8-a79a-048a-380de5a54f6c@de.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 12/11/2017 02:55 PM, David Hildenbrand wrote:
> On 11.12.2017 13:21, Christian Borntraeger wrote:
>> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
>> limiting the memory per slot to 8TB-4k. As memory slots on s390/kvm must
>> be a multiple of 1MB we need start a new memory region if we cross
>> 8TB-1M.
>>
>> With that (and optimistic overcommitment in the kernel) I was able to
>> start a 24TB guest on a 1TB system.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 28 +++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 8425534..073f6ed 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -154,14 +154,36 @@ static void virtio_ccw_register_hcalls(void)
>>                                     virtio_ccw_hcall_early_printk);
>>  }
>>  
>> +/*
>> + * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
>> + * as the dirty bitmap must be managed by bitops that take an int as
>> + * position indicator. If we have a guest beyond that we will split off
>> + * new subregions. The split must happen on a segment boundary (1MB).
>> + */
>> +#define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
>> +#define SEG_MSK (~0xfffffULL)
>> +#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
> 
> Just wondering if we could get into trouble when calculating
> 
> KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE

maybe just using 1ULL instead of 1UL?


> 
> on a host with sizeof(long) == 4
> 
> could it wrap? (e.g. crazy mingw stuff)
> 
>>  static void s390_memory_init(ram_addr_t mem_size)
>>  {
>>      MemoryRegion *sysmem = get_system_memory();
>> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +    ram_addr_t chunk, offset = 0;
>> +    unsigned int number = 0;
>> +    gchar *name;
>>  
>>      /* allocate RAM for core */
>> -    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
>> -    memory_region_add_subregion(sysmem, 0, ram);
>> +    name = g_strdup_printf("s390.ram");
>> +    while (mem_size) {
>> +        MemoryRegion *ram = g_new(MemoryRegion, 1);
> 
> I'd add an empty line here.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
>> +        /* KVM does not allow memslots >= 8 TB */
>> +        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
>> +        memory_region_allocate_system_memory(ram, NULL, name, chunk);
>> +        memory_region_add_subregion(sysmem, offset, ram);
>> +        mem_size -= chunk;
>> +        offset += chunk;
>> +        g_free(name);
>> +        name = g_strdup_printf("s390.ram.%u", ++number);
>> +    }
>> +    g_free(name);
>>  
>>      /* Initialize storage key device */
>>      s390_skeys_init();
>>
> 
> 
