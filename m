Received: from eggs.gnu.org ([2001:4830:134:3::10]:35461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXqUM-0005DO-E2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXqUH-0004Gu-Kp
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:10 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:47607
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dXqUH-0004Gl-Bt
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:05 -0400
Date: Wed, 19 Jul 2017 16:02:03 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170719150203.GF6973@jhogan-linux.le.imgtec.org>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<742650a35d49502a994c008fd3a70eccd5391f1b.1500378931.git-series.james.hogan@imgtec.com>
	<dfb9c8fe-0779-89d4-dbab-5b030f6666be@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jbjSy6MlVbxVYm72"
Content-Disposition: inline
In-Reply-To: <dfb9c8fe-0779-89d4-dbab-5b030f6666be@imgtec.com>
Subject: Re: [Qemu-devel] [PATCH 4/14] target/mips: Add CP0_Ebase.WG (write
 gate) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

--jbjSy6MlVbxVYm72
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 03:54:47PM +0100, Yongbok Kim wrote:
>=20
>=20
> On 18/07/2017 12:55, James Hogan wrote:
> > Add support for the CP0_EBase.WG bit, which allows upper bits to be
> > written (bits 31:30 on MIPS32, or bits 63:30 on MIPS64), along with the
> > CP0_Config5.CV bit to control whether the exception vector for Cache
> > Error exceptions is forced into KSeg1.
> >=20
> > This is necessary on MIPS32 to support Segmentation Control and Enhanced
> > Virtual Addressing (EVA) extensions (where KSeg1 addresses may not
> > represent an unmapped uncached segment).
> >=20
> > It is also useful on MIPS64 to allow the exception base to reside in
> > XKPhys, and possibly out of range of KSEG0 and KSEG1.
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> > Changes in v2:
> > - Fix CP0_EBase.WG to be read only when WG is not set in
> >   CP0_EBase_rw_bitmask, otherwise it will be wrongly probed as present.
> > - Make cache error exception vector conditional on Config3.SC as well as
> >   Config5.CV, as per the PRA, and take the CP0C3_SC definition from
> >   patch 7 (Yongbok).
> > - Rename CP0_EBase_rw_bitmask to CP0_EBaseWG_rw_bitmask (Yongbok).
> > ---
> >  target/mips/cpu.h            |  5 ++++-
> >  target/mips/helper.c         | 14 ++++++++------
> >  target/mips/machine.c        |  6 +++---
> >  target/mips/op_helper.c      | 12 ++++++++++--
> >  target/mips/translate.c      |  8 +++++---
> >  target/mips/translate_init.c |  1 +
> >  6 files changed, 31 insertions(+), 15 deletions(-)
> >=20
>=20
>=20
> > --- a/target/mips/op_helper.c
> > +++ b/target/mips/op_helper.c
> > @@ -1515,14 +1515,22 @@ target_ulong helper_mftc0_ebase(CPUMIPSState *e=
nv)
> > =20
> >  void helper_mtc0_ebase(CPUMIPSState *env, target_ulong arg1)
> >  {
> > -    env->CP0_EBase =3D (env->CP0_EBase & ~0x3FFFF000) | (arg1 & 0x3FFF=
F000);
> > +    target_ulong mask =3D 0x3FFFF000 | env->CP0_EBaseWG_rw_bitmask;
> > +    if (arg1 & (1 << CP0EBase_WG) & mask) {
>=20
> isn't it just ...?
> if (arg1 & env->CP0_EBaseWG_rw_bitmask) {

I suppose, now that the field is specific to the WG bit.

Thanks
James

>=20
> > +        mask |=3D ~0x3FFFFFFF;
> > +    }
> > +    env->CP0_EBase =3D (env->CP0_EBase & ~mask) | (arg1 & mask);
> >  }
> > =20
> >  void helper_mttc0_ebase(CPUMIPSState *env, target_ulong arg1)
> >  {
> >      int other_tc =3D env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
> >      CPUMIPSState *other =3D mips_cpu_map_tc(env, &other_tc);
> > -    other->CP0_EBase =3D (other->CP0_EBase & ~0x3FFFF000) | (arg1 & 0x=
3FFFF000);
> > +    target_ulong mask =3D 0x3FFFF000 | env->CP0_EBaseWG_rw_bitmask;
> > +    if (arg1 & (1 << CP0EBase_WG) & mask) {
>=20
> here as well.
>=20
> > +        mask |=3D ~0x3FFFFFFF;
> > +    }
> > +    other->CP0_EBase =3D (other->CP0_EBase & ~mask) | (arg1 & mask);
> >  }
> > =20
>=20
>=20
> Otherwise,
> Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
>=20
> Regards,
> Yongbok

--jbjSy6MlVbxVYm72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllvdGEACgkQbAtpk944
dnrckg/+Mp7EwrNuHN1QPDL+1l5vDUZF8pxvq4ADxXJP0P1WGPSrAE5jIcpN4Tj/
Zx42bEk9WOOVyi7pmJOzwh2qiY8twQlWYgK6d1RnHMN6dJlv/K6V3jAKjUvFVkFU
5Bn00AoYRB5S1fgrjdMkqbUEqVrBmqKPUAnA1QuX3WfcnQkQT1AfRxgKP5KmP2KM
h5TCg9F8R+hrZepbsD5vPzFPCfCEeQUA31L1c1H7MZ9KWynCYcn8VfgG6Aq+eVwp
MuB2NCmTzXJ6DpikEUYy00n2uwOdkDaw+YJSmbJhYHyxzCYNMTjlFaVENKtGtjh+
l3vInt4iWuIlyfb2y61p8xsjBPXrAi5gy5XKr64PhVHAj37RnYiHC+GR2mH2g4PH
lDDNRe2UJagwdIRJjBRQvjcJzdZXm9gc6wKWZ5G3pYXApqLQSxuX3UXUuutlRwwW
EvIYQTQ4EpbAy9VfCr1IR8EXrv99tJ2DmVRKDkbd6r8o0uE5hlVGr7OMdzdQC8fm
iYHE0UY/rj7NFveHobyxTCGlVvbjEJ0Srttwtu3QCgeWQtROTI3Xv+pP97H2mo1s
6610iKn0RrzVAHEZ/w6AlXZq/buFTuJvi/pnM/gXdNidYqO11iXiFi5gJlq8HfA9
GjywiUxB8TE2uKkEoW7spT5qu/4FXKC9iWWQwFbNFNPDItb52RU=
=MHvd
-----END PGP SIGNATURE-----

--jbjSy6MlVbxVYm72--
