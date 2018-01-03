Received: from eggs.gnu.org ([2001:4830:134:3::10]:44196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWseL-00046p-4b
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWseG-0007Mo-99
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:40:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWseF-0007JT-Un
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:40:40 -0500
References: <20180102234108.32713-1-laurent@vivier.eu>
	<20180102234108.32713-8-laurent@vivier.eu>
	<5630ba80-503f-f7e7-2764-c433aa3ea19a@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2ec23cfd-ead8-8119-ab37-0f74a62c3df0@vivier.eu>
Date: Thu, 4 Jan 2018 00:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <5630ba80-503f-f7e7-2764-c433aa3ea19a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 07/17] target/m68k: add chk and chk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

Le 03/01/2018 à 22:52, Richard Henderson a écrit :
> On 01/02/2018 03:40 PM, Laurent Vivier wrote:
>> +void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
>> +{
>> +    if (val < 0 || val > ub) {
>> +        CPUState *cs = CPU(m68k_env_get_cpu(env));
>> +
>> +        /* Recover PC and CC_OP for the beginning of the insn.  */
>> +        cpu_restore_state(cs, GETPC());
>> +
>> +        /* Adjust PC and FLAGS to end of the insn.  */
>> +        env->pc += 2;
>> +        helper_flush_flags(env, env->cc_op);
>> +        env->cc_n = val;
>> +
>> +        cs->exception_index = EXCP_CHK;
>> +        cpu_loop_exit(cs);
>> +    }
>> +}
>> +
> 
> I thought you said for 68040, N is always unset for val >= 0.
> That would suggest
> 
>   helper_flush_flags(env, env->cc_op);
>   env->cc_n = val;
>   if (val < 0 || val > ub) {
>     ...
>   }

ok, my though was it is better to not update the flag if it is not
needed (it should be undefined), but what you suggest is closer to the
real hardware so I will update it.

> Did you examine the real hw change to the other flags?

yes, C is modified, and the logic is:
  C = 0 <= ub ? val < 0 || ub < val : val < 0 && ub < val;
All other flags are not modified.

I'm going to update the patch to reflect the change of N and C by the
real hardware.

> Because they're officially undefined, which suggests
> 
>   env->cc_n = val;
>   env->cc_op = CC_OP_LOGIC;
> 
>> +void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
>> +{
>> +    helper_flush_flags(env, env->cc_op);
>> +
>> +    env->cc_z = val != lb && val != ub;
>> +    env->cc_c = lb <= ub ? val < lb || val > ub : val > ub && val < lb;
>> +
>> +    if (env->cc_c) {
>> +        CPUState *cs = CPU(m68k_env_get_cpu(env));
>> +
>> +        cpu_restore_state(cs, GETPC());
>> +        env->cc_op = CC_OP_FLAGS;
> 
> A comment that we're reverting a change made during unwind would be helpful here.

Ok

Thanks,
Laurent
