Received: from eggs.gnu.org ([209.51.188.92]:34751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBekk-0005aB-3y
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBekj-0005Fc-3W
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:12:26 -0400
Received: from mail-eopbgr750090.outbound.protection.outlook.com
	([40.107.75.90]:17888
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBeki-0005Ei-Na
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:12:25 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 3 Apr 2019 12:12:21 +0000
Message-ID: <BN6PR2201MB12513ADADA13DA0F9D19D0F7C6570@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB12517DB6F0F0B64C4A2CD62CC6560@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<4aa5f2b4-5288-ef42-1a56-f427a779ab60@rt-rk.com>
In-Reply-To: <4aa5f2b4-5288-ef42-1a56-f427a779ab60@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 5/5] target/mips: Refactor and fix
 INSERT.<B|H|W|D> instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> Subject: Re: [PATCH v4 5/5] target/mips: Refactor and fix INSERT.<B|H|W|D=
> instructions
>=20
> On 2.4.19. 22:50, Aleksandar Markovic wrote:
> >> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> >> Subject: [PATCH v4 5/5] target/mips: Refactor and fix INSERT.<B|H|W|D>=
 instructions
> >>
> >> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >>
> >> The old version of the helper for the INSERT.<B|H|W|D> MSA instruction=
s
> >> has been replaced with four helpers that don't use switch, and change
> >> the endianness of the given index, when executed on a big endian host.
> >>
> >> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> >> ---
> > ...
> >
> >
> >> +    n %=3D 16;
> > Mateja, could you just clarify what is the purpose of this line (and
> > similar three lines involving "%=3D")? It looks to me that n is already
> > limited here to be between 0 and 15, isn't it? (that follows from the
> > source code of gen_msa_elm().) What made you insert this line,
> > as it stands?
>=20
> It was
>=20
> n %=3D DF_ELEMENTS(df);
>=20
> but when I deleted the df argument, so it had to be done like
> this. I think it's a matter of precaution (in case a number
> greater than 15, or 8... is passed as an argument).

Oh, I see.
=20
At this moment, I think a more appropriate code would be:

assert(n < 16)

The whole set of functions decoding this group of instructions is
too complicated (several layers, repeated calculations), and could
be further simplified. But let's say that would be outside of the
scope of this patch and series. Your series, in fact, begins that
simplification by removing redundant decoding of "df" in helpers,
so it is a good step towards better code organization, and we'll
leave more detailed cleanup for some future endeavors.

Yours,
Aleksandar
