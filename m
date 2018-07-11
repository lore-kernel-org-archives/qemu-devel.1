Received: from eggs.gnu.org ([2001:4830:134:3::10]:52444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdFFT-0003GT-AJ
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdFFP-0000cP-Hw
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:33:39 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdFFP-0000c9-Cd
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:33:35 -0400
Received: by mail-oi0-x244.google.com with SMTP id s198-v6so49233863oih.11
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:33:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180711132553.GI31228@stefanha-x1.localdomain>
References: <20180710153335.1232-1-jusual@mail.ru>
	<20180711132553.GI31228@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Jul 2018 14:33:14 +0100
Message-ID: <CAFEAcA_jekzwR8i3_1nB4smoQjoM6N_eUSP6jFP2gE08y8n9yg@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

On 11 July 2018 at 14:25, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jul 10, 2018 at 06:33:35PM +0300, Julia Suvorova via Qemu-devel wrote:
>> The differences from ARMv7-M NVIC are:
>>   * ARMv6-M only supports up to 32 external interrupts
>>    (configurable feature already). The ICTR is reserved.
>>   * Active Bit Register is reserved.
>>   * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>>  hw/intc/armv7m_nvic.c | 29 +++++++++++++++++++++++++----
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index 38aaf3dc8e..8545c87caa 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -420,6 +420,10 @@ static void set_prio(NVICState *s, unsigned irq, bool secure, uint8_t prio)
>>      assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
>>      assert(irq < s->num_irq);
>>
>> +    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
>
> ARMv8-M also has the NVIC:
> https://static.docs.arm.com/ddi0553/a/DDI0553A_e_armv8m_arm.pdf
>
> Should arm_feature(&s->cpu->env, ARM_FEATURE_V6) be used instead of
> !arm_feature(&s->cpu->env, ARM_FEATURE_V7)?

All of v6M, v7M and v8M cores will set ARM_FEATURE_V6, so
testing on it doesn't distinguish them.

thanks
-- PMM
