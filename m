Received: from eggs.gnu.org ([2001:4830:134:3::10]:51906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ddUbv-0002Cr-QM
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 00:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ddUbu-0006Bv-5t
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 00:53:19 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1ddUbt-00069E-LE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 00:53:18 -0400
Received: by mail-it0-x244.google.com with SMTP id t78so445372ita.1
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 21:53:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170803083956.GD4456@dhcp-200-186.str.redhat.com>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
	<CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
	<f6024bcb-3dcb-609f-c2a7-3d425e738e33@twiddle.net>
	<CAOMFOmVN74ghnqWGyfxHB_LqcSLC8XzRkrk88VXaPh4JRvYRNQ@mail.gmail.com>
	<20170803083956.GD4456@dhcp-200-186.str.redhat.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 3 Aug 2017 21:53:14 -0700
Message-ID: <CAOMFOmWaFAbkSYj3m1AWMN6sjdpGMzugOFtfArPjzDLx495N3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to make ELF headers/symbol sections available
 for multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>

Hi Kevin

Thanks for the information.

So I sounds like we do want multiboot to load all sections regardless
of its segments info. To achieve it we need to read sections headers
and load all section that were not loaded yet.

I have a working implementation here
https://github.com/anatol/qemu/commit/26773cf4f1f30b2d0d3fd89cce024f8e9c5603c5
Tested it with my multiboot OS image. The target iterates over all
sections and prints their names/address. The output result is the same
for QEMU and for VmWare+GRUB.

Let me know if this idea looks good so I can send this patch to qemu maillist.


On Thu, Aug 3, 2017 at 1:39 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 03.08.2017 um 00:00 hat Anatol Pomozov geschrieben:
>> Hello Richard
>>
>> Thank you for this useful information. I still learning about ELF and
>> a lot of things are still unclear for me.
>>
>> On Mon, Jul 31, 2017 at 11:20 AM, Richard Henderson <rth@twiddle.net> wrote:
>> > On 07/31/2017 10:21 AM, Anatol Pomozov wrote:
>> >> ELF sections info is needed for an OS to map address space properly.
>> >
>> > No, ELF *program header* info is needed for an OS to map the address space
>> > properly.  For example:
>> >
>> > $ readelf -hl vmlinux-4.9.0-3-5kc-malta
>>
>> Thanks for this information about program headers. I reread elf_ops.h
>> and now I see that QEMU loads all PT_LOAD segments. I wonder why GRUB
>> bootloader loads also sections that are not in this segment (e.g. GRUB
>> loads content of .shstrtab into target's memory despite my elf does
>> not keep it in PT_LOAD segment).
>
> Remember that what we're talking about isn't primarily an ELF loader,
> but a Multiboot loader. Multiboot can work without ELF (e.g. with flat
> binaries) if bit 16 in the Multiboot header flags is set and the
> additional header fields are correctly provided. However, if you are
> loading an ELF binary, then Multiboot specifies that the bootloader
> makes use of the ELF headers and you don't have to set bit 16 in the
> header.
>
> If ELF says that some things have to be loaded (and bit 16 is clear),
> then the bootloader will load them. If Multiboot says that additional
> things can or have to be loaded, it will load those, too. The section
> headers are only one example of additional data that Multiboot provides.
> It also loads additional modules, provides the e820 memory map, etc.,
> none of which are described by ELF.
>
>> What ELF specification says about it? Does it tell a loader to load
>> only PT_LOAD segments? In this case bootloaders should follow it as
>> well and current QEMU behavior is correct.
>
> The current behaviour of QEMU is correct because it doesn't set bit 5 in
> the flags field of the Multiboot info struct, i.e. it doesn't advertise
> that the section headers are available, so it doesn't have to provide
> it.
>
> It is also not feature complete, because a full Multiboot implementation
> would implement this and advertise bit 5. Adding the feature would be
> useful because there are guest kernels that can make use of it.
>
>> But multiboot expects section headers info and .shstrtab section to be
>> loaded to the target memory. I believe I need to modify my linker
>> script and add this information into the loadable segment.
>
> No. First of all, you don't even need this information to find the start
> and end of the kernel code. Second, if a Multiboot loader loads this, it
> doesn't have to be in a loadable segment. This is more like debug
> information, not like an inherent part of the program.
>
>> Here is my current linker script:
>>
>> ======================
>> ENTRY(start)
>>
>> SECTIONS {
>>     . = 1M;
>>
>>     .text : {
>>         KEEP(*(.data.multiboot))
>>         *(.text .text*)
>>     }
>>
>>     .rodata : {
>>         *(.rodata .rodata*)
>>     }
>>
>>     .data : {
>>         *(.data .data.*)
>>     }
>>
>>     .bss : {
>>         __bss_start = .;
>>         *(.bss .bss*)
>>         . = ALIGN(8);
>>         __bss_end = .;
>>     }
>> }
>> =======================
>>
>> With my linker script only .text .rodata .data and .bss are included
>> into the loadable segment.
>>
>>
>> So my questions: how to tell the linker to include "section headers"
>> and ".shstrtab" section into loadable segment? Once it is done I can
>> try to modify QEMU to pass its addresses to the target.
>
> Requiring section headers to be contained in a loadable segment wouldn't
> be a correct implementation of the Multiboot feature.
>
> Kevin
