Received: from eggs.gnu.org ([2001:4830:134:3::10]:57011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fT5hk-0006aW-Km
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fT5hh-0000aj-1o
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:20:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fT5hg-0000Zc-Sm
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:20:48 -0400
References: <1528830325-5501-1-git-send-email-eric.auger@redhat.com>
	<53a44ac2-0b11-9cf7-87fd-8a9acc17aa60@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3c142930-c124-8da3-4304-d42e699c49bf@redhat.com>
Date: Wed, 13 Jun 2018 15:20:46 +0200
MIME-Version: 1.0
In-Reply-To: <53a44ac2-0b11-9cf7-87fd-8a9acc17aa60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com

Hi Paolo,

On 06/13/2018 11:56 AM, Paolo Bonzini wrote:
> On 12/06/2018 21:05, Eric Auger wrote:
>> When an IOMMUMemoryRegion is in front of a virtio device,
>> address_space_cache_init does not set cache->ptr as the memory
>> region is not RAM. However when the device performs an access,
>> we end up in glue() which performs the translation and then uses
>> MAP_RAM. This latter uses the unset ptr and returns a wrong value
>> which leads to a SIGSEV in address_space_lduw_internal_cached_slow,
>> for instance. Let's test whether the cache->ptr is set, and in
>> the negative use the old macro definition. This fixes the
>> use cases featuring vIOMMU (Intel and ARM SMMU) which lead to
>> a SIGSEV.
>>
>> Fixes: 48564041a73a (exec: reintroduce MemoryRegion caching)
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> I am not sure whether it doesn't break any targeted optimization
>> but at least it removes the SIGSEV.
> 
> Actually cache->ptr is always NULL here, since this is the slow path
> (there is even an assertion in address_space_translate_cached); so
> MAP_RAM can be even simpler and, apart from the bugfix, I think we
> should remove all of IS_DIRECT, MAP_RAM and INVALIDATE as a follow-up.
> They were needed in the original implementation of MemoryRegionCache,
> which only worked with RAM regions but not anymore now that the RAM case
> is open-coded in include/exec/memory_ldst_cached.inc.h.

OK I respinned with your suggestions. Hope it matches your expectations.

Thanks

Eric
> 
> Thanks,
> 
> Paolo
> 
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  exec.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/exec.c b/exec.c
>> index f6645ed..46fbd25 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -3800,7 +3800,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>>  #define SUFFIX                   _cached_slow
>>  #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
>>  #define IS_DIRECT(mr, is_write)  memory_access_is_direct(mr, is_write)
>> -#define MAP_RAM(mr, ofs)         (cache->ptr + (ofs - cache->xlat))
>> +#define MAP_RAM(mr, ofs)         (cache->ptr ? \
>> +                                 (cache->ptr + (ofs - cache->xlat)) :  \
>> +                                 qemu_map_ram_ptr((mr)->ram_block, ofs))
>>  #define INVALIDATE(mr, ofs, len) invalidate_and_set_dirty(mr, ofs, len)
>>  #define RCU_READ_LOCK()          ((void)0)
>>  #define RCU_READ_UNLOCK()        ((void)0)
>>
> 
> 
