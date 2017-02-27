Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLCI-0006nY-Us
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLCE-0002Ov-1s
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:38 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciLCD-0002Or-RH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:33 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so13417327wmd.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:18:33 -0800 (PST)
Date: Mon, 27 Feb 2017 13:18:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227131830.GP28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814910969.28146.2398026356734732533.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3SAtXwgGp429mN7"
Content-Disposition: inline
In-Reply-To: <148814910969.28146.2398026356734732533.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 27/28] 9pfs: local: open2: don't follow
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


--R3SAtXwgGp429mN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:45:09PM +0100, Greg Kurz wrote:
> The local_open2() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) open() which follows symbolic links for all path elements but the
>     rightmost one
> (2) local_set_xattr()->setxattr() which follows symbolic links for all
>     path elements
> (3) local_set_mapped_file_attr() which calls in turn local_fopen() and
>     mkdir(), both functions following symbolic links for all path
>     elements but the rightmost one
> (4) local_post_create_passthrough() which calls in turn lchown() and
>     chmod(), both functions also following symbolic links
>=20
> This patch converts local_open2() to rely on opendir_nofollow() and
> mkdirat() to fix (1), as well as local_set_xattrat(),
> local_set_mapped_file_attrat() and local_set_cred_passthrough() to
> fix (2), (3) and (4) respectively. Since local_open2() already opens
> a descriptor to the target file, local_set_cred_passthrough() is
> modified to reuse it instead of opening a new one.
>=20
> The mapped and mapped-file security modes are supposed to be identical,
> except for the place where credentials and file modes are stored. While
> here, we also make that explicit by sharing the call to openat().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - use openat_file()
>     - pass dirfd and name to local_set_cred_passthrough()
> ---
>  hw/9pfs/9p-local.c |   56 ++++++++++++++++++----------------------------=
------
>  1 file changed, 19 insertions(+), 37 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--R3SAtXwgGp429mN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCcmAAoJEJykq7OBq3PIS+QH/jxr75pz2en/HuqYq5OwOsIp
rT7vK31XTwY1BaNO6M7+8DPGpU559cCrmEK5Txuuidlo8B/ZCLnxKztOrfSl04Nm
ZJ72tD/N5VLJh6CyOzQzqEPnyKovmkzWw0OS6xFT/8oa1d53nfucKXBQUA0YkKdn
Q8CdXytA82+XDxBjQBaGUTjGkORKt5md7H4GPPn5ihFx5kU9fG0b+JuMQIV71bNN
un9narIwxqqY34fT5Vb1b0T2+eA/PUE3uTyBnU2SK6lT/4U2k/aEK+pslmzEQ6x+
6kLCiRwHx+e4sq1bYrEbJpmST2apW7ajbtIMchi90rvx7gPwUbwHEI2nKg+HE3I=
=PcJC
-----END PGP SIGNATURE-----

--R3SAtXwgGp429mN7--
