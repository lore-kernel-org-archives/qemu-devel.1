Received: from eggs.gnu.org ([209.51.188.92]:52280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1guMDx-0005B8-Kg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1guMDw-0004Hx-Ay
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:59:05 -0500
Received: from mail-eopbgr690108.outbound.protection.outlook.com
	([40.107.69.108]:9655
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1guMDv-00045l-9s
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:59:03 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 14 Feb 2019 18:58:57 +0000
Message-ID: <BN6PR2201MB1251DE348F8B09029D23895EC6670@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1547830785-7079-8-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAFEAcA8gk8MsDoHA5mzO0q16odQs-++rY=QbjZu=dkC+=5OjFg@mail.gmail.com>
In-Reply-To: <CAFEAcA8gk8MsDoHA5mzO0q16odQs-++rY=QbjZu=dkC+=5OjFg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL v2 07/12] target/mips: Update ITU to utilize
 SAARI and SAAR CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Thursday, February 14, 2019 7:40 PM
> To: Aleksandar Markovic
> Cc: QEMU Developers; Aleksandar Markovic
> Subject: Re: [PULL v2 07/12] target/mips: Update ITU to utilize SAARI and=
 SAAR CP0 registers
>=20
> On Fri, 18 Jan 2019 at 16:59, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> >
> > From: Yongbok Kim <yongbok.kim@mips.com>
> >
> > Update ITU to utilize SAARI and SAAR CP0 registers.
>=20
> Hi; Coverity complains (CID 1398648) about this bit of code:
>=20
> > -static void itc_reconfigure(MIPSITUState *tag)
> > +void itc_reconfigure(MIPSITUState *tag)
> >  {
> >      uint64_t *am =3D &tag->ITCAddressMap[0];
> >      MemoryRegion *mr =3D &tag->storage_io;
> > @@ -92,6 +92,12 @@ static void itc_reconfigure(MIPSITUState *tag)
> >      uint64_t size =3D (1 * KiB) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
> >      bool is_enabled =3D (am[0] & ITC_AM0_EN_MASK) !=3D 0;
> >
> > +    if (tag->saar_present) {
> > +        address =3D ((*(uint64_t *) tag->saar) & 0xFFFFFFFFE000ULL) <<=
 4;
> > +        size =3D 1 << ((*(uint64_t *) tag->saar >> 1) & 0x1f);
> > +        is_enabled =3D *(uint64_t *) tag->saar & 1;
> > +    }
> > +
>=20
> because the "1 << ..." calculation of size is done as a 32-bit
> signed integer which may then be unintentionally sign-extended
> into the 64-bit result. Using "1ULL" instead of "1" on the LHS
> of the shift would fix this.
>=20

Thanks, I'll try to integrate the fix soon.

Aleksandar

> thanks
> -- PMM
 =
