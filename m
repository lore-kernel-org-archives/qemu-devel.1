Received: from eggs.gnu.org ([2001:4830:134:3::10]:40433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLjX-0008II-4M
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLjU-0005Pw-0L
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:06:51 -0400
Received: from mail-eopbgr690094.outbound.protection.outlook.com
	([40.107.69.94]:19791
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqLjT-0005Pb-IL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:06:47 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 17:06:41 +0000
Message-ID: <BN7PR08MB486867F6E966AB071EAC4ADBC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-41-git-send-email-aleksandar.markovic@rt-rk.com>,
	<97501a9d-c00f-7aba-1af2-256629f9abf5@linaro.org>
In-Reply-To: <97501a9d-c00f-7aba-1af2-256629f9abf5@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 40/84] target/mips: Fix pre-nanoMIPS MT
 ASE instructions availability control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, August 16, 2018 6:37 PM
>=20
> Subject: Re: [PATCH v9 40/84] target/mips: Fix pre-nanoMIPS MT ASE instru=
ctions availability control
>=20
> On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> > From: Aleksandar Rikalo <arikalo@wavecomp.com>
> >
> > Use bits from configuration registers for availability control
> > of MT ASE instructions, rather than only ISA_MT bit in insn_flags.
> > This is done by adding a field in hflags for MT bit, and adding
> > functions check_mt() and check_cp0_mt().
> >
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  target/mips/cpu.h       |  3 ++-
> >  target/mips/internal.h  |  6 +++++-
> >  target/mips/translate.c | 45 +++++++++++++++++++++++++++++++++++++----=
----
> >  3 files changed, 44 insertions(+), 10 deletions(-)
>=20
> What was wrong with using insn_flags?
>=20

The problem with using ISA_MT from insn_flags is that it doesn't provide th=
e correct availability control. Even though all instructions from MT ASE ar=
e related, they are available under different conditions:

Case 1 - DMT, DVPE, EMT, EVPE:
   =20
    if IsCoprocessorEnabled(0) then
        if Config3 MT then
            <main fuctionality>
        else
            SignalException(ReservedInstruction)
        endif
    else
        SignalException(CoprocessorUnusable, 0)
    endif

Case 2 - FORK, YIELD:

    if Config3 MT then
        <main fuctionality>
    else
        SignalException(ReservedInstruction)
    endif

Case 3 - MFTR, MTTR:

    if IsCoprocessorEnabled(0) then
        <main fuctionality>
    else
        SignalException(CoprocessorUnusable, 0)
    endif

> I'll note that hflags should be reserved for things that can change at ru=
ntime.
>  I thought all of these configuration registers were read-only.
>=20
> Anyway, with this plus the XNP patch from earlier, you now only have one
> remaining bit within hflags and then that resource is exhausted.
>=20

I think some of the previously-implemented similar cases involving read-onl=
y bits were handled the same way, and we just built on that. What would you=
 suggest as a more appropriate solution in such cases (of accessing "preset=
 by hardware" bits)?

Regards,
Aleksandar=
