Received: from eggs.gnu.org ([2001:4830:134:3::10]:36028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfSpP-0006B5-S6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfSpM-0001Ye-L6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:23:23 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:48487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfSpM-0001Xu-DT
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:23:20 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id AC6688B1A9
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 17:23:18 +0200 (CEST)
Date: Wed, 9 Aug 2017 17:23:13 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809172313.54001ae5@bahia.lan>
In-Reply-To: <4e7d8277-4930-9de5-bfce-04969f1f781d@redhat.com>
References: <150228860899.28168.1415083032613087245.stgit@bahia>
	<d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
	<4e7d8277-4930-9de5-bfce-04969f1f781d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_+l.b=UReb8SbjzkC53DH4u";
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

--Sig_/_+l.b=UReb8SbjzkC53DH4u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 10:01:14 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/09/2017 09:55 AM, Eric Blake wrote:
> > On 08/09/2017 09:23 AM, Greg Kurz wrote: =20
> >> This function has to ensure it doesn't follow a symlink that could be =
used
> >> to escape the virtfs directory. This could be easily achieved if fchmo=
dat()
> >> on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, b=
ut
> >> it doesn't. =20
> >=20
> > Might be worth including a URL of the LKML discussion on the last
> > version of that patch attempt.
> >  =20
> >>
> >> The current implementation covers most use-cases, but it notably fails=
 if:
> >> - the target path has access rights equal to 0000 (openat() returns EP=
ERM), =20
> >>   =3D> once you've done chmod(0000) on a file, you can never chmod() a=
gain =20
> >> - the target path is UNIX domain socket (openat() returns ENXIO) =20
> >>   =3D> bind() of UNIX domain sockets fails if the file is on 9pfs =20
> >>
> >> The solution is to use O_PATH: openat() now succeeds in both cases, an=
d we
> >> can ensure the path isn't a symlink with fstat(). The associated entry=
 in
> >> "/proc/self/fd" can hence be safely passed to the regular chmod() sysc=
all. =20
> >=20
> > Hey - should we point this out as a viable solution to the glibc folks,
> > since their current user-space emulation of AT_SYMLINK_NOFOLLOW is brok=
en?
> >  =20
>=20
>=20
> > Nope, unsafe when O_PATH_9P_UTIL is 0.  This needs to be more like:
> >=20
> > /* Now we handle racing symlinks.  On kernels without O_PATH, we will
> >  * fail on some corner cases, but that's better than dereferencing a
> >  * symlink that was injected during the TOCTTOU between our initial
> >  * fstatat() and openat_file().
> >  */
> > if (O_PATH_9P_UTIL) {
> >     fstat, S_ISLINK, proc_path, chmod()
> > } else {
> >     fchmod()
> > } =20
>=20
> For that matter, I think you also want to avoid the O_WRONLY fallback
> when O_PATH works, as in:
>=20
> >> -    fd =3D openat_file(dirfd, name, O_RDONLY, 0);
> >> +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
> >>      if (fd =3D=3D -1) { =20
>=20
> changing this to 'if (fd =3D=3D -1 && !O_PATH_9P_UTIL)'
>=20

Yes, will do.

--Sig_/_+l.b=UReb8SbjzkC53DH4u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmLKOEACgkQAvw66wEB28K1EwCdF1gV2j9udOghIrt58R7Mv6pW
HZMAnihbE2zbryirFuk359NXdCef/jZ9
=rEgt
-----END PGP SIGNATURE-----

--Sig_/_+l.b=UReb8SbjzkC53DH4u--
