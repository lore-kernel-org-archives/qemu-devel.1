Received: from eggs.gnu.org ([2001:4830:134:3::10]:35797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfSon-0005jt-DH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfSok-0001GN-5Y
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:22:45 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:56240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfSoj-0001FQ-NJ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:22:42 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id F20988B2D4
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 17:22:39 +0200 (CEST)
Date: Wed, 9 Aug 2017 17:22:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809172233.36e17285@bahia.lan>
In-Reply-To: <d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
References: <150228860899.28168.1415083032613087245.stgit@bahia>
	<d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_YwqOs1I0kAOoD81b9tfDaY";
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

--Sig_/_YwqOs1I0kAOoD81b9tfDaY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 09:55:32 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/09/2017 09:23 AM, Greg Kurz wrote:
> > This function has to ensure it doesn't follow a symlink that could be u=
sed
> > to escape the virtfs directory. This could be easily achieved if fchmod=
at()
> > on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, but
> > it doesn't. =20
>=20
> Might be worth including a URL of the LKML discussion on the last
> version of that patch attempt.
>=20

Ok.

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
> Hey - should we point this out as a viable solution to the glibc folks,
> since their current user-space emulation of AT_SYMLINK_NOFOLLOW is broken?
>=20

Probably. What's the best way to do that ?

> >=20
> > The previous behavior is kept for older systems that don't have O_PATH.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: - renamed OPENAT_DIR_O_PATH to O_PATH_9P_UTIL and use it as a repla=
cement
> >       for O_PATH to avoid build breaks on O_PATH-less systems
> >     - keep current behavior for O_PATH-less systems
> >     - added comments
> >     - TODO in 2.11: add _nofollow suffix to openat_dir() and openat_fil=
e()
> > ---
> >  hw/9pfs/9p-local.c |   41 +++++++++++++++++++++++++++++++++--------
> >  hw/9pfs/9p-util.h  |   24 +++++++++++++++---------
> >  2 files changed, 48 insertions(+), 17 deletions(-)
> >=20
> > +     /* First, we clear non-racing symlinks out of the way. */
> > +    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW)) {
> > +        return -1;
> > +    }
> > +    if (S_ISLNK(stbuf.st_mode)) {
> > +        errno =3D ELOOP; =20
>=20
> I don't know if ELOOP is the best errno value to use here, but I don't
> have any better suggestions so I'm okay with it.
>=20
> > +        return -1;
> > +    }
> > +
> > +    /* Access modes are ignored when O_PATH is supported. We try O_RDO=
NLY and
> > +     * O_WRONLY for old-systems that don't support O_PATH.
> >       */
> > -    fd =3D openat_file(dirfd, name, O_RDONLY, 0);
> > +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
> >      if (fd =3D=3D -1) {
> >          /* In case the file is writable-only and isn't a directory. */
> >          if (errno =3D=3D EACCES) {
> > @@ -356,7 +366,22 @@ static int fchmodat_nofollow(int dirfd, const char=
 *name, mode_t mode)
> >      if (fd =3D=3D -1) {
> >          return -1;
> >      }
> > -    ret =3D fchmod(fd, mode);
> > +
> > +    /* Now we handle racing symlinks. */
> > +    ret =3D fstat(fd, &stbuf);
> > +    if (ret) {
> > +        goto out;
> > +    }
> > +    if (S_ISLNK(stbuf.st_mode)) {
> > +        errno =3D ELOOP;
> > +        ret =3D -1;
> > +        goto out;
> > +    }
> > +
> > +    proc_path =3D g_strdup_printf("/proc/self/fd/%d", fd);
> > +    ret =3D chmod(proc_path, mode); =20
>=20
> Nope, unsafe when O_PATH_9P_UTIL is 0.  This needs to be more like:
>=20
> /* Now we handle racing symlinks.  On kernels without O_PATH, we will
>  * fail on some corner cases, but that's better than dereferencing a
>  * symlink that was injected during the TOCTTOU between our initial
>  * fstatat() and openat_file().
>  */
> if (O_PATH_9P_UTIL) {
>     fstat, S_ISLINK, proc_path, chmod()
> } else {
>     fchmod()
> }
>=20

Oops, you're right. I'll fix that.

--Sig_/_YwqOs1I0kAOoD81b9tfDaY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmLKLkACgkQAvw66wEB28JNigCdHWEU0pYGZktW6io3I6ZwbPgE
rIMAn1GZaeDzDw2IutUqR6lFrFTmK5/d
=amcA
-----END PGP SIGNATURE-----

--Sig_/_YwqOs1I0kAOoD81b9tfDaY--
