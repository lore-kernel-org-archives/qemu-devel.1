Received: from eggs.gnu.org ([2001:4830:134:3::10]:35201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjOj-0000EQ-Ck
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjOi-00032I-2y
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:50:41 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqjOh-00031t-Ss
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:50:40 -0500
Received: by mail-ot0-x244.google.com with SMTP id l5so4571567otf.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:50:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:50:18 +0000
Message-ID: <CAFEAcA-kPFXSU_bixh6zn4JPow-KeP5dW3wNVQ6h93YUgbMZbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stef O'Rear <sorear2@gmail.com>
Cc: RISC-V Patches <patches@groups.riscv.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 27 February 2018 at 15:50, Stef O'Rear <sorear2@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 6:01 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 27 February 2018 at 00:15, Michael Clark <mjc@sifive.com> wrote:
>>> The spike_v1.9
>>> machine has been renamed to spike_v1.9.1 to match the privileged ISA
>>> version and spike_v1.10 has been made the default machine.
>>
>> I'm confused about this. Generally QEMU boards should model
>> hardware, and the board shouldn't care about the ISA versions.
>
> The spike boards model the Berkeley architectural simulator "spike"
> (https://github.com/riscv/riscv-isa-sim), which does not have a formal
> release process or version numbers so we are using the ISA version as
> a proxy for spike's version.
>
> When physical boards are released with full documentation I presume we
> will be adding board definitions for them, and they will imply
> specific ISA versions.
>
>> Versioned board names in QEMU generally follow _QEMU_'s versioning,
>> and indicate that a board is identical to whatever we modelled
>> in that earlier QEMU version, for VM migration compatibility.
>
> In this case we're handling two logically distinct boards.  We could
> combine them and implement a parameter; I was having trouble finding a
> suitable example to follow earlier but it looks like gic-version in
> hw/arm/virt.c is one.  This seems like a bad thing to change this late
> in the review though?

You don't need to make them one board with a command line option
if that doesn't suit -- for instance hw/arm/vexpress.c defines
multiple board models that are variants on each other and
share a lot of code. That said, see below...

>> Board renames for minor ISA version bumps sounds like there's going
>> to be a lot of churn and breakage -- is this stuff really ready?
>> (Also, should we really have two different board source files
>> for two different ISA versions? I would have expected these to
>> share a source file to share code.)
>
> 1.10 is the version we have committed to long term support for; it
> matches all public hardware the upstream Linux port, so it seems
> appropriate to use for QEMU.
>
> 1.9.1 was the version supported by riscv-qemu at the time Michael
> Clark took over maintainership; we have not removed support for it
> because we cannot prove that there is nobody depending on it, although
> I do not use it myself and do not know anyone else who does, so I
> would not personably object to removing it if that were required.

I would rather not have stray legacy old versions in QEMU just
because we think maybe somebody might be using them. If 1.10
is the long-term-support committed version, then I think we
should just have a model of that. Anybody who for some reason is
still stuck on an older unsupported version gets to find out
what "unsupported" means; they can always keep using whatever
old QEMU code base they've been using up til now, presumably.

thanks
-- PMM
