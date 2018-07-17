Received: from eggs.gnu.org ([2001:4830:134:3::10]:50760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffQFf-0005ud-7j
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffQFb-0007i4-BX
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:42:51 -0400
Received: from smtp16.mail.ru ([94.100.176.153]:42816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1ffQFa-0007gT-VJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:42:47 -0400
References: <20180713103059.12539-1-jusual@mail.ru>
	<CAFEAcA9zzSu86Ra3Cgs_V8NYnC+vYCujE5vBkqtnX6AWFk-+LQ@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <42c6cde3-2b82-f1e8-f893-ce19849f9e46@mail.ru>
Date: Tue, 17 Jul 2018 16:42:35 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zzSu86Ra3Cgs_V8NYnC+vYCujE5vBkqtnX6AWFk-+LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arm: Add ARMv6-M programmer's model support
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

On 17.07.2018 16:09, Peter Maydell wrote:
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index a914ce4e8c..3788cb773d 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -220,6 +220,11 @@ static void arm_cpu_reset(CPUState *s)
>>               env->v7m.aircr = R_V7M_AIRCR_BFHFNMINS_MASK;
>>           }
>>
>> +        if (!arm_feature(env, ARM_FEATURE_V7)) {
>> +            env->v7m.ccr[M_REG_NS] = 0x3f8;
>> +            env->v7m.ccr[M_REG_S] = 0x3f8;
> 
> This code will have no effect, because just below we already have an
> assignment to these fields:
>          env->v7m.ccr[M_REG_NS] = R_V7M_CCR_STKALIGN_MASK;
>          env->v7m.ccr[M_REG_S] = R_V7M_CCR_STKALIGN_MASK;

My bad; I'll put the assignments that you mentioned into if/else block.

>> +        }
>> +
>>           /* In v7M the reset value of this bit is IMPDEF, but ARM recommends
>>            * that it resets to 1, so QEMU always does that rather than making
>>            * it dependent on CPU model. In v8M it is RES1.
>> @@ -230,6 +235,11 @@ static void arm_cpu_reset(CPUState *s)
>>               /* in v8M the NONBASETHRDENA bit [0] is RES1 */
>>               env->v7m.ccr[M_REG_NS] |= R_V7M_CCR_NONBASETHRDENA_MASK;
>>               env->v7m.ccr[M_REG_S] |= R_V7M_CCR_NONBASETHRDENA_MASK;
>> +
>> +            if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
>> +                env->v7m.ccr[M_REG_NS] |= R_V7M_CCR_UNALIGN_TRP_MASK;
>> +                env->v7m.ccr[M_REG_S] |= R_V7M_CCR_UNALIGN_TRP_MASK;
>> +            }
> 
> This should be outside the "if v8" if(), because you also want it for v6M
> (giving you the v6M CCR value of STKALIGN and UNALIGN_TRP set and all
> other bits clear).

This is the main problem. If I understand correctly, bits[4:8] also
should be read-as-one (Table B3-4 ARMv6-M ARM). And I've already set them
(with UNALIGN_TRP) before for v6m.

Best regards, Julia Suvorova.
