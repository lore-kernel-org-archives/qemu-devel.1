Received: from eggs.gnu.org ([2001:4830:134:3::10]:44496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBLVb-0001bS-H5
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBLVY-0006vE-BH
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dBLVY-0006v7-5Q
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:30:24 -0400
References: <1495107549-6097-1-git-send-email-thuth@redhat.com>
	<aa39e27c-4ec0-6431-3fe6-3e3c761502a2@redhat.com>
	<58434d0d-66f9-c86e-7f86-6b7437a21a24@redhat.com>
	<20170518132025.xuqowm2q5rgshrva@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7633253d-d622-79eb-1825-1b77ba5e2d31@redhat.com>
Date: Thu, 18 May 2017 15:30:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170518132025.xuqowm2q5rgshrva@aurel32.net>
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 18.05.2017 15:20, Aurelien Jarno wrote:
> On 2017-05-18 14:59, Thomas Huth wrote:
>> On 18.05.2017 14:23, David Hildenbrand wrote:
>>>
>>>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
>>>> index f6e5bce..de0ecd4 100644
>>>> --- a/target/s390x/mem_helper.c
>>>> +++ b/target/s390x/mem_helper.c
>>>> @@ -20,6 +20,7 @@
>>>>  
>>>>  #include "qemu/osdep.h"
>>>>  #include "cpu.h"
>>>> +#include "exec/address-spaces.h"
>>>>  #include "exec/helper-proto.h"
>>>>  #include "exec/exec-all.h"
>>>>  #include "exec/cpu_ldst.h"
>>>> @@ -973,6 +974,33 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>>>>      }
>>>>  }
>>>>  
>>>> +uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
>>>> +{
>>>> +    CPUState *cs = CPU(s390_env_get_cpu(env));
>>>> +    uint64_t abs_addr;
>>>> +    int i;
>>>> +
>>>
>>> It is somewhat strange that we set a condition code in case of a program
>>> interrupt (I assume that's the magic of the return value?). But maybe
>>> setting the CC on program interrupts is perfectly valid.
>>
>> According to the PoP:
>>
>> "[...] The operation is ter-
>> minated on addressing and protection exceptions. If
>> termination occurs, the condition code and the con-
>> tents of bit positions 32-63 of general register 0 are
>> unpredictable in the 24-bit or 31-bit addressing
>> mode, or the condition code and bits 0-63 of the reg-
>> ister are unpredictable in the 64-bit addressing mode."
>>
>> So setting CC=1 seems a valid behavior here ;-)
> 
> Actually program_interrupt will never return, so CC is left unchanged in
> case of an exception. It's also matches the unpredictable value
> described in the PoP ;-).

Ah, right, program_interrupt() calls cpu_loop_exit() which in turn does
the longjump ... makes more sense to me now, thanks for the hint!

 Thomas
