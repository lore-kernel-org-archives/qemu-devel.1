Received: from eggs.gnu.org ([2001:4830:134:3::10]:38592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfSuD-0000N4-GL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfSuA-0004Qv-A2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:28:21 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:43594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfSuA-0004Qe-4J
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:28:18 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id AC0F18B963
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 17:28:16 +0200 (CEST)
Date: Wed, 9 Aug 2017 17:28:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809172811.0b7fa4cd@bahia.lan>
In-Reply-To: <2a4a537f-0f26-3f5a-eaae-2e73bcef4a99@msgid.tls.msk.ru>
References: <150228860899.28168.1415083032613087245.stgit@bahia>
	<2a4a537f-0f26-3f5a-eaae-2e73bcef4a99@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/1rqR=iPQVD.n=O/agxaQyTq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.10 PATCH v2] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, zhiyong.wu@ucloud.cn, Eric Blake <eblake@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

--Sig_/1rqR=iPQVD.n=O/agxaQyTq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 18:11:51 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 09.08.2017 17:23, Greg Kurz wrote:
> > This function has to ensure it doesn't follow a symlink that could be u=
sed
> > to escape the virtfs directory. This could be easily achieved if fchmod=
at()
> > on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, but
> > it doesn't.
> >=20
> > The current implementation covers most use-cases, but it notably fails =
if:
> > - the target path has access rights equal to 0000 (openat() returns EPE=
RM), =20
> >   =3D> once you've done chmod(0000) on a file, you can never chmod() ag=
ain =20
> > - the target path is UNIX domain socket (openat() returns ENXIO) =20
> >   =3D> bind() of UNIX domain sockets fails if the file is on 9pfs =20
> >=20
> > The solution is to use O_PATH: openat() now succeeds in both cases, and=
 we
> > can ensure the path isn't a symlink with fstat(). The associated entry =
in
> > "/proc/self/fd" can hence be safely passed to the regular chmod() sysca=
ll. =20
>=20
> How we can ensure the path isn't a symlink using fstat() ?
>=20
> As far as I understand, fstat NEVER, EVER will return S_ISLINK, because
> we can't actually "open" a symlink itsef, only the target of the symlink.
>=20

Except when O_PATH is passed, as stated in open(2):

If  pathname  is a symbolic link and the O_NOFOLLOW flag is also
specified, then the call returns a file descriptor referring  to
the  symbolic  link.

See Eric's program that proves it at:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01600.html


> /mjt


--Sig_/1rqR=iPQVD.n=O/agxaQyTq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmLKgsACgkQAvw66wEB28JPxwCcDkMiqul9VHVmccCLqLKHchNg
SkIAoIwIZmJrwuWywhRBUxvZjAiUj0Fz
=+5yy
-----END PGP SIGNATURE-----

--Sig_/1rqR=iPQVD.n=O/agxaQyTq--
