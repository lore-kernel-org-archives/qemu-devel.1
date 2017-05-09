Received: from eggs.gnu.org ([2001:4830:134:3::10]:35742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d81cM-0008Im-0O
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d81cI-00010R-3c
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:39:42 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:59181)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d81cH-0000zS-TN
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:39:38 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7C9D5EE332
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:39:36 +0200 (CEST)
Date: Tue, 9 May 2017 11:39:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170509113932.2443c627@bahia>
In-Reply-To: <2b6e4c71-8f11-a1f5-8b34-43ac68f2d503@redhat.com>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399505841.29022.17760460736155165332.stgit@bahia.lan>
	<2b6e4c71-8f11-a1f5-8b34-43ac68f2d503@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/gcBa7aMUfiWE_k1U+4zhh9O";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 5/5] 9pfs: local: forbid client access to
 metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TMOpbw==?= Gaspard <leo@gaspard.io>

--Sig_/gcBa7aMUfiWE_k1U+4zhh9O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 5 May 2017 12:13:52 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/05/2017 09:37 AM, Greg Kurz wrote:
> > When using the mapped-file security mode, we shouldn't let the client
> > mess with the metadata. The current code already hides it but the
> > client can still access the metadata through several operations.
> >=20
> > This patch fixes the issue by:
> > - preventing the creation of fids pointing to the metadata (name_to_pat=
h)
> > - failing various operations taking a dirpath and a name arguments if
> >   name is a metadata reserved name
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-local.c |   41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >=20
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index b427d2928800..93cadac302c9 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -588,6 +588,11 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath=
 *dir_path,
> >      int err =3D -1;
> >      int dirfd;
> > =20
> > +    if (local_must_skip_metadata(fs_ctx, name)) {
> > +        errno =3D EINVAL;
> > +        return -1;
> > +    }
> > + =20
>=20
> I don't know if EINVAL is the best error, but it seems reasonable enough.
>=20

I admit that I'm not really a big fan of returning EINVAL, but there's
nothing like "this file name is illegal" on Linux and I couldn't come
up with a better error...

--Sig_/gcBa7aMUfiWE_k1U+4zhh9O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkRjlQACgkQAvw66wEB28Jo8ACcCDWlt7rVE2a5jjI48+sNgziC
9r0AoJwLpvK5tKdId6JkxdRdk0UA+9xl
=ZAzp
-----END PGP SIGNATURE-----

--Sig_/gcBa7aMUfiWE_k1U+4zhh9O--
