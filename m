Received: from eggs.gnu.org ([2001:4830:134:3::10]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezo5y-0006Bg-BU
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznzw-0006XX-H4
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:38:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eznzw-0006X5-AG
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:34:36 -0400
Received: by mail-ot0-x243.google.com with SMTP id m22-v6so16649059otf.10
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:34:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-oqg8UJD=i9swm8AiF=tvJ7GY6+CyStJNiZyoqUYfMqg@mail.gmail.com>
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-oqg8UJD=i9swm8AiF=tvJ7GY6+CyStJNiZyoqUYfMqg@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:34:35 -0700
Message-ID: <CAHNT7NtejweUKLvwSwORsexE+Lbz54mA3aPoXwyK=bLww8gBcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Jim Wilson <jimw@sifive.com>, Richard Henderson <richard.henderson@linaro.org>

On Fri, Mar 23, 2018 at 3:20 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 20 March 2018 at 22:25, Michael Clark <mjc@sifive.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > The following changes since commit f1a63fcfcd92c88be8942b5ae71aef
> 9749a4f135:
> >
> >   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
> >
> > for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679:
> >
> >   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:13
> -0700)
>
> I know this pull request needs a respin, but I gave it a test build
> run anyway to see if there were any issues thrown up by that (there
> weren't, which is great).
>
> I did notice that the tag name you quote here,
> "tags/riscv-qemu-2.12-fixes",
> doesn't seem to be a tag pushed to your git repo. I tested with
> "tags/riscv-qemu-2.12-fixes-v5" which I'm guessing is what you meant.
> You probably want to have a look into the workflow which generates
> these pullreq emails though to ensure it's creating them with the
> tag names that you intend, though.
>

I'll make sure I have the version number on the tag in future PRs.

I just sent a v6 series which includes two new bug fixes, and all of the
unreviewed patches as requested by Phil.

It's interesting to note that the reviewed patches are the cleanups which
are not critical and the unreviewed patches are mostly the actual bug
fixes, and likely require a reading of the specification. The bug fixes are
of course harder to review. I might ask around to see if we can find a
reviewer familar with RISC-V. The CSR return 0 vs trap behaviour is
something I discussed with Andrew Waterman and there were issues raised on
the riscv-isa-manual github repo as we are trying to clarify the behaviour
or MMU, no-MMU; S-mode vs no S-mode, etc. I have more fixes planned as we
try to more accurately emulate the MCU class cores with no-MMU but I don't
have the bandwidth at present to make all the required changes. i.e. cores
that don't report misa.S should trap on all s* CSRs but cores with misa.S
with no-MMU should just return 0 for satp (Supervisor Address Translation
Pointer) and ignore writes. The page walker changes are also made after a
closer reading of the specification i.e. handling mstatus.MXR permissions
and various other subtleties. There are also bounds checks for device-tree,
which don't actually show up in practice likely because the physical memory
write routines appear to silently handle bounds overruns. I added some
printfs and discovered the device tree size was larger than the ROM, so the
ROM space has been increased and bounds checks have been added.

And of course we have added the critical workaround for the mstatus.FS
problem, after checking that the workaround behaviour is legal, which it is.

26/26 in the series is what I would refer to as a critical fix. Of course
we'd like to get all of the changes in, as I believe the Fedora folk have
been using QEMU with this series applied. Indeed 26/26 is a derivative of
Richard W.M. Jones fix for the fedora rpm, however I've made it checkpatch
compliant and added comments describing the workaround.

I've cc'd Jim, while he works on GCC, he has helped with some spec
conformance bug fixes in QEMU, although not to do with the page walker. I
had added Palmer's sign-off to some of the patches after speaking with him,
as I sit near to him, so I guess he can't review them, but he could review
the latest fixes which don't have his sign-off. I'll try and find somebody
next week who doesn't mind looking at the Privileged Spec and
riscv-isa-manual issue tracker discussions to review the spec related bug
fixes... It would be nice to get this series in to QEMU 2.12...

Thanks,
Michael.
