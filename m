Received: from eggs.gnu.org ([2001:4830:134:3::10]:55714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciNIS-0005Iw-Ce
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciNIP-00040w-91
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ciNIP-00040e-0s
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:33:05 -0500
Date: Mon, 27 Feb 2017 15:33:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170227153302.GX28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yKmnPmKxJBqIz68t"
Content-Disposition: inline
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 00/28] Series short description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>


--yKmnPmKxJBqIz68t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:41:32PM +0100, Greg Kurz wrote:
> This series tries to fix CVE-2016-9602 reported by Jann Horn of Google
> Project Zero:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1413929
>=20
> This vulnerability affects all accesses to the underlying filesystem in
> the "local" backend code.
>=20
> If QEMU is started with:
>=20
> -fsdev local,security_model=3D<passthrough|none>,path=3D/foo/bar
>=20
> then the guest can cause QEMU to create symlinks in /foo/bar.
>=20
> This causes accesses to any path /foo/bar/some/path to be unsafe, since
> untrusted code within the guest (or in another guest sharing the same
> virtfs folder) could change some/path to point to a random path of the
> host filesystem.
>=20
> The core problem is that the "local" backend relies on path-based syscalls
> to access the underlying filesystem. All path-based syscalls are vulnerab=
le
> to this issue, even open(O_NOFOLLOW) or syscalls that explicitly don't
> dereference symlinks, since the kernel only checks the rightmost element =
of
> the path. Depending on the privilege level of the QEMU process, a guest c=
an
> end up opening, renaming, changing ACLs, unlinking... files on the host
> filesystem.
>=20
> The right way to address this is to use "at" variants of all syscalls in
> the "local" backend code. This requires to open directories without
> traversing any symlink in the intermediate path elements. There was a
> tentative to introduce an O_BENEATH flag for openat() that would address
> this:
>=20
> https://patchwork.kernel.org/patch/7007181/
>=20
> Unfortunately this never got merged.  An alternative is to walk through a=
ll
> path elements manually with openat(O_NOFOLLOW).
>=20
> v2:
> 	- /proc based implementation for xattr code (fixes metadata perf drop
>           observed with v1)
>         - some code refactoring
>=20
> Stefan.
>=20
> I had to rework some patches you had already reviewed, please consider
> giving your Reviewed-by again if the changes are ok.
>=20
> Thanks.
>=20
> --
> Greg
>=20
> ---
>=20
> Greg Kurz (28):
>       9pfs: local: move xattr security ops to 9p-xattr.c
>       9pfs: remove side-effects in local_init()
>       9pfs: remove side-effects in local_open() and local_opendir()
>       9pfs: introduce openat_nofollow() helper
>       9pfs: local: keep a file descriptor on the shared folder
>       9pfs: local: open/opendir: don't follow symlinks
>       9pfs: local: lgetxattr: don't follow symlinks
>       9pfs: local: llistxattr: don't follow symlinks
>       9pfs: local: lsetxattr: don't follow symlinks
>       9pfs: local: lremovexattr: don't follow symlinks
>       9pfs: local: unlinkat: don't follow symlinks
>       9pfs: local: remove: don't follow symlinks
>       9pfs: local: utimensat: don't follow symlinks
>       9pfs: local: statfs: don't follow symlinks
>       9pfs: local: truncate: don't follow symlinks
>       9pfs: local: readlink: don't follow symlinks
>       9pfs: local: lstat: don't follow symlinks
>       9pfs: local: renameat: don't follow symlinks
>       9pfs: local: rename: use renameat
>       9pfs: local: improve error handling in link op
>       9pfs: local: link: don't follow symlinks
>       9pfs: local: chmod: don't follow symlinks
>       9pfs: local: chown: don't follow symlinks
>       9pfs: local: symlink: don't follow symlinks
>       9pfs: local: mknod: don't follow symlinks
>       9pfs: local: mkdir: don't follow symlinks
>       9pfs: local: open2: don't follow symlinks
>       9pfs: local: drop unused code
>=20
>=20
>  hw/9pfs/9p-local.c      | 1023 ++++++++++++++++++++++++++---------------=
------
>  hw/9pfs/9p-local.h      |   20 +
>  hw/9pfs/9p-posix-acl.c  |   44 --
>  hw/9pfs/9p-util.c       |   65 +++
>  hw/9pfs/9p-util.h       |   52 ++
>  hw/9pfs/9p-xattr-user.c |   24 -
>  hw/9pfs/9p-xattr.c      |  166 +++++++-
>  hw/9pfs/9p-xattr.h      |   87 +---
>  hw/9pfs/Makefile.objs   |    2=20
>  9 files changed, 887 insertions(+), 596 deletions(-)
>  create mode 100644 hw/9pfs/9p-local.h
>  create mode 100644 hw/9pfs/9p-util.c
>  create mode 100644 hw/9pfs/9p-util.h
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yKmnPmKxJBqIz68t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtEauAAoJEJykq7OBq3PIn3QH/jNlZCIyTKDFYX+8LqqMeSQI
Pf36tfUnZw9A/bwnAF+eBznXvrXeLi7tHy2a+xFQ9ffG82Z/vIN2SSiXaHLjtUzH
M7Qt4QEnP6z+xFWhBQV23JE5sPkUvQ3a7zL/3a7dqxjxWkyoxca/0LQMHDoauPa2
uStwRg2DCXHbvMOQliajjzhacs6wdlG/MQZfEXXXSsQzDPCov93lp0E+1v3Y44+U
0jaPpSAdvwWEl0DWezH/HU5zlX5b1qvrEzw4UpoOp9w2JLYiOqlPK8N3CZSRe/2a
cv50GIpWOnQDIutxdCgWRE88TR5rKLLIpTSdBddZehvOH7cVj9X93UH4ClDPBws=
=ZPKu
-----END PGP SIGNATURE-----

--yKmnPmKxJBqIz68t--
