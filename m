Received: from eggs.gnu.org ([2001:4830:134:3::10]:43670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmsS-0001ns-QU
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmsP-00086i-M6
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:39:52 -0500
Date: Sun, 26 Feb 2017 01:39:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-CA9Zw8fHjO707g_RW2TJcR50GS16xLX-Gi7OCi06P_A@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1702260133190.45393@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<c2915d0d2f3966ddb92005129b680727a69a3bcd.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA8YGAyG3_uKwGJhff+ruearUP6eyQ0DROqZhGmdcaq6dw@mail.gmail.com>
	<alpine.BSF.2.20.1702242118560.76443@zero.eik.bme.hu>
	<CAFEAcA-CA9Zw8fHjO707g_RW2TJcR50GS16xLX-Gi7OCi06P_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 03/10] sm501: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Sat, 25 Feb 2017, Peter Maydell wrote:
> On 24 February 2017 at 20:23, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> The SM501/SM502 is a multimedia chip that besides a display controller also
>> contains some other functions (see
>> http://cateee.net/lkddb/web-lkddb/MFD_SM501.html) and this is what is
>> emulated here as these are part of the chip itself.
>
> Hmm; that's pretty ugly but I guess it's sort of like a container
> device that needs to contain various things inside it.
>
>>>>
>>>> -    /* create qemu graphic console */
>>>> -    s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
>>>> +static Property sm501_sysbus_properties[] = {
>>>> +    DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
>>>> +    DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
>>>> +    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
>
> Pointer properties and properties which tell the device what
> address it's at are both signs that something's not quite
> modelled right. There may be no better way to do things right
> now, or then again there may be.

Maybe but I think that would not be part of this series but some other 
clean up separately. This series makes it a bit cleaner but does not aim 
to fix everything.

>>>> +    DEFINE_PROP_END_OF_LIST(),
>>>> +};
>>>
>>>
>>>> +static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
>>>> +{
>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>> +
>>>> +    dc->realize = sm501_realize_sysbus;
>>>> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>>>> +    dc->desc = "SM501 Multimedia Companion";
>>>> +    dc->props = sm501_sysbus_properties;
>>>> +/* Note: pointer property "chr-state" may remain null, thus
>>>> + * no need for dc->cannot_instantiate_with_device_add_yet = true;
>>>> + */
>>>> }
>>>
>>>
>>> You also need a VMState struct registered in dc->vmsd and a reset
>>> function registered in dc->reset.
>>
>>
>> Even if no migration is supported? Is there a simple example I could look at
>> on what should go into these?
>
> The idea is to support migration. There are examples of doing
> VMState structures all over the tree. You just need a structure
> that lists all the bits of your state data structure that
> contain guest-modifiable state.
>
> Reset is straightforward: it's just a function that resets
> the state of the device as if the system had been hard
> powercycled.

I've tried to add these but vmstate is only added to the PCI version 
because the OHCI device I've looked at also does the same, which is likely 
beacuse the sysbus version is only used on SH4 which does not support 
migration anyway. The PCI verison can be instantiated on machines that 
have migration support so it makes sense to do it there. I hope this is 
acceptable.
