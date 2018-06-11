Received: from eggs.gnu.org ([2001:4830:134:3::10]:37934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOTg-0002DN-Jp
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOTb-0006tg-S9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:11:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180515171446.10834-1-peter.maydell@linaro.org>
	<CAFEAcA9TGnyeH8=f0xJ3sD9TtXQs_NbiJWBp9h6zsAz-UEOLrw@mail.gmail.com>
	<CAFEAcA8vS_uk7Yz+JgoHvHnwFjY-T7ShnOCiwO+QzikycQ_5yA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <723bbc56-558f-6c4d-327f-d6984aadd6c9@amsat.org>
Date: Mon, 11 Jun 2018 12:11:18 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vS_uk7Yz+JgoHvHnwFjY-T7ShnOCiwO+QzikycQ_5yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/mps2-tz: Put ethernet
 controller behind PPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 06/11/2018 11:02 AM, Peter Maydell wrote:
> I guess nobody else is interested -- applying to target-arm.next.

Sorry I missed this. I'm not specially interested in this particular
board, but in hw/arm/mps2-tz.c which is the most up-to-date board
example we have in the codebase.

> 
> thanks
> -- PMM
> 
> On 29 May 2018 at 16:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Ping for review?
>>
>> thanks
>> -- PMM
>>
>>
>> On 15 May 2018 at 18:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> The ethernet controller in the AN505 MPC FPGA image is behind
>>> the same AHB Peripheral Protection Controller that handles
>>> the graphics and GPIOs. (In the documentation this is clear
>>> in the block diagram but the ethernet controller was omitted
>>> from the table listing devices connected to the PPC.)
>>> The ethernet sits behind AHB PPCEXP0 interface 5. We had
>>> incorrectly claimed that this was a "gpio4", but there are
>>> only 4 GPIOs in this image.
>>>
>>> Correct the QEMU model to match the hardware.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> A minor nit that I didn't notice when I was modelling this.
>>>
>>> NB: I think the PSRAM is also supposed to be behind this
>>> interface of the PPC, but we definitely can't model that
>>> because our PPC implementation won't work for executing
>>> code from RAM that sits behind it.
>>>
>>>  hw/arm/mps2-tz.c | 32 +++++++++++++++++++++++---------
>>>  1 file changed, 23 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
>>> index 8dc8bfd4ab..c5ef95e4cc 100644
>>> --- a/hw/arm/mps2-tz.c
>>> +++ b/hw/arm/mps2-tz.c
>>> @@ -74,12 +74,13 @@ typedef struct {
>>>      UnimplementedDeviceState spi[5];
>>>      UnimplementedDeviceState i2c[4];
>>>      UnimplementedDeviceState i2s_audio;
>>> -    UnimplementedDeviceState gpio[5];
>>> +    UnimplementedDeviceState gpio[4];
>>>      UnimplementedDeviceState dma[4];
>>>      UnimplementedDeviceState gfx;
>>>      CMSDKAPBUART uart[5];
>>>      SplitIRQ sec_resp_splitter;
>>>      qemu_or_irq uart_irq_orgate;
>>> +    DeviceState *lan9118;
>>>  } MPS2TZMachineState;
>>>
>>>  #define TYPE_MPS2TZ_MACHINE "mps2tz"
>>> @@ -224,6 +225,26 @@ static MemoryRegion *make_fpgaio(MPS2TZMachineState *mms, void *opaque,
>>>      return sysbus_mmio_get_region(SYS_BUS_DEVICE(fpgaio), 0);
>>>  }
>>>
>>> +static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
>>> +                                  const char *name, hwaddr size)
>>> +{
>>> +    SysBusDevice *s;
>>> +    DeviceState *iotkitdev = DEVICE(&mms->iotkit);
>>> +    NICInfo *nd = &nd_table[0];
>>> +
>>> +    /* In hardware this is a LAN9220; the LAN9118 is software compatible
>>> +     * except that it doesn't support the checksum-offload feature.
>>> +     */
>>> +    qemu_check_nic_model(nd, "lan9118");
>>> +    mms->lan9118 = qdev_create(NULL, "lan9118");
>>> +    qdev_set_nic_properties(mms->lan9118, nd);
>>> +    qdev_init_nofail(mms->lan9118);
>>> +
>>> +    s = SYS_BUS_DEVICE(mms->lan9118);
>>> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 16));

EXP_IRQ: "GPIOs to the NVIC's lines 32 and up."

So this is IRQ[48], Ethernet, correct.

>>> +    return sysbus_mmio_get_region(s, 0);
>>> +}
>>> +
>>>  static void mps2tz_common_init(MachineState *machine)
>>>  {
>>>      MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
>>> @@ -363,7 +384,7 @@ static void mps2tz_common_init(MachineState *machine)
>>>                  { "gpio1", make_unimp_dev, &mms->gpio[1], 0x40101000, 0x1000 },
>>>                  { "gpio2", make_unimp_dev, &mms->gpio[2], 0x40102000, 0x1000 },
>>>                  { "gpio3", make_unimp_dev, &mms->gpio[3], 0x40103000, 0x1000 },
>>> -                { "gpio4", make_unimp_dev, &mms->gpio[4], 0x40104000, 0x1000 },

4 GPIOs, correct.

>>> +                { "eth", make_eth_dev, NULL, 0x42000000, 0x100000 },

Correct.

>>>              },
>>>          }, {
>>>              .name = "ahb_ppcexp1",
>>> @@ -447,13 +468,6 @@ static void mps2tz_common_init(MachineState *machine)
>>>                                                       "cfg_sec_resp", 0));
>>>      }
>>>
>>> -    /* In hardware this is a LAN9220; the LAN9118 is software compatible
>>> -     * except that it doesn't support the checksum-offload feature.
>>> -     * The ethernet controller is not behind a PPC.
>>> -     */
>>> -    lan9118_init(&nd_table[0], 0x42000000,
>>> -                 qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 16));
>>> -
>>>      create_unimplemented_device("FPGA NS PC", 0x48007000, 0x1000);
>>>
>>>      armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400000);
>>> --
>>> 2.17.0
> 

FWIW:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
