Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv7a-0005sX-95
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv7S-0005jO-DF
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:15:52 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgv7S-0005j0-6W
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:15:46 -0500
Received: by mail-wm0-x241.google.com with SMTP id m70so377344wma.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:15:43 -0800 (PST)
Date: Thu, 23 Feb 2017 15:15:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223151540.GY30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760175415.31154.3167953970081939276.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5iovQLtJQXc0+Hs"
Content-Disposition: inline
In-Reply-To: <148760175415.31154.3167953970081939276.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 25/29] 9pfs: local: symlink: don't follow
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


--q5iovQLtJQXc0+Hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:42:34PM +0100, Greg Kurz wrote:
> The local_symlink() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) symlink() which follows symbolic links for all path elements but the
>     rightmost one
> (2) open(O_NOFOLLOW) which follows symbolic links for all path elements b=
ut
>     the rightmost one
> (3) local_set_xattr()->setxattr() which follows symbolic links for all
>     path elements
> (4) local_set_mapped_file_attr() which calls in turn local_fopen() and
>     mkdir(), both functions following symbolic links for all path
>     elements but the rightmost one
>=20
> This patch converts local_symlink() to rely on opendir_nofollow() and
> symlinkat() to fix (1), openat(O_NOFOLLOW) to fix (2), as well as
> local_set_xattrat() and local_set_mapped_file_attrat() to fix (3) and
> (4) respectively.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   81 ++++++++++++++++------------------------------=
------
>  1 file changed, 25 insertions(+), 56 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--q5iovQLtJQXc0+Hs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvycAAoJEJykq7OBq3PIVHEIALwq3NFC4LXVLrwY8giuJOKG
V2Iu+7pPLmmy013QP1VaHYB3miRNfwvuRT5aCCg4XVzKQJz+pseRf4np3ZFfCmA3
z2vj5kJi4aKAm01avcfiREp8YuxFE+pLLrSdri5xgbIyzLOX1altSqK9izeO9svA
Qp/0dR8WExfdZQXOcd0VcnJ0KKIDIqtwFOhOlA8IBybJPtqybwwYBZ/I9gG7DbWT
F+aFMDPw6OeWfbPtGejDG325hQzMdlvw0TNf5SiBUiIt1DXfk8JcVg6ifFU+MEh5
TuPJmLMaCplv4FACMaLcuDa/cCVhm3ztZQgEv6rtgQVGW9662fF84Cpzg0DYz1A=
=0inh
-----END PGP SIGNATURE-----

--q5iovQLtJQXc0+Hs--
