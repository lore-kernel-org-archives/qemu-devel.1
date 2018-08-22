Received: from eggs.gnu.org ([2001:4830:134:3::10]:48242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsWuD-0006oh-Bu
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsWuA-0004dE-5S
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:26:53 -0400
From: David Hildenbrand <david@redhat.com>
References: <20180822075750.12399-1-david@redhat.com>
	<20180822075750.12399-2-david@redhat.com>
	<2a286edc-3d3f-974d-03f6-296031a0b350@twiddle.net>
	<1448959e-3e59-d183-2de8-d0f129968909@redhat.com>
Message-ID: <cf11858e-8e95-ad50-014f-c599d1d272db@redhat.com>
Date: Wed, 22 Aug 2018 19:26:47 +0200
MIME-Version: 1.0
In-Reply-To: <1448959e-3e59-d183-2de8-d0f129968909@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/8] s390x/tcg: factor out and fix DATA
 exception injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 22.08.2018 18:52, David Hildenbrand wrote:
> On 22.08.2018 18:31, Richard Henderson wrote:
>> On 08/22/2018 12:57 AM, David Hildenbrand wrote:
>>> The DXC is to be stored in the low core, and only in the FPC in case AFP
>>> is enabled in CR0.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/cpu.h         |  1 +
>>>  target/s390x/excp_helper.c | 28 ++++++++++++++++++++++++++++
>>>  target/s390x/fpu_helper.c  | 13 +++----------
>>>  target/s390x/helper.h      |  1 +
>>>  target/s390x/tcg_s390x.h   |  2 ++
>>>  target/s390x/translate.c   | 19 +++++++++----------
>>>  6 files changed, 44 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>>> index 6f8861e554..5e50c3a303 100644
>>> --- a/target/s390x/cpu.h
>>> +++ b/target/s390x/cpu.h
>>> @@ -322,6 +322,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
>>>  #define CR0_LOWPROT             0x0000000010000000ULL
>>>  #define CR0_SECONDARY           0x0000000004000000ULL
>>>  #define CR0_EDAT                0x0000000000800000ULL
>>> +#define CR0_AFP                 0x0000000000040000ULL
>>>  #define CR0_EMERGENCY_SIGNAL_SC 0x0000000000004000ULL
>>>  #define CR0_EXTERNAL_CALL_SC    0x0000000000002000ULL
>>>  #define CR0_CKC_SC              0x0000000000000800ULL
>>> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
>>> index f0ce60cff2..f5cab94ec5 100644
>>> --- a/target/s390x/excp_helper.c
>>> +++ b/target/s390x/excp_helper.c
>>> @@ -21,11 +21,13 @@
>>>  #include "qemu/osdep.h"
>>>  #include "cpu.h"
>>>  #include "internal.h"
>>> +#include "exec/helper-proto.h"
>>>  #include "qemu/timer.h"
>>>  #include "exec/exec-all.h"
>>>  #include "exec/cpu_ldst.h"
>>>  #include "hw/s390x/ioinst.h"
>>>  #include "exec/address-spaces.h"
>>> +#include "tcg_s390x.h"
>>>  #ifndef CONFIG_USER_ONLY
>>>  #include "sysemu/sysemu.h"
>>>  #include "hw/s390x/s390_flic.h"
>>> @@ -48,6 +50,32 @@
>>>      do { } while (0)
>>>  #endif
>>>  
>>> +void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
>>> +                                           uintptr_t ra)
>>> +{
>>> +    CPUState *cs = CPU(s390_env_get_cpu(env));
>>> +
>>> +    g_assert(!(dxc & ~0xff));
>>> +#if !defined(CONFIG_USER_ONLY)
>>> +    /* Store the DXC into the lowcore */
>>> +    stw_phys(cs->as, env->psa + offsetof(LowCore, data_exc_code), dxc);
>>> +#endif
>>> +
>>> +    /* Store the DXC into the FPC if AFP is enabled */
>>> +    if (env->cregs[0] & CR0_AFP) {
>>> +        env->fpc = (env->fpc & ~0xff00) | (dxc << 8);
>>> +    }
>>> +    s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
>>
>> We should probably export tcg_s390_program_interrupt, so ...
>>
>>> +
>>> +    /* the following is not necessary, but allows us to use noreturn */
>>> +    cpu_loop_exit_restore(cs, ra);
>>
>> ... you don't have to do this.
>> But even if not, g_assert_not_reached() is better here.
> 
> If that also works, fine.
> 
>>
>> I'll note that s390_program_interrupt is buggy for tcg, in that it logs
>> env->psw.addr before cpu_loop_restore, and therefore psw.addr is essentially
>> random data.
> 
> Indeed, for that it works fairly reliably.


... just realized that it is really only about logging.

> 
> I'll send a fix with the next version.
> 
> Thanks!
> 
>>
>>
>> r~
>>
> 
> 


-- 

Thanks,

David / dhildenb
