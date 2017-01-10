Received: from eggs.gnu.org ([2001:4830:134:3::10]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQsxE-0004GS-Gs
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQsxD-0005V1-GU
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:42:56 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:34815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQsxD-0005Un-7z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:42:55 -0500
Received: by mail-ua0-x230.google.com with SMTP id 35so48993620uak.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 01:42:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKM74PWeQZZcM_TKwdCfvOz+RAWa3Y2V7favwCiPT0U4rw@mail.gmail.com>
References: <cover.1482265908.git.alistair.francis@xilinx.com>
	<b985247bfcb7375de984e801c4145fde931360bb.1482265908.git.alistair.francis@xilinx.com>
	<CAFEAcA88=_J3==CJ3fy+jurM9APvRErYFhopuz-bJeML5mPSvw@mail.gmail.com>
	<CAKmqyKM74PWeQZZcM_TKwdCfvOz+RAWa3Y2V7favwCiPT0U4rw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 09:42:33 +0000
Message-ID: <CAFEAcA8FFHuHTWZ6xteWN+s34g62=W7ukqhCotBKi9shuYt0nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/3] arm_generic_timer: Add the ARM
 Generic Timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>

On 10 January 2017 at 01:41, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Fri, Jan 6, 2017 at 3:57 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 20 December 2016 at 22:42, Alistair Francis
>> <alistair.francis@xilinx.com> wrote:

>>> +    },{ .name = "CNTCV_LOWER",
>>> +        .addr = A_CNTCV_LOWER,
>>> +        .post_read = counter_low_value_postr,
>>> +    },{ .name = "CNTCV_UPPER",
>>> +        .addr = A_CNTCV_UPPER,
>>> +        .post_read = counter_high_value_postr,
>>
>> Spec says that you should also be able to access the whole
>> 64-bit counter value with a 64-bit access -- is this reginfo
>> sufficient to make that work?
>
> How do you know, all I see if that it is a 64-bit register. All the
> documentation about accesses specifies only 32-bit accesses.

v8 ARM ARM DDI0487A.k, I3.5.3 (CNTCV register description):
"In an implementation that supports 64-bit atomic memory accesses,
this register must be accessible using a 64-bit atomic access."


>> This means you can't use this device in a system which
>> doesn't implement TrustZone. I think this would be better
>> handled by just having the board map the memory region
>> in to only the Secure address space if it is a TZ-aware board.
>
> How can I map something into the secure address space? Is there an
> example of this? The only think I can find is in the arm/virt.c
> machine with the secure_sysmem MemoryRegion.

Yeah, virt.c is the place to look -- for instance we put one
of the UARTs in the secure address space only.
Basically to support separate address spaces:
 * create a MemoryRegion to be the secure view of the world
 * add the NS MemoryRegion to it as a subregion with low
   priority (so S sees all the NS devices -- this isn't
   required but that's usually how h/w is set up)
 * use object_property_set_link() to connect the S memory
   region to each CPU's secure-memory property
 * add any S-only devices to the S MemoryRegion

>>> +REG32(CNTCR, 0x00)
>>> +    FIELD(CNTCR, EN, 0, 1)
>>> +    FIELD(CNTCR, HDBG, 1, 1)
>>> +REG32(CNTSR, 0x04)
>>> +    FIELD(CNTSR, DBGH, 1, 1)
>>> +REG32(CNTCV_LOWER, 0x08)
>>> +REG32(CNTCV_UPPER, 0x0C)
>>> +REG32(CNTFID0, 0x20)
>>> +/* We don't model CNTFIDn */
>>> +/* We don't model the CounterID registers either */
>>
>> Does the Xilinx h/w not implement them at all?
>> (ie do we need a property for "device has the ID regs" if we add them
>> later?)
>
> There is nothing in the register spec describing registers being here.
>
> The last register I see is called: (IOU_SCNTRS)
> base_frequency_ID_register at address 0xFF260020.

I suspect there's an implicit reads-as-zero after that.
(The frequency table has to have at least one real entry
plus the zero terminator -- see I3.5.5 (CNTFID0).)

QEMU's implementation will only support one frequency so
we only need one table entry too (for the moment, anyway).

>> The spec says it's mandatory to have at least the entry for
>> the counter base frequency plus end-of-table marker.
>> I would expect EL3 firmware to want to read this table in order
>> to write the correct values to CNTFRQ_EL0 for each CPU.
>
> I don't see anything like that in section I3.5.21 in the ARM ARM,
> where are you looking?

There's no I3.5.21 in my copy of the spec (rev A.k), I suspect
you have an older rev. I think the generic timer docs got
revamped at some point, so you might want to grab the latest rev.

Anyway, it looks like you have got CNTFIDn (that's CNTFID0)
and an implicit undocumented zero-terminator.

The spec says CounterIDn are IMPDEF, which I guess is why
your implementation doesn't bother to implement them.

thanks
-- PMM
