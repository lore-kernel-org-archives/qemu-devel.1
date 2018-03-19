Received: from eggs.gnu.org ([2001:4830:134:3::10]:56130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim4-0006Yf-6M
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim2-0000HZ-V9
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:40 -0400
Date: Mon, 19 Mar 2018 11:21:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180319002149.GB3905@umbus.fritz.box>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
	<CAFEAcA9Uv_EyW6E=6cp+9QDCa4w13WxHQ5pCGp6E-3iOhq-mWg@mail.gmail.com>
	<20180317040215.GE4525@umbus.fritz.box>
	<CAFEAcA95=S4A6EhP1ZZROxCUT4iQzC6g8xiHixm9yRtOkbkM1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <CAFEAcA95=S4A6EhP1ZZROxCUT4iQzC6g8xiHixm9yRtOkbkM1Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/9] ppc-for-2.12 queue 20180315
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, surajjs@au1.ibm.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 17, 2018 at 10:08:26AM +0000, Peter Maydell wrote:
> On 17 March 2018 at 04:02, David Gibson <david@gibson.dropbear.id.au> wro=
te:
> > On Fri, Mar 16, 2018 at 05:25:04PM +0000, Peter Maydell wrote:
> >> Hi -- this looks like it provokes new runtime error warnings from the
> >> clang sanitizer:
> >
> > Hrm.  What options do you need to trip these warnings?  Just using
> > --cc=3Dclang doesn't give them to me, and using --enable-sanitizers
> > gives my piles of unrelated warnings.
>=20
> https://wiki.qemu.org/Testing#clang_UBSan documents the necessary
> cflags.

Thanks.

> >> TEST: tests/boot-serial-test... (pid=3D926)
> >>   /ppc/boot-serial/ppce500:                                           =
 OK
> >>   /ppc/boot-serial/prep:                                              =
 OK
> >>   /ppc/boot-serial/40p:                                               =
 OK
> >>   /ppc/boot-serial/g3beige:                                           =
 OK
> >>   /ppc/boot-serial/mac99:                                             =
 OK
> >>   /ppc/boot-serial/sam460ex:
> >> /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
> >> runtime error: load of value 142, which is not a valid value for type
> >> 'bool'
> >> OK
> >>
> >> TEST: tests/boot-serial-test... (pid=3D1016)
> >>   /ppc64/boot-serial/ppce500:                                         =
 OK
> >>   /ppc64/boot-serial/prep:                                            =
 OK
> >>   /ppc64/boot-serial/40p:                                             =
 OK
> >>   /ppc64/boot-serial/mac99:                                           =
 OK
> >>   /ppc64/boot-serial/pseries:                                         =
 OK
> >>   /ppc64/boot-serial/powernv:                                         =
 OK
> >>   /ppc64/boot-serial/sam460ex:
> >> /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
> >> runtime error: load of value 85, which is not a valid value for type
> >> 'bool'
> >> OK
> >>
> >> Looks like you're not initializing ctx->lazy_tlb_flush for all configs:
> >>     if (env->mmu_model =3D=3D POWERPC_MMU_32B ||
> >>         env->mmu_model =3D=3D POWERPC_MMU_601 ||
> >>         (env->mmu_model & POWERPC_MMU_64B))
> >>             ctx->lazy_tlb_flush =3D true;
> >>
> >> should perhaps be
> >>     ctx->lazy_tlb_flush =3D
> >>         env->mmu_model =3D=3D POWERPC_MMU_32B ||
> >>         env->mmu_model =3D=3D POWERPC_MMU_601 ||
> >>         (env->mmu_model & POWERPC_MMU_64B);
> >>
> >> ?
> >
> > Uh.. maybe.. except I don't see anything in the series that would be
> > likely to change that behaviour.
>=20
> I imagine it's "tests/boot-serial: Test the sam460ex board" --
> this code was previously not being exercised in 'make check',
> and now it is.

Yeah, looks like.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqvAp0ACgkQbDjKyiDZ
s5Ky0A/9HyWdgUIW3CBVQvrdr7FY8GifQvCH1cYS2Sa+EUlyChGZ/gOOcQOwt0Zi
slpbZ8tsFmNP6rMn/GtOxNQPu+smWri5IkLTg5FfKNGZ1FtMMc9TKPmcBOdEMkp4
NTQAWCMEhF+yh4CHJMgAzSsGgWSd3j/ZrSOozn/7SwtGOOBj/YsBFtw61XETCCXD
d82cBrMm6cgFzLNSSmg2mONEonxPslFzIU9k5osjDritjIcInarCfLpwhtQYxeDf
AHtwcnskHkU45w6iNDifS6pLPQhrAPt7boCbvupLhJ5HINFLGkof0SzX9v4lkqUq
uQGwuhQPF2sHPNvLFdi2KgE3B7ZJlwzC0ZM4WEHI446nLOvs5RbmtjguJoyxFIiC
7/ar2SGpYSV10FOkN52iHMhZUZ0Gw1kJ23g8KTNKfaKb8N36sH44y441vMeIZMRi
yz08ry0YD1JjzwnZCSnVXwBCB7s9S1dHSr1uxm8qtQ3z54l8vvGvnB+U1khG3ah1
7fSIH54h5g13NaOFnY9GdQ4D8A3MaIE4XwEVErp7Fr326i9QxVtJsLol5CsG5+OJ
7YzmeIJzStxOCzHWFXCNqoMPlCAwgEU7QJbhR3IxTe0uaavehtLv44/rWJzLVaOa
i7kyvrcx2MkwQ9W1ehBq4e5ke5TdBRaroUW5lh00daJCAfucRBo=
=qBFR
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
