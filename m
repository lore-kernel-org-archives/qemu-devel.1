Received: from eggs.gnu.org ([2001:4830:134:3::10]:45418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLBh-0006CC-Gc
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLBc-0002Hs-Jx
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:01 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciLBc-0002Hb-DU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:17:56 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so13407511wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:17:56 -0800 (PST)
Date: Mon, 27 Feb 2017 13:17:53 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227131753.GN28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814906880.28146.13942320633418827458.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K4LMwn8CgX2KMboP"
Content-Disposition: inline
In-Reply-To: <148814906880.28146.13942320633418827458.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 22/28] 9pfs: local: chmod: don't follow
 symlinks
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


--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:44:28PM +0100, Greg Kurz wrote:
> The local_chmod() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) chmod() which follows symbolic links for all path elements
> (2) local_set_xattr()->setxattr() which follows symbolic links for all
>     path elements
> (3) local_set_mapped_file_attr() which calls in turn local_fopen() and
>     mkdir(), both functions following symbolic links for all path
>     elements but the rightmost one
>=20
> We would need fchmodat() to implement AT_SYMLINK_NOFOLLOW to fix (1). This
> isn't the case on linux unfortunately: the kernel doesn't even have a fla=
gs
> argument to the syscall :-\ It is impossible to fix it in userspace in
> a race-free manner. This patch hence converts local_chmod() to rely on
> open_nofollow() and fchmod(). This fixes the vulnerability but introduces
> a limitation: the target file must readable and/or writable for the call
> to openat() to succeed.
>=20
> It introduces a local_set_xattrat() replacement to local_set_xattr()
> based on fsetxattrat() to fix (2), and a local_set_mapped_file_attrat()
> replacement to local_set_mapped_file_attr() based on local_fopenat()
> and mkdirat() to fix (3). No effort is made to factor out code because
> both local_set_xattr() and local_set_mapped_file_attr() will be dropped
> when all users have been converted to use the "at" versions.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - use openat_dir()
>     - updated the changelog and added a comment for fchmod()
> ---
>  hw/9pfs/9p-local.c |  178 ++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 167 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCcBAAoJEJykq7OBq3PIGoUIAKGgAoxb1jZoyOW+8m4/5bvP
wp3QVqrjLgitE/aBE8FQ/F3axidgnxF6yKj/8X+ODM5+Z4WVSxOW0gPp0Od5Shwz
jLJWvHvYxZvlvQpVoCpWULaIyJYM+SHYAxcygiaF8okfiD+tjccip702AhJD1clw
QNyLJerbrUbIZKFFJhrix3SKd3gss2FKp6RbYz/4ObNU+dX7eKbbBFxv9iFScCSd
nFm1RQdnr9p/NtJQjBhvyzn0ve564Vets0jflJ4g+CLmDUoc5BftTn7b4LhvInP1
Z1aq7VYGO7Q2bbUCUO+Uf6LTEttB7gamccBiiM8/lzgjHyYL2VhOqwJSj9828WE=
=HEBZ
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--
