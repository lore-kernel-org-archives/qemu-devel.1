Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch3di-00036d-Rq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch3de-0002nZ-P4
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:21:38 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:52508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ch3de-0002nU-IK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:21:34 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 0653FAEF66
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 01:21:32 +0100 (CET)
Date: Fri, 24 Feb 2017 01:21:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170224012126.216c84b4@bahia.lan>
In-Reply-To: <20170223142315.GM30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760166051.31154.9036980312875397552.stgit@bahia.lan>
	<20170223142315.GM30636@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/kFtz_XNp7h_j0gqw6qBDh8V";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 13/29] 9pfs: local: remove: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/kFtz_XNp7h_j0gqw6qBDh8V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2017 14:23:15 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, Feb 20, 2017 at 03:41:00PM +0100, Greg Kurz wrote:
> > +    dirfd =3D local_opendir_nofollow(ctx, dirpath);
> > +    if (dirfd) {
> > +        goto out;
> >      }
> > =20
> > -    buffer =3D rpath(ctx, path);
> > -    err =3D remove(buffer);
> > -    g_free(buffer);
> > +    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
> > +        goto err_out;
> > +    }
> > +
> > +    if (S_ISDIR(stbuf.st_mode)) {
> > +        flags |=3D AT_REMOVEDIR;
> > +    }
> > +
> > +    err =3D local_unlinkat_common(ctx, dirfd, name, flags); =20
>=20
> The alternative is optimistically skip fstat but then do:
>=20
>   if (err =3D=3D EISDIR) {

It would be err =3D=3D -1 && errno =3D=3D EISDIR actually.

>       err =3D local_unlinkat_common(ctx, dirfd, name, flags | AT_REMOVEDI=
R);
>   }
>=20
> It might be faster.
>=20

This would work for passthrough and mapped modes indeed. For mapped-file
mode, things are more complicated though. If path points to a directory
and we call local_unlinkat_common() without AT_REMOVEDIR, it won't unlink
the metadata directory and unlinkat() will fail with ENOENT because
the directory isn't empty... I'd rather try to optimize in a followup
patch later to avoid the extra complexity.

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


--Sig_/kFtz_XNp7h_j0gqw6qBDh8V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlivfIYACgkQAvw66wEB28LNkQCffQD+U9dVW6jKgOmPZEW/Ze9t
iPEAnApIlZ7hoGwBpkiLqO4NvUdgJ/vY
=BZg4
-----END PGP SIGNATURE-----

--Sig_/kFtz_XNp7h_j0gqw6qBDh8V--
