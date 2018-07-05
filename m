Received: from eggs.gnu.org ([2001:4830:134:3::10]:34947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fb1oK-0004Qy-PY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fb1oG-0008JN-T1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:48:28 -0400
Received: from smtp16.mail.ru ([94.100.176.153]:37072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fb1oG-0008BA-Gm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:48:24 -0400
References: <20180704203639.29553-1-jusual@mail.ru>
	<CAFEAcA_6213s2e+_sDfCRemnVViPQ8ACSS8nRNAYs05a8xhbQA@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <f0fc8b58-d320-2b6e-6c5b-404c2e400097@mail.ru>
Date: Thu, 5 Jul 2018 13:48:15 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6213s2e+_sDfCRemnVViPQ8ACSS8nRNAYs05a8xhbQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Forbid unprivileged mode for M
 Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 05.07.2018 13:33, Peter Maydell wrote:
> On 4 July 2018 at 21:36, Julia Suvorova <jusual@mail.ru> wrote:
>> MSR handling is the only place where CONTROL.nPRIV is modified.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>>   target/arm/helper.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 5ee229eb35..83cca554ad 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -10781,8 +10781,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>>               !arm_v7m_is_handler_mode(env)) {
>>               write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
>>           }
>> -        env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
>> -        env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
>> +        if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
>> +            env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
>> +            env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
>> +        }
>>           break;
>>       default:
>>       bad_reg:
>> --
> 
> Could you also guard the similar code in the CONTROL_NS case a
> little earlier, in the function, please?
> 
>              env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
>              env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;
> 
> That won't be executed for v6M but for v8M it matters.

Sure, I'll send v2.

Best regards, Julia Suvorova.
