Received: from eggs.gnu.org ([2001:4830:134:3::10]:47648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fk6Z9-0005t3-FG
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fk6Z8-0001Pj-2M
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:42:19 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fk6Z7-0001PT-MZ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:42:17 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so20586285oib.6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 04:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <1527229488-49822-1-git-send-email-mjc@sifive.com>
	<83728e91-de69-c376-a768-0aad501ff64e@twiddle.net>
	<CAFEAcA-hOTPOfW7ruRsSYt32Ahu707iMJtXdXkUREpLyHdFwJQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-hOTPOfW7ruRsSYt32Ahu707iMJtXdXkUREpLyHdFwJQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 30 Jul 2018 23:42:06 +1200
Message-ID: <CAHNT7NsJnejaweD24bFR9BEZyJ+yiyabX6a9F3cmGBhqXp5Z=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Correct typo in RV32 perf counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Richard Henderson <rth@twiddle.net>

On Mon, 30 Jul 2018 at 10:46 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 25 May 2018 at 14:17, Richard Henderson <rth@twiddle.net> wrote:
> > On 05/24/2018 11:24 PM, Michael Clark wrote:
> >> This patch enables mhpmcounter3h through mhpmcounter31h on RV32.
> >> Previously the RV32 h versions (high 32-bits of 64-bit counters)
> >> of these counters would trap with an illegal instruction instead
> >> of returning 0 as intended.
> >>
> >> Reported-by: Richard Henderson <rth@twiddle.net>
> >> Signed-off-by: Michael Clark <mjc@sifive.com>
> >> ---
> >>  target/riscv/op_helper.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Fixes: Coverity CID 1390849
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Ping -- Coverity is still complaining about this -- did this
> patch get lost?


Sort of. I assumed it would go into a trivial queue.

Feel free to apply, however it=E2=80=99s going to create (another) rebase c=
onflict
against my =E2=80=98for-upstream=E2=80=99 queue as this code has gone away,=
 hence it is not
in my queue.

The bug is fixed in my tree in an alternate way as we have overhauled the
CSR system to support atomic read/modify/write CSRs, and the new code is
table driven versus using jumbo switch statements.

When we transcribed this code to the new CSR system the bug disappeared as
a consequence of the  nature of the new mechanism which matches the table
listings in the RISC-V Privileged ISA manual which makes this type of bug
much more obvious:

https://github.com/riscv/riscv-qemu/blob/qemu-for-upstream/target/riscv/csr=
.c#L912-L919

My tree is up-to-date as of 3.0-rc2, and has been rebased against
Alistair=E2=80=99s changes but I have a feeling we are still missing review=
s.

We also have additional CSR fixes (such as vectored interrupts) that depend
on the context of the new CSR system and we don=E2=80=99t have enough bandw=
idth to
maintain a backport to the old code in upstream QEMU.

I guess it is problematic going via my tree as last time I looked we didn=
=E2=80=99t
have enough reviews.

I can include this change in my pull for 3.1, along with the patches in my
tree that have Reviewed-by and fix the rebase conflicts for anything that
depends on new context (hopefully not creating new bugs during that
process).

I haven=E2=80=99t reposted the code that has not been reviewed as I=E2=80=
=99ll do that when
I have a chance to reorder and split my queue based on what has been
reviewed and what hasn=E2=80=99t.

I=E2=80=99ve deferred that because i=E2=80=99m still working on new code th=
at will be
shipping from the SiFive tree (for which i=E2=80=99m currently writing test=
 cases
for).

Michael.
