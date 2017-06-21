Received: from eggs.gnu.org ([2001:4830:134:3::10]:36055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dNmV3-0003EF-1f
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 16:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dNmV1-0001Ow-PF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 16:45:17 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dNmV1-0001Oc-Je
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 16:45:15 -0400
Received: by mail-io0-x244.google.com with SMTP id h134so1928433iof.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 13:45:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619210807.ejwk5zfe2f4g5znw@os.inf.tu-dresden.de>
References: <20170607044148.10481-1-anatol.pomozov@gmail.com>
	<20170608204116.svjgt323qrbghyku@os.inf.tu-dresden.de>
	<CAOMFOmX3YXKJ-JkOpiedZZaG4RpgFg+LJhhLTFN+LaS9i17TMg@mail.gmail.com>
	<CAOMFOmWsODJzsqhF7mexh=NT_sF7HYs4UuVK41YOBGSYB6o4Sg@mail.gmail.com>
	<20170619210807.ejwk5zfe2f4g5znw@os.inf.tu-dresden.de>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Wed, 21 Jun 2017 13:45:11 -0700
Message-ID: <CAOMFOmXQDUd0m0uFxVOWQP35dfkvurbj7YRuDT_=0Xubib0PBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Remove restriction that prevents bootimg
 elf64 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: Goswin von Brederlow <goswin-v-b@web.de>

Hi Adam, thank you for your reply.

On Mon, Jun 19, 2017 at 2:08 PM, Adam Lackorzynski
<adam@os.inf.tu-dresden.de> wrote:
> Hi,
>
> On Tue Jun 13, 2017 at 17:05:41 -0700, Anatol Pomozov wrote:
>> Do these arguments sound reasonable to apply the patch?
>
> I'm not really convinced.
>
>> On Thu, Jun 8, 2017 at 2:07 PM, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
>> > +reply-all
>> >
>> > On Thu, Jun 8, 2017 at 1:41 PM, Adam Lackorzynski
>> > <adam@os.inf.tu-dresden.de> wrote:
>> >>
>> >> On Tue Jun 06, 2017 at 21:41:48 -0700, Anatol Pomozov wrote:
>> >>> It is possible to create a 64 bit elf image that has valid multiboot header.
>> >>> qemu should be able to boot such images.
>> >>
>> >> But this 64bit image actually starts with 32bit code, right?
>> >
>> > Correct. The very first part of the startup code has to be 32bit.
>> > After it sets "long mode" it can use 64bit instructions. To make sure
>> > that the preamble has only 32bit instructions one have to use asm
>> > directive such as ".code32".
>> >
>> > Here is an example from LitleKernel sturtup code:
>> >
>> > https://github.com/littlekernel/lk/blob/master/arch/x86/64/start.S#L50
>> >
>> > .code32 tells assembler to treat following text as 32 bit code. And
>> > later when it jumps into "long mode"
>> >
>> > https://github.com/littlekernel/lk/blob/master/arch/x86/64/start.S#L214
>> > one can use 64bit code.
>> >
>> >> So it's a 32bit program and the check verifies that this is the case.
>> >
>> > While preamble have to contain 32 only instructions the rest of the
>> > image can perfectly contain 64bit code. Right now 64bit binary cannot
>> > be run with "qemu-system-x86_64 -kernel". But the same binary runs
>> > fine if packed with GRUB as iso.
>> >
>> > I tried to hack around this restriction by adding
>> > "OUTPUT_FORMAT(elf32-i386)" to the linker file and compiling project
>> > with 64bit support. But GNU ld program crashed at Ubuntu 14.04. It
>> > means not that many people use this code path. GNU ld compiled from
>> > HEAD does not have this problem but now GDB is confused by the fact
>> > that ELF contains 64bit code while header reports i386.
>
> That's unfortunate.
>
>> > Practically there is no reason for this check as it prevents running
>> > 64bit binaries with "qemu-system-x86_64 -kernel".
>
> One reason for the check is that it prevents that one loads a 64bit ELF
> binary that then fails strangely because it does not have the magic
> 32bit code to set up things.

I would not call the 32bit preamble a magic - it is fairly well
documented; it is just a result of backward compatibility that
AMD/Intel carry for a long time. Every single 64-bit operation system
(Linux, Windows, FreeBSD, ...) has such 32bit init sequence.

And while I understand your concerns about bugs in 64-bit mode
initialization I do not think that preventing elf64 images altogether
is a right fix for it. Loading 64bit OS with multiboot is a totally
valid use-case, you can find plenty of examples/OS that show how to do
it. Adding the restriction is just another hoop that users need to
jump over.

It is a good idea to check how other multiboot-compliant bootloaders
deal with such situation. GRUB has the best support for multiboot and
it works great both with elf64 bit images. You can see its code here
http://git.savannah.gnu.org/cgit/grub.git/tree/grub-core/loader/multiboot.c#n208

/* Load ELF32 or ELF64.  */
grub_err_t
grub_multiboot_load_elf (mbi_load_data_t *mld)
{
  if (grub_multiboot_is_elf32 (mld->buffer))
    return grub_multiboot_load_elf32 (mld);
  else if (grub_multiboot_is_elf64 (mld->buffer))
    return grub_multiboot_load_elf64 (mld);

  return grub_error (GRUB_ERR_UNKNOWN_OS, N_("invalid arch-dependent
ELF magic"));
}


I tried my elf64 OS in following configuration:
  Qemu + GRUB = works
  VMWare + GRUB = works
  GRUB at bare hardware = works

Qemu with -kernel loading elf64 directly - works flawlessly if the
patch above applied.

So currently QEMU breaks compatibility with GRUB. elf64 images boot
fine with GRUB while fail to boot with QEMU.

> At least there needs to be an override
> (could also be in the ELF info).
>
> Doing a proper 32bit wrapper is also possible, although that would need
> a little ELF loader, or a custom loader, probably. We've done it this
> way but that also requires some more lines.

No need for a wrapper. Current QEMU code works fine with elf64. I did
not spot any problems so far.


BTW I saw an argument in qemu maillist saying elf64 is not possible to
use in multiboot as there is no way to link 32bit code with 64bit
code. And while linkers do not allow it explicitly there are some
tricks that allow to merge two different architectures into one
binary. The easiest way is to use ".code32" directive in asm and
compile it with x86_64 architecture. "objcopy" is also possible to
use. Linux has its own simple linker to handle this situation
https://github.com/torvalds/linux/blob/master/arch/x86/boot/tools/build.c

> If allowing 64bit binaries it should also be checked that all relevant
> values fit into 32bit.

Agree that additional checks are useful. One thing that comes to my
mind is that elf entry addresses should be below 4GiB to fit the
multiboot field.
