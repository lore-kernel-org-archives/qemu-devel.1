Received: from eggs.gnu.org ([2001:4830:134:3::10]:60195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjrjv-00075H-Cm
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjrjr-0000wy-9U
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:15:39 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:47605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjrjr-0000uu-2B
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:15:35 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5913828375
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:15:31 +0100 (CET)
Date: Fri, 3 Mar 2017 19:15:24 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303191524.048b2d1f@bahia.lan>
In-Reply-To: <a93b0903-cf60-d21b-2d68-cd182e06aed3@redhat.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com>
	<20170303174353.676c1a7b@bahia.lan>
	<a93b0903-cf60-d21b-2d68-cd182e06aed3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Xltyr48VKGDZTh0U9IOuqTr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, G 3 <programmingkidx@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

--Sig_/Xltyr48VKGDZTh0U9IOuqTr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 12:11:36 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 03/03/2017 10:43 AM, Greg Kurz wrote:
>=20
> >>> +#ifndef O_PATH
> >>> +    #define O_PATH 0
> >>> +#endif   =20
> >>
> >> Isn't the use of O_PATH required in order to fix the recent
> >> security vulnerability in 9p ?  If so, then defining it to
> >> 0 means the QEMU is silently becoming vulnerable once again
> >> which I don't think is a good idea.
> >> =20
> >=20
> > O_PATH was supposed to be used as an optimization here, since fds retur=
ned by
> > this function are only passed to openat()... but your comment makes me =
realize
> > I inadvertently dropped O_NOFOLLOW between v1 and v2 of the patchset. A=
nd this
> > IS an actual vulnerability issue :) And reading the openat() manpage, I=
 see
> > that O_PATH | O_NOFOLLOW doesn't cause openat() to fail, but to return =
a fd
> > pointing to the symlink which is certainly not what I want :) =20
>=20
> Why not? It works, since openat(fd, ...) fails with EBADF if fd is a
> symlink rather than a directory.  (Well, it SHOULD fail like that,
> according to the man page; I need to write a test program and find out
> for sure).  So you don't have to do any additional syscalls, as your
> very next *at call will tell you if you actually got a directory or a
> symlink.
>=20

O_PATH | O_NOFOLLOW is a special case as described in the last paragraph
of O_PATH in the man page:

              If  pathname  is a symbolic link and the O_NOFOLLOW flag is a=
lso
              specified, then the call returns a file descriptor referring =
 to
              the  symbolic  link.   This  file  descriptor can be used as =
the
              dirfd argument in calls to fchownat(2),  fstatat(2),  linkat(=
2),
              and readlinkat(2) with an empty pathname to have the calls op=
er=E2=80=90
              ate on the symbolic link.

Cheers.

--
Greg

--Sig_/Xltyr48VKGDZTh0U9IOuqTr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5sr0ACgkQAvw66wEB28I53wCdGEakufUCdqUkfyh4IRoOgfDd
YuIAn13lfoec95svL38hnqvxsKx8BGwL
=te5Q
-----END PGP SIGNATURE-----

--Sig_/Xltyr48VKGDZTh0U9IOuqTr--
