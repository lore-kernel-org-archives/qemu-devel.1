Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG6Yz-0001FL-3u
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG6Yu-0004cs-1W
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:33:37 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:50923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dG6Yt-0004cc-RU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:33:31 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6DB8BFE5A9
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 18:33:30 +0200 (CEST)
Date: Wed, 31 May 2017 18:33:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531183324.03bf98fe@bahia.lan>
In-Reply-To: <20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/=HqbC_FZg._snUt+W=c6tIQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org

--Sig_/=HqbC_FZg._snUt+W=c6tIQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 18:17:37 +0200
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> On Wed, 31 May 2017 16:09:33 +0100
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>=20
> > The thread-id of 0 means any CPU but we then ignore the fact we find
> > the first_cpu in this case who can have an index of 0. Instead of
> > bailing out just test if we have managed to match up thread-id to a
> > CPU.
> >=20
> > Otherwise you get:
> >   gdb_handle_packet: command=3D'vCont;C04:0;c'
> >   put_packet: reply=3D'E22'
> >=20
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  gdbstub.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/gdbstub.c b/gdbstub.c
> > index a249846954..29c9ed3002 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -934,8 +934,8 @@ static int gdb_handle_vcont(GDBState *s, const
> > char *p)
> >               * CPU first, and only then we can use its index.
> >               */
> >              cpu =3D find_cpu(idx);
> > -            /* invalid CPU/thread specified */
> > -            if (!idx || !cpu) {
> > +            /* invalid thread specified, cpu not found. */
> > +            if (!cpu) {
> >                  res =3D -EINVAL;
> >                  goto out;
> >              } =20
>=20
> This is strange. cpu_index() is defined as:
>=20
> static inline int cpu_index(CPUState *cpu)
> {
> #if defined(CONFIG_USER_ONLY)
>     return cpu->host_tid;
> #else
>     return cpu->cpu_index + 1;
> #endif
> }
>=20
> therefore it shouldn't return 0 under any circumstance, and

I think it is 0 for first_cpu in user mode.

> find_cpu(idx) should also fail if idx =3D=3D 0, because internally it also
> uses cpu_index()
>=20
> on the other hand, you say that the patch does fix the problem for you,
> which really confuses me.
>=20
>=20
>=20
> (probably) completely unrelatedly, this:
>=20
> res =3D qemu_strtoul(p + 1, &p, 16, &tmp);
>=20
> should be like this instead:
>=20
> res =3D qemu_strtoul(p, &p, 16, &tmp);
>=20
> but this shouldn't impact you in any way.
>=20
>=20
>=20


--Sig_/=HqbC_FZg._snUt+W=c6tIQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlku8FQACgkQAvw66wEB28LTbACeOgefLLfhsSKXjyrzeHDPIbS8
BekAoIsJ4WVrtKPRWHGWB1nhE7Wr9Q/s
=4Gk4
-----END PGP SIGNATURE-----

--Sig_/=HqbC_FZg._snUt+W=c6tIQ--
