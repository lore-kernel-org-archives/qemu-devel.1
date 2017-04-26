Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3PcJ-0002cO-Ny
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3PcG-0001mk-Gr
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:16:35 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3PcG-0001mQ-AN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:16:32 -0400
Received: by mail-wm0-x233.google.com with SMTP id r190so9690953wme.1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 09:16:31 -0700 (PDT)
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-2-git-send-email-cota@braap.org>
	<87efwf8nsm.fsf@linaro.org>
	<5af8f37b-3ffa-6689-bcfa-4e5601fb2087@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5af8f37b-3ffa-6689-bcfa-4e5601fb2087@redhat.com>
Date: Wed, 26 Apr 2017 17:16:58 +0100
Message-ID: <87a87387ph.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/04/2017 12:29, Alex Bennée wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>>> This paves the way for upcoming work.
>>>
>>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>>> ---
>>>  tcg-runtime.c     | 21 +++++++++++++++++++++
>>>  tcg/tcg-runtime.h |  2 ++
>>>  tcg/tcg.h         |  1 +
>>>  3 files changed, 24 insertions(+)
>>>
>>> diff --git a/tcg-runtime.c b/tcg-runtime.c
>>> index 4c60c96..90d2d4b 100644
>>> --- a/tcg-runtime.c
>>> +++ b/tcg-runtime.c
>>> @@ -27,6 +27,7 @@
>>>  #include "exec/helper-proto.h"
>>>  #include "exec/cpu_ldst.h"
>>>  #include "exec/exec-all.h"
>>> +#include "exec/tb-hash.h"
>>>
>>>  /* 32-bit helpers */
>>>
>>> @@ -141,6 +142,26 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
>>>      return ctpop64(arg);
>>>  }
>>>
>>> +void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
>>> +{
>>> +    CPUState *cpu = ENV_GET_CPU(env);
>>> +    TranslationBlock *tb;
>>> +    target_ulong cs_base, pc;
>>> +    uint32_t flags;
>>> +
>>> +    if (unlikely(atomic_read(&cpu->exit_request))) {
>>> +        goto out_epilogue;
>>> +    }
>>> +    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>> +    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
>>> +    if (likely(tb && tb->pc == addr && tb->cs_base == cs_base &&
>>> +               tb->flags == flags)) {
>>
>> Should we also not be checking the TB hasn't been invalidated: tb->invalid?
>
> It's not needed because this lookup is (if I understand it right) once
> only and is not reused later.  This is why tb_find doesn't check
> tb->invalid, but uses it to avoid adding the TB to the chain.

Right. And when tb->invalid = true is set we then flush it from the
jump cache so it will never be found by the helper after.


OK nothing to see here ;-)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

>
> Good:
>
> 	tb_find			tb_phys_invalidate
> 				  tb_lock
> 				  tb->invalid = true
> 	  lookup cache
> 	  cache hit
> 				  tb_unlock
> 	  tb_lock
> 	  tb->invalid?
> 	    yes, skip tb_add_jump
> 	  tb_unlock
> 	  execute tb once
>
> Bad (doesn't happen):
>
> 	tb_find			tb_phys_invalidate
> 				  tb_lock
> 				  tb->invalid = true
> 	  lookup cache
> 	  cache hit
> 				  tb_unlock
> 	  tb_lock
> 	  tb_add_jump
> 	  tb_unlock
> 	  execute tb many times
>
> Paolo
>
>>> +        return tb->tc_ptr;
>>> +    }
>>> + out_epilogue:
>>> +    return tcg_ctx.code_gen_epilogue;
>>> +}
>>> +
>>>  void HELPER(exit_atomic)(CPUArchState *env)
>>>  {
>>>      cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
>>> diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
>>> index 114ea6f..c41d38a 100644
>>> --- a/tcg/tcg-runtime.h
>>> +++ b/tcg/tcg-runtime.h
>>> @@ -24,6 +24,8 @@ DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
>>>  DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
>>>  DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
>>>
>>> +DEF_HELPER_FLAGS_2(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env, tl)
>>> +
>>>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>>>
>>>  #ifdef CONFIG_SOFTMMU
>>> diff --git a/tcg/tcg.h b/tcg/tcg.h
>>> index 6c216bb..5ec48d1 100644
>>> --- a/tcg/tcg.h
>>> +++ b/tcg/tcg.h
>>> @@ -699,6 +699,7 @@ struct TCGContext {
>>>         extension that allows arithmetic on void*.  */
>>>      int code_gen_max_blocks;
>>>      void *code_gen_prologue;
>>> +    void *code_gen_epilogue;
>>>      void *code_gen_buffer;
>>>      size_t code_gen_buffer_size;
>>>      void *code_gen_ptr;
>>
>>
>> --
>> Alex Bennée
>>


--
Alex Bennée
