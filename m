Received: from eggs.gnu.org ([2001:4830:134:3::10]:59723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e4u6Z-0001np-6S
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e4u6W-0004Ko-2O
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:34:15 -0400
References: <20171016202358.3633-1-david@redhat.com>
	<20171016202358.3633-3-david@redhat.com>
	<8dd3c355-7d91-e1bb-b7d6-4d3e3e213da3@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <45f91319-3fe3-403d-1c79-af1ce33b49ed@redhat.com>
Date: Wed, 18 Oct 2017 21:34:07 +0200
MIME-Version: 1.0
In-Reply-To: <8dd3c355-7d91-e1bb-b7d6-4d3e3e213da3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/tcg: low-address protection
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, cohuck@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 18.10.2017 20:21, Thomas Huth wrote:
> On 16.10.2017 22:23, David Hildenbrand wrote:
>> This is a neat way to implement low address protection, whereby
>> only the first 512 bytes of the first two pages (each 4096 bytes) of
>> every address space are protected.
>>
>> Store a tec of 0 for the access exception, this is what is defined by
>> Enhanced Suppression on Protection in case of a low address protection
>> (Bit 61 set to 0, rest undefined).
>>
>> We have to make sure to to pass the access address, not the masked page
>> address into mmu_translate*().
>>
>> Drop the check from testblock. So we can properly test this via
>> kvm-unit-tests.
>>
>> This will check every access going through one of the MMUs.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/excp_helper.c |  3 +-
>>  target/s390x/mem_helper.c  |  8 ----
>>  target/s390x/mmu_helper.c  | 94 +++++++++++++++++++++++++++++-----------------
>>  3 files changed, 60 insertions(+), 45 deletions(-)
> [...]
>> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
>> index 9daa0fd8e2..9806685bee 100644
>> --- a/target/s390x/mmu_helper.c
>> +++ b/target/s390x/mmu_helper.c
>> @@ -106,6 +106,35 @@ static void trigger_page_fault(CPUS390XState *env, target_ulong vaddr,
>>      trigger_access_exception(env, type, ilen, tec);
>>  }
>>  
>> +/* check whether the address would be proteted by Low-Address Protection */
>> +static bool is_low_address(uint64_t addr)
>> +{
>> +    return addr < 512 || (addr >= 4096 && addr <= 4607);
>> +}
> 
> Just cosmetic, but I'd rather either use "<=" or "<" both times, so:
> 
>    return addr <= 511 || (addr >= 4096 && addr <= 4607);
> 

That one then, as it matches the wording in the PoP.

>> +    /* Check the private-space control bit */
>> +    switch (asc) {
>> +    case PSW_ASC_PRIMARY:
>> +        return !(env->cregs[1] & _ASCE_PRIVATE_SPACE);
>> +    case PSW_ASC_SECONDARY:
>> +        return !(env->cregs[7] & _ASCE_PRIVATE_SPACE);
>> +    case PSW_ASC_HOME:
>> +        return !(env->cregs[13] & _ASCE_PRIVATE_SPACE);
>> +    default:
>> +        g_assert_not_reached();
> 
> Well, this is certainly reachable - if the guest was running in access
> register mode. So it might be nicer to the user if you keep the
> error_report() here?

Right, this would be reachable via translate_pages(), but not via the
tlb. Although unlikely to hit it at that point, we can keep the error.

Conny, can you fix these two up or do you want me to resend?


-- 

Thanks,

David
