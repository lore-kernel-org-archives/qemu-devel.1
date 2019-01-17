Received: from eggs.gnu.org ([209.51.188.92]:34433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gkB4x-000466-Tc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gkB4v-0005N7-OJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:03:43 -0500
Received: from mail-eopbgr680127.outbound.protection.outlook.com
	([40.107.68.127]:37924
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gkB4v-0005GL-IV
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:03:41 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 17 Jan 2019 17:03:29 +0000
Message-ID: <BN6PR2201MB12512974D97B0E8BD05D162FC6830@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<dccb35585b1e6f333e6809234cb9eacf63d5a686.1547403692.git.noring@nocrew.org>,
	<BN6PR2201MB125192D10C9D6C9D52F0E01FC6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB125192D10C9D6C9D52F0E01FC6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/9] target/mips: Introduce 32 R5900
 128-bit multimedia registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Aleksandar Markovic
> Sent: Tuesday, January 15, 2019 10:20 PM
> To: Fredrik Noring; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: Re: [PATCH 2/9] target/mips: Introduce 32 R5900 128-bit multimed=
ia registers
>=20
> > From: Fredrik Noring <noring@nocrew.org>
> > Sent: Sunday, January 13, 2019 8:03 PM
> > To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> > Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> > Subject: [PATCH 2/9] target/mips: Introduce 32 R5900 128-bit multimedia=
 registers
> >
> > The 32 R5900 128-bit MMRs are split into two 64-bit halves: the lower
> > halves are the GPRs and the upper halves are accessible by the R5900-
> > specific multimedia instructions.
> >
> > Signed-off-by: Fredrik Noring <noring@nocrew.org>
> > ---

Since this patch is not a subject of any disagreement, and "#ifdef"
structure is of a cosmetic nature, I will do these minor cosmetic
changes while applying, and insert this patch in the next MIPS pull
request, scheduled shortly.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Other patches from this series will not be in the pull request.

> >  target/mips/cpu.h       |  2 ++
> >  target/mips/translate.c | 14 ++++++++++++--
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index 03c03fd8c6..9ff4a68d90 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -180,6 +180,8 @@ struct TCState {
> >  #define MXU_CR_RD_EN    1
> >  #define MXU_CR_MXU_EN   0
> >
> > +    /* Upper 64-bit MMRs (multimedia registers); the lower 64-bit are =
GPRs */
> > +    uint64_t mmr[32];
> >  };
> >
> >  typedef struct CPUMIPSState CPUMIPSState;
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index a538351032..9d5150ec8b 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -2455,7 +2455,10 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
> >  static TCGv_i64 fpu_f64[32];
> >  static TCGv_i64 msa_wr_d[64];
> >
> > -#if !defined(TARGET_MIPS64)
> > +#if defined(TARGET_MIPS64)
> > +/* Upper 64-bit MMRs (multimedia registers); the lower 64-bit are GPRs=
 */
> > +static TCGv_i64 cpu_mmr[32];
> > +#else
>=20
> Naming is perfect, but:
>=20
> #if-#else-#endif is confusing here:
> - MMR declaration should be under it own #if defined(TARGET_MIPS64)
> - MXU declaration should be under separate #if !defined(TARGET_MIPS64)
> (we are not dealing with two variants (64/32) of the same item, but with =
two
> separate items, one is valid for 64-bit only, another for 32-bit only)
>=20
> >  /* MXU registers */
> >  static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
> >  static TCGv mxu_CR;
> > @@ -29785,7 +29788,14 @@ void mips_tcg_init(void)
> >      fpu_fcr31 =3D tcg_global_mem_new_i32(cpu_env,
> >                                         offsetof(CPUMIPSState, active_f=
pu.fcr31),
> >                                         "fcr31");
> > -#if !defined(TARGET_MIPS64)
> > +#if defined(TARGET_MIPS64)
> > +    cpu_mmr[0] =3D NULL;
> > +    for (i =3D 1; i < 32; i++)
> > +        cpu_mmr[i] =3D tcg_global_mem_new_i64(cpu_env,
> > +                                            offsetof(CPUMIPSState,
> > +                                                     active_tc.mmr[i])=
,
> > +                                            regnames[i]);
> > +#else
> >      for (i =3D 0; i < NUMBER_OF_MXU_REGISTERS - 1; i++) {
> >          mxu_gpr[i] =3D tcg_global_mem_new(cpu_env,
> >                                          offsetof(CPUMIPSState,
> > --
>=20
> The same applies here.
>=20
> > 2.19.2
>=20
> =
