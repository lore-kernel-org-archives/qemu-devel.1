Received: from eggs.gnu.org ([2001:4830:134:3::10]:48147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chLVL-0000Xk-3r
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chLVG-0005LT-7l
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:26:11 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:39683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1chLVG-0005KW-0U
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:26:06 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 0DF73AA206
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 20:26:01 +0100 (CET)
Date: Fri, 24 Feb 2017 20:25:53 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170224202553.06a06115@bahia.lan>
In-Reply-To: <CAG48ez2Qgje31AN=MszVtHXoNQj-LGpRfaVZ0iV1kw+_vnq0gQ@mail.gmail.com>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760173919.31154.7555675803159581620.stgit@bahia.lan>
	<20170223151042.GW30636@stefanha-x1.localdomain>
	<20170224113402.07a0fb44@bahia.lan>
	<b3f08f09-9678-2142-c4d7-5a66f49b173d@redhat.com>
	<CAG48ez2Qgje31AN=MszVtHXoNQj-LGpRfaVZ0iV1kw+_vnq0gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/3y+MZd8F+Mfy66Bdj6yE2wy";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 23/29] 9pfs: local: chmod: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jann Horn <jannh@google.com>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar
	K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/3y+MZd8F+Mfy66Bdj6yE2wy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Feb 2017 17:22:19 +0100
Jann Horn <jannh@google.com> wrote:
> [...]
> And unfortunately, that flags argument is not actually present in the
> real syscall.
> See this glibc code:
>=20
> int
> fchmodat (int fd, const char *file, mode_t mode, int flag)
> {
>   if (flag & ~AT_SYMLINK_NOFOLLOW)
>     return INLINE_SYSCALL_ERROR_RETURN_VALUE (EINVAL);
> #ifndef __NR_lchmod /* Linux so far has no lchmod syscall.  */
>   if (flag & AT_SYMLINK_NOFOLLOW)
>     return INLINE_SYSCALL_ERROR_RETURN_VALUE (ENOTSUP);
> #endif
>=20
>   return INLINE_SYSCALL (fchmodat, 3, fd, file, mode);
> }
>=20
> and this kernel code:
>=20
> SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
> umode_t, mode)
> {
>   [...]
> }
>=20
> So to fix this, you'll probably have to add a new syscall fchmodat2()
> to the kernel,
> wire it up for all the architectures and get the various libc
> implementations to adopt
> that. That's going to be quite tedious. :(

Yeah, Eric and I had a discussion about that on irc. I'll start to
work on the kernel part, at least. Indeed, adoption by the various
libc is likely to take some time... When the syscalls are available
in the kernel, maybe it is possible to implement something in the
9pfs code with the syscall() function.

In the meantime, we'll have to live with a degraded version of
fchmodat() based on openat()+fchmod(). This will fail if the
file isn't accessible but it is better than allowing the guest
to chmod() any file on the host.

--Sig_/3y+MZd8F+Mfy66Bdj6yE2wy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliwiMEACgkQAvw66wEB28LCqgCfRrrBPJs3Pkn1ZCQ5U2rEKPBo
1LEAn2G7OJxKRCrmQWWLZiSuVYT2c/da
=9s+q
-----END PGP SIGNATURE-----

--Sig_/3y+MZd8F+Mfy66Bdj6yE2wy--
