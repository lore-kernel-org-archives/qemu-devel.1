Received: from eggs.gnu.org ([2001:4830:134:3::10]:47887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebbHW-00006u-Ge
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 19:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebbHV-0003ca-2Y
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 19:08:42 -0500
MIME-Version: 1.0
In-Reply-To: <8b247357a2e52d16d287db87b5d0957a@tribudubois.net>
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<548464fa8211307b397a5f50122abd3d@tribudubois.net>
	<ea0e6a65-fd7b-e62b-8aa0-2531bbcbf49f@adacore.com>
	<04ce75e9cdb6e001830c720196208e7f@tribudubois.net>
	<44e1abb6-88e7-95a0-ff27-fed969eb3a9c@adacore.com>
	<fb38cb0996586b500ef8b75877d16e7e@tribudubois.net>
	<8b247357a2e52d16d287db87b5d0957a@tribudubois.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jan 2018 16:08:05 -0800
Message-ID: <CAKmqyKMDvE4+MqwvEj2-KMFrLtJkKkUZ6A2eTyFUSqWeQJksjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: Fabien Chouteau <chouteau@adacore.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Qemu-devel <qemu-devel-bounces+jcd=tribudubois.net@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 15, 2018 at 9:27 AM, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
> Le 2018-01-15 14:45, Jean-Christophe Dubois a =C3=A9crit :
>>
>> Le 2018-01-15 12:09, Fabien Chouteau a =C3=A9crit :
>>>
>>> On 12/01/2018 15:10, Jean-Christophe Dubois wrote:
>>>>
>>>> Le 2018-01-12 11:55, Fabien Chouteau a =C3=A9crit :
>>>>>
>>>>> On 11/01/2018 13:35, Jean-Christophe Dubois wrote:
>>>>>>
>>>>>> Thanks Fabien,
>>>>>>
>>>>>> Now, as a side question, could you tell me which reference LEON3
>>>>>> platform is implemented by Qemu in leon3_generic?
>>>>>>
>>>>>
>>>>> I think it was the based on the FPGA version of Leon3 I was using at
>>>>> the
>>>>> time. The name leon3_generic comes from my will to make it a
>>>>> configurable board where users could define the number and the locati=
on
>>>>> of the different peripherals, I never had time to work on this.
>>>>
>>>>
>>>> I see. I am not sure how to bring configurability to Qemu. There is th=
e
>>>> possibility to describe the hw PTF with DTC/DTB or something similar. =
I
>>>> think some people were working on it for the ARM Qemu platform (but I =
am not
>>>> sure what happened to this initiative).
>>>>
>>>> Now in the meantime, would it make sense to move leon3_generic to a ts=
im
>>>> compatible platform?
>>>>
>>>
>>> I don't think so, leon3_generic is compatible with a real hardware whic=
h
>>> is also interesting for comparison.
>>
>>
>> What real hardware (gaisler reference platform) is it? Could you point
>> to the public reference manual for this hardware?
>>
>> Another possibility is to add a leon3_tsim platform into Qemu to
>> support the compatibility with the tsim emulator. But the difference
>> with leon3_generic would be minimal.
>>
>>>
>>>> This would allow to validate the same software on the 2 simulators
>>>> (obviously it would not be compatible with your specific FPGA version =
for
>>>> now).
>>>>
>>>
>>> The Leon3 AMBA bus provides a way to discover the peripherals and their
>>> address, so any system should be capable of supporting different
>>> peripheral layouts.
>>>
>>> Here's an example of AMBA discovery code from a very old project of min=
e
>>> (don't judge me on this :) :
>>> https://github.com/Fabien-Chouteau/kabitbol/blob/master/src/amba.c
>>>
>>> There was a couple of patches submitted some times ago to add Leon3 AMB=
A
>>> support in QEMU, I think it's time to bring them back...
>>
>>
>> What you are talking about here is the possibility for the software
>> running inside Qemu to probe/discover the hardware. For such feature
>> Qemu should implement what is required for this AMBA discovery. But it
>> does not solve how you decide at run time at what addresses are the
>> various AMBA devices (how you decide to emulate a tsim platform or
>> another one).
>>
>> Note: For now I am not so much interested in the AMBA discovery as the
>> type of software platform I am thinking about is embedded where the
>> hardware is well known ahead of time. This discovery capability would
>> make sense for more generic OS like linux or such. We cannot require
>> all embedded OS to implement the AMBA discovery process.
>
>
> For the configurability of Qemu, I was thinking of using something simila=
r
> to the Qemu provided by Xilinx (http://www.wiki.xilinx.com/QEMU). Basical=
ly,
> you provide a DTB file as a Qemu command line argument and Qemu will buil=
d
> the various devices (including addresses and interrupts) based on the
> content of this file. Then when running an OS, it can provide the DTB fil=
e
> (for example to Linux) that match exactly the emulated platform.
>
> This should allow to build "any" variation of the platform and to add
> devices as you need them. This makes sense for Xilinx (their customer are
> building custom platforms) and it would also make sense for LEON as the C=
PU
> core is usually integrated inside a custom SOC/FPGA.

This is a cool solution and works pretty well for us, but it requires
very complex code and is not easy to debug or maintain, just something
to keep in mind.

We also have a lot of trouble working with Linux device trees. For our
more complex ZynqMP SoC we have our own non-standard device trees as
the Linux ones don't include enough information.

Alistair

>
> JC
>
