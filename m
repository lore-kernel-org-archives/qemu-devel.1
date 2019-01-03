Received: from eggs.gnu.org ([208.118.235.92]:55204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gfByx-0005Ze-EC
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gfByw-0002xZ-FP
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:00:55 -0500
References: <975b9131-9937-cfea-3b5d-ef36d0c2b761@gmail.com>
	<CAFEAcA-2tWtEqd-Z0xqNMeocf4rns+FihrAPudiQGz+85HFjJg@mail.gmail.com>
	<7b61db39-7059-6286-2282-b90f45a85faf@gmail.com>
	<CAFEAcA9HkBC4M8vNsHd9M0YrAEYPb=3vd9jj8zkPruMKrtP=mA@mail.gmail.com>
From: Nick Hudson <nicholas.a.hudson@gmail.com>
Message-ID: <b8242fec-0ad1-fcb8-0b99-264f8600a965@gmail.com>
Date: Thu, 3 Jan 2019 23:00:45 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HkBC4M8vNsHd9M0YrAEYPb=3vd9jj8zkPruMKrtP=mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>



On 03/01/2019 17:27, Peter Maydell wrote:
> On Thu, 3 Jan 2019 at 16:50, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
>> On 03/01/2019 16:20, Peter Maydell wrote:
>>> On Tue, 11 Dec 2018 at 12:27, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
>>>> --- a/hw/arm/boot.c
>>>> +++ b/hw/arm/boot.c
>>>> @@ -30,8 +30,9 @@
>>>>      * Documentation/arm/Booting and Documentation/arm64/booting.txt
>>>>      * They have different preferred image load offsets from system RAM base.
>>>>      */
>>>> -#define KERNEL_ARGS_ADDR 0x100
>>>> -#define KERNEL_LOAD_ADDR 0x00010000
>>>> +#define KERNEL_ARGS_ADDR   0x100
>>>> +#define KERNEL_NOLOAD_ADDR 0x00000000
>>>
>>> If I'm reading the code right, this requests that noload images
>>> are loaded at offset zero into RAM, yes ?
>>
>> Not quite.
>>
>> They're loaded as if the full noload image (including uboot header)
>> was loaded at offset zero, but as load_uboot_image doesn't load the
>> header then the image body (minus the header) is loaded at offset
>> zero + the size of the u-boot header, i.e. 0x40.
>>
>>> That's not a great
>>> choice, because we put our little mini bootloader at offset 0,
>>> and so the two will clash.
>>
>> Fortuntately, the bootloader fits in the space that the uboot header would
>> have occupied.
>>
>> My commit message has
>>
>> "The bootloader fits in the space that the uboot header would have occupied."
>>
>> to try and described this. I could add more of a description if required?
> 
> Ah, I missed that. This seems very fragile to me -- 0x40
> is only 64 bytes, which is 16 instructions. Currently
> our boot loader code is less than that, but only by four
> insns or so, so it's very plausible that some future
> enhancement to the loader code would take it over the 0x40
> boundary, at which point handling of noload images will
> silently fail. At a minimum we should have an assertion
> that we stay below 0x40; but I'm not keen on restricting
> ourselves to 16-instruction bootloaders.

I can add an assertion.

Kernels often like to be 2MiB aligned to allow for more simple
translation tables. This and the fact that  the bootloader hasn't 
changed in 3 years I'd like to kick this can down the road.

> 
> Will a noload image ever in practice also be a Linux kernel
> (ie hdr->ih_os == IH_OS_LINUX) ?

NetBSD/FreeBSD/OpenBSD (ab)use IH_OS_LINUX.  They and Linux

> If not, then we don't lose
> anything by not allowing those to be loaded. (And if anybody
> does in future complain that their image doesn't work, we
> could make it supported by allowing the mini-bootloader to
> be placed elsewhere in RAM.)



> 
> thanks
> -- PMM
> 

thanks,
Nick
