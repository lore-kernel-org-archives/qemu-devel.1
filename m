Received: from eggs.gnu.org ([209.51.188.92]:50139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cwj-0001Gf-5c
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cwh-0001FU-SU
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:27:29 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2cwh-0001Eq-L7
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:27:27 -0500
Received: by mail-ot1-x341.google.com with SMTP id 98so319477oty.1
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 06:27:27 -0800 (PST)
MIME-Version: 1.0
References: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
	<1550029560-30530-2-git-send-email-sandra@codesourcery.com>
	<CAFEAcA8p9rSYEJQ7jPFvM9Q+UXi6r7Vr8voWQ_fhzzFX1=uVzw@mail.gmail.com>
	<97684d40-2a1a-1c3c-cb29-cf137fa00875@codesourcery.com>
In-Reply-To: <97684d40-2a1a-1c3c-cb29-cf137fa00875@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 14:27:14 +0000
Message-ID: <CAFEAcA9_AO_3BGXH+LJ6V6=r6KF1vfzACbcd9FLE5gskVqzAUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, Andrew Jenner <andrew@codesourcery.com>

On Fri, 8 Mar 2019 at 23:51, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> On 3/7/19 7:57 AM, Peter Maydell wrote:
> >> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
> >> index 5f0ab2f..c697047 100644
> >> --- a/hw/nios2/boot.c
> >> +++ b/hw/nios2/boot.c
> >> @@ -140,6 +140,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
> >>           uint64_t entry, low, high;
> >>           uint32_t base32;
> >>           int big_endian = 0;
> >> +        int kernel_space = 0;
> >>
> >>   #ifdef TARGET_WORDS_BIGENDIAN
> >>           big_endian = 1;
> >> @@ -155,10 +156,12 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
> >>                                      translate_kernel_address, NULL,
> >>                                      &entry, NULL, NULL,
> >>                                      big_endian, EM_ALTERA_NIOS2, 0, 0);
> >> +            kernel_space = 1;
> >>           }
> >>
> >>           /* Always boot into physical ram. */
> >> -        boot_info.bootstrap_pc = ddr_base + 0xc0000000 + (entry & 0x07ffffff);
> >> +        boot_info.bootstrap_pc = ddr_base + (kernel_space ? 0xc0000000 : 0)
> >> +                                 + (entry & 0x07ffffff);
> >
> > It's not clear to me what's going on here, or why an
> > entry address of 0xc000_0000 is special, but I don't
> > know anything about NiosII -- maybe it's clear if you do?
>
> The processor reference guide documents that the kernel is placed at
> virtual memory address 0xc0000000.
>
> https://www.intel.com/content/www/us/en/programmable/documentation/iga1409256728501.html#iga1409332620358
>
> The problem the patch to boot.c is trying to solve is that we found
> things like unwind info were screwed up when using -kernel to load
> executables with an entry address other than 0xc0000000.

Ah, so this is one of those architectures like MIPS that
has multiple aliases of the same lump of physical RAM with
different properties. So an ELF file could be linked to
load in one of multiple aliases.

> > Why isn't the bootstrap_pc just always the entry address ?
> > Some comments on what is being done here and the use cases
> > being addressed might assist. I wasn't able to work out what
> > the remarks in the commit message meant, I'm afraid.
> >
> > Looking at the code, I don't think that the second call to
> > load_elf() will return a different entry address to the first
> > one (ie translate_kernel_address() is not applied to &entry).
> > That means that kernel_space is only true if entry == 0xc0000000,
> > and
> >    (kernel_space ? 0xc0000000 : 0) + (entry & 0x07ffffff);
> > is almost the same thing as just 'entry'.
>
> It seems like these remarks are directed more at the existing code than
> the patch....  :-S  TBH, I don't know why it was done that way originally.

Yeah, some of this is the fault of the original code, which is
doing weird things and not documenting why. But you're changing
this code, so you're currently the best expert we have at
what the architecture should do. So I'm trying to figure out
by asking you questions what the architecture does and what
the code is intended to do.

Right now my impression from reading the code and this patch is
that the existing code is doing something odd and possibly
wrong but which happens to work for whatever set of executables
it was being tested with, and then this patch is layering on a
workaround that fixes some other set of use cases -- but it would
be better if we could figure out what the real hardware does and
do that, which should then work in all the cases we're trying to
support (or we can say "no, these binaries are built wrongly and
they wouldn't load on the real hardware either"). If the real
hardware is doing something odd that's OK, but then we should
have a nice clear comment describing what the hardware does.

> > The description says this is "generic", but it appears to
> > be almost identical to the existing 10M50 board model,
> > including having exactly the same devices at the same
> > apparently arbitrary addresses.
> >
> > Could we instead add a machine parameter to the existing
> > board so you could say "-machine 10m50-ghrd,mmu=no"
> > (and drop the other changes -- it's not clear what they're
> > needed for) ?
> >
> > If it really ought to be a separate board model, perhaps
> > it should be in the same source file and share the common
> > code.
>
> I didn't write this code, but the intent was actually to allow
> executables linked for the 3c120 devboards we'd been using for hardware
> testing to run in this emulation; not to emulate a mmu-less 10m50 board.

That sounds like the right answer is "provide a model of a 3c120
board", not "provide something that is labelled generic but
is actually a 10m50 with no MMU" ?

thanks
-- PMM
