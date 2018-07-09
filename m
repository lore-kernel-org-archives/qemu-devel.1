Received: from eggs.gnu.org ([2001:4830:134:3::10]:44502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fca2v-0000nS-9n
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fca2u-0002vz-CK
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:33:57 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fca2u-0002vq-7A
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:33:56 -0400
Received: by mail-oi0-x242.google.com with SMTP id s198-v6so37372533oih.11
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 10:33:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c2311584-618a-b880-d42a-637a9333702a@linaro.org>
References: <20180709155826.18993-1-peter.maydell@linaro.org>
	<c2311584-618a-b880-d42a-637a9333702a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 18:33:35 +0100
Message-ID: <CAFEAcA9g3NCcodB8H3m5MsCL=JD56HO6D-utLyUKvY_Nwv-0Jg@mail.gmail.com>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 9 July 2018 at 18:23, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 07/09/2018 08:58 AM, Peter Maydell wrote:
>> The function memory_region_is_unassigned() is rather misnamed, because
>> what it is actually testing is whether the memory region is backed
>> by host RAM, and so whether get_page_addr_code() can find a ram_addr_t
>> corresponding to the guest address.
>>
>> Replace it with memory_region_is_ram_backed(), which has a name
>> better matching its actual semantics.  (We invert the sense of the
>> return value to avoid having a _not_ in the function name.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> The difference between this and memory_region_is_ram() is pretty
>> subtle, to the extent I'm not completely sure exactly what it is;
>> io_mem_notdirty and io_mem_watch at least won't be considered as
>> "ram" by memory_region_is_ram(), though.
>
> Yeah, I'm not quite sure why io_mem_rom and io_mem_notdirty at least do not
> have the rom_device bit set.
>
> I suppose io_mem_watch is even more special in that it also wants to trap read
> operations.  And do we really want to trap execute operations in that?  Surely
> that's what actual breakpoints are for.  Of course, that would probably mean
> special casing the special case.
>
>> -bool memory_region_is_unassigned(MemoryRegion *mr)
>> +bool memory_region_is_ram_backed(MemoryRegion *mr)
>
> Well... ok.  We should document that this, surprisingly, does not include
> actual ram.  Just things that are ram with caveats.

I think it must include actual RAM, or we would not be able to
execute from actual RAM ? The only way to get to get_page_addr_code()'s
"here's the ram_addr_t for this" exit path is if memory_region_is_unassigned()
returns false.

>> -    return mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
>> -        && mr != &io_mem_watch;
>> +    return !(mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
>> +             && mr != &io_mem_watch);
>
> This is annoyingly convoluted.  I would prefer to push
> the not through the expression:
>
>   return (mr->rom_device || mr == &io_mem_rom
>           || mr == &io_mem_notdirty || mr == &io_mem_watch);

Yeah, I was optimizing for "easy to review as not changing behaviour
except for flipping the sense of the return value", rather than
"resulting code is most simple".

thanks
-- PMM
