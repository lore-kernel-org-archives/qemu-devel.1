Received: from eggs.gnu.org ([2001:4830:134:3::10]:49260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffmzF-0000M8-0V
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffmzB-0002ZD-Vw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:59:25 -0400
Received: from smtp5.mail.ru ([94.100.179.24]:57244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1ffmzB-0002Wv-Iw
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:59:21 -0400
References: <20180710153335.1232-1-jusual@mail.ru>
	<CAFEAcA_oZtV3NQnJNPQh74BOk7eyo_A_j4smCbU+xV=QatpJeA@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <1b8b53d3-721a-ab7d-bcb3-43cf97127a7a@mail.ru>
Date: Wed, 18 Jul 2018 16:59:12 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_oZtV3NQnJNPQh74BOk7eyo_A_j4smCbU+xV=QatpJeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvic: Change NVIC to support ARMv6-M
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

On 17.07.2018 15:58, Peter Maydell wrote:
> On 10 July 2018 at 16:33, Julia Suvorova <jusual@mail.ru> wrote:
>> The differences from ARMv7-M NVIC are:
>>    * ARMv6-M only supports up to 32 external interrupts
>>     (configurable feature already). The ICTR is reserved.
>>    * Active Bit Register is reserved.
>>    * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>>   hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++----
>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index 38aaf3dc8e..8545c87caa 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -420,6 +420,10 @@ static void set_prio(NVICState *s, unsigned irq, bool secure, uint8_t prio)
>>       assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
>>       assert(irq < s->num_irq);
>>
>> +    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
>> +        prio &= 0xc0;
> 
> Rather than hard-coding this, I think we should have a
> num_prio_bits field in the NVICState struct which defines
> how many bits of priority are implemented. This would be
> 2 for v6M and 8 otherwise, and can be set in
> armv7m_nvic_realize. Then the mask is
>    MAKE_64BIT_MASK(8 - num_prio_bits, num_prio_bits);
> (For v8M the number of priority bits is configurable.)

Do I understand correctly that the check in armv7m_nvic_realize is for
Baseline, not only v6m, because Baseline has only 4 priority levels too?
And num_prio_bits should be just a field, not a property?

Best regards, Julia Suvorova.
