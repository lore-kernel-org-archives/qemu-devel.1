Received: from eggs.gnu.org ([2001:4830:134:3::10]:43597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqphP-0004p4-K4
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 19:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqphN-0004el-W3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 19:34:23 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eqphN-0004ed-OY
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 19:34:21 -0500
Received: by mail-ot0-x243.google.com with SMTP id l5so673927otf.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 16:34:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 28 Feb 2018 13:34:20 +1300
Message-ID: <CAHNT7Nvg_-wuF_3hJ-Q8sovstB+a2npPvH713ZnDw0y1on-4Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Wed, Feb 28, 2018 at 3:01 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 27 February 2018 at 00:15, Michael Clark <mjc@sifive.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5a
> f8c5c2a6d0:
> >
> >   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07
> +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v7
> >
> > for you to fetch changes up to 170a9d412ca1eb3b7ae6f6c1ff86dcbdff0fd7a8:
> >
> >   RISC-V Build Infrastructure (2018-02-27 11:09:43 +1300)
> >
> > - ----------------------------------------------------------------
> > QEMU RISC-V Emulation Support (RV64GC, RV32GC)
>
> Hi; thanks for this pull request. Unfortunately it seems to
> be missing Signed-off-by: tags. Every commit needs to have
> the Signed-off-by: tags from the people who contributed code to
> it, indicating that they're OK with the code going into QEMU.
> (If the work was done by and copyright a company then you don't
> need to provide signoffs from every person at the company who
> worked on the code if you don't want to.)
>
> > The spike_v1.9
> > machine has been renamed to spike_v1.9.1 to match the privileged ISA
> > version and spike_v1.10 has been made the default machine.
>
> I'm confused about this. Generally QEMU boards should model
> hardware, and the board shouldn't care about the ISA versions.
> Versioned board names in QEMU generally follow _QEMU_'s versioning,
> and indicate that a board is identical to whatever we modelled
> in that earlier QEMU version, for VM migration compatibility.
> Board renames for minor ISA version bumps sounds like there's going
> to be a lot of churn and breakage -- is this stuff really ready?
> (Also, should we really have two different board source files
> for two different ISA versions? I would have expected these to
> share a source file to share code.)
>
> I did a test build and there are some compile errors:
>
> /home/pm215/qemu/linux-user/main.c:38:24: fatal error: target_elf.h:
> No such file or directory
>  #include "target_elf.h"
>                         ^
> compilation terminated.
>
> This is because your patchset has a clash with commit 542ca4349878a2e
> which has just merged to master, and refactors out an ifdef ladder,
> so now all targets supporting linux-user need to provide a
> linux-user/$ARCH/target_elf.h file. Could you fix that up and rebase,
> please?
>

No worries. I'll rebase and submit a v8 patch series very soon.

I've just discussed with SiFive, and they wish to remove a couple of
machines and devices from the v8 patch series. They want to get the chip
model, SOC and board model right before they submit them upstream.

This is fine, as most folk seem to want to use "virt" to run Linux and we
have the "spike" machines that match the RISC-V Foundation ISA Simulator.

SiFive's boards are for customers that are using their MCUs without MMUs.
We can wait until they are fully baked before we submit them. The machines
are quite easy to maintain on a file level such that they won't cause much
trouble with them being in downstream repos. Other RISC-V vendors also
probably want to submit their boards and core models at some point too, if
they choose to support QEMU...
