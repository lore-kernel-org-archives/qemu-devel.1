Received: from eggs.gnu.org ([209.51.188.92]:49470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gghCQ-0006NU-M1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gghCO-0003tP-PD
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:33:02 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gghCM-0003im-PK
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:32:58 -0500
Received: by mail-pg1-x542.google.com with SMTP id g189so1020382pgc.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 18:32:56 -0800 (PST)
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-5-richard.henderson@linaro.org>
	<CAFEAcA8r+Zt3rZWnHa+-uj25OtB9i6UoCXVqNHBsr_88JVfRuA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62de25ca-0fd5-0da4-382a-bc3d5cc7948c@linaro.org>
Date: Tue, 8 Jan 2019 12:32:48 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8r+Zt3rZWnHa+-uj25OtB9i6UoCXVqNHBsr_88JVfRuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/27] target/arm: Add PAuth helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/5/19 2:25 AM, Peter Maydell wrote:
> On Fri, 14 Dec 2018 at 05:24, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The cryptographic internals are stubbed out for now,
>> but the enable and trap bits are checked.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ----
> 
>> +static void QEMU_NORETURN pauth_trap(CPUARMState *env, int target_el,
>> +                                     uintptr_t ra)
>> +{
>> +    CPUState *cs = ENV_GET_CPU(env);
>> +
>> +    cs->exception_index = EXCP_UDEF;
>> +    env->exception.syndrome = syn_pactrap();
>> +    env->exception.target_el = target_el;
>> +    cpu_loop_exit_restore(cs, ra);
> 
> This should use raise_exception(), or some variant on it that
> lets you pass in the ra, because otherwise you lose the
> "redirect EL1 exceptions to EL2" HCR.TGE behaviour.
> Or can we only ever call this for a target_el of 2 or 3?

This particular usage can only ever target EL 2 or 3,
in response to {SCR,HCR}.API being clear.  AFAICS that
trap is properly directed already.

But, yes, raise_exception_ra would be useful.


r~
