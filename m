Received: from eggs.gnu.org ([2001:4830:134:3::10]:48771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGBT5-0008WV-VU
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGBT4-00037M-7V
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:52:24 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:33419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGBT3-00036r-Ur
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:52:22 -0400
Received: by mail-oi0-x236.google.com with SMTP id k5-v6so23044608oiw.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:52:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=gUN=FF8_--cpsnu8ynsReA+R_9mkfaXzMEmmSo2cKQ@mail.gmail.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_=gUN=FF8_--cpsnu8ynsReA+R_9mkfaXzMEmmSo2cKQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 9 May 2018 10:52:20 +1200
Message-ID: <CAHNT7NsSwzT36k_9Mvm-SReLj0NGpYEKmzzeWsRacow-CwYYbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] RISC-V: QEMU 2.13 Privileged ISA
 emulation updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-stable <qemu-stable@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Wed, May 9, 2018 at 1:22 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 6 May 2018 at 00:35, Michael Clark <mjc@sifive.com> wrote:
> > The following changes since commit c8b7e627b4269a3bc3ae41d9f42054
> 7a47e6d9b9:
> >
> >   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04'
> into staging (2018-05-04 14:42:46 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-pull-
> 20180506
> >
> > for you to fetch changes up to 5aec3247c190f10654250203a1742490ae7343a2:
> >
> >   RISC-V: Mark ROM read-only after copying in code (2018-05-06 10:54:21
> +1200)
> >
> > ----------------------------------------------------------------
> > RISC-V: QEMU 2.13 Privileged ISA emulation updates
> >
> > Several code cleanups, minor specification conformance changes,
> > fixes to make ROM read-only and add device-tree size checks.
> >
> > * Honour privileged ISA v1.10 counter enable CSRs.
> > * Implements WARL behavior for CSRs that don't support writes
> >   * Past behavior of raising traps was non-conformant
> >     with the RISC-V Privileged ISA Specification v1.10.
> > * Allow S-mode access to sstatus.MXR when priv ISA >= v1.10
> > * Sets mtval/stval to zero on exceptions without addresses
> >   * Past behavior of leaving the last value was non-conformant
> >     with the RISC-V Privileged ISA Specition v1.10. mtval/stval
> >     must be set on all exceptions; to zero if not supported.
> > * Make ROMs read-only and implement device-tree size checks
> >   * Uses memory_region_init_rom and rom_add_blob_fixed_as
> > * Adds hexidecimal instruction bytes to disassembly output.
> > * Fixes missing break statement for rv128 disassembly.
> > * Several code cleanups
> >   * Replacing hard-coded constants with enums
> >   * Dead-code elimination
> >
> > This is an incremental pull that contains 20 reviewed changes out
> > of 38 changes currently queued in the qemu-2.13-for-upstream branch.
> >
>
> Applied, thanks.
>

Thanks!

I didn't include qemu-stable on this series as I simply hadn't spent the
time to locally test the issue with 'sifive_u' that Alastair mentioned.
I've now locally reproduced Alastair's results confirming that the last
commit in this series, namely "RISC-V: Mark ROM read-only after copying in
code", fixes the 'sifive_u' board.

-
https://git.qemu.org/?p=qemu.git;a=commit;h=5aec3247c190f10654250203a1742490ae7343a2

There are however several other usability issues and bugs fixess in this
series that could be considered for 'qemu-stable'.

- "RISC-V: Mark ROM read-only after copying in code" fixes the 'sifive_u'
board issue (bug fix)
- "RISC-V: No traps on writes to misa,minstret,mcycle" fixes a case where
an illegal instruction should not be generated (bug fix - misa write bug
was hit by Andes Technology)
- "RISC-V: Make mtvec/stvec ignore vectored traps" fixes a case where an
illegal instruction should not be generated (bug fix - not hit yet, but
nevertheless is a fix)
- "RISC-V: Use [ms]counteren CSRs when priv ISA >= v1.10" fixes the counter
enable CSRs, so they actually work (bug fix - hit by someone working on
'perf' for riscv-linux)
- "RISC-V: Include instruction hex in disassembly" adds instruction bytes
to disassembly to improbe usability, and was on the list before soft-freeze
(small usability issue)
- "RISC-V: Make virt board description match spike" makes the -help listing
use consistent naming for privileged ISA version (small usability issue)

The rest of the series are the innocuous fixes and code cleanups (replacing
constants with enums, etc) that had been on the list mid-March, with the
exception of "RISC-V: Fix missing break statement in disassembler" which
fixes the rv128 disassembly issue picked up recently by coverity and the
"RISC-V: Add mcycle/minstret support for -icount auto" is a small new
feature.

It would be safe to import the tag as the cleanup commits or I can
selectively backport changes. The issue is the fixes depending on context
of the cleanup commits early in the series. The sifive_u fix: "RISC-V: Mark
ROM read-only after copying in code" depends on diff context from "RISC-V:
Remove identity_translate from load_elf" and "RISC-V: Use ROM base address
and size from memmap" which were both code cleanups.

The question is whether code cleanups can come into qemu-stable (i.e. merge
this tag to stable) or whether we should cherry-pick and solve merge
conflicts to get the minimal set of commits with what we classify as
important fixes or usability issue into qemu-stable. The most essential
would be to just backport "RISC-V: Mark ROM read-only after copying in
code" as it makes the 'sifive_u' board usable. The others are nice-to-have.

This first 20 patch series deliberately include low risk changes focused on
spec conformance issues, minor usabiliy issues, some code cleanups, with
the exception of the ROM bug actually fixing the 'sifive_u' board. I have
been using git rebase to move the smaller fixes earlier in the series.

Richard, what changes to you think you would classify as being suitable for
qemu-stable?  These changes have also been quite extensively tested with
SMP Linux running Fedora. I'm building GCC and QEMU in an MTTCG multi-core
RISC-V QEMU 'virt' instance, along with testing the 'spike' and 'sifive_e'
and now 'sifive_u' boards with Linux boots.

Thanks,
Michael.
