Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ck7kz-0004nb-P7
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 06:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ck7ku-0000DS-Q0
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 06:21:49 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:43189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ck7ku-0000CL-Fu
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 06:21:44 -0500
Received: from player726.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0DF0B2964D
	for <qemu-devel@nongnu.org>; Sat,  4 Mar 2017 12:21:42 +0100 (CET)
Date: Sat, 4 Mar 2017 12:21:39 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170304122139.63796173@bahia.lan>
In-Reply-To: <ebe5c30c-0af6-7f5b-15bf-4626773a2a9d@redhat.com>
References: <148856193073.554.6631259860971664030.stgit@bahia>
	<ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
	<ebe5c30c-0af6-7f5b-15bf-4626773a2a9d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/xF/EQ6yMejNUJ1dDlNeUCVW";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

--Sig_/xF/EQ6yMejNUJ1dDlNeUCVW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 17:43:49 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 03/03/2017 12:14 PM, Eric Blake wrote:
> > On 03/03/2017 11:25 AM, Greg Kurz wrote: =20
> >> We should pass O_NOFOLLOW otherwise openat() will follow symlinks and =
make
> >> QEMU vulnerable.
> >>
> >> O_PATH was used as an optimization: the fd returned by openat_dir() is=
 only
> >> passed to openat() actually, so we don't really need to reach the unde=
rlying
> >> filesystem.
> >>
> >> O_NOFOLLOW | O_PATH isn't an option: if name is a symlink, openat() wi=
ll
> >> return a fd, forcing us to do some other syscall to detect we have a
> >> symlink. Also, O_PATH doesn't exist in glibc 2.13 and older. =20
> >=20
> > But the very next use of openat(fd, ) should fail with EBADF if fd is =
=20
>=20
> or ENOTDIR, actually
>=20
> > not a directory, so you don't need any extra syscalls.  I agree that we
> > _need_ O_NOFOLLOW, but I'm not yet convinced that we must avoid O_PATH
> > where it works.
> >=20
> > I'm in the middle of writing a test program to probe kernel behavior and
> > demonstrate (at least to myself) whether there are scenarios where
> > O_PATH makes it possible to open something where omitting it did not,
> > while at the same time validating that O_NOFOLLOW doesn't cause problems
> > if a symlink-fd is returned instead of a directory fd, based on our
> > subsequent use of that fd in a *at call. =20
>=20
> My test case is below.  Note that based on my testing, I think you want
> a v2 of this patch, which does:
>=20

Yeah, #12 and #13 in your test case show that we're safe because O_DIRECTORY
causes openat() to fail with EISDIR right away (we won't have to worry about
an hypothetical symlink-fd).

> #ifndef O_PATH
> #define O_PATH 0
> #endif
>=20

It is acceptable to ignore O_PATH here because we have O_DIRECTORY, and
we know openat_dir() will hence fail. But this code sits in a header
file, and we probably don't want O_PATH to be silently converted to 0 in
other potential cases where it is used without O_DIRECTORY.

I'd rather do something like the following then:

#ifdef O_PATH
#define OPENAT_DIR_O_PATH O_PATH
#else
#define OPENAT_DIR_O_PATH 0
#endif

Makes sense ?

>  static inline int openat_dir(int dirfd, const char *name)
>  {
> -    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
> +    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_NOFOLLOW |
> O_PATH);
>  }
>=20
>=20
>=20
> #define _GNU_SOURCE 1
> #include <stdio.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <errno.h>
> #include <stdlib.h>
>=20
> int main(int argc, char **argv)
> {
>     int i =3D 0;
>     int ret =3D 1;
>     int fd;
>     struct stat st;
>=20
>     if (mkdir("d", 0700) < 0) {
>         printf("giving up, please try again once 'd' is removed\n");
>         return ret;
>     }
>=20
>     /* Create a playground for testing with. */
>     i =3D 1;
>     if (creat("d/file", 0600) < 0)
>         goto cleanup;
>     i =3D 2;
>     if (mkdir("d/subdir", 0700) < 0)
>         goto cleanup;
>     i =3D 3;
>     if (creat("d/subdir/subfile", 0600) < 0)
>         goto cleanup;
>     i =3D 4;
>     if (chmod("d/subdir", 0100) < 0)
>         goto cleanup;
>     i =3D 5;
>     if (symlink("file", "d/link-file") < 0)
>         goto cleanup;
>     i =3D 6;
>     if (symlink("subdir", "d/link-subdir") < 0)
>         goto cleanup;
>=20
>     /* Sanity: We can stat a child file with just search permissions,
>      * whether via a directory or symlink-to-directory */
>     i =3D 7;
>     if (stat("d/subdir/subfile", &st) < 0)
>         goto cleanup;
>     i =3D 8;
>     if (stat("d/link-subdir/subfile", &st) < 0)
>         goto cleanup;
>=20
>     /* Since the directory is not readable, we can't get a normal fd */
>     fd =3D open("d/subdir", O_DIRECTORY | O_NOFOLLOW | O_RDONLY);
>     if (fd !=3D -1) {
>         printf("unexpected success opening non-readable dir\n");
>         ret =3D 2;
>         goto cleanup;
>     }
>     /* But we can get at it with O_PATH */
>     i =3D 9;
>     fd =3D open("d/subdir", O_DIRECTORY | O_NOFOLLOW | O_RDONLY | O_PATH);
>     if (fd < 0)
>         goto cleanup;
>     /* And use it in *at functions */
>     i =3D 10;
>     if (fstatat(fd, "subfile", &st, 0) < 0)
>         goto cleanup;
>     i =3D 11;
>     if (close(fd) < 0)
>         goto cleanup;
>=20
>     /* Note that O_DIRECTORY fails on symlinks with O_PATH... */
>     i =3D 12;
>     fd =3D open("d/link-subdir", O_DIRECTORY | O_NOFOLLOW | O_RDONLY |
> O_PATH);
>     if (fd !=3D -1) {
>         printf("unexpected success on symlink-dir with O_DIRECTORY\n");
>         ret =3D 2;
>         goto cleanup;
>     }
>     /* or on symlinks to files regardless of O_PATH... */
>     i =3D 13;
>     fd =3D open("d/link-file", O_DIRECTORY | O_NOFOLLOW | O_RDONLY | O_PA=
TH);
>     if (fd !=3D -1) {
>         printf("unexpected success on symlink-file with
> O_DIRECTORY|O_PATH\n");
>         ret =3D 2;
>         goto cleanup;
>     }
>     i =3D 14;
>     fd =3D open("d/link-file", O_DIRECTORY | O_NOFOLLOW | O_RDONLY);
>     if (fd !=3D -1) {
>         printf("unexpected success on symlink-file with just
> O_DIRECTORY\n");
>         ret =3D 2;
>         goto cleanup;
>     }
>     /* but O_PATH without O_DIRECTORY opens a symlink fd */
>     i =3D 15;
>     fd =3D open("d/link-subdir", O_NOFOLLOW | O_RDONLY | O_PATH);
>     if (fd < 0)
>         goto cleanup;
>     /* However, that symlink fd is not usable in *at */
>     i =3D 16;
>     if (fstatat(fd, "subfile", &st, 0) =3D=3D 0) {
>         printf("unexpected success using symlink fd in fstatat\n");
>         ret =3D 2;
>         goto cleanup;
>     }
>     if (errno !=3D EBADF && errno !=3D ENOTDIR)
>         goto cleanup;
>     i =3D 17;
>     if (close(fd) < 0)
>         goto cleanup;
>=20
>     printf("All tests passed\n");
>     ret =3D 0;
>=20
>  cleanup:
>     if (ret =3D=3D 1) {
>         perror("unexpected failure");
>         printf("encountered when i=3D%d\n", i);
>     }
>     system("chmod -R u+rwx d; rm -rf d");
>     return ret;
> }
>=20
>=20
>=20


--Sig_/xF/EQ6yMejNUJ1dDlNeUCVW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli6o0MACgkQAvw66wEB28IjLQCfVCHYClSPc7f2pwZaX5RbK7Lc
yNsAnjfETZONY2n4Wb6ZGwm2t6iI+84P
=EvQM
-----END PGP SIGNATURE-----

--Sig_/xF/EQ6yMejNUJ1dDlNeUCVW--
