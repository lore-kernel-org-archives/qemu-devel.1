Received: from eggs.gnu.org ([2001:4830:134:3::10]:58019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEI0I-00057j-Sz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEI0H-0000Ox-Uy
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:26:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEI0H-0000Oq-O9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:26:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id n65-v6so16793050oig.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 10:26:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ad8ffc6-5549-99bf-940f-6734c579e354@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-5-richard.henderson@linaro.org>
	<CAFEAcA-wq3kasUe8pkdUJXNJYNnLABrPgeQE4fokSLL995SFkg@mail.gmail.com>
	<1ad8ffc6-5549-99bf-940f-6734c579e354@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 18:26:28 +0100
Message-ID: <CAFEAcA_gPP80BdfhExzHksJyf5KhbQtMH=bGypW4C9uy=fm9jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/9] tcg: Introduce atomic
 helpers for integer min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 3 May 2018 at 18:13, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 05/03/2018 06:26 AM, Peter Maydell wrote:
>> On 27 April 2018 at 01:26, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> Given that this atomic operation will be used by both risc-v
>>> and aarch64, let's not duplicate code across the two targets.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  accel/tcg/atomic_template.h | 71 +++++++++++++++++++++++++++++++++++++++++++++
>>>  accel/tcg/tcg-runtime.h     |  8 +++++
>>>  tcg/tcg-op.h                | 34 ++++++++++++++++++++++
>>>  tcg/tcg.h                   |  8 +++++
>>>  tcg/tcg-op.c                |  8 +++++
>>>  5 files changed, 129 insertions(+)
>>
>>> @@ -233,6 +270,39 @@ ABI_TYPE ATOMIC_NAME(add_fetch)(CPUArchState *env, target_ulong addr,
>>>          ldo = ldn;
>>>      }
>>>  }
>>> +
>>> +/* These helpers are, as a whole, full barriers.  Within the helper,
>>> + * the leading barrier is explicit and the trailing barrier is within
>>> + * cmpxchg primitive.
>>> + */
>>> +#define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
>>> +ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
>>> +                        ABI_TYPE xval EXTRA_ARGS)                   \
>>> +{                                                                   \
>>> +    ATOMIC_MMU_DECLS;                                               \
>>> +    XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
>>> +    XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
>>> +    smp_mb();                                                       \
>>> +    ldn = atomic_read__nocheck(haddr);                              \
>>
>> I see you're using the __nocheck function here. How does this
>> work for the 32-bit host case where you don't necessarily have
>> a 64-bit atomic primitive?
>
> It won't be compiled for the 32-bit host.  Translation will not attempt to use
> this helper and will instead call exit_atomic.

OK. Can you point me at the code that handles min/max atomics in that case?

thanks
-- PMM
