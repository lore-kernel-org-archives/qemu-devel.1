Received: from eggs.gnu.org ([2001:4830:134:3::10]:56341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXroE-0006Ae-1t
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXroC-0004qq-Uj
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:26:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:55968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXroC-0004q3-NZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:26:44 -0400
Date: Wed, 19 Jul 2017 18:26:40 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170719162640.626jhtrynleoz5t5@aurel32.net>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<ffb745754ddd4f389935cfb2ad4b6f3e560a2655.1500378931.git-series.james.hogan@imgtec.com>
	<20170719102750.6br5bsfz5wbskfzm@aurel32.net>
	<20170719134418.GE6973@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hldvwhj7f6u6hfgs"
Content-Disposition: inline
In-Reply-To: <20170719134418.GE6973@jhogan-linux.le.imgtec.org>
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
To: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, qemu-devel@nongnu.org, Petar Jovanovic <petar.jovanovic@imgtec.com>


--hldvwhj7f6u6hfgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-07-19 14:44, James Hogan wrote:
> On Wed, Jul 19, 2017 at 12:27:50PM +0200, Aurelien Jarno wrote:
> > On 2017-07-18 12:55, James Hogan wrote:
> > > Using MFC0 to read CP0_UserLocal uses tcg_gen_ld32s_tl, however
> > > CP0_UserLocal is a target_ulong. On a big endian host with a MIPS64
> > > target this reads and sign extends the more significant half of the
> > > 64-bit register.
> > >=20
> > > Fix this by using ld_tl to load the whole target_ulong and ext32s_tl =
to
> > > sign extend it, as done for various other target_ulong COP0 registers.
> > >=20
> > > Fixes: d279279e2b5c ("target-mips: implement UserLocal Register")
> > > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > > Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> > > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > > Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
> > > ---
> > > Changes in v2:
> > > - New patch.
> > > ---
> > >  target/mips/translate.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > > index 3022f349cb2a..556aba969a12 100644
> > > --- a/target/mips/translate.c
> > > +++ b/target/mips/translate.c
> > > @@ -5138,8 +5138,9 @@ static void gen_mfc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
> > >              goto cp0_unimplemented;
> > >          case 2:
> > >              CP0_CHECK(ctx->ulri);
> > > -            tcg_gen_ld32s_tl(arg, cpu_env,
> > > -                             offsetof(CPUMIPSState, active_tc.CP0_Us=
erLocal));
> > > +            tcg_gen_ld_tl(arg, cpu_env,
> > > +                          offsetof(CPUMIPSState, active_tc.CP0_UserL=
ocal));
> > > +            tcg_gen_ext32s_tl(arg, arg);
> > >              rn =3D "UserLocal";
> > >              break;
> > >          default:
> >=20
> > I think this is what gen_mfc0_load64() does, that said this whole area
>=20
> Ah yes, that could do with some wider use (and possibly s/64/tl/ or
> something).
>=20
> > probably need a rework (see for example how inefficiently
> > gen_mfc0_load32 is implemented). So:
>=20
> Erm, doesn't gen_mfc0_load32() fail to sign extend as it should when
> used for mfc0...?

Yes, this is correct. tcg_gen_ext_i32_tl sign-extends the value when
converting it from TCGv_i32 to TCGv_tl. tcg_gen_extu_i32_tl is the op
which zero-extends the value. Basically TCG sign-extends the value "by
default", like for MIPS.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--hldvwhj7f6u6hfgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEd0YmQqnvlP0Pdxltupx4Bh3djJsFAllviEAACgkQupx4Bh3d
jJvJBhAAuuYpB/0JOo2E7mbkYxxcsJo07v9k8EjcVRSGjOlLobQ2ApWFLFSWtWnz
wZlpi/fyCZWeOF3KRvH+W3amHgDe8B176HRmv80NYY+cSL6VAk4quAxd8PTFwG+6
1HKTmsYZ1dVQ2fsQU1fOTHRZeDKAjfu+h5cNKSoRILEjpTHP+he2AedlECWwY2H7
baGEC3cZNJHtm3o+4j/5k9U7iR0UAu/F1qZZC8Qj0OeQDBiuSR3nhrwyG5YILgXG
yYJhExLGJsjlgktt15u4oZt+qu4FbFauUmq8PXRv9gjVHEKn66bIyiTFCE+ROCdE
7tK2Y3+4A9jFNTef5GcMSv/36EfO3JM3Cd/20DA9qUXwe+iUHiOs2CVeFW/rexVK
HYR5cOx3tPVNtT/CCwQSTSaqRtOoRb/O2XaJ0F7V6+MH3j3iwVVDA4mS4wI3pm+Y
dVmFEVeIek6acypo5IzUkad0w2ijEq+k/RkEbyKbreEBpPi+O3Vs2CYu+uWNo/+T
xXABTRAZPtne6cwOOTBk3GQ0loXN8mxbNK/QGuhpqFPGLBnSTg2hnyPx60eelDNo
0u4o9czCxefZk5vxmB8BHRnIzQW5Vms6HiBxAmHAkXaKdF3eybxsj0dR3F6toxT6
BanqGlwep0HKVxP7WCFRpimmM5A+REjIm6KukMjLyxpJ3T1GlqM=
=Lf0b
-----END PGP SIGNATURE-----

--hldvwhj7f6u6hfgs--
