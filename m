Received: from eggs.gnu.org ([2001:4830:134:3::10]:44103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVYXX-0007zG-Is
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVYXW-0001Jk-G2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:27:59 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xOEX3p0H2=GfYbGXwJkfYYXkVfZH=h0GbM_-bZ4auSA@mail.gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-2-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKMO4GQB1Cgy5rZw8pJawO_kWFZ7PiLGzWPch5CqkOKp=Q@mail.gmail.com>
	<CAFEAcA9xOEX3p0H2=GfYbGXwJkfYYXkVfZH=h0GbM_-bZ4auSA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Jul 2017 09:27:23 +0200
Message-ID: <CAKmqyKNR269fZpVz5zqyMbkU7JDKGswnyq10+zud0FxA5_m4Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/7] hw/arm/mps2: Implement skeleton
 mps2-an385 and mps2-an511 board models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Tue, Jul 11, 2017 at 6:35 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 11 July 2017 at 15:33, Alistair Francis <alistair23@gmail.com> wrote:
>> On Tue, Jul 11, 2017 at 1:17 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Model the ARM MPS2/MPS2+ FPGA based development board.
>>>
>>> The MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
>>> FPGA but is otherwise the same as the 2). Since the CPU itself
>>> and most of the devices are in the FPGA, the details of the board
>>> as seen by the guest depend significantly on the FPGA image.
>>>
>>> We model the following FPGA images:
>>>  "mps2_an385" -- Cortex-M3 as documented in ARM Application Note AN385
>>>  "mps2_an511" -- Cortex-M3 'DesignStart' as documented in AN511
>>>
>>> They are fairly similar but differ in the details for some
>>> peripherals.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  hw/arm/Makefile.objs            |   1 +
>>>  hw/arm/mps2.c                   | 273 ++++++++++++++++++++++++++++++++++++++++
>>>  default-configs/arm-softmmu.mak |   1 +
>>>  3 files changed, 275 insertions(+)
>>>  create mode 100644 hw/arm/mps2.c
>>>
>>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>>> index 4c5c4ee..a2e56ec 100644
>>> --- a/hw/arm/Makefile.objs
>>> +++ b/hw/arm/Makefile.objs
>>> @@ -18,3 +18,4 @@ obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
>>>  obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>>>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
>>>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>>> +obj-$(CONFIG_MPS2) += mps2.o
>>
>> Is this file name possibly too generic? Should it be arm-mps2 instead.
>
> It's already in hw/arm/, and we don't ever do anything that
> confuses foo.o in one directory with foo.o in another.
> (Also none of the other board or SoCs have 'arm' prepended.)
>
>> I don't see any other boards with the same name from a Google search,
>> but it just seems a bit vague having a three letter acronym.
>
>>> +#define TYPE_MPS2_MACHINE "mps2"
>>
>> This public name seems too common as well. I am just worried it'll
>> conflict with something one day.
>
> I can see the issue, but on the other hand the type name is not
> external ABI, so we can always rename it later if we have to.

That's true, but it's still not ideal to be changing device names willy nilly.

> The board names themselves (mps2-an385 and mps2-an511) on the
> other hand we have to get right from the start. I'm not sure
> tacking an arm- on the front of those helps; they're already
> pretty ungainly.

I think the boards are already long enough to be unique and probably
don't need an 'arm-'. Although I think having the vendor name does
clarify what the board is. Imagine a user is querying QEMU for what
boards it supports and sees a board name they don't recognise. It will
be a lot easier to figure out what board this is is you search "ARM
MPS2" instead of just MPS2.

>
> The other possible name floating around here is "v2m-mps",
> which at least some of the docs refer to as the name of
> the motherboard. There's a lot of just of just plain "MPS2", though.

I guess what we generally do is copy the spec/datasheet. So if it is
in there then the name is fine.

>
> (I note that we've had 'kzm' and 'z2' since forever and they
> haven't ever conflicted with anything despite being pretty short.)

Good point.

>
> I dunno; I'll have a think about it. Naming is hard...
>
>>> +
>>> +    MemoryRegion *system_memory = get_system_memory();
>>> +
>>> +    DeviceState *armv7m;
>>
>> These should be at the top of the function.
>
> Fixed (along with the 'sccdev' added to the DeviceState
> line in a later patch).
>
>>> +    create_unimplemented_device("CMSDK APB peripheral region @0x40000000",
>>> +                                0x40000000, 0x00010000);
>>> +    create_unimplemented_device("CMSDK peripheral region @0x40010000",
>>> +                                0x40010000, 0x00010000);
>>> +    create_unimplemented_device("Extra peripheral region @0x40020000",
>>> +                                0x40020000, 0x00010000);
>>> +    create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
>>> +    create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
>>> +    create_unimplemented_device("VGA", 0x41000000, 0x0200000);
>>
>> I did not know this was an option, this is pretty cool.
>
> Yeah. It's really nice for bringing up a board model because
> you can just add -d unimp to your command line and get the
> info about what devices the guest is prodding that you need
> to implement next.

Yeah, this is great!

Thanks,
Alistair

>
> thanks
> -- PMM
