Received: from eggs.gnu.org ([2001:4830:134:3::10]:52161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adam@os.inf.tu-dresden.de>) id 1dN3uH-0003Ir-76
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adam@os.inf.tu-dresden.de>) id 1dN3uD-0006ur-62
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:08:21 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:55661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <adam@os.inf.tu-dresden.de>)
	id 1dN3uC-0006ra-UL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:08:17 -0400
Date: Mon, 19 Jun 2017 23:08:07 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Message-ID: <20170619210807.ejwk5zfe2f4g5znw@os.inf.tu-dresden.de>
References: <20170607044148.10481-1-anatol.pomozov@gmail.com>
	<20170608204116.svjgt323qrbghyku@os.inf.tu-dresden.de>
	<CAOMFOmX3YXKJ-JkOpiedZZaG4RpgFg+LJhhLTFN+LaS9i17TMg@mail.gmail.com>
	<CAOMFOmWsODJzsqhF7mexh=NT_sF7HYs4UuVK41YOBGSYB6o4Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAOMFOmWsODJzsqhF7mexh=NT_sF7HYs4UuVK41YOBGSYB6o4Sg@mail.gmail.com>
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
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: qemu-devel@nongnu.org

Hi,

On Tue Jun 13, 2017 at 17:05:41 -0700, Anatol Pomozov wrote:
> Do these arguments sound reasonable to apply the patch?

I'm not really convinced.

> On Thu, Jun 8, 2017 at 2:07 PM, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> > +reply-all
> >
> > On Thu, Jun 8, 2017 at 1:41 PM, Adam Lackorzynski
> > <adam@os.inf.tu-dresden.de> wrote:
> >>
> >> On Tue Jun 06, 2017 at 21:41:48 -0700, Anatol Pomozov wrote:
> >>> It is possible to create a 64 bit elf image that has valid multiboot header.
> >>> qemu should be able to boot such images.
> >>
> >> But this 64bit image actually starts with 32bit code, right?
> >
> > Correct. The very first part of the startup code has to be 32bit.
> > After it sets "long mode" it can use 64bit instructions. To make sure
> > that the preamble has only 32bit instructions one have to use asm
> > directive such as ".code32".
> >
> > Here is an example from LitleKernel sturtup code:
> >
> > https://github.com/littlekernel/lk/blob/master/arch/x86/64/start.S#L50
> >
> > .code32 tells assembler to treat following text as 32 bit code. And
> > later when it jumps into "long mode"
> >
> > https://github.com/littlekernel/lk/blob/master/arch/x86/64/start.S#L214
> > one can use 64bit code.
> >
> >> So it's a 32bit program and the check verifies that this is the case.
> >
> > While preamble have to contain 32 only instructions the rest of the
> > image can perfectly contain 64bit code. Right now 64bit binary cannot
> > be run with "qemu-system-x86_64 -kernel". But the same binary runs
> > fine if packed with GRUB as iso.
> >
> > I tried to hack around this restriction by adding
> > "OUTPUT_FORMAT(elf32-i386)" to the linker file and compiling project
> > with 64bit support. But GNU ld program crashed at Ubuntu 14.04. It
> > means not that many people use this code path. GNU ld compiled from
> > HEAD does not have this problem but now GDB is confused by the fact
> > that ELF contains 64bit code while header reports i386.

That's unfortunate.

> > Practically there is no reason for this check as it prevents running
> > 64bit binaries with "qemu-system-x86_64 -kernel".

One reason for the check is that it prevents that one loads a 64bit ELF
binary that then fails strangely because it does not have the magic
32bit code to set up things. At least there needs to be an override
(could also be in the ELF info).

Doing a proper 32bit wrapper is also possible, although that would need
a little ELF loader, or a custom loader, probably. We've done it this
way but that also requires some more lines.

If allowing 64bit binaries it should also be checked that all relevant
values fit into 32bit.



Adam
