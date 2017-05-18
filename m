Received: from eggs.gnu.org ([2001:4830:134:3::10]:34844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBL1o-000291-VY
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBL1k-0004Rv-4v
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dBL1j-0004Qd-SY
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:59:36 -0400
References: <1495107549-6097-1-git-send-email-thuth@redhat.com>
	<aa39e27c-4ec0-6431-3fe6-3e3c761502a2@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <58434d0d-66f9-c86e-7f86-6b7437a21a24@redhat.com>
Date: Thu, 18 May 2017 14:59:28 +0200
MIME-Version: 1.0
In-Reply-To: <aa39e27c-4ec0-6431-3fe6-3e3c761502a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 18.05.2017 14:23, David Hildenbrand wrote:
> 
>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
>> index f6e5bce..de0ecd4 100644
>> --- a/target/s390x/mem_helper.c
>> +++ b/target/s390x/mem_helper.c
>> @@ -20,6 +20,7 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "cpu.h"
>> +#include "exec/address-spaces.h"
>>  #include "exec/helper-proto.h"
>>  #include "exec/exec-all.h"
>>  #include "exec/cpu_ldst.h"
>> @@ -973,6 +974,33 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>>      }
>>  }
>>  
>> +uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
>> +{
>> +    CPUState *cs = CPU(s390_env_get_cpu(env));
>> +    uint64_t abs_addr;
>> +    int i;
>> +
> 
> It is somewhat strange that we set a condition code in case of a program
> interrupt (I assume that's the magic of the return value?). But maybe
> setting the CC on program interrupts is perfectly valid.

According to the PoP:

"[...] The operation is ter-
minated on addressing and protection exceptions. If
termination occurs, the condition code and the con-
tents of bit positions 32-63 of general register 0 are
unpredictable in the 24-bit or 31-bit addressing
mode, or the condition code and bits 0-63 of the reg-
ister are unpredictable in the 64-bit addressing mode."

So setting CC=1 seems a valid behavior here ;-)

>> +    real_addr = fix_address(env, real_addr);
> 
> Could it be that fix_address() misses handling for 24 bit mode? (no idea
> if that is really relevant, just wondering).

Yes, 24-bit mode is not emulated by QEMU at all, as far as I know... but
that's another story.

>> +    abs_addr = mmu_real2abs(env, real_addr) & TARGET_PAGE_MASK;
>> +    if (!address_space_access_valid(&address_space_memory, abs_addr,
>> +                                    TARGET_PAGE_SIZE, true)) {
>> +        program_interrupt(env, PGM_ADDRESSING, 4);
>> +        return 1;
>> +    }
>> +
>> +    /* Check low-address protection */
>> +    if ((env->cregs[0] & CR0_LOWPROT) != 0 && real_addr < 0x2000) {
> 
> I would drop the != 0.

Ok, I can do that in case I have to respin the patch.

>> +        program_interrupt(env, PGM_PROTECTION, 4);
>> +        return 1;
>> +    }
>> +
>> +    for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
>> +        stq_phys(cs->as, abs_addr + i, 0);
>> +    }
>> +
>> +    return 0;
>> +}
> 
> Looks good to me!

Thanks!

 Thomas
