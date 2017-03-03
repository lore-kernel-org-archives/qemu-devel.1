Received: from eggs.gnu.org ([2001:4830:134:3::10]:46171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjsZ6-0005jo-4u
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjsZ2-0002hf-0j
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:08:32 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:34587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjsZ1-0002hT-Q4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:08:27 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 52D162824A
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 20:08:26 +0100 (CET)
Date: Fri, 3 Mar 2017 20:08:21 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303200821.70ea87e8@bahia.lan>
In-Reply-To: <ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
References: <148856193073.554.6631259860971664030.stgit@bahia>
	<ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/tygN_cza/IQKcMPVhCGXrIE";
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
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

--Sig_/tygN_cza/IQKcMPVhCGXrIE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 12:14:10 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 03/03/2017 11:25 AM, Greg Kurz wrote:
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
> > symlink. Also, O_PATH doesn't exist in glibc 2.13 and older. =20
>=20
> But the very next use of openat(fd, ) should fail with EBADF if fd is
> not a directory, so you don't need any extra syscalls.  I agree that we
> _need_ O_NOFOLLOW, but I'm not yet convinced that we must avoid O_PATH
> where it works.
>=20

You may have a point indeed.

> I'm in the middle of writing a test program to probe kernel behavior and
> demonstrate (at least to myself) whether there are scenarios where
> O_PATH makes it possible to open something where omitting it did not,
> while at the same time validating that O_NOFOLLOW doesn't cause problems
> if a symlink-fd is returned instead of a directory fd, based on our
> subsequent use of that fd in a *at call.
>=20

I must leave right now, but please share the result of your experiment.

Thanks for your support on helping to fix 9p, Eric :)

Cheers.

--
Greg

--Sig_/tygN_cza/IQKcMPVhCGXrIE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5vyUACgkQAvw66wEB28K6iwCgonQqjrEV4+bjqqUBWpD724/Q
egwAn12ZQ8CwHKGVWy6q4wmEfq93HBQt
=O7Hm
-----END PGP SIGNATURE-----

--Sig_/tygN_cza/IQKcMPVhCGXrIE--
