Received: from eggs.gnu.org ([2001:4830:134:3::10]:56664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3KQY-0004G7-CO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3KQX-0004XE-Ey
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:44:06 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-2-git-send-email-cota@braap.org>
	<87efwf8nsm.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f999ad8-7208-7980-c17a-e9450176d1df@twiddle.net>
Date: Wed, 26 Apr 2017 12:43:55 +0200
MIME-Version: 1.0
In-Reply-To: <87efwf8nsm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] tcg-runtime: add lookup_tb_ptr
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/26/2017 12:29 PM, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
>> This paves the way for upcoming work.
>>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>> ---
>>   tcg-runtime.c     | 21 +++++++++++++++++++++
>>   tcg/tcg-runtime.h |  2 ++
>>   tcg/tcg.h         |  1 +
>>   3 files changed, 24 insertions(+)
>>
>> diff --git a/tcg-runtime.c b/tcg-runtime.c
>> index 4c60c96..90d2d4b 100644
>> --- a/tcg-runtime.c
>> +++ b/tcg-runtime.c
>> @@ -27,6 +27,7 @@
>>   #include "exec/helper-proto.h"
>>   #include "exec/cpu_ldst.h"
>>   #include "exec/exec-all.h"
>> +#include "exec/tb-hash.h"
>>
>>   /* 32-bit helpers */
>>
>> @@ -141,6 +142,26 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
>>       return ctpop64(arg);
>>   }
>>
>> +void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
>> +{
>> +    CPUState *cpu = ENV_GET_CPU(env);
>> +    TranslationBlock *tb;
>> +    target_ulong cs_base, pc;
>> +    uint32_t flags;
>> +
>> +    if (unlikely(atomic_read(&cpu->exit_request))) {
>> +        goto out_epilogue;
>> +    }
>> +    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>> +    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
>> +    if (likely(tb && tb->pc == addr && tb->cs_base == cs_base &&
>> +               tb->flags == flags)) {
> 
> Should we also not be checking the TB hasn't been invalidated: tb->invalid?

We don't check in tb_find.

I guess we're assuming that such have been purged from the tb_jmp_cache.  That 
said, tb_phys_invalidate assumes tb_locked, and I don't immediately remember 
how all that is supposed to tie together.


r~
