Received: from eggs.gnu.org ([2001:4830:134:3::10]:53922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dd1gz-0004uq-TQ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dd1gy-0005qJ-JH
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:00:37 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:33669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dd1gy-0005ox-CR
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:00:36 -0400
Received: by mail-it0-x242.google.com with SMTP id m34so61804iti.0
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 15:00:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f6024bcb-3dcb-609f-c2a7-3d425e738e33@twiddle.net>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
	<CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
	<f6024bcb-3dcb-609f-c2a7-3d425e738e33@twiddle.net>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Wed, 2 Aug 2017 15:00:33 -0700
Message-ID: <CAOMFOmVN74ghnqWGyfxHB_LqcSLC8XzRkrk88VXaPh4JRvYRNQ@mail.gmail.com>
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
To: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>

Hello Richard

Thank you for this useful information. I still learning about ELF and
a lot of things are still unclear for me.

On Mon, Jul 31, 2017 at 11:20 AM, Richard Henderson <rth@twiddle.net> wrote:
> On 07/31/2017 10:21 AM, Anatol Pomozov wrote:
>> ELF sections info is needed for an OS to map address space properly.
>
> No, ELF *program header* info is needed for an OS to map the address space
> properly.  For example:
>
> $ readelf -hl vmlinux-4.9.0-3-5kc-malta

Thanks for this information about program headers. I reread elf_ops.h
and now I see that QEMU loads all PT_LOAD segments. I wonder why GRUB
bootloader loads also sections that are not in this segment (e.g. GRUB
loads content of .shstrtab into target's memory despite my elf does
not keep it in PT_LOAD segment).

What ELF specification says about it? Does it tell a loader to load
only PT_LOAD segments? In this case bootloaders should follow it as
well and current QEMU behavior is correct.

But multiboot expects section headers info and .shstrtab section to be
loaded to the target memory. I believe I need to modify my linker
script and add this information into the loadable segment.

Here is my current linker script:

======================
ENTRY(start)

SECTIONS {
    . = 1M;

    .text : {
        KEEP(*(.data.multiboot))
        *(.text .text*)
    }

    .rodata : {
        *(.rodata .rodata*)
    }

    .data : {
        *(.data .data.*)
    }

    .bss : {
        __bss_start = .;
        *(.bss .bss*)
        . = ALIGN(8);
        __bss_end = .;
    }
}
=======================

With my linker script only .text .rodata .data and .bss are included
into the loadable segment.


So my questions: how to tell the linker to include "section headers"
and ".shstrtab" section into loadable segment? Once it is done I can
try to modify QEMU to pass its addresses to the target.

>
> Using a mips kernel binary I happend to have handy; it would be the same for
> x86_64, prior to being bundled in the (imo superfluous bzImage) format.
>
> ELF Header:
>   Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF64
>   Data:                              2's complement, little endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              EXEC (Executable file)
>   Machine:                           MIPS R3000
>   Version:                           0x1
>   Entry point address:               0xffffffff806ed590
>   Start of program headers:          64 (bytes into file)
>   Start of section headers:          13351328 (bytes into file)
>   Flags:                             0x80000001, noreorder, mips64r2
>   Size of this header:               64 (bytes)
>   Size of program headers:           56 (bytes)
>   Number of program headers:         2
>   Size of section headers:           64 (bytes)
>   Number of section headers:         28
>   Section header string table index: 27
>
> The ELF file header, always at file offset 0.  The relevant info is the
> encoding (64-bit little-endian), cpu (mips), and start of program headers.
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000001000 0xffffffff80100000 0xffffffff80100000
>                  0x00000000009fefb4 0x0000000000a5a150  RWE    1000
>   NOTE           0x00000000005fecb0 0xffffffff806fdcb0 0xffffffff806fdcb0
>                  0x0000000000000024 0x0000000000000024  R      4
>
> The ELF program header.  There is one segment to be loaded, at a given physical
> address (which happens to match the virtual address, but that need not have
> been so).
>
> The segment consists of 0x9fefb4 bytes of data to be loaded from the file, and
> occupies 0xa5a150 in memory.  The difference between the two sizes is "bss",
> and should be zeroed.
>
> A proper ELF loader will process *all* LOAD segments, however many are required
> by the binary.  Though in practice there will probably only be 1 or 2.
>
> Section to Segment mapping:
>   Segment Sections...
>   00     .text __ex_table __dbe_table .notes .rodata .pci_fixup __ksymtab
> __ksymtab_gpl __kcrctab __kcrctab_gpl __ksymtab_strings __param __modver .data
> .data..page_aligned .init.text .init.data .exit.text .data.reloc .sbss .bss
>   01     __dbe_table .notes
>
> This mapping is provided by readelf for convenience, not actually present in
> the ELF file.  But it is handy when debugging a linker script.
>
>> Quoting Multiboot specification
>> https://www.gnu.org/software/grub/manual/multiboot/multiboot.html
>
> I'm not sure why someone felt the need to re-invent the wheel, especially
> considering its introduction section talks about trying to stop reinventing the
> wheel...
>
> But... whatever.  I'm not sure why this is relevant to $SUBJECT, since it does
> not appear to have anything to do with ELF at all.
>
>
> r~
