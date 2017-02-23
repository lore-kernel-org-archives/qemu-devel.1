Received: from eggs.gnu.org ([2001:4830:134:3::10]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgrOG-0005lX-Dl
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgrOB-0004Q0-Ei
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:16:52 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgrOB-0004Pt-5l
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:16:47 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so2158536wmv.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 03:16:47 -0800 (PST)
Date: Thu, 23 Feb 2017 11:16:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223111644.GD30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760159100.31154.15503472827834963062.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <148760159100.31154.15503472827834963062.stgit@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:39:51PM +0100, Greg Kurz wrote:
> When using the passthrough security mode, symbolic links created by the
> guest are actual symbolic links on the host file system.
>=20
> Since the resolution of symbolic links during path walk is supposed to
> occur on the client side. The server should hence never receive any path
> pointing to an actual symbolic link. This isn't guaranteed by the protocol
> though, and malicious code in the guest can trick the server to issue
> various syscalls on paths whose one or more elements are symbolic links.
> In the case of the "local" backend using the "passthrough" or "none"
> security modes, the guest can directly create symbolic links to arbitrary
> locations on the host (as per spec). The "mapped-xattr" and "mapped-file"
> security modes are also affected to a lesser extent as they require some
> help from an external entity to create actual symbolic links on the host,
> i.e. anoter guest using "passthrough" mode for example.

s/anoter/another/

>=20
> The current code hence relies on O_NOFOLLOW and "l*()" variants of system
> calls. Unfortunately, this only applies to the rightmost path component.
> A guest could maliciously replace any component in a trusted path with a
> symbolic link. This could allow any guest to escape a virtfs shared folde=
r.
>=20
> This patch introduces a variant of the openat() syscall that successively
> opens each path element with O_NOFOLLOW. When passing a file descriptor
> pointing to a trusted directory, one is guaranteed to be returned a
> file descriptor pointing to a path which is beneath the trusted directory.
> This will be used by subsequent patches to implement symlink-safe path wa=
lk
> for any access to the backend.
>=20
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-util.c     |   69 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/9pfs/9p-util.h     |   25 ++++++++++++++++++
>  hw/9pfs/Makefile.objs |    2 +
>  3 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 hw/9pfs/9p-util.c
>  create mode 100644 hw/9pfs/9p-util.h
>=20
> diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> new file mode 100644
> index 000000000000..48292d948401
> --- /dev/null
> +++ b/hw/9pfs/9p-util.c
> @@ -0,0 +1,69 @@
> +/*
> + * 9p utilities
> + *
> + * Copyright IBM, Corp. 2017
> + *
> + * Authors:
> + *  Greg Kurz <groug@kaod.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "9p-util.h"
> +
> +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mode)

This function doesn't handle absolute paths?  It ignores leading '/' and
therefore treats all paths as relative paths.

> +{
> +    const char *tail =3D path;
> +    const char *c;
> +    int fd;
> +
> +    fd =3D dup(dirfd);
> +    if (fd =3D=3D -1) {
> +        return -1;
> +    }
> +
> +    while (*tail) {
> +        int next_fd;
> +        char *head;
> +
> +        while (*tail =3D=3D '/') {
> +            tail++;
> +        }
> +
> +        if (!*tail) {
> +            break;
> +        }
> +
> +        head =3D g_strdup(tail);
> +        c =3D strchr(tail, '/');
> +        if (c) {
> +            head[c - tail] =3D 0;
> +            next_fd =3D openat(fd, head, O_DIRECTORY | O_RDONLY | O_NOFO=
LLOW);
> +        } else {
> +            /* We don't want bad things to happen like opening a file th=
at
> +             * sits outside the virtfs export, or hanging on a named pip=
e,
> +             * or changing the controlling process of a terminal.
> +             */
> +            flags |=3D O_NOFOLLOW | O_NONBLOCK | O_NOCTTY;
> +            next_fd =3D openat(fd, head, flags, mode);
> +        }
> +        g_free(head);
> +        if (next_fd =3D=3D -1) {
> +            close_preserve_errno(fd);
> +            return -1;
> +        }
> +        close(fd);
> +        fd =3D next_fd;
> +
> +        if (!c) {
> +            break;
> +        }
> +        tail =3D c + 1;
> +    }
> +    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
> +    assert(!fcntl(fd, F_SETFL, flags));

If path=3D"/" then we'll set flags on dirfd.  These flags are shared with
other fds that have been duped.  Is this really what you want?

> +
> +    return fd;
> +}
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> new file mode 100644
> index 000000000000..e19673d85222
> --- /dev/null
> +++ b/hw/9pfs/9p-util.h
> @@ -0,0 +1,25 @@
> +/*
> + * 9p utilities
> + *
> + * Copyright IBM, Corp. 2017
> + *
> + * Authors:
> + *  Greg Kurz <groug@kaod.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_9P_UTIL_H
> +#define QEMU_9P_UTIL_H
> +
> +static inline void close_preserve_errno(int fd)
> +{
> +    int serrno =3D errno;
> +    close(fd);
> +    errno =3D serrno;
> +}
> +
> +int openat_nofollow(int dirfd, const char *path, int flags, mode_t mode);
> +
> +#endif
> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index da0ae0cfdbae..32197e6671dd 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y  =3D 9p.o
> +common-obj-y  =3D 9p.o 9p-util.o
>  common-obj-y +=3D 9p-local.o 9p-xattr.o
>  common-obj-y +=3D 9p-xattr-user.o 9p-posix-acl.o
>  common-obj-y +=3D coth.o cofs.o codir.o cofile.o
>=20
>=20

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrsScAAoJEJykq7OBq3PIwREH/17I1E4u8ndIw39S1ln4M0Cy
n305iVppyjd/arbFfzwih1DSUJGI9n3ahL2EIiZ+s+yUkB6tRw+oD84WZfc9UVDH
rqUrRaBfZpTZUnGoAM08br4Ew/z2Sf4WJbj3bcogU+Wn+oj/UGvU+qFfRSV3k7FR
/a72amS+uBk6Ahk+6gVL5EBR8hcYWvu7e5xUZ6cZtWet2s2OXmB2s83JDDg3+7Xa
AvWI1D+S58Xky1s1KQK7bUsXdEpa0gS4uHtP0zmIfo/BMxEwMmc8VMCKnipKA1P8
el/qVqouEq1DHzzShYYfpif0BJ9isKZmX6ot3uFZf0JuVNnQSIWfEqx0nbLZWxU=
=sdLe
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
