Received: from eggs.gnu.org ([2001:4830:134:3::10]:46827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv81-0006As-Dj
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv80-0005uk-Hq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:16:21 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgv80-0005uQ-BT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:16:20 -0500
Received: by mail-wr0-x242.google.com with SMTP id 89so4260592wrr.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:16:20 -0800 (PST)
Date: Thu, 23 Feb 2017 15:16:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223151617.GZ30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760176237.31154.7566198284512559524.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McORcswOES2gGXLb"
Content-Disposition: inline
In-Reply-To: <148760176237.31154.7566198284512559524.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 26/29] 9pfs: local: mknod: don't follow
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


--McORcswOES2gGXLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:42:42PM +0100, Greg Kurz wrote:
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
> A new local_set_cred_passthrough() helper based on fchownat() and fchmod()
> is introduced as a replacement to local_post_create_passthrough() to fix =
(4).
> No effort is made to factor out code because local_post_create_passthroug=
h()
> will be dropped when all users have been converted to call the new helper.
>=20
> The mapped and mapped-file security modes are supposed to be identical,
> except for the place where credentials and file modes are stored. While
> here, we also make that explicit by sharing the call to mknodat().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   82 +++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 49 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--McORcswOES2gGXLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvzBAAoJEJykq7OBq3PICmAH/04SnYl6zzI1i9ayLlFU1Rm+
k0Kq5Yy84pkN3HVyQsfsZS26QVHj1pbJrCktPKzxTbjZBqpAmH2B4HVGucYY3fB6
LMI067NXYV6L31wxxroMWAWFi4pRBhFeYta9W1OSiF5tmmZhZnAxaCyeakyVx0aB
T4YvCy6I8AyJ1X8Tc5NMx/kvdPUabTT4zAYxi62RjY81gWVSus3XIhlhS7MqcxEA
JEMt2TMJfpWB8nvoJedXz0QCqbHxOR5KuoyQUi6ZVEfoteoDuZjAMEt2TVI/nkw/
0OXOnA1SrvNYybEJu56d4/1tI6NhXxO8AbtIpnfWI/fWSe2fUSyqzYsPpeghvaU=
=A0s+
-----END PGP SIGNATURE-----

--McORcswOES2gGXLb--
