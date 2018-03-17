Received: from eggs.gnu.org ([2001:4830:134:3::10]:59441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ex33p-0004dz-QK
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 00:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ex33m-00061P-I5
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 00:03:13 -0400
Date: Sat, 17 Mar 2018 15:02:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180317040215.GE4525@umbus.fritz.box>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
	<CAFEAcA9Uv_EyW6E=6cp+9QDCa4w13WxHQ5pCGp6E-3iOhq-mWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Uv_EyW6E=6cp+9QDCa4w13WxHQ5pCGp6E-3iOhq-mWg@mail.gmail.com>
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


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 05:25:04PM +0000, Peter Maydell wrote:
> On 15 March 2018 at 04:18, David Gibson <david@gibson.dropbear.id.au> wro=
te:
> > The following changes since commit 026aaf47c02b79036feb830206cfebb2a726=
510d:
> >
> >   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-=
request' into staging (2018-03-13 16:26:44 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180315
> >
> > for you to fetch changes up to a9ab8cc157054ea6941fb849c78d9e6c515a7730:
> >
> >   target/ppc: fix tlbsync to check privilege level depending on GTSE (2=
018-03-15 11:18:31 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue for 2018-03-15
> >
> > Here's the set of accumulated patches now that we're into soft freeze.
> > I've split new functionality into a ppc-for-2.13 branch, so this only
> > has bugfixes.  Well.. and a couple of simple cleanups to make bugfixes
> > easier, some test improvements and a trivial change to make command
> > line options more obvious.  I think those are all acceptable for soft
> > freeze.
> >
>=20
> Hi -- this looks like it provokes new runtime error warnings from the
> clang sanitizer:

Hrm.  What options do you need to trip these warnings?  Just using
--cc=3Dclang doesn't give them to me, and using --enable-sanitizers
gives my piles of unrelated warnings.

>=20
> TEST: tests/boot-serial-test... (pid=3D926)
>   /ppc/boot-serial/ppce500:                                            OK
>   /ppc/boot-serial/prep:                                               OK
>   /ppc/boot-serial/40p:                                                OK
>   /ppc/boot-serial/g3beige:                                            OK
>   /ppc/boot-serial/mac99:                                              OK
>   /ppc/boot-serial/sam460ex:
> /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
> runtime error: load of value 142, which is not a valid value for type
> 'bool'
> OK
>=20
> TEST: tests/boot-serial-test... (pid=3D1016)
>   /ppc64/boot-serial/ppce500:                                          OK
>   /ppc64/boot-serial/prep:                                             OK
>   /ppc64/boot-serial/40p:                                              OK
>   /ppc64/boot-serial/mac99:                                            OK
>   /ppc64/boot-serial/pseries:                                          OK
>   /ppc64/boot-serial/powernv:                                          OK
>   /ppc64/boot-serial/sam460ex:
> /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
> runtime error: load of value 85, which is not a valid value for type
> 'bool'
> OK
>=20
> Looks like you're not initializing ctx->lazy_tlb_flush for all configs:
>     if (env->mmu_model =3D=3D POWERPC_MMU_32B ||
>         env->mmu_model =3D=3D POWERPC_MMU_601 ||
>         (env->mmu_model & POWERPC_MMU_64B))
>             ctx->lazy_tlb_flush =3D true;
>=20
> should perhaps be
>     ctx->lazy_tlb_flush =3D
>         env->mmu_model =3D=3D POWERPC_MMU_32B ||
>         env->mmu_model =3D=3D POWERPC_MMU_601 ||
>         (env->mmu_model & POWERPC_MMU_64B);
>=20
> ?

Uh.. maybe.. except I don't see anything in the series that would be
likely to change that behaviour.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqsk0QACgkQbDjKyiDZ
s5JcLBAAnSyk01ehqOHhvFlL8ZA2UYYbSK6ABpenb7RFUWj39KtoCxXHuCLbTB8y
NJZ7KBP5FyNcIgAfuksbJyznCF7D3E3GrZvs3D4YmiPOhg7irG+1Mzd7REceNDHr
my43Vkv2UAwF/f2SaWZM1/kEhUGunVeavFhpf9OYnswwsbm8ABTTBeVL6JSKmemb
9XWEoaUplIv3gakV2M5CSEKrbHh8XEl5HVqAsvyBR7hbFS6sQ7VtXhZ97aShHwrT
kEkRWBoJlOvNgEN6/IQA50ZAO7Ts69Ul5yVYnPYiul5nSNFnwhpJdpUOJ+MrYx17
ds3bs4Pqvi3QYuYCKIgEBcvJUCEUOoN/mr6mFcu7rk95rg5Iz6Fro3dS5m79ws/J
6/UQniDAz/58Kl2pErGcA6N8/8e/VzSJdnHKNgCzdEO8dAl+9bPJoAf2HXaXd3Za
72EoAeZ4rIco/mK7YafE9I6gqRoxeUurXjAGMSE+S7N9tUHKkhyORrFvjK7SNczm
hg5yWSB6MmE8P/xZMRFDExmWvExqsNxwYLdSoRAKfIdRXMa2xXx0u4TeO/iU5MzJ
oA6jRY/E+w68i/VaCSg5UzA0E2eVyvWnit8BQmEUC23KBy3jn9loCkH6U5HH1NN0
VubvGNu0j+I+RqrPxDYYJ6eMB87u2hS+B1V77OzdJabJND1pZZ4=
=PVp5
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
