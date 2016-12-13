Received: from eggs.gnu.org ([2001:4830:134:3::10]:36941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cGmvO-0005cQ-0p
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cGmvJ-0007cR-H7
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:15:18 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cGmvJ-0007cK-8u
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:15:13 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so16508604wjb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:15:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-5-pbonzini@redhat.com>
	<20161212140655.GE4074@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b90df89-815d-daa6-7c26-23e8034fcae7@redhat.com>
Date: Tue, 13 Dec 2016 14:14:09 +0100
MIME-Version: 1.0
In-Reply-To: <20161212140655.GE4074@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/11] exec: introduce MemoryRegionCache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: borntraeger@de.ibm.com, famz@redhat.com, qemu-devel@nongnu.org, mst@redhat.com



On 12/12/2016 15:06, Stefan Hajnoczi wrote:
> On Mon, Dec 12, 2016 at 12:18:50PM +0100, Paolo Bonzini wrote:
>> diff --git a/exec.c b/exec.c
>> index d4b3656..8d4bb0e 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -3077,6 +3077,82 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
>>  #define RCU_READ_UNLOCK(...)     rcu_read_unlock()
>>  #include "memory_ldst.inc.c"
>>  
>> +int64_t address_space_cache_init(MemoryRegionCache *cache,
>> +                                 AddressSpace *as,
>> +                                 hwaddr addr,
>> +                                 hwaddr len,
>> +                                 bool is_write)
>> +{
>> +    hwaddr l, xlat;
>> +    MemoryRegion *mr;
>> +    void *ptr;
>> +
>> +    assert(len > 0);
>> +
>> +    l = len;
>> +    mr = address_space_translate(as, addr, &xlat, &l, is_write);
>> +    if (!memory_access_is_direct(mr, is_write)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    l = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
>> +    ptr = qemu_ram_ptr_length(mr->ram_block, xlat, &l);
>> +
>> +    cache->xlat = xlat;
>> +    cache->is_write = is_write;
>> +    cache->mr = mr;
>> +    cache->ptr = ptr;
>> +    cache->len = l;
>> +    memory_region_ref(cache->mr);
>> +
>> +    return l;
>> +}
> 
> What happens when [addr, addr + len) overlaps a MemoryRegion boundary?
> It looks like this function silently truncates the MemoryRegionCache,

Yes, this is what address_space_map does.  It's up to the caller to
decide what to do.

Patch 8 ("virtio: use MemoryRegionCache to access descriptors") does it
right.  As you noted, patch 9 doesn't check for errors at all---that's
part of why this is RFC.

Paolo

> leading to an assertion failure in address_space_translate_cached().
> 
> Perhaps it would be better to fail address_space_cache_init() if the
> length is truncated.
> 
