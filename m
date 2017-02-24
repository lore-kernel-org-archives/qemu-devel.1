Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1chJUw-0001pt-Po
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1chJUt-0000xC-Bk
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1chJUs-0000wl-U7
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:35 -0500
Date: Fri, 24 Feb 2017 17:17:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170224171730.GE27402@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760159100.31154.15503472827834963062.stgit@bahia.lan>
	<20170223111644.GD30636@stefanha-x1.localdomain>
	<20170223125621.1d03281c@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20170223125621.1d03281c@bahia.lan>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Prasad J Pandit <prasad@redhat.com>, qemu-devel@nongnu.org, Jann Horn <jannh@google.com>


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 12:56:21PM +0100, Greg Kurz wrote:
> On Thu, 23 Feb 2017 11:16:44 +0000
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> > On Mon, Feb 20, 2017 at 03:39:51PM +0100, Greg Kurz wrote:
> > > When using the passthrough security mode, symbolic links created by t=
he
> > > guest are actual symbolic links on the host file system.
> > >=20
> > > Since the resolution of symbolic links during path walk is supposed to
> > > occur on the client side. The server should hence never receive any p=
ath
> > > pointing to an actual symbolic link. This isn't guaranteed by the pro=
tocol
> > > though, and malicious code in the guest can trick the server to issue
> > > various syscalls on paths whose one or more elements are symbolic lin=
ks.
> > > In the case of the "local" backend using the "passthrough" or "none"
> > > security modes, the guest can directly create symbolic links to arbit=
rary
> > > locations on the host (as per spec). The "mapped-xattr" and "mapped-f=
ile"
> > > security modes are also affected to a lesser extent as they require s=
ome
> > > help from an external entity to create actual symbolic links on the h=
ost,
> > > i.e. anoter guest using "passthrough" mode for example. =20
> >=20
> > s/anoter/another/
> >=20
> > >=20
> > > The current code hence relies on O_NOFOLLOW and "l*()" variants of sy=
stem
> > > calls. Unfortunately, this only applies to the rightmost path compone=
nt.
> > > A guest could maliciously replace any component in a trusted path wit=
h a
> > > symbolic link. This could allow any guest to escape a virtfs shared f=
older.
> > >=20
> > > This patch introduces a variant of the openat() syscall that successi=
vely
> > > opens each path element with O_NOFOLLOW. When passing a file descript=
or
> > > pointing to a trusted directory, one is guaranteed to be returned a
> > > file descriptor pointing to a path which is beneath the trusted direc=
tory.
> > > This will be used by subsequent patches to implement symlink-safe pat=
h walk
> > > for any access to the backend.
> > >=20
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/9pfs/9p-util.c     |   69 +++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  hw/9pfs/9p-util.h     |   25 ++++++++++++++++++
> > >  hw/9pfs/Makefile.objs |    2 +
> > >  3 files changed, 95 insertions(+), 1 deletion(-)
> > >  create mode 100644 hw/9pfs/9p-util.c
> > >  create mode 100644 hw/9pfs/9p-util.h
> > >=20
> > > diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
> > > new file mode 100644
> > > index 000000000000..48292d948401
> > > --- /dev/null
> > > +++ b/hw/9pfs/9p-util.c
> > > @@ -0,0 +1,69 @@
> > > +/*
> > > + * 9p utilities
> > > + *
> > > + * Copyright IBM, Corp. 2017
> > > + *
> > > + * Authors:
> > > + *  Greg Kurz <groug@kaod.org>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "9p-util.h"
> > > +
> > > +int openat_nofollow(int dirfd, const char *path, int flags, mode_t m=
ode) =20
> >=20
> > This function doesn't handle absolute paths?  It ignores leading '/' and
> > therefore treats all paths as relative paths.
> >=20
>=20
> Yes because any path coming from the client is supposed (*) to be relativ=
e to the
> shared directory and openat(2) says:

Please change the function name since this isn't openat with nofollow
behavior, it's a subset of openat that only takes relative paths with
nofollow behavior.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYsGqqAAoJEJykq7OBq3PIWWcH/jSFI2wU6JN6MP79GFhpDDY/
DGULWAo+4QhvTj51G2Jh0RanImWStaBaMGwvvvVsP86S8jdCM1I+/q0nyOLsoGoJ
TfBvfMPbFwd1sbvjciuPLM/GNh7N60sKvDZpA31dY2PSR5gql+hQ2YA4kwNDwDZo
dd+4dIX09+WtnL3PaxGfRPfUUABXjUUCyJOjOlrXucsz49439ky94UWXRovLyk9Z
yeB91w+hQp923FXCye7ZzqvcWpSRDLoD8sJAvF3632Ybn/H3rJiYEV8xf7hgmbxC
WwamNXIkJEoiCNk8rYYzgo9UqNvxHqxvKL3qs9GYBL52YsE9SiNcDn9+SEPJPmA=
=tie7
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
