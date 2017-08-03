Received: from eggs.gnu.org ([2001:4830:134:3::10]:41288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddL0j-0000XA-PK
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddL0h-0003f4-4X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:38:17 -0400
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:46046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ddL0g-0003dM-U8
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:38:15 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id D54DC65CAD
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 20:38:12 +0200 (CEST)
Date: Thu, 3 Aug 2017 20:38:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170803203805.141d0708@bahia.lan>
In-Reply-To: <5065c286-ad67-697e-bc02-84d66ad0682d@amsat.org>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
	<48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
	<5065c286-ad67-697e-bc02-84d66ad0682d@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/tbSQyWfHzovjlt1mKf8unEL";
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>

--Sig_/tbSQyWfHzovjlt1mKf8unEL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Aug 2017 11:07:13 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 08/03/2017 10:55 AM, Eric Blake wrote:
> > On 08/03/2017 08:34 AM, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >> Hi Greg,
> >>
> >> On 08/02/2017 11:47 AM, Greg Kurz wrote: =20
> >>> Building QEMU on fedora26 with the latest gcc package fails:
> >>>
> >>>     CC      ppc64-softmmu/target/ppc/kvm.o
> >>> In file included from include/sysemu/hw_accel.h:16:0,
> >>>                    from target/ppc/kvm.c:31:
> >>> target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=
=E2=80=99:
> >>> include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may=
 be used
> >>> uninitialized =20
> >  =20
> >>
> >> This sizeof() use looks unnatural to me. I wonder why not use size_t,
> >> since this is about sizeof()/ARRAY_SIZE(). The problem seems to come
> >> from the commit this cast was introduced (61c7bbd236):
> >>
> >> target-ppc/kvm.c:1302:21: error: comparison of unsigned expression < 0
> >> is always false [-Werror=3Dtype-limits]
> >>
> >> So I'd rather suggest this code, which looks more natural to read to m=
e:
> >>
> >>      if (ARRAY_SIZE(args_tmp)) {
> >>          for (i =3D 0; i < ARRAY_SIZE(args_tmp) && ... =20
>=20
> Oops I forgot to suggest size_t i.
>=20
> >=20
> > For that matter, the existing code is doing:
> >=20
> > int i;
> > i < (int)ARRAY_SIZE(args_tmp)
> >=20
> > but wouldn't that be better as:
> >=20
> > size_t i;
> > i < ARRAY_SIZE(args_temp)
> >=20
> > I guess we have both the old compilers (per commit 61c7bbd2) and the new
> > to worry about; although I was unable to reproduce it on Fedora 26 on
> > x86_64 (is this an architecture-dependent compiler bug?)
> >  =20
>=20

The following code snippet spits a warning with gcc-7.1.1-3.fc26 and -Wall =
on
ppc64le AND x86_64:

int foo(void)
{
    char empty_array[] =3D { };
    int i, ret =3D 0;

    for (i =3D 0; i < (int) (sizeof(empty_array) / sizeof(empty_array[0]));=
 i++) {
        ret =3D empty_array[i];
    }

    return ret;
}

If I drop the (int), the warning goes away... and so does the build break
of qemu-system-ppc64 on my ppc64le host.

I don't have 4.7.1 or 4.6 compilers around but I could check 4.8.5
is okay with that change FWIW.

> Ok so let's stop losing time about compiler incoherent warnings, using=20
> -Wno-type-limits for GCC < 5...
> So we can keep a sane/understandable codebase, using size_t and no (int)=
=20
> cast.
>=20

If I also convert 'int i' to 'size_t i' then I get the same error as
in commit 61c7bbd2:

error: comparison of unsigned expression < 0 is always
 false [-Werror=3Dtype-limits]

> Phil.


--Sig_/tbSQyWfHzovjlt1mKf8unEL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmDbY0ACgkQAvw66wEB28KzuQCfTXSOyHyA+2D+h/o/DaTGhPB4
bpgAnAuxx+6eBSQrhHzBz4aAMWwnPR2b
=dDY0
-----END PGP SIGNATURE-----

--Sig_/tbSQyWfHzovjlt1mKf8unEL--
