Received: from eggs.gnu.org ([2001:4830:134:3::10]:32840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1defyM-0006r4-LW
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1defyH-0006W2-NP
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:13:22 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:33072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1defyH-0006VR-Fu
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:13:17 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 029F489EB8
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 13:13:15 +0200 (CEST)
Date: Mon, 7 Aug 2017 13:13:09 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170807131309.6261ddfc@bahia.lan>
In-Reply-To: <e11535cd-242f-bfc2-d854-af3cc9044665@redhat.com>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
	<48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
	<5065c286-ad67-697e-bc02-84d66ad0682d@amsat.org>
	<20170803203805.141d0708@bahia.lan>
	<e11535cd-242f-bfc2-d854-af3cc9044665@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/GLaQFN_9GXtPpbkWi24fa55";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>

--Sig_/GLaQFN_9GXtPpbkWi24fa55
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Aug 2017 13:56:45 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/03/2017 01:38 PM, Greg Kurz wrote:
> > The following code snippet spits a warning with gcc-7.1.1-3.fc26 and -W=
all on
> > ppc64le AND x86_64:
> >=20
> > int foo(void)
> > {
> >     char empty_array[] =3D { };
> >     int i, ret =3D 0;
> >=20
> >     for (i =3D 0; i < (int) (sizeof(empty_array) / sizeof(empty_array[0=
])); i++) {
> >         ret =3D empty_array[i];
> >     }
> >=20
> >     return ret;
> > } =20
>=20
> Confirmed.  No idea why the cast makes gcc think i is uninitialized.
>=20

FYI, I've created a BZ to track this issue in gcc:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1478864

> >=20
> > If I drop the (int), the warning goes away... and so does the build bre=
ak
> > of qemu-system-ppc64 on my ppc64le host.
> >=20
> > I don't have 4.7.1 or 4.6 compilers around but I could check 4.8.5
> > is okay with that change FWIW. =20
>=20
> I tested with gcc 4.4.7 on RHEL 6, but -Wtype-limits there didn't warn
> whether or not the (int) was present; it's possible that we still need
> to test with 4.6 or 4.7.1 to see whether it makes a difference.
>=20
> >  =20
> >> Ok so let's stop losing time about compiler incoherent warnings, using=
=20
> >> -Wno-type-limits for GCC < 5...
> >> So we can keep a sane/understandable codebase, using size_t and no (in=
t)=20
> >> cast. =20
>=20
> That's also a possibility, if we still hit old compilers that require
> the (int).
>=20
> >> =20
> >=20
> > If I also convert 'int i' to 'size_t i' then I get the same error as
> > in commit 61c7bbd2:
> >=20
> > error: comparison of unsigned expression < 0 is always
> >  false [-Werror=3Dtype-limits] =20
>=20
> Confirmed with newer gcc, whether or not the (int) cast is present.
>=20


--Sig_/GLaQFN_9GXtPpbkWi24fa55
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmIS0UACgkQAvw66wEB28LFWwCeNZIcjnNjH2iVKNijWMqPWHp2
YpsAn10xOs6nZSTiQSKsNo1cyz6wxwmQ
=3jPc
-----END PGP SIGNATURE-----

--Sig_/GLaQFN_9GXtPpbkWi24fa55--
