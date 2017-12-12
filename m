Received: from eggs.gnu.org ([2001:4830:134:3::10]:60305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1eOl39-0007pz-DV
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1eOl38-00006I-2x
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:56:47 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1eOl37-00005q-Sq
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:56:46 -0500
Received: by mail-it0-x241.google.com with SMTP id f143so24470612itb.0
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 05:56:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d776710c-2255-947b-22c6-336e9491bb81@redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
	<6b4b6351-eeb4-a4d3-8ddf-5401516671ae@redhat.com>
	<CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
	<5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
	<CAFEAcA_+NnpeP9Le7bp9yrYQDwtuP79pt8GpVzJ4RBDMx1iomA@mail.gmail.com>
	<09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
	<CAFEAcA-357eVt3s_7ULWxssQttvAV0DkUv_tGkyk8umVgfH1QA@mail.gmail.com>
	<d776710c-2255-947b-22c6-336e9491bb81@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 12 Dec 2017 13:56:44 +0000
Message-ID: <CAKv+Gu9e6qwJ4=t=UHHGsVs1XM26agh17Mgy0ckAvUsy+2xi2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 12 December 2017 at 13:28, Laszlo Ersek <lersek@redhat.com> wrote:
> On 12/12/17 13:47, Peter Maydell wrote:
>> On 12 December 2017 at 12:41, Laszlo Ersek <lersek@redhat.com> wrote:
>>> I agree. There's one user-visible complication: while with one UART,
>>> it's not possible to mix things up, with two UARTs, users will
>>> inevitably want to assign inverse roles to them, relative to what QEMU /
>>> the firmware assigns originally.
>>>
>>> E.g. if one PL011 is redirected to a regular file (debug messages) and
>>> the other one to stdio (console), there will be complaints that "I
>>> wanted it the other way around". The redirection happens on the backend
>>> (chardev) level, but the firmware won't see the difference on the
>>> frontend (PL011) level.
>>>
>>> Is it possible to add a new property to the UART nodes in the DTB, like
>>> "purpose"?
>>
>> This is what the "chosen" stdout-path node in the DTB is for,
>> but you said you didn't want to look at that :-) (it means
>> "device to be used for boot console output".)
>
> :(
>
> Ard is right that we really shouldn't do that kind of parsing magic in
> very early UEFI stuff.
>
>
>>> Or can we make a virt-arm policy that "first -serial is always ...,
>>> second -serial is always ..."?
>>
>> Well, the first -serial will always be the 0x09000000 one
>> that we have today, and the second -serial will be the other
>> one (unless you have -machine secure=yes, in which case
>> second -serial is the secure-only UART and third -serial is
>> the second NS UART).
>>
>> Is this any different to the x86 case, where there are two
>> UARTs at different IO port/IRQ locations?
>
> OVMF (x86) uses two distinct devices for the two purposes discussed.
>
> * It uses the "debug console device" for debug message output, at
> hard-coded IO port 0x402; so if you'd like to capture those messages,
> then you have to add:
>
>   -chardev file,id=debugfile,path=debug.log \
>   -device isa-debugcon,iobase=0x402,chardev=debugfile \
>
> (or the more traditional
>
>   -debugcon file:debug.log \
>   -global isa-debugcon.iobase=0x402 \
> )
>
> * For console I/O, it uses the first serial port. (I think I have once
> investigated what it takes to use other serial ports for console I/O --
> I'm no longer sure if "it happens to be impossible in OVMF", or just
> "nobody ever does that".)
>
>
> The important distinction (on the UEFI level anyway) is that the debug
> messages need to go to a super dumb device, while console I/O can use a
> much higher-level serial IO abstraction ("protocol").
>
>
>> I think the only thing users really expect is that if you're
>> using just the one serial port for anything then it's the
>> first one.
>
> You are right -- we've never had two (non-secure) UARTs on virt-arm, so
> we can invent whatever assignment, as long as:
>
> - the single UART case doesn't break (keeps receiving both debug output
> and console IO),
>
> - whatever we invent for the two UARTs case now, it remains consistent
> over time. I think this implies we can rely on the FDT node ordering in
> the firmware (if we want to use the 2nd UART at all, that is), and then
> QEMU shouldn't change the serial_hds[] <-> FDT node mapping in the
> future, in machvirt_init() and the callees thereof.
>

Given that the DEBUG output is only produced on DEBUG builds, couldn't
we simply stipulate that DEBUG output appears on the PL011 with the
lowest physical address? That keeps the current status quo, and is
probably sufficient for 99% of the use cases of people using the DEBUG
builds.

Then, we can introduce some code to decode stdout-path in FdtClientDxe
(a higher level DT parsing driver) so that the actual serial console
gets installed onto whichever UART is described as the system console.
Also, given that ArmVirtQemu is tightly coupled to QEMU/mach-virt, we
could decide to only use node names in stdout-path (as we do
currently) to simplify the parsing logic.
