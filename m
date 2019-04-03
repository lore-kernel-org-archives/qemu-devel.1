Received: from eggs.gnu.org ([209.51.188.92]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBcyC-0005Aw-Gz
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBcyB-0000Pu-Am
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:18:12 -0400
Received: from mail-eopbgr820138.outbound.protection.outlook.com
	([40.107.82.138]:34891
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBcyA-0000IU-Tg
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:18:11 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 3 Apr 2019 10:18:07 +0000
Message-ID: <BN6PR2201MB12517771934D20ADBA40B8E9C6570@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=hG_3htcguRp11NGx3pZP5QY8V6r1kYONYxbcE+NkmQ8Q@mail.gmail.com>,
	<92db38b6-176b-7cbe-b546-242c926d6bf4@linaro.org>
In-Reply-To: <92db38b6-176b-7cbe-b546-242c926d6bf4@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize ILVEV.<B|H=
|W|D> MSA > instructions
>=20
> On 4/3/19 6:25 AM, Aleksandar Markovic wrote:
> >
> > On Apr 2, 2019 5:20 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.co=
m
> > <mailto:mateja.marjanovic@rt-rk.com>> wrote:
> >>
> >> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com
> > <mailto:Mateja.Marjanovic@rt-rk.com>>
> >>
> >> Optimize set of MSA instructions ILVEV, using directly
> >
> > Use full instruction names, with the only exception of possible Bachus-=
Naur
> > forms... again.
> >
> >> tcg registers and performing logic on them instead of
> >> using helpers.
> >>
> >> In the following table, the first column is the performance
> >> before this patch. The second represents the performance,
> >> after converting from helpers to tcg, but without using
> >> tcg_gen_deposit function. The third one is the solution
> >> which is implemented in this patch.
> >>
> >>  instr    ||   before    || no-deposit ||  with-deposit
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>  ilvev.b  ||  126.92 ms  ||  24.52 ms  ||  24.43 ms
> >>  ilvev.h  ||   93.67 ms  ||  23.92 ms  ||  23.86 ms
> >>  ilvev.w  ||  117.86 ms  ||  23.83 ms  ||  22.17 ms
> >>  ilvev.d  ||   45.49 ms  ||  19.74 ms  ||  19.71 ms
> >>
> >> The solution with deposit is suggested by Richard Henderson.
> >>
> >> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com
> > <mailto:mateja.marjanovic@rt-rk.com>>
> >> ---
> >
> > The byte and halfword cases of this patch most likely produce highly
> > unoptimized code for cases:
> >
> > wd =3D=3D wt =3D=3D ws
> > wd =3D=3D wt !=3D ws
> > wd !=3D ws =3D=3D wt
> > wd =3D=3D ws !=3D wt
> >
> > Please take these cases into account.
>=20
> I beg to differ.  We want to minimize the amount of special cases.
>=20
> If you multiply the different cases like this you also multiply the maint=
enance
> overhead.  You force future maintainers to wonder if the cases are truly
> distinct or if they are mere optimization.
>=20

I find your objection hard to understand.

The subject and the goal of the patch is obviously optimization. If there i=
s
a danger of unclarity in the resulting source code, this is easily alleviat=
ed
by, for example, inserting informative comments, as is routinely done in
many other areas of QEMU or any software product.

Sincerely,
Aleksandar

> The only special cases that I advocate that you add are driven by standar=
d
> macros that the assembler generates -- e.g. register move (via or), regis=
ter
> negate (via nor), etc.
>=20
>=20
> r~
