Received: from eggs.gnu.org ([2001:4830:134:3::10]:56170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim6-0006Yq-4d
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim2-0000HY-Uv
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:42 -0400
Date: Mon, 19 Mar 2018 11:21:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180319002116.GA3905@umbus.fritz.box>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
	<CAFEAcA9Uv_EyW6E=6cp+9QDCa4w13WxHQ5pCGp6E-3iOhq-mWg@mail.gmail.com>
	<20180317040215.GE4525@umbus.fritz.box>
	<CAFEAcA95=S4A6EhP1ZZROxCUT4iQzC6g8xiHixm9yRtOkbkM1Q@mail.gmail.com>
	<alpine.BSF.2.21.1803171212100.8314@zero.eik.bme.hu>
	<alpine.BSF.2.21.1803171226110.8314@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1803171226110.8314@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/9] ppc-for-2.12 queue 20180315
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 17, 2018 at 12:30:58PM +0100, BALATON Zoltan wrote:
> On Sat, 17 Mar 2018, BALATON Zoltan wrote:
> > On Sat, 17 Mar 2018, Peter Maydell wrote:
> > > On 17 March 2018 at 04:02, David Gibson
> > > <david@gibson.dropbear.id.au> wrote:
> > > > On Fri, Mar 16, 2018 at 05:25:04PM +0000, Peter Maydell wrote:
> > > > > Hi -- this looks like it provokes new runtime error warnings from=
 the
> > > > > clang sanitizer:
> > > >=20
> > > > Hrm.  What options do you need to trip these warnings?  Just using
> > > > --cc=3Dclang doesn't give them to me, and using --enable-sanitizers
> > > > gives my piles of unrelated warnings.
> > >=20
> > > https://wiki.qemu.org/Testing#clang_UBSan documents the necessary
> > > cflags.
> > >=20
> > > >=20
> > > > >=20
> > > > > TEST: tests/boot-serial-test... (pid=3D926)
> > > > >   /ppc/boot-serial/ppce500:                                      =
      OK
> > > > >   /ppc/boot-serial/prep:                                         =
      OK
> > > > >   /ppc/boot-serial/40p:                                          =
      OK
> > > > >   /ppc/boot-serial/g3beige:                                      =
      OK
> > > > >   /ppc/boot-serial/mac99:                                        =
      OK
> > > > >   /ppc/boot-serial/sam460ex:
> > > > > /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979=
:15:
> > > > > runtime error: load of value 142, which is not a valid value for =
type
> > > > > 'bool'
> > > > > OK
> > > > >=20
> > > > > TEST: tests/boot-serial-test... (pid=3D1016)
> > > > >   /ppc64/boot-serial/ppce500:                                    =
      OK
> > > > >   /ppc64/boot-serial/prep:                                       =
      OK
> > > > >   /ppc64/boot-serial/40p:                                        =
      OK
> > > > >   /ppc64/boot-serial/mac99:                                      =
      OK
> > > > >   /ppc64/boot-serial/pseries:                                    =
      OK
> > > > >   /ppc64/boot-serial/powernv:                                    =
      OK
> > > > >   /ppc64/boot-serial/sam460ex:
> > > > > /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979=
:15:
> > > > > runtime error: load of value 85, which is not a valid value for t=
ype
> > > > > 'bool'
> > > > > OK
> > > > >=20
> > > > > Looks like you're not initializing ctx->lazy_tlb_flush for all co=
nfigs:
> > > > >     if (env->mmu_model =3D=3D POWERPC_MMU_32B ||
> > > > >         env->mmu_model =3D=3D POWERPC_MMU_601 ||
> > > > >         (env->mmu_model & POWERPC_MMU_64B))
> > > > >             ctx->lazy_tlb_flush =3D true;
> > > > >=20
> > > > > should perhaps be
> > > > >     ctx->lazy_tlb_flush =3D
> > > > >         env->mmu_model =3D=3D POWERPC_MMU_32B ||
> > > > >         env->mmu_model =3D=3D POWERPC_MMU_601 ||
> > > > >         (env->mmu_model & POWERPC_MMU_64B);
> > > > >=20
> > > > > ?
> > > >=20
> > > > Uh.. maybe.. except I don't see anything in the series that would be
> > > > likely to change that behaviour.
> > >=20
> > > I imagine it's "tests/boot-serial: Test the sam460ex board" --
> > > this code was previously not being exercised in 'make check',
> > > and now it is.
> >=20
> > I'm not sure what could cause this in case of sam460ex. It has PPC440
> > which has POWERPC_MMU_BOOKE but the ppce500 should also have that and a
> > similar u-boot and that does not produce this error. Is there maybe some
> > initialisation of some structure I've missed somewhere? But these
> > DisasContext structs seem to be internal to TCG so I'm not sure what
> > could be missing outside of TCG to avoid this. Could be that the
> > different u-boot version does something that triggers this while the one
> > for ppce500 does not execute code that causes this warning during the
> > test?
>=20
> Oops, replied too soon. I've checked e500 and it seems to have
> POWERPC_MMU_BOOKE206 (I thought e500 was BookE but I don't know these very
> well). Only bamboo, virtex-ml507 and sam460ex seem to be POWERPC_MMU_BOOKE
> so if only the sam460ex test is added now and the others were never tested
> then it could be this is the first time this is catched.

Thanks for the pointer.  I've now confirmed that the sam460ex test was
the problem.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqvAnoACgkQbDjKyiDZ
s5L7RBAArSuGN4oGtcjbhDPEW6DzlHiSuFVFrRx4QvvNh7kgTJd7ESBdcuUwSxPQ
AZ5HHSIDXJHae0GTmIVlOuZl9EX54s4QC1/lIYiqgDGnWJjPpCRwXkScSJuwqUlv
LBCua6/yAeCu2tWa/GDoT9llYSwGAhMmZcOgmH1skpu0jcdDTtcmgqtSCRCRRHx0
Dk3AlUzog7ptAGC0ALY5nrPR9YdeKXCs3fYKL1WbrA4dFH9/a0yGy+w09vxvYzHl
PxmeejWW5A/4OJTyeqdQSh7IGQ7Eh/4g/UrNa0bdXdsIGnnLuqQ7AEz6h3gZcnpk
PZYxjt3NCTgMwjNcGjuai0bl4GO/AwFZJVqvoBWtlMEQCA9oADiFD+fKSZDyN5Wl
cZyEXi7zpqd33CswVBNXqWNAVQ4j5Cavxh4nMgS70aeCzx11KsiqFOURA0MXS5Dk
+wAFFejGyH0rBL/oMGheNCDH12ganNJSv799+79Bze9PdvJcUKdxWMZaqysxktXH
zt85JMlC49JNOVw6DBp9616Vj58qAp8HOJTuHAD5fQrTZSfOD90hCOfxSSRPllle
YvAeu6vLNzcYl6YpJyjyLdIHpeaZQNIkJgGjaFqxXFs1DfAl3wjT5ukTxm+jzzEw
la6wANWuHQwr2vDcnWVhXv8oc9kzLQ6+Lysg5356D7XuWT0cPiY=
=fqsX
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
