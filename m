Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfoy-0003OT-Vh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqfot-0008KA-9c
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:01:33 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqfot-0008Jr-3o
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:01:27 -0500
Received: by mail-ot0-x242.google.com with SMTP id 108so3846264otv.3
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:01:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519690504-37792-1-git-send-email-mjc@sifive.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 14:01:05 +0000
Message-ID: <CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 27 February 2018 at 00:15, Michael Clark <mjc@sifive.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
>
>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v7
>
> for you to fetch changes up to 170a9d412ca1eb3b7ae6f6c1ff86dcbdff0fd7a8:
>
>   RISC-V Build Infrastructure (2018-02-27 11:09:43 +1300)
>
> - ----------------------------------------------------------------
> QEMU RISC-V Emulation Support (RV64GC, RV32GC)

Hi; thanks for this pull request. Unfortunately it seems to
be missing Signed-off-by: tags. Every commit needs to have
the Signed-off-by: tags from the people who contributed code to
it, indicating that they're OK with the code going into QEMU.
(If the work was done by and copyright a company then you don't
need to provide signoffs from every person at the company who
worked on the code if you don't want to.)

> The spike_v1.9
> machine has been renamed to spike_v1.9.1 to match the privileged ISA
> version and spike_v1.10 has been made the default machine.

I'm confused about this. Generally QEMU boards should model
hardware, and the board shouldn't care about the ISA versions.
Versioned board names in QEMU generally follow _QEMU_'s versioning,
and indicate that a board is identical to whatever we modelled
in that earlier QEMU version, for VM migration compatibility.
Board renames for minor ISA version bumps sounds like there's going
to be a lot of churn and breakage -- is this stuff really ready?
(Also, should we really have two different board source files
for two different ISA versions? I would have expected these to
share a source file to share code.)

I did a test build and there are some compile errors:

/home/pm215/qemu/linux-user/main.c:38:24: fatal error: target_elf.h:
No such file or directory
 #include "target_elf.h"
                        ^
compilation terminated.

This is because your patchset has a clash with commit 542ca4349878a2e
which has just merged to master, and refactors out an ifdef ladder,
so now all targets supporting linux-user need to provide a
linux-user/$ARCH/target_elf.h file. Could you fix that up and rebase,
please?

thanks
-- PMM
