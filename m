Received: from eggs.gnu.org ([2001:4830:134:3::10]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqfau-0006Nc-Ot
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqfaq-0002kd-NI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:19:16 -0400
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com
	([104.47.33.137]:20521
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqfaq-0002kN-IW
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:19:12 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 17 Aug 2018 14:19:10 +0000
Message-ID: <BN7PR08MB4868AC7A52778443C22B5FB3C63D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-48-git-send-email-aleksandar.markovic@rt-rk.com>,
	<e277dd47-fe10-4e70-3e0e-58aeabe13153@linaro.org>
In-Reply-To: <e277dd47-fe10-4e70-3e0e-58aeabe13153@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 47/84] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 6
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
> Sent: Thursday, August 16, 2018 7:38 PM
>=20
> Subject: Re: [PATCH v9 47/84] target/mips: Add emulation of DSP ASE for n=
anoMIPS - part 6
>=20
> On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> > From: Stefan Markovic <smarkovic@wavecomp.com>
> >
> > Add emulation of DSP ASE instructions for nanoMIPS - part 6.
> >
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  target/mips/translate.c | 62 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 420a296..02ae3d9 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -17777,6 +17777,64 @@ static void gen_pool32axf_4_nanomips_insn(Disa=
sContext *ctx, uint32_t opc,
> >      tcg_temp_free(t0);
> >  }
> >
> > +static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t =
opc,
> > +                                          int rt, int rs, int rd)
> > +{
> > +    TCGv t0;
> > +    TCGv rs_t;
> > +
> > +    if (rt =3D=3D 0) {
> > +        /* Treat as NOP. */
> > +        return;
> > +    }
>=20
> This...
>=20
> > +
> > +    t0 =3D tcg_temp_new();
> > +    rs_t =3D tcg_temp_new();
> > +
> > +    gen_load_gpr(rs_t, rs);
> > +
> > +    switch (opc) {
> > +    case NM_SHRA_R_QB:
> > +        check_dspr2(ctx);
>=20
> ... misses out on these checks.
> Better off with the gen_store_gpr calls from the other ASE patches.
>=20

Yes, we switched to the gen_store_gpr() calls in v10, removed if(rt =3D=3D =
0) block, and harmonized handling that case with handling in other DSP patc=
hes.=
