Received: from eggs.gnu.org ([2001:4830:134:3::10]:42013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHUzG-0003dQ-B5
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHUzB-0003T7-Lp
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:27:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHUzB-0003SU-Dm
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:27:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so11565492wme.5
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:27:13 -0700 (PDT)
References: <20181030114048.21527-1-philmd@redhat.com>
	<20181030114048.21527-3-philmd@redhat.com>
	<CAFEAcA-4_fn19H9aCio4QKikdMBv_oicgWNrThCXshNJ3HOnig@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b27c4766-794e-a3dd-7931-6c54e30bd30d@redhat.com>
Date: Tue, 30 Oct 2018 15:27:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4_fn19H9aCio4QKikdMBv_oicgWNrThCXshNJ3HOnig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] arm: exynos4: Add dma support for
 smdkc210
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 30/10/18 15:06, Peter Maydell wrote:
> On 30 October 2018 at 11:40, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>>
>> QEMU already supports pl330. Instantiate it for smdkc210.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> [PMD: Do not set default qdev properties]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   hw/arm/exynos4_boards.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
> 
>>   static void exynos4_boards_init_ram(Exynos4BoardState *s,
>>                                       MemoryRegion *system_mem,
>>                                       unsigned long ram_size)
>> @@ -171,6 +187,14 @@ static void smdkc210_init(MachineState *machine)
>>
>>       lan9215_init(SMDK_LAN9118_BASE_ADDR,
>>               qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]));
>> +
>> +    pl330_init(SMDK_PL330_BASE0_ADDR,
>> +            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(35, 1)]), 32);
>> +    pl330_init(SMDK_PL330_BASE1_ADDR,
>> +            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(36, 1)]), 32);
>> +    pl330_init(SMDK_PL330_BASE2_ADDR,
>> +            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(34, 1)]), 1);
>> +
>>       arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
>>   }
> 
> Are the PL330s really on the board and not part of the SoC? The
> layout of the dts files in the kernel suggests they're in the
> SoC, in which case they would belong in hw/arm/exynos4210.c.

Yes you are right, I missed that :|
