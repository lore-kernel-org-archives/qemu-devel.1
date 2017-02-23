Received: from eggs.gnu.org ([2001:4830:134:3::10]:46968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv8k-0006sI-At
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv8h-0006Dj-1J
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:17:06 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgv8g-0006DV-Qy
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:17:02 -0500
Received: by mail-wm0-x243.google.com with SMTP id m70so384836wma.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:17:02 -0800 (PST)
Date: Thu, 23 Feb 2017 15:16:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223151659.GA30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760177071.31154.11710584398661216674.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tK3TaB1xs9ylLrl6"
Content-Disposition: inline
In-Reply-To: <148760177071.31154.11710584398661216674.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 27/29] 9pfs: local: mkdir: don't follow
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


--tK3TaB1xs9ylLrl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:42:50PM +0100, Greg Kurz wrote:
> The local_mkdir() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) mkdir() which follows symbolic links for all path elements but the
>     rightmost one
> (2) local_set_xattr()->setxattr() which follows symbolic links for all
>     path elements
> (3) local_set_mapped_file_attr() which calls in turn local_fopen() and
>     mkdir(), both functions following symbolic links for all path
>     elements but the rightmost one
> (4) local_post_create_passthrough() which calls in turn lchown() and
>     chmod(), both functions also following symbolic links
>=20
> This patch converts local_mkdir() to rely on opendir_nofollow() and
> mkdirat() to fix (1), as well as local_set_xattrat(),
> local_set_mapped_file_attrat() and local_set_cred_passthrough() to
> fix (2), (3) and (4) respectively.
>=20
> The mapped and mapped-file security modes are supposed to be identical,
> except for the place where credentials and file modes are stored. While
> here, we also make that explicit by sharing the call to mkdirat().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   55 +++++++++++++++++++---------------------------=
------
>  1 file changed, 20 insertions(+), 35 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tK3TaB1xs9ylLrl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvzrAAoJEJykq7OBq3PId4EH/i3W3nR44dLL01IljGHc3L1R
8hhY2svtQP+h8jxUbwl7Fm1wgONvqtIniEQNJCiMFMBJEwVFGqXzp2SklnrLn9j/
TShTq7TVM7EVYlVSiWMjeP5SpC4r+g0/G45wLwiP/8JRPs64tl0ubbCukbHdjvWc
RMkn8wR60uQWkrqaqHpyuxFj0Z8xrU85aR/kXfflQYtW9tbX3A3Vgjewd9/TXm5T
JEpvIww57GTCU23x8qGZIL91Ls20Mc7imeLljC1oKo3vKB0AxGKjcT9nG8X7sEee
Nr1VzvvltukoXjjM3wOYB7kBLU1OA2cMq5HhxgyCXx2XbUcsgl0r8XDrjIbTglM=
=Bk+b
-----END PGP SIGNATURE-----

--tK3TaB1xs9ylLrl6--
