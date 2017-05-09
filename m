Received: from eggs.gnu.org ([2001:4830:134:3::10]:44349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d84G4-0008Rf-Hm
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d84G1-0007e7-Dc
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:28:52 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:42074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d84G1-0007dQ-6n
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:28:49 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7D797EE440
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 14:28:47 +0200 (CEST)
Date: Tue, 9 May 2017 14:28:36 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170509142836.4a07d8d9@bahia>
In-Reply-To: <356752db-bd70-a908-141e-eec99f4c15e2@redhat.com>
References: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
	<1f0bf90b-a706-01c8-cad1-6dea6620deef@redhat.com>
	<alpine.DEB.2.10.1705081454510.24729@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1705081459030.24729@sstabellini-ThinkPad-X260>
	<356752db-bd70-a908-141e-eec99f4c15e2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/iHUUV3/cGA1i=bBhEzaqta=";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] Fix issues affecting Xen 9pfs discovered
 by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com, xen-devel@lists.xensource.com, aneesh.kumar@linux.vnet.ibm.com, qemu-devel@nongnu.org

--Sig_/iHUUV3/cGA1i=bBhEzaqta=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 8 May 2017 17:05:01 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/08/2017 05:00 PM, Stefano Stabellini wrote:
>=20
> >>> Directly calling fcntl(F_SETFD) without first reading fcntl(F_GETFD) =
is
> >>> (theoretically) incorrect.  Better might be using qemu_set_cloexec()
> >>> instead of open-coding something. =20
> >>
> >> Makes sense but the unchecked return of fcntl, discovered by Coverity,
> >> would remain unfixed by calling qemu_set_cloexec here. I don't think I
> >> am up for fixing all the call sites of qemu_set_cloexec.
> >>
> >> I am going to drop this change, and resend this patch was only the oth=
er
> >> two fixes, fixing 1374836 only. =20
> >=20
> > Unless you would be fine with:
> >=20
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 4d9189e..16894ad 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -182,7 +182,9 @@ void qemu_set_cloexec(int fd)
> >  {
> >      int f;
> >      f =3D fcntl(fd, F_GETFD);
> > -    fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> > +    assert(f !=3D -1);
> > +    f =3D fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> > +    assert(f !=3D -1); =20
>=20
> Seems reasonable to me, but I don't know if anyone else would object.
>=20
> Changes semantics if someone ever calls qemu_set_cloexec(-1) (previously
> it would ignore the EBADF failures, now it will abort) - such callers
> are arguably broken, so that's okay by me.
>=20

I've checked all current users and they all pass a valid fd to
qemu_set_cloexec(). Also F_SETFD/F_GETFD is required by POSIX
and we cannot get an EINVAL failure either. I guess the change
is ok then.

--Sig_/iHUUV3/cGA1i=bBhEzaqta=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkRtfUACgkQAvw66wEB28L+OwCePK40vVUaukOdgimx0i4vg39x
Y80An1+tEQPDPLt+mGP9VpZsT1VodLJA
=qvk4
-----END PGP SIGNATURE-----

--Sig_/iHUUV3/cGA1i=bBhEzaqta=--
