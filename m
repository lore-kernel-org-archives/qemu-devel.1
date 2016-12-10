Received: from eggs.gnu.org ([2001:4830:134:3::10]:33396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFqgK-0008SV-OS
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 18:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFqgG-0002OX-Ql
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 18:03:52 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:45703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cFqgG-0002OP-Jl
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 18:03:48 -0500
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8A382642FA
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 00:03:46 +0100 (CET)
Date: Sun, 11 Dec 2016 00:03:41 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161211000341.19d4192c@bahia>
In-Reply-To: <4d3cb602-acd8-42d2-43d7-c67c3c933aeb@redhat.com>
References: <148127558476.2633.13433882390740185948.stgit@bahia>
	<148127568042.2633.5084932697061472826.stgit@bahia>
	<85cb0570-87e5-8396-dd04-eb6400226278@redhat.com>
	<20161210145708.7a1d7b93@bahia>
	<4d3cb602-acd8-42d2-43d7-c67c3c933aeb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/YgFXxQW6dNpfm05SUUGo3xH";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/8] 9pfs: fix P9_NOTAG and P9_NOFID macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/YgFXxQW6dNpfm05SUUGo3xH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Dec 2016 10:24:35 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 12/10/2016 07:57 AM, Greg Kurz wrote:
>=20
> >>> -#define P9_NOTAG    (u16)(~0)
> >>> -#define P9_NOFID    (u32)(~0)
> >>> +#define P9_NOTAG    (uint16_t)(~0)
> >>> +#define P9_NOFID    (uint32_t)(~0)   =20
> >>
> >> Don't you want to write ((uint16_t)(~0)), to ensure that this expressi=
on
> >> can be used as a drop-in in any other syntactical situation?
> >> =20
> >=20
> > These defines come from the linux kernel sources and I must admit it
> > didn't cross my mind... can you share a case where this would cause
> > troubles ? =20
>=20
> Unlikely to occur in real code, but:
>=20
>   int a[] =3D { -2, -3 };
>   int *b =3D a + 1;
>   printf("%d\n", (uint16_t)(~0)[b]); // prints 65534 - let's see why?
>=20
>   // prints 65534, or the result of b[-1] cast to uint16_t
>   printf("%d\n", (uint16_t)((~0)[b]));
>=20
>   // probably dumps core, as b[65535] is out of bounds
>   printf("%d\n", ((uint16_t)(~0))[b]);
>=20
> that is, since [] has higher precedence than casts, failure to
> parenthesize a cast will change the interpretation of P9_NOTAG[pointer].
>=20

... which is indeed very unlikely to happen even if it is legit. :)

> And yes, if you copied from the kernel, that means the kernel has a bug
> (even if it is unlikely to trip up normal code).
>=20

I'll send a patch there too.

>=20
> >  =20
> >> Or even write it as UINT16_C(~0) (using <stdint.h>), or as UINT16_MAX.
> >> (Be aware: the type of (uint16_t)(~0) is uint16_t, while the type of
> >> UINT16_MAX is int, due to the rules of integer promotion, if that matt=
ers)
> >> =20
> >=20
> > UINT16_C(~0) expands to ~0 and UINT16_MAX expands to (65535), at least =
on
> > my laptop (glibc-headers-2.23.1-11.fc24.x86_64)... doesn't that mean the
> > type of UINT16_C(~0) is also int ? Please enlighten me. =20
>=20
> Indeed, UINT16_C produces an int constant, not uint16_t (since there is
> no such thing as a uint16_t constant).  So the cast is the only way to
> force ~0 to be truncated to a 16-bit pattern.  But using UINT16_MAX is
> probably just fine, as it is the all-ones value with the correct integer
> promotion for use in any other arithmetic.
>=20
> >=20
> > The 9P spec at http://man.cat-v.org/plan_9/5/version says "(ushort)~0".=
 My
> > understanding is 16 bits all ones. I guess I'd rather then go for
> > ((uint16_t)(~0)). =20
>=20
> Verbose, but works, as does UINT16_MAX.  But I stand corrected that
> UINT16_C(~0) does not work.
>=20

Ok, I'll go the UINT16_MAX way then.

Thanks for the detailed explanation.

Cheers.

--
Greg

--Sig_/YgFXxQW6dNpfm05SUUGo3xH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhMic0ACgkQAvw66wEB28KyxQCgh8xzPNUecEpSd5GF6NPMylRw
F9AAn2xoUAd8vpkwhm3RZFG1Rw/6/xU4
=UlNO
-----END PGP SIGNATURE-----

--Sig_/YgFXxQW6dNpfm05SUUGo3xH--
