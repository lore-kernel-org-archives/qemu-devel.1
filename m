Received: from eggs.gnu.org ([2001:4830:134:3::10]:55234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch0WD-0007x4-4u
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch0W9-0002PO-T5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:01:41 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:41544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ch0W9-0002Oo-Mt
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:01:37 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id D38C6AFA8F
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 22:01:35 +0100 (CET)
Date: Thu, 23 Feb 2017 22:01:29 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170223220129.73fe54c2@bahia.lan>
In-Reply-To: <2e9357a4-34ad-9cc1-db39-5ed00bdc015d@redhat.com>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760161575.31154.505252736798591155.stgit@bahia.lan>
	<2e9357a4-34ad-9cc1-db39-5ed00bdc015d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WPbtYG+1GW.AA=nI3PUFsXS";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce
 symlink-attack safe xattr helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/WPbtYG+1GW.AA=nI3PUFsXS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2017 09:02:39 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/20/2017 08:40 AM, Greg Kurz wrote:
> > All operations dealing with extended attributes are vulnerable to symli=
nk
> > attacks because they use path-based syscalls which can traverse symbolic
> > links while walking through the dirname part of the path.
> >=20
> > The solution is to introduce helpers based on opendir_nofollow(). This
> > calls for "at" versions of the extended attribute syscalls, which don't
> > exist unfortunately. This patch implement them by simulating the "at"
> > behavior with fchdir(). Since the current working directory is process
> > wide, and we don't want to confuse another thread in QEMU, all the work
> > is done in a separate process. =20
>=20
> Can you emulate *at using /proc/fd/nnn/xyz?  Coreutils was one of the
> early adopters of the power of *at functions, and found that emulation
> of *at via procfs was a LOT more efficient than emulation via fchdir
> (although both emulations still exist in gnulib, since procfs is not
> universal).
>=20

Yeah, Stefan suggested this on irc. I had also found a tentative patchset to
implement genuine f*xattrat() calls in the kernel 3 yrs ago, that never got
merged. The author, Florian Weimer, also told me /proc was the way to go.

It looks like we have a consensus :)

--Sig_/WPbtYG+1GW.AA=nI3PUFsXS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlivTakACgkQAvw66wEB28LHGgCfTmxqsV3DKkMV4wDqoxOFAzcG
X3IAn2aNdKZEXCAFnqar1cUDL5XLfS9i
=Wu1Q
-----END PGP SIGNATURE-----

--Sig_/WPbtYG+1GW.AA=nI3PUFsXS--
