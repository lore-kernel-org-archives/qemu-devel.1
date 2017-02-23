Received: from eggs.gnu.org ([2001:4830:134:3::10]:60964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgs9Z-0007kt-7C
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgs0l-0005X1-SL
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:56:43 -0500
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:40575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cgs0l-0005Sk-Im
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:56:39 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 429FEAE928
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 12:56:29 +0100 (CET)
Date: Thu, 23 Feb 2017 12:56:21 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170223125621.1d03281c@bahia.lan>
In-Reply-To: <20170223111644.GD30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760159100.31154.15503472827834963062.stgit@bahia.lan>
	<20170223111644.GD30636@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/1u9Q2T8i5/cTEsa5RX9N.dt";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 04/29] 9pfs: introduce openat_nofollow()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Prasad J Pandit <prasad@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Jann Horn <jannh@google.com>

--Sig_/1u9Q2T8i5/cTEsa5RX9N.dt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2017 11:16:44 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, Feb 20, 2017 at 03:39:51PM +0100, Greg Kurz wrote:
> > When using the passthrough security mode, symbolic links created by the
> > guest are actual symbolic links on the host file system.
> >=20
> > Since the resolution of symbolic links during path walk is supposed to
> > occur on the client side. The server should hence never receive any path
> > pointing to an actual symbolic link. This isn't guaranteed by the proto=
col
> > though, and malicious code in the guest can trick the server to issue
> > various syscalls on paths whose one or more elements are symbolic links.
> > In the case of the "local" backend using the "passthrough" or "none"
> > security modes, the guest can directly create symbolic links to arbitra=
ry
> > locations on the host (as per spec). The "mapped-xattr" and "mapped-fil=
e"
> > security modes are also affected to a lesser extent as they require some
> > help from an external entity to create actual symbolic links on the hos=
t,
> > i.e. anoter guest using "passthrough" mode for example. =20
>=20
> s/anoter/another/
>=20
> >=20
> > The current code hence relies on O_NOFOLLOW and "l*()" variants of syst=
em
> > calls. Unfortunately, this only applies to the rightmost path component.
> > A guest could maliciously replace any component in a trusted path with a
> > symbolic link. This could allow any guest to escape a virtfs shared fol=
der.
> >=20
> > This patch introduces a variant of the openat() syscall that successive=
ly
> > opens each path element with O_NOFOLLOW. When passing a file descriptor
> > pointing to a trusted directory, one is guaranteed to be returned a
> > file descriptor pointing to a path which is beneath the trusted directo=
ry.
> > This will be used by subsequent patches to implement symlink-safe path =
walk
> > for any access to the backend.
> >=20
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-util.c     |   69 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  hw/9pfs/9p-util.h     |   25 ++++++++++++++++++
> >  hw/9pfs/Makefile.objs |    2 +
> >  3 files changed, 95 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/9pfs/9p-util.c
> >  create mode 100644 hw/9pfs/9p-util.h
> >=20
> > diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> > new file mode 100644
> > index 000000000000..48292d948401
> > --- /dev/null
> > +++ b/hw/9pfs/9p-util.c
> > @@ -0,0 +1,69 @@
> > +/*
> > + * 9p utilities
> > + *
> > + * Copyright IBM, Corp. 2017
> > + *
> > + * Authors:
> > + *  Greg Kurz <groug@kaod.org>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "9p-util.h"
> > +
> > +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mod=
e) =20
>=20
> This function doesn't handle absolute paths?  It ignores leading '/' and
> therefore treats all paths as relative paths.
>=20

Yes because any path coming from the client is supposed (*) to be relative =
to the
shared directory and openat(2) says:

If pathname is absolute, then dirfd is ignored.

(*) we make sure in the frontend that any path sent by the client doesn't
    contain '/'

> > +{
> > +    const char *tail =3D path;
> > +    const char *c;
> > +    int fd;
> > +
> > +    fd =3D dup(dirfd);
> > +    if (fd =3D=3D -1) {
> > +        return -1;
> > +    }
> > +
> > +    while (*tail) {
> > +        int next_fd;
> > +        char *head;
> > +
> > +        while (*tail =3D=3D '/') {
> > +            tail++;
> > +        }
> > +
> > +        if (!*tail) {
> > +            break;
> > +        }
> > +
> > +        head =3D g_strdup(tail);
> > +        c =3D strchr(tail, '/');
> > +        if (c) {
> > +            head[c - tail] =3D 0;
> > +            next_fd =3D openat(fd, head, O_DIRECTORY | O_RDONLY | O_NO=
FOLLOW);
> > +        } else {
> > +            /* We don't want bad things to happen like opening a file =
that
> > +             * sits outside the virtfs export, or hanging on a named p=
ipe,
> > +             * or changing the controlling process of a terminal.
> > +             */
> > +            flags |=3D O_NOFOLLOW | O_NONBLOCK | O_NOCTTY;
> > +            next_fd =3D openat(fd, head, flags, mode);
> > +        }
> > +        g_free(head);
> > +        if (next_fd =3D=3D -1) {
> > +            close_preserve_errno(fd);
> > +            return -1;
> > +        }
> > +        close(fd);
> > +        fd =3D next_fd;
> > +
> > +        if (!c) {
> > +            break;
> > +        }
> > +        tail =3D c + 1;
> > +    }
> > +    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
> > +    assert(!fcntl(fd, F_SETFL, flags)); =20
>=20
> If path=3D"/" then we'll set flags on dirfd.  These flags are shared with
> other fds that have been duped.  Is this really what you want?
>=20

You're right. This only makes sense if fd comes from openat() above...

Thanks for the catch! :)

> > +
> > +    return fd;
> > +}
> > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > new file mode 100644
> > index 000000000000..e19673d85222
> > --- /dev/null
> > +++ b/hw/9pfs/9p-util.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + * 9p utilities
> > + *
> > + * Copyright IBM, Corp. 2017
> > + *
> > + * Authors:
> > + *  Greg Kurz <groug@kaod.org>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef QEMU_9P_UTIL_H
> > +#define QEMU_9P_UTIL_H
> > +
> > +static inline void close_preserve_errno(int fd)
> > +{
> > +    int serrno =3D errno;
> > +    close(fd);
> > +    errno =3D serrno;
> > +}
> > +
> > +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mod=
e);
> > +
> > +#endif
> > diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> > index da0ae0cfdbae..32197e6671dd 100644
> > --- a/hw/9pfs/Makefile.objs
> > +++ b/hw/9pfs/Makefile.objs
> > @@ -1,4 +1,4 @@
> > -common-obj-y  =3D 9p.o
> > +common-obj-y  =3D 9p.o 9p-util.o
> >  common-obj-y +=3D 9p-local.o 9p-xattr.o
> >  common-obj-y +=3D 9p-xattr-user.o 9p-posix-acl.o
> >  common-obj-y +=3D coth.o cofs.o codir.o cofile.o
> >=20
> >  =20


--Sig_/1u9Q2T8i5/cTEsa5RX9N.dt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliuzeUACgkQAvw66wEB28I2TgCfRjJUG6y8bK5knDfU7+yNbymR
PC8AnAiV2WaBOnlhPnNjEbWpGzflkA0W
=B2/K
-----END PGP SIGNATURE-----

--Sig_/1u9Q2T8i5/cTEsa5RX9N.dt--
