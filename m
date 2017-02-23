Received: from eggs.gnu.org ([2001:4830:134:3::10]:48023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgvE7-0003RB-F6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgvE6-0007sI-Lf
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:22:39 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgvE6-0007s3-FU
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:22:38 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so394755wmd.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:22:38 -0800 (PST)
Date: Thu, 23 Feb 2017 15:22:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223152235.GB30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760177893.31154.1632894671963250618.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SHFFXbs3XlGSDX14"
Content-Disposition: inline
In-Reply-To: <148760177893.31154.1632894671963250618.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 28/29] 9pfs: local: open2: don't follow
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


--SHFFXbs3XlGSDX14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:42:58PM +0100, Greg Kurz wrote:
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
>  hw/9pfs/9p-local.c |   70 ++++++++++++++++++++++------------------------=
------
>  1 file changed, 29 insertions(+), 41 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SHFFXbs3XlGSDX14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrv47AAoJEJykq7OBq3PItlYH/1tGfF+eR00LOcXg0lvYT6JD
VhfUqnPkeOWOTGL5YVgWgoTl/lo5SPy/es4NOfEE4duLyiliNakpLIODPgX6GcBf
5Z0mClIQwphipnmmEuHwvvMtpkPyKavRlm+tbTfpYao/VOkWUpfgjBy3//lMhL2Y
5s7WJacuM7k0SDWpaZv5Vriqblnx9VbAfiq6JR1Fd8deSlQ3hQ4egPuFy32cS/H3
+TF/gTMebDo4pYpXbdxbON7vWI85p6hsC2Kua77F47yC/rezpg4yqb9oLAX5qbdS
9nKay74icDHShMZcnZJMrElArfgpmH9kwyMm6aR4bOQom7N08idi84C/Kia6ll8=
=mId5
-----END PGP SIGNATURE-----

--SHFFXbs3XlGSDX14--
