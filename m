Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjsVJ-0004IQ-H5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjsVF-0001dZ-Gv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:04:37 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:51466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjsVF-0001dQ-8V
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:04:33 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 91A47239F7
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 20:04:31 +0100 (CET)
Date: Fri, 3 Mar 2017 20:04:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303200426.4cb90e84@bahia.lan>
In-Reply-To: <9131ba64-a0a6-ab88-9faf-6e56ec67b79e@ilande.co.uk>
References: <148856193073.554.6631259860971664030.stgit@bahia>
	<9131ba64-a0a6-ab88-9faf-6e56ec67b79e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/H_TUcuS59v=b=xOQGe5ZSCQ";
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, "Daniel P.
	Berrange" <berrange@redhat.com>

--Sig_/H_TUcuS59v=b=xOQGe5ZSCQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 17:54:35 +0000
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 03/03/17 17:25, Greg Kurz wrote:
>=20
> > We should pass O_NOFOLLOW otherwise openat() will follow symlinks and m=
ake
> > QEMU vulnerable.
> >=20
> > O_PATH was used as an optimization: the fd returned by openat_dir() is =
only
> > passed to openat() actually, so we don't really need to reach the under=
lying
> > filesystem.
> >=20
> > O_NOFOLLOW | O_PATH isn't an option: if name is a symlink, openat() will
> > return a fd, forcing us to do some other syscall to detect we have a
> > symlink. Also, O_PATH doesn't exist in glibc 2.13 and older.
> >=20
> > The only sane thing to do is hence to drop O_PATH, and only pass O_NOFO=
LLOW.
> >=20
> > While here, we also fix local_unlinkat_common() to use openat_dir() for
> > the same reasons (it was a leftover in the original patchset actually).
> >=20
> > This fixes CVE-2016-9602.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-local.c |    2 +-
> >  hw/9pfs/9p-util.h  |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index 5db7104334d6..e31309a29c58 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -959,7 +959,7 @@ static int local_unlinkat_common(FsContext *ctx, in=
t dirfd, const char *name,
> >          if (flags =3D=3D AT_REMOVEDIR) {
> >              int fd;
> > =20
> > -            fd =3D openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH=
);
> > +            fd =3D openat_dir(dirfd, name);
> >              if (fd =3D=3D -1) {
> >                  goto err_out;
> >              }
> > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > index 091f3ce88e15..4001d1fd8398 100644
> > --- a/hw/9pfs/9p-util.h
> > +++ b/hw/9pfs/9p-util.h
> > @@ -22,7 +22,7 @@ static inline void close_preserve_errno(int fd)
> > =20
> >  static inline int openat_dir(int dirfd, const char *name)
> >  {
> > -    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
> > +    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_NOFOLLOW);
> >  }
> > =20
> >  static inline int openat_file(int dirfd, const char *name, int flags, =
=20
>=20
> Thanks Greg.
>=20
> This patch got me slightly further, but I now get another build failure:
>=20
>=20
> cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
> -I/home/build/src/qemu/git/qemu/tcg
> -I/home/build/src/qemu/git/qemu/tcg/i386
> -I/home/build/src/qemu/git/qemu/linux-headers
> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> -I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qemu/include
> -I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/libfdt
> -Werror -pthread -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
> -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -MP
> -MT hw/9pfs/9p-local.o -MF hw/9pfs/9p-local.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/9pfs/9p-local.o hw/9pfs/9p-local.c
> hw/9pfs/9p-local.c: In function =E2=80=98local_set_cred_passthrough=E2=80=
=99:
> hw/9pfs/9p-local.c:352:40: error: =E2=80=98AT_EMPTY_PATH=E2=80=99 undecla=
red (first use
> in this function)
> hw/9pfs/9p-local.c:352:40: note: each undeclared identifier is reported
> only once for each function it appears in
> make: *** [hw/9pfs/9p-local.o] Error 1
>=20

Oops, my bad. In a previous version of the patchset, name could be an
empty string on purpose... This isn't the case in the latest version
but I forgot to drop AT_EMPTY_PATH. I'll send a patch, but you can
simply remove it in the meantime to fix your build.

>=20
> A quick search suggested that I should be able to get around this by
> adding a #include in hw/9pfs/9p-local.c for "linux/fcntl.h" however
> adding that gives me a couple of redefinition errors:
>=20
>=20
> cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
> -I/home/build/src/qemu/git/qemu/tcg
> -I/home/build/src/qemu/git/qemu/tcg/i386
> -I/home/build/src/qemu/git/qemu/linux-headers
> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> -I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qemu/include
> -I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/libfdt
> -Werror -pthread -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
> -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -MP
> -MT hw/9pfs/9p-local.o -MF hw/9pfs/9p-local.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/9pfs/9p-local.o hw/9pfs/9p-local.c
> In file included from /usr/include/x86_64-linux-gnu/asm/fcntl.h:1:0,
>                  from /usr/include/linux/fcntl.h:4,
>                  from hw/9pfs/9p-local.c:30:
> /usr/include/asm-generic/fcntl.h:127:8: error: redefinition of =E2=80=98s=
truct
> f_owner_ex=E2=80=99
> In file included from /usr/include/fcntl.h:34:0,
>                  from /home/build/src/qemu/git/qemu/include/qemu/osdep.h:=
79,
>                  from hw/9pfs/9p-local.c:14:
> /usr/include/x86_64-linux-gnu/bits/fcntl.h:203:8: note: originally
> defined here
> In file included from /usr/include/x86_64-linux-gnu/asm/fcntl.h:1:0,
>                  from /usr/include/linux/fcntl.h:4,
>                  from hw/9pfs/9p-local.c:30:
> /usr/include/asm-generic/fcntl.h:167:8: error: redefinition of =E2=80=98s=
truct
> flock=E2=80=99
> In file included from /usr/include/fcntl.h:34:0,
>                  from /home/build/src/qemu/git/qemu/include/qemu/osdep.h:=
79,
>                  from hw/9pfs/9p-local.c:14:
> /usr/include/x86_64-linux-gnu/bits/fcntl.h:167:8: note: originally
> defined here
> In file included from /usr/include/x86_64-linux-gnu/asm/fcntl.h:1:0,
>                  from /usr/include/linux/fcntl.h:4,
>                  from hw/9pfs/9p-local.c:30:
> /usr/include/asm-generic/fcntl.h:184:8: error: redefinition of =E2=80=98s=
truct
> flock64=E2=80=99
> In file included from /usr/include/fcntl.h:34:0,
>                  from /home/build/src/qemu/git/qemu/include/qemu/osdep.h:=
79,
>                  from hw/9pfs/9p-local.c:14:
> /usr/include/x86_64-linux-gnu/bits/fcntl.h:182:8: note: originally
> defined here
> make: *** [hw/9pfs/9p-local.o] Error 1
>=20
>=20
> Any thoughts?
>=20
> Mark.
>=20


--Sig_/H_TUcuS59v=b=xOQGe5ZSCQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5vjsACgkQAvw66wEB28IEvwCdF7WwHusYKzV94RhfBXh2IslH
PPAAoI8bEJErrJJ5AVE19e1zanXP9cpx
=JnHg
-----END PGP SIGNATURE-----

--Sig_/H_TUcuS59v=b=xOQGe5ZSCQ--
