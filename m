Received: from eggs.gnu.org ([2001:4830:134:3::10]:36475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQ50-0003pk-EW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQ4z-0003Zf-3r
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:49:26 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:41960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etQ4y-0003ZM-Sf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:49:25 -0500
Received: by mail-oi0-x22f.google.com with SMTP id g5so659955oiy.8
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 19:49:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86NXTeMdp3tsvJXYNZtqCX5zGeSd05U=hso6f=UaCOjQ@mail.gmail.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
	<CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
	<CAFEAcA_otsCR5CC2amGpU2cTdViH4+PkH84XHz1PaYt5nKGhAQ@mail.gmail.com>
	<CAHNT7NtJniQs_JcWOHnUr06be7Ht=9+sHmdr+rVNRUwy5+fJiw@mail.gmail.com>
	<CAHNT7Nv-Whr=fdgXANnSuw1yxb6EEBzdxVFSfkLZhh6knzS3sA@mail.gmail.com>
	<CAFEAcA86NXTeMdp3tsvJXYNZtqCX5zGeSd05U=hso6f=UaCOjQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 16:49:23 +1300
Message-ID: <CAHNT7NunrFAfTk9CTw9m8ecW-Fz6-m3UY-h0DtZUG1zYFU26jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8
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

On Wed, Mar 7, 2018 at 12:09 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 6 March 2018 at 01:30, Michael Clark <mjc@sifive.com> wrote:
> > I've squashed the trivial spike rename fix and rebased against master as
> of
> > commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a562 Merge remote-tracking
> branch
> > 'remotes/stefanha/tags/block-pull-request' into staging. See here:
> >
> > - https://github.com/riscv/riscv-qemu/releases/tag/riscv-
> qemu-upstream-v8.1
>
> OK. In the interests of getting the RISC-V port into upstream before
> the upcoming softfreeze deadline (which is next Tuesday)[*], please
> can you:
>  * make sure you have a signed tag and send it as a proper pull request
> email
>  * send your other queued changes to the mailing list as a patch series
>    so they can be reviewed
>  * work with Igor to identify the changes you need to make for the
>    CPU type registering issue he's raised, and then send a patch for that
>

I believe I have done all 3 now.

I would also like to forward port the change to implement IEEE-754
minimumNumber/maximumNumber to fix our fmin/fmax regression. I dropped the
patch due to conflicting changes in softfloat. With that change we are
passing all of the current riscv-tests for the Base ISA, with the exception
of returning NaN for SP floating point ops on DP register values. RISC-V
has a NaN boxing scheme to identify the type of floating point values in
memory, unlike SSE registers where the upper bits are undefined, RISC-V
requires the FP register file to "box" SP inside of a wider -NaN. i.e. the
upper 32 bits are all 1s. This was done to support type identification for
FPUs that work with a recoded internal format. The mechanism is described
in "9.2 NaN Boxing of Narrower Values" in the draft RISC-V ISA Manual. The
essence is to solve the context switch issue where FSD (Store Double) is
used to save values from the register file. By defining the upper bits as
Boxed within a NaN, the spec solves a binary compatibility issue between
different RISC-V implementations. For QEMU RISC-V, we'll need to add checks
on all SP floating point operations to check that the value is canonically
boxed, otherwise return a NaN (in the corner case where incorrect code
performs a SP operation on an FPU register containing a DP value). Once we
fix this issue, and minimumNumber/maximumNumber, QEMU RISC-V will be
passing 100% of the current Base ISA tests.

[*] For us, 'softfreeze' means that any new features must be in a pull
> request on the mailing list by that date; after that only bugfixes.
> Hardfreeze and the first rc candidate build is a week after that.
> See https://wiki.qemu.org/Planning/2.12 for other dates.
>
> thanks
> -- PMM
>
