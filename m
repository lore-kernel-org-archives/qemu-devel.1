Received: from eggs.gnu.org ([2001:4830:134:3::10]:39976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciMOj-0005BE-2e
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciMOf-0000g6-3X
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:35:33 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:51849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciMOe-0000fY-Sq
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:35:29 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C21DDB3EEA
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:35:27 +0100 (CET)
Date: Mon, 27 Feb 2017 15:35:19 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170227153519.0e6ce641@bahia.lan>
In-Reply-To: <20170227124901.GH28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814893846.28146.10539730675852394601.stgit@bahia>
	<20170227124901.GH28403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/d=dtXVa30/_L6jZl2OOVtXn";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 06/28] 9pfs: local: open/opendir: don't
 follow symlinks
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

--Sig_/d=dtXVa30/_L6jZl2OOVtXn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 12:49:01 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Sun, Feb 26, 2017 at 11:42:18PM +0100, Greg Kurz wrote:
> > @@ -48,6 +49,24 @@ typedef struct {
> >      int mountfd;
> >  } LocalData;
> > =20
> > +int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
> > +                        mode_t mode)
> > +{
> > +    LocalData *data =3D fs_ctx->private;
> > +
> > +    /* All paths are relative to the path data->mountfd points to */
> > +    while (*path =3D=3D '/') {
> > +        path++;
> > +    }
> > +
> > +    return openat_nofollow(data->mountfd, path, flags, mode); =20
>=20
> What about all the other openat_nofollow() users?  They don't explicitly

$ git grep openat_nofollow
hw/9pfs/9p-local.c:    return openat_nofollow(data->mountfd, path, flags, m=
ode);
hw/9pfs/9p-util.c:int openat_nofollow(int dirfd, const char *path, int flag=
s, mode_t mode)
hw/9pfs/9p-util.h:int openat_nofollow(int dirfd, const char *path, int flag=
s, mode_t mode);

> strip leading slashes.  Perhaps this should be part of a renamed
> relative_openat_nofollow() function.
>=20
> > +}
> > +
> > +int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
> > +{
> > +    return local_open_nofollow(fs_ctx, path, O_DIRECTORY | O_RDONLY, 0=
); =20
>=20
> Why not strip slashes here?

Because this one calls the other one above.

--Sig_/d=dtXVa30/_L6jZl2OOVtXn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0OSgACgkQAvw66wEB28I7GwCfQv9EC4MOyZMjEBkwZGRkxTXE
SYcAoJGAm7k1UbmquIpBaGY26Qf13ZcZ
=W29c
-----END PGP SIGNATURE-----

--Sig_/d=dtXVa30/_L6jZl2OOVtXn--
