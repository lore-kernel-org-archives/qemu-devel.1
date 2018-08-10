Received: from eggs.gnu.org ([2001:4830:134:3::10]:51166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnyFa-0006RT-El
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnyFZ-0003gr-Il
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:38:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-5-stefanha@redhat.com>
	<829318c8-9921-b856-e2bb-86583f43a8e7@amsat.org>
	<CAFEAcA-YQ1yE0jc2CgTvvPipNjMC=7SkKQcKHV5-vgPwEBFHSQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5bec224b-79df-c7ec-be22-38cf53236e00@amsat.org>
Date: Fri, 10 Aug 2018 00:37:53 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-YQ1yE0jc2CgTvvPipNjMC=7SkKQcKHV5-vgPwEBFHSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 4/7] target/arm: add
 "cortex-m0" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, Su Hang <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On 07/30/2018 02:51 PM, Peter Maydell wrote:
> On 27 July 2018 at 06:26, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Stefan,
>>
>> On 07/25/2018 05:59 AM, Stefan Hajnoczi wrote:
>>> Define a "cortex-m0" ARMv6-M CPU model.
>>>
>>> Most of the register reset values set by other CPU models are not
>>> relevant for the cut-down ARMv6-M architecture.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  target/arm/cpu.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 3848ef46aa..7e477c0d23 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -1255,6 +1255,15 @@ static void arm11mpcore_initfn(Object *obj)
>>>      cpu->reset_auxcr = 1;
>>>  }
>>>
>>> +static void cortex_m0_initfn(Object *obj)
>>> +{
>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>> +    set_feature(&cpu->env, ARM_FEATURE_V6);
>>> +    set_feature(&cpu->env, ARM_FEATURE_M);
>>
>> What about ARM_FEATURE_THUMB2 (T32)?
> 
> No, the M0 doesn't have Thumb2. It has Thumb1 plus a tiny set
> of 32-bit instructions (which we deal with specially in translate.c).

Oh I thought it as Thumb2, ok.

> 
> (As it happens we generally can't get to the checks on the THUMB2
> feature for a v6M core, so I think but have not checked thoroughly
> that it would make no difference to QEMU's behaviour whether the
> feature bit was set or not.)
> 
>> Peter: Since the M0 (optionally?) supports 32x32 multiply, should this
>> cpu use the ARM_FEATURE_THUMB_DSP feature? Else this might trigger an
>> 'Undefined Instruction' in disas_thumb2_insn().
> 
> ARM_FEATURE_THUMB_DSP only enables checks in disas_thumb2_insn()
> (and 32x32->32 multiply is not one of the insns it gates).
> The only insns in that function that a v6M core can execute are
> msr, mrs, dsb, dmb, isb and bl, none of which are affected by that
> feature switch.

Yes.

> 
>> And what about optional ARM_FEATURE_PMSA?
>> Oh this would be cortex_m0plus_initfn() for "cortex-m0-plus", ok.
> 
> Yep, plain M0 has no MPU (and so we're postponing the work
> of implementing the v6M PMSA, which IIRC isn't quite the
> same as the v7M one).

Thanks for your detailed explanations :)

Regards,

Phil.
