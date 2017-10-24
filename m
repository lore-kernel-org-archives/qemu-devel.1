Received: from eggs.gnu.org ([2001:4830:134:3::10]:56018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6x1o-0006rb-0p
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6x1m-000144-58
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:05:48 -0400
Date: Tue, 24 Oct 2017 13:05:32 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1710241246330.82180@zero.eik.bme.hu>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bzt bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, 24 Oct 2017, bzt bzt wrote:
> On Mon, Oct 23, 2017 at 6:34 PM, Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
>>> +/* According to
>>> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2837/
>>> README.md
>>> + * The underlying architecture of the BCM2837 is identical to the
>> BCM2836.
>>> The only significant
>>> + * difference is the replacement of the ARMv7 quad core cluster with a
>>> quad-core ARM Cortex A53
>>> + * (ARMv8) cluster. So we use cortex-a53- here. */
>>
>> Are there any changes from bcm2836 other than the CPU model?
>
>
>> Duplicating the whole file just to have a different CPU seems like a bad
>> idea to me. I would suggest parameterising the CPU model in bcm2836 (and
>> maybe noting in header comments etc. that it can also model 2837), and then
>> instantiating it from raspi.c with the correct CPU type depending on which
>> machine is being used. That will also reduce the size of the patch
>> significantly, which will make it easier to get it reviewed.
>>
>
> For now, there's no more difference in the emulation than the CPU, but
> BCM2837 has a lot more to offer (40 bit address space, wifi, bluetooth
> etc.). So sooner or later it will need it's own source file to support all
> of that without getting the code messy. I have asked Peter whether it does
> worth writing future proof code, or keep the change at the bare minimum,
> but had no answer yet.
>
>
>>
>> (Alternatively, if there are minor but non-trivial differences between
>> 2836 and 2837 other than the CPU model, you may want to create something
>> like bcm2835_peripherals that contains all the functionality common to
>> both. But I suspect that isn't the case here.)
>>
>
> Well, bcm2837 is backward compatible with the bcm2836, but has a lot more
> registers and a different boot up process (different address and no atags).
> The common functionality is already in bcm2835_peripherals, and the MMIO
> address change from bcm2835 to bcm2836 has already been added by you.
> What's different is a lot more devices, which imho would be unwise to add
> to bcm2835 or either to bcm2836. So to be future proof I've created a
> separated file, but you are right at the current level of emulation it's
> not necessary.
[...]
>> Similarly, this looks like a clone of raspi2_init. I think it would be
>> better to have one function, parametrised if needed.
>>
>
> For now, yes. But the extra devices bcm2837 have will need extra
> initialization, and I though it would be clearer to separate in advance.
> Again, I've asked Peter about this, but had no response. As I see having a
> parametrised single function is simplier for now, but could lead to a messy
> code later when all the SoC features will be added. But I'm ain't no expert
> on qemu source, this is my first patch, so I'm open to suggestions! :-)
>
> Summa summarum, which one is preferred? Think of the future or keep it at a
> bare minimum?

I don't feel I have a deciding word in this but to share my opinion I 
think it's better to keep it in one file avoiding too much code 
duplication as long as those features that would make the implementations 
different aren't added now. Then when those features are added the files 
could be split or the best way can be decided at that point based on how 
those features will be implemented so no need to think that far ahead now. 
This would make patches easier to review now and maintaining the common 
code easier until they are different enough so a split needs to be done.

Regrads,
BALATON Zoltan
