Received: from eggs.gnu.org ([2001:4830:134:3::10]:45543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLBz-0006XE-V6
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLBv-0002KC-2Q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:19 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciLBu-0002Js-SU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:14 -0500
Received: by mail-wm0-x241.google.com with SMTP id u63so13383806wmu.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:18:14 -0800 (PST)
Date: Mon, 27 Feb 2017 13:18:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227131810.GO28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814909433.28146.640260834814194727.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline
In-Reply-To: <148814909433.28146.640260834814194727.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 25/28] 9pfs: local: mknod: don't follow
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


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:44:54PM +0100, Greg Kurz wrote:
> The local_mknod() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) mknod() which follows symbolic links for all path elements but the
>     rightmost one
> (2) local_set_xattr()->setxattr() which follows symbolic links for all
>     path elements
> (3) local_set_mapped_file_attr() which calls in turn local_fopen() and
>     mkdir(), both functions following symbolic links for all path
>     elements but the rightmost one
> (4) local_post_create_passthrough() which calls in turn lchown() and
>     chmod(), both functions also following symbolic links
>=20
> This patch converts local_mknod() to rely on opendir_nofollow() and
> mknodat() to fix (1), as well as local_set_xattrat() and
> local_set_mapped_file_attrat() to fix (2) and (3) respectively.
>=20
> A new local_set_cred_passthrough() helper based on fchownat() and
> fchmodat_nofollow() is introduced as a replacement to
> local_post_create_passthrough() to fix (4).
>=20
> The mapped and mapped-file security modes are supposed to be identical,
> except for the place where credentials and file modes are stored. While
> here, we also make that explicit by sharing the call to mknodat().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - use fchmodat_nofollow()
> ---
>  hw/9pfs/9p-local.c |   68 +++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 35 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCcSAAoJEJykq7OBq3PIh90H/1HSWn2jRS268LXjeywNCkUt
B+OeiUHVxANQF+b7mYNM/h6x7KOmQzCnScRavtAJPoLs1iJrTw5hlLZbB3jLg1Ax
q7eDc1zjftkM3IvV23L1b82gGDykCHSyWLDGgLNUofIGQAMkrKTiwihkNQmLcf0E
TflxjvoqFjxTS+NuOrlqy8vpfyxD1XNUbd3v1nfY6vU+JbtCWjMn7FfXm6zVsky6
XrnhTjlZCWD1548j7R+Holbvw1wez6AUOXuHXEaLqwIEr38qEaS+VtZL1miPY2lu
myoG0652pzilESO7baPeOWXpQksOQAg3RPlD17xiwdsd/XjbbKMqqZgSGgF4MfE=
=MFUC
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--
