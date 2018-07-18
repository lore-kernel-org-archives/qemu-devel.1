Received: from eggs.gnu.org ([2001:4830:134:3::10]:53279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffqmd-0006jf-5K
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffqmc-0004N8-5h
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:02:39 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffqmb-0004Mq-Vw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:02:38 -0400
Received: by mail-oi0-x244.google.com with SMTP id i12-v6so10499811oik.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 11:02:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1b8b53d3-721a-ab7d-bcb3-43cf97127a7a@mail.ru>
References: <20180710153335.1232-1-jusual@mail.ru>
	<CAFEAcA_oZtV3NQnJNPQh74BOk7eyo_A_j4smCbU+xV=QatpJeA@mail.gmail.com>
	<1b8b53d3-721a-ab7d-bcb3-43cf97127a7a@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Jul 2018 19:02:16 +0100
Message-ID: <CAFEAcA_LiiOqOShC4q=itsN7=hy6k=JC8306T+t_yJow_tfUVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 18 July 2018 at 14:59, Julia Suvorova <jusual@mail.ru> wrote:
> On 17.07.2018 15:58, Peter Maydell wrote:
>>
>> On 10 July 2018 at 16:33, Julia Suvorova <jusual@mail.ru> wrote:
>>>
>>> The differences from ARMv7-M NVIC are:
>>>    * ARMv6-M only supports up to 32 external interrupts
>>>     (configurable feature already). The ICTR is reserved.
>>>    * Active Bit Register is reserved.
>>>    * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
>>>
>>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>>> ---
>>>   hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++----
>>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>>> index 38aaf3dc8e..8545c87caa 100644
>>> --- a/hw/intc/armv7m_nvic.c
>>> +++ b/hw/intc/armv7m_nvic.c
>>> @@ -420,6 +420,10 @@ static void set_prio(NVICState *s, unsigned irq,
>>> bool secure, uint8_t prio)
>>>       assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios
>>> */
>>>       assert(irq < s->num_irq);
>>>
>>> +    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
>>> +        prio &= 0xc0;
>>
>>
>> Rather than hard-coding this, I think we should have a
>> num_prio_bits field in the NVICState struct which defines
>> how many bits of priority are implemented. This would be
>> 2 for v6M and 8 otherwise, and can be set in
>> armv7m_nvic_realize. Then the mask is
>>    MAKE_64BIT_MASK(8 - num_prio_bits, num_prio_bits);
>> (For v8M the number of priority bits is configurable.)
>
>
> Do I understand correctly that the check in armv7m_nvic_realize is for
> Baseline, not only v6m, because Baseline has only 4 priority levels too?
> And num_prio_bits should be just a field, not a property?

Make it for v6M -- v8M baseline doesn't specify a particular
number of priority levels, you can do anything. You can leave
it as a field and we'll bump it up to a property if we need it
(probably if/when we do a v8M baseline CPU model); though
if you want to make it a full property that's fine too.

thanks
-- PMM
