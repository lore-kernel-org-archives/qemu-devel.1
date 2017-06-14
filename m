Received: from eggs.gnu.org ([2001:4830:134:3::10]:52242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dKvog-0007GC-Aq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 20:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dKvof-0000cO-2N
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 20:05:46 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dKvoe-0000bs-Ek
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 20:05:44 -0400
Received: by mail-it0-x242.google.com with SMTP id f20so5614267itb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:05:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMFOmX3YXKJ-JkOpiedZZaG4RpgFg+LJhhLTFN+LaS9i17TMg@mail.gmail.com>
References: <20170607044148.10481-1-anatol.pomozov@gmail.com>
	<20170608204116.svjgt323qrbghyku@os.inf.tu-dresden.de>
	<CAOMFOmX3YXKJ-JkOpiedZZaG4RpgFg+LJhhLTFN+LaS9i17TMg@mail.gmail.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Tue, 13 Jun 2017 17:05:41 -0700
Message-ID: <CAOMFOmWsODJzsqhF7mexh=NT_sF7HYs4UuVK41YOBGSYB6o4Sg@mail.gmail.com>
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
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: qemu-devel@nongnu.org

Hi Adam

Do these arguments sound reasonable to apply the patch?

On Thu, Jun 8, 2017 at 2:07 PM, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> +reply-all
>
> On Thu, Jun 8, 2017 at 1:41 PM, Adam Lackorzynski
> <adam@os.inf.tu-dresden.de> wrote:
>>
>> On Tue Jun 06, 2017 at 21:41:48 -0700, Anatol Pomozov wrote:
>>> It is possible to create a 64 bit elf image that has valid multiboot header.
>>> qemu should be able to boot such images.
>>
>> But this 64bit image actually starts with 32bit code, right?
>
> Correct. The very first part of the startup code has to be 32bit.
> After it sets "long mode" it can use 64bit instructions. To make sure
> that the preamble has only 32bit instructions one have to use asm
> directive such as ".code32".
>
> Here is an example from LitleKernel sturtup code:
>
> https://github.com/littlekernel/lk/blob/master/arch/x86/64/start.S#L50
>
> .code32 tells assembler to treat following text as 32 bit code. And
> later when it jumps into "long mode"
>
> https://github.com/littlekernel/lk/blob/master/arch/x86/64/start.S#L214
> one can use 64bit code.
>
>> So it's a 32bit program and the check verifies that this is the case.
>
> While preamble have to contain 32 only instructions the rest of the
> image can perfectly contain 64bit code. Right now 64bit binary cannot
> be run with "qemu-system-x86_64 -kernel". But the same binary runs
> fine if packed with GRUB as iso.
>
> I tried to hack around this restriction by adding
> "OUTPUT_FORMAT(elf32-i386)" to the linker file and compiling project
> with 64bit support. But GNU ld program crashed at Ubuntu 14.04. It
> means not that many people use this code path. GNU ld compiled from
> HEAD does not have this problem but now GDB is confused by the fact
> that ELF contains 64bit code while header reports i386.
>
> Practically there is no reason for this check as it prevents running
> 64bit binaries with "qemu-system-x86_64 -kernel".
