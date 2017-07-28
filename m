Received: from eggs.gnu.org ([2001:4830:134:3::10]:35937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1db01u-0002HF-TS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1db01r-0003bP-1E
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:49:50 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:47646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1db01q-0003YI-R7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:49:46 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 16E706557F
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 09:49:44 +0200 (CEST)
Date: Fri, 28 Jul 2017 09:49:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170728094933.30d23ff6@bahia.lan>
In-Reply-To: <96837087-e5a3-3c8c-63f3-fab1f821274a@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-18-f4bug@amsat.org>
	<20170727134005.76e74eb6@bahia.lan>
	<96837087-e5a3-3c8c-63f3-fab1f821274a@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rbspyCDtCY3JEIGSCul2CTV";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for 2.10 v2 18/20] 9pfs:
 avoid sign conversion error simplifying the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

--Sig_/rbspyCDtCY3JEIGSCul2CTV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jul 2017 16:18:07 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 07/27/2017 08:40 AM, Greg Kurz wrote:
> > On Wed, 26 Jul 2017 23:42:22 -0300
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > Now, I'm not sure this can be merged during hard freeze since it is
> > more code cleanup than actual bug fixing... =20
>=20
> Hmm the commit message is probably not enough.
> The problem is this code can send broken packets, see inlined:
>=20
> >  =20
> >>   hw/9pfs/9p.c | 6 ++----
> >>   1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> >> index 333dbb6f8e..0a37c8bd13 100644
> >> --- a/hw/9pfs/9p.c
> >> +++ b/hw/9pfs/9p.c
> >> @@ -945,7 +945,6 @@ static void coroutine_fn v9fs_version(void *opaque)
> >>       v9fs_string_init(&version);
> >>       err =3D pdu_unmarshal(pdu, offset, "ds", &s->msize, &version);
> >>       if (err < 0) { =20
>=20
> if err =3D=3D -1
>=20
> >> -        offset =3D err; =20
>=20
> here this sets offset =3D (size_t)(-1) =3D SIZE_MAX
>=20
> >>           goto out;

and here we jump directly to the out label, so...

> >>       }
> >>       trace_v9fs_version(pdu->tag, pdu->id, s->msize, version.data);
> >> @@ -962,13 +961,12 @@ static void coroutine_fn v9fs_version(void *opaq=
ue)
> >>  =20
> >>       err =3D pdu_marshal(pdu, offset, "ds", s->msize, &version);
> >>       if (err < 0) {
> >> -        offset =3D err;
> >>           goto out;
> >>       }
> >> -    offset +=3D err; =20
>=20
> here offset +=3D SIZE_MAX which wraps, so this equivs to offset -=3D 1
>=20

... this cannot happen.

> >> +    err +=3D offset;
> >>       trace_v9fs_version_return(pdu->tag, pdu->id, s->msize, version.d=
ata);
> >>   out:
> >> -    pdu_complete(pdu, offset); =20
>=20
> now we have offset =3D 7 - 1 =3D 6, since 6 > 0 pdu_complete() does not=20
> marshal the error code but 6 bytes of crap from pdu?
>=20
> Maybe I missed something.
>=20
> >> +    pdu_complete(pdu, err);
> >>       v9fs_string_free(&version);
> >>   }
> >>    =20
>=20
> Regards,
>=20
> Phil.

I've pushed this to my 9p-next branch to be merged in 2.11.

Cheers,

--
Greg

--Sig_/rbspyCDtCY3JEIGSCul2CTV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll67I4ACgkQAvw66wEB28ISnQCfW5opHwz5eS5ug0tDOmm7dE46
MBUAmwTGzZ/ijOXs1rwbpkpqL86JLilS
=L/Ls
-----END PGP SIGNATURE-----

--Sig_/rbspyCDtCY3JEIGSCul2CTV--
