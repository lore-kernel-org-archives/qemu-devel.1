Received: from eggs.gnu.org ([2001:4830:134:3::10]:54415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gMx8H-00054o-0R
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gMx8E-0002aa-CI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:31:08 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:58290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gMx8C-0002VU-CT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:31:06 -0500
Date: Wed, 14 Nov 2018 16:30:46 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181114153046.GA2359@sx9>
References: <1542135956-3780-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAAdtpL4cd2i0ZgL_hyPc9wgp5-=v5qeExmAnpdr0XZ97_5cwjg@mail.gmail.com>
	<CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/mips: Disable R5900 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Philippe,

On Tue, Nov 13, 2018 at 11:51:54PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On Tue, Nov 13, 2018 at 8:29 PM Philippe Mathieu-Daud=C3=A9
> <philippe@mathieu-daude.net> wrote:
> > On Tue, Nov 13, 2018 at 8:08 PM Aleksandar Markovic
> > <aleksandar.markovic@rt-rk.com> wrote:
> > >
> > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > Disable R5900 support. There are some outstanding issues related
> > > to ABI support and emulation accuracy, that were not understood
> > > well during review process. Disable to avoid backward compatibility
> > > issues.
>=20
> If the issues you mentioned are "the R5900 tcg opcodes are not
> implemented correctly", then this patch is OK, because no cpu can use
> the R5900 opcodes.

The issue is that the Linux kernel emulates certain opcodes (e.g. LL, SC,
RDHWR, DMULT, etc.) by psABI requirements. This is a common requirement
for many other MIPS implementations, not only the R5900. It is trivial to
do this with QEMU user mode, but evidently for whatever reason Aleksandar
does not permit this emulation.

> At some point while reading your reviews, I understood the R5900
> patches introduced incorrect behaviors for the non-R5900 cpus. In this
> case this patch wouldn't suffice.

No, that was never the case and I'm not aware of any such problems.
However, there is a refactoring series, and we have observed preexisting
bugs in the MIPS emulation, unrelated to the R5900. The opcode decoder
could also be improved, such as in asserting reserved instructions in
more cases where opcodes are invalid, etc.

> Hoping I misinterpreted your reviews, then this patch is OK.
> With one of the suggested comments:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Then we will fix this for the 4.0 release.

What exactly needs to be fixed regarding the psABI? The relevant opcodes
would need to stay, and not be prohibited and removed as Aleksandar has
suggested, since such opcode removal breaks the psABI requirements.

Finally, as Maciej explained in some detail, the document that Aleksandar
just recently requested is known to not exist, for any MIPS implementatio=
n,
so we are not going to make any progress on that either.

Fredrik
