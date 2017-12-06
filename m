Received: from eggs.gnu.org ([2001:4830:134:3::10]:58985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMYT1-0008Bk-8b
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMYSr-0008Gy-2e
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:06:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45812
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eMYSq-0008ES-Sw
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:06:13 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6C4hU8021818
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 07:06:10 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epcha36qw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:06:10 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 6 Dec 2017 12:06:08 -0000
References: <20171206120000.63822-1-borntraeger@de.ibm.com>
	<0b60c788-0470-1fa0-390c-472d75aef0dc@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 6 Dec 2017 13:06:03 +0100
MIME-Version: 1.0
In-Reply-To: <0b60c788-0470-1fa0-390c-472d75aef0dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8c5f5393-9191-fdae-e852-196163d42d50@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC] s390x: split memory into 4TB chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>



On 12/06/2017 01:04 PM, David Hildenbrand wrote:
> On 06.12.2017 13:00, Christian Borntraeger wrote:
>> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
>> limiting the memory per slot to 7.999TB. Lets split the base memory
>> into 4TB chunks to allow go beyond 8TB for a guest. With that (and
>> optimistic overcommitment in the kernel) I was able to start  a 59TB
>> guest on a 1TB system.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 8425534..6735bbb 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -157,11 +157,25 @@ static void virtio_ccw_register_hcalls(void)
>>  static void s390_memory_init(ram_addr_t mem_size)
>>  {
>>      MemoryRegion *sysmem = get_system_memory();
>> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +    ram_addr_t chunk, offset;
>> +    gchar *name;
>>  
>>      /* allocate RAM for core */
>> -    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
>> -    memory_region_add_subregion(sysmem, 0, ram);
>> +    offset = 0;
>> +    while (mem_size) {
>> +        MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +        chunk = mem_size;
>> +        /* KVM does not allow memslots >= 8 TB. Lets split into 4TB chunks */> +        if (chunk > 4UL * 1024 * 1024 * 1024 * 1024) {
>> +            chunk = 4UL * 1024 * 1024 * 1024 * 1024;
>> +        }
>> +        name = g_strdup_printf("s390.ram[0x%lx]", offset);
>> +        memory_region_allocate_system_memory(ram, NULL, name, chunk);
>> +        memory_region_add_subregion(sysmem, offset, ram);
>> +        mem_size -= chunk;
>> +        offset += chunk;
>> +        g_free(name);
>> +    }
>>  
>>      /* Initialize storage key device */
>>      s390_skeys_init();
>>
> 
> This will most certainly break migration, no?

Probably yes. Thats why the patch has RFC. I was looking for ideas.
> 
> 1. I remember the name being used for migration, I might be wrong.
> 2. Migration of guests > 4TB is certainly broken ;)
> 
> I wonder if this should rather be handled in the kvm_slot code.
> (silently create an manage two slots)
