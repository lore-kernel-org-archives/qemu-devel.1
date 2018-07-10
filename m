Received: from eggs.gnu.org ([2001:4830:134:3::10]:44066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcqKA-0004br-Se
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcqKA-0002Ah-1F
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:56:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcqK9-0002Aa-S3
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:56:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id r16-v6so41755682oie.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 03:56:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a7caddb3-038e-a97c-26db-13a7ad05576e@twiddle.net>
References: <20180709155826.18993-1-peter.maydell@linaro.org>
	<c2311584-618a-b880-d42a-637a9333702a@linaro.org>
	<CAFEAcA9g3NCcodB8H3m5MsCL=JD56HO6D-utLyUKvY_Nwv-0Jg@mail.gmail.com>
	<a7caddb3-038e-a97c-26db-13a7ad05576e@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 11:56:28 +0100
Message-ID: <CAFEAcA-H3nQsNXM3be_AZZCZ6ijz9GXq9pNa0TTuU3YKsAAaGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] exec.c: Replace
 memory_region_is_unassigned() with memory_region_is_ram_backed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 9 July 2018 at 18:50, Richard Henderson <rth@twiddle.net> wrote:
> On 07/09/2018 10:33 AM, Peter Maydell wrote:
>>> Well... ok.  We should document that this, surprisingly, does not include
>>> actual ram.  Just things that are ram with caveats.
>>
>> I think it must include actual RAM, or we would not be able to
>> execute from actual RAM ? The only way to get to get_page_addr_code()'s
>> "here's the ram_addr_t for this" exit path is if memory_region_is_unassigned()
>> returns false.
>>
>>>> -    return mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
>>>> -        && mr != &io_mem_watch;
>
> Huh.  I don't follow how this old expression excludes ram,
> and so assumed that must be checked separately earlier.
>
> There's clearly still something here I don't understand.

I dug a bit deeper, and the reason why this works is that the MR
it's operating on is not an arbitrary MR for this chunk of the
address space. It's the section->mr for the section returned by
iotlb_to_section() for the iotlbentry value. That value is set
up by memory_region_section_get_iotlb(), which picks either
PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM for any MR that is
RAM (by the memory_region_is_ram() definition). So then the
iotlb_to_section() call will return one of the dummy sections
and its section->mr will be either io_mem_rom or io_mem_notdirty,
not the original MR.

The other thing I've noticed is that after my in-progress
patches to handle execution from MMIO regions, the code that
calls memory_region_is_unassigned() is just

    iotlbentry = &env->iotlb[mmu_idx][index];
    section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
    mr = section->mr;
    if (memory_region_is_unassigned(mr)) {
       ...

and there is no other use of 'mr', so perhaps it would be
better to have a function that takes a MemoryRegionSection
rather than a MemoryRegion that must be the one we got from
section->mr...

thanks
-- PMM
