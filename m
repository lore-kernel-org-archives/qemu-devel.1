Received: from eggs.gnu.org ([2001:4830:134:3::10]:52413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1flA8I-0003No-BD
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1flA8H-0005ug-HM
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:42:58 -0400
References: <20180726023645.13927-1-joel@jms.id.au>
	<20180726023645.13927-3-joel@jms.id.au>
	<94bc2d11-7916-bc4e-02d8-da62e3ed303b@mail.ru>
	<CACPK8XfYvU8+0s+FBGe7NuAst38ska0vpS8HVPWkM8OHyLFpdQ@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <c2432d29-fb24-924a-4df2-2abf5d52afca@mail.ru>
Date: Thu, 2 Aug 2018 12:42:44 +0300
MIME-Version: 1.0
In-Reply-To: <CACPK8XfYvU8+0s+FBGe7NuAst38ska0vpS8HVPWkM8OHyLFpdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] arm: Add Nordic Semiconductor nRF51
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>

On 30.07.2018 17:02, Joel Stanley wrote:
> On 26 July 2018 at 20:31, Julia Suvorova <jusual@mail.ru> wrote:
> 
>>> +++ b/hw/arm/nrf51_soc.c
> 
>>> +static void nrf51_soc_init(Object *obj)
>>> +{
>>> +    NRF51State *s = NRF51_SOC(obj);
>>> +
>>> +    memory_region_init(&s->container, obj, "nrf51-container",
>>> UINT64_MAX);
>>> +
>>> +    object_initialize(&s->cpu, sizeof(s->cpu), TYPE_ARM_M_PROFILE);
>>> +    object_property_add_child(OBJECT(s), "armv6m", OBJECT(&s->cpu),
>>> &error_abort);
>>> +    qdev_set_parent_bus(DEVICE(&s->cpu), sysbus_get_default());
>>> +    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
>>> ARM_CPU_TYPE_NAME("cortex-m0"));
>>> +    qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 96);
>>
>>
>> Where did this number come from? ARMv6-M NVIC supports only 32 interrupts.
> 
> I think this was left over from when I was first creating a m0 based
> system (efm32hg) over a year ago. Good catch.
> 
> I couldn't see a table of valid interrupts in the nrf51 datasheet. Are
> you able to find this information?
> 
> If not, I will re-spin with the number of irqs set to 32.

The only information in the nRF51 Reference Manual is given in
paragraph 10.1.6:
A peripheral only occupies one interrupt, and the interrupt number
follows the peripheral ID, for example, the peripheral with ID=4 is
connected to interrupt number 4 in the Nested Vector Interrupt
Controller (NVIC).

Thus, Table 2 in 5.2 can be used as an interrupt table.

In any case, unextended ARMv6-M limits the number of interrupts to 32.
And efm32hg is based on M0+ and can have additional features.

Best regards, Julia Suvorova.
