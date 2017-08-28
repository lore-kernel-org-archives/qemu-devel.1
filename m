Received: from eggs.gnu.org ([2001:4830:134:3::10]:50920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmRnI-0006rK-M8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmRnH-0003Os-Nw
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:42:04 -0400
MIME-Version: 1.0
In-Reply-To: <03c05a60-d697-500b-c2fc-d99b24f3f64c@twiddle.net>
References: <20170828035327.17146-1-bobby.prani@gmail.com>
	<20170828035327.17146-3-bobby.prani@gmail.com>
	<03c05a60-d697-500b-c2fc-d99b24f3f64c@twiddle.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 28 Aug 2017 17:41:29 -0400
Message-ID: <CAJhHMCC4Y0Zos+g4M6Rms+vO8cdZ+AOupciRFWTfnbFgpRs9jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] mttcg: Implement implicit ordering
 semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "open list:AArch64 target" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Aug 28, 2017 at 1:57 PM, Richard Henderson <rth@twiddle.net> wrote:
> On 08/27/2017 08:53 PM, Pranith Kumar wrote:
>> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
>> index 55a46ac825..b41a248bee 100644
>> --- a/tcg/aarch64/tcg-target.h
>> +++ b/tcg/aarch64/tcg-target.h
>> @@ -117,4 +117,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>>      __builtin___clear_cache((char *)start, (char *)stop);
>>  }
>>
>> +#define TCG_TARGET_DEFAULT_MO (0)
>> +
>>  #endif /* AARCH64_TCG_TARGET_H */
>
> Please add all of these in one patch, separate from the tcg-op.c changes.
> We should also just make this mandatory and remove any related #ifdefs.

I tried looking up ordering semantics for architectures like ia64 and
s390. It is not really clear. I think every arch but for x86 can be
defined as weak, even though archs like sparc can also be configured
as TSO. Is this right?

>
>> +void tcg_gen_req_mo(TCGBar type)
>
> static, until we find that we need it somewhere else.
>

Will fix.

>> +#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
>> +    TCGBar order_mismatch = type & (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO);
>> +    if (order_mismatch) {
>> +        tcg_gen_mb(order_mismatch | TCG_BAR_SC);
>> +    }
>> +#else
>> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>> +#endif
>
> Hmm.  How about
>
> static void tcg_gen_reg_mo(TCGBar type)
> {
> #ifdef TCG_GUEST_DEFAULT_MO
>     type &= TCG_GUEST_DEFAULT_MO;
> #endif
> #ifdef TCG_TARGET_DEFAULT_MO
>     type &= ~TCG_TARGET_DEFAULT_MO;
> #endif
>     if (type) {
>         tcg_gen_mb(type | TCG_BAR_SC);
>     }
> }

Yes, this looks better and until we can get all the possible
definitions of TCG_GUEST_DEFAULT_MO and TCG_TARGET_DEFAULT_MO figured
out I would like to keep the #ifdefs.

>
> Just because one of those is undefined doesn't mean we can't infer tighter
> barriers from the others, including the initial value of TYPE.
>
>>  void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
>>  {
>> +    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_LD_ST);
>>      memop = tcg_canonicalize_memop(memop, 0, 0);
>
> You're putting the barrier before the load, so that should be
>
>   TCG_MO_LD_LD | TCG_MO_ST_LD
>
> i.e.  TCG_MO_<any>_<current op>
>
> If you were putting the barrier afterward (an equally reasonable option), you'd
> reverse that and use what you have above.

OK, will fix this. Thanks for the review.

-- 
Pranith
