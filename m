Received: from eggs.gnu.org ([2001:4830:134:3::10]:43922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXpHE-00081k-DH
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXpHA-0006pW-CB
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:44:32 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:47018
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dXpHA-0006nx-3z
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:44:28 -0400
Date: Wed, 19 Jul 2017 14:44:18 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170719134418.GE6973@jhogan-linux.le.imgtec.org>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<ffb745754ddd4f389935cfb2ad4b6f3e560a2655.1500378931.git-series.james.hogan@imgtec.com>
	<20170719102750.6br5bsfz5wbskfzm@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YQqXcV2RhGcBJl4C"
Content-Disposition: inline
In-Reply-To: <20170719102750.6br5bsfz5wbskfzm@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH 1/14] target/mips: Fix MIPS64 MFC0
 UserLocal on BE host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, qemu-devel@nongnu.org, Petar Jovanovic <petar.jovanovic@imgtec.com>

--YQqXcV2RhGcBJl4C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 12:27:50PM +0200, Aurelien Jarno wrote:
> On 2017-07-18 12:55, James Hogan wrote:
> > Using MFC0 to read CP0_UserLocal uses tcg_gen_ld32s_tl, however
> > CP0_UserLocal is a target_ulong. On a big endian host with a MIPS64
> > target this reads and sign extends the more significant half of the
> > 64-bit register.
> >=20
> > Fix this by using ld_tl to load the whole target_ulong and ext32s_tl to
> > sign extend it, as done for various other target_ulong COP0 registers.
> >=20
> > Fixes: d279279e2b5c ("target-mips: implement UserLocal Register")
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
> > ---
> > Changes in v2:
> > - New patch.
> > ---
> >  target/mips/translate.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 3022f349cb2a..556aba969a12 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -5138,8 +5138,9 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
> >              goto cp0_unimplemented;
> >          case 2:
> >              CP0_CHECK(ctx->ulri);
> > -            tcg_gen_ld32s_tl(arg, cpu_env,
> > -                             offsetof(CPUMIPSState, active_tc.CP0_User=
Local));
> > +            tcg_gen_ld_tl(arg, cpu_env,
> > +                          offsetof(CPUMIPSState, active_tc.CP0_UserLoc=
al));
> > +            tcg_gen_ext32s_tl(arg, arg);
> >              rn =3D "UserLocal";
> >              break;
> >          default:
>=20
> I think this is what gen_mfc0_load64() does, that said this whole area

Ah yes, that could do with some wider use (and possibly s/64/tl/ or
something).

> probably need a rework (see for example how inefficiently
> gen_mfc0_load32 is implemented). So:

Erm, doesn't gen_mfc0_load32() fail to sign extend as it should when
used for mfc0...?

>=20
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

Cheers
James

--YQqXcV2RhGcBJl4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllvYikACgkQbAtpk944
dnpQlg//aA/q1Fz4fVz6QgMKbaM9Myw7kBQUrtGroGw3bDkPrRjrq6VqYeRJvVW+
STYqckRI+XzZvAht+orSqHa8v8fBA7qQ46XPGR6Bl5sSOqcqEJEWuv5kwc5bOhaL
w+XUSVeZZTaEMFI8ZBziBp8YggSJOmzZapVFmKpM+RzX15LGecDtLGETpPH0a/Qy
slG4mYv9EhymBfyAv//jTRDySHF8BqZSz0I379gcg8z6yyyCQwqgfcUBXA7AymPZ
1lXycANcboWidCpTJAum9xH5u5aj1zkaFmq3lqHtDplrOIPeGkxwZCXsN4D0DgpB
k2F3X8qcpwsOOCNA9n8tCoGcmTqi0u7fX0XZWiqifmgLdVICsilyOo8NlcTq3EHu
cNzhYFhe+FTanYZunXEaKXpAVJWuyfl4zo+pecLpF9VNIxS8BmlbWdRu12DDH0DT
Ddxu/IEFxHJHJvf1PobbCk9ArycypCRXNZ8myTb7+mjzIWVZd0/2oCU6BYX12fRY
grDKR5fACs6DO86xD2AE8OCpFPFGcmPgffm9AauqvsZ9+rynkXtdfQ+Jx3pZ+c8d
k/+rOMeMbUX92GViJPNtZublgPMW/UXT4VRhovbIcc528qZnfv/+k1ieJOYijWj6
HMOZ6Qg+yQGTQzduutunZsOoGYCXGT7BVyV1NNMO68ZQZoZCz2c=
=J1Ac
-----END PGP SIGNATURE-----

--YQqXcV2RhGcBJl4C--
