Received: from eggs.gnu.org ([2001:4830:134:3::10]:41127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguoJ-0003fr-Sc
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguoE-0007VK-UY
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:55:59 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cguoE-0007VC-MS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:55:54 -0500
Received: by mail-wr0-x243.google.com with SMTP id 89so4197056wrr.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:55:54 -0800 (PST)
Date: Thu, 23 Feb 2017 14:55:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223145551.GR30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760170128.31154.5884656729259031522.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XAEV7zm15O60d1Zf"
Content-Disposition: inline
In-Reply-To: <148760170128.31154.5884656729259031522.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 18/29] 9pfs: local: lstat: don't follow
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


--XAEV7zm15O60d1Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:41PM +0100, Greg Kurz wrote:
> The local_lstat() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) lstat() which follows symbolic links in all path elements but the
>     rightmost one
> (2) getxattr() which follows symbolic links in all path elements
> (3) local_mapped_file_attr()->local_fopen()->openat(O_NOFOLLOW) which
>     follows symbolic links in all path elements but the rightmost
>     one
>=20
> This patch converts local_lstat() to rely on opendir_nofollow() and
> fstatat(AT_SYMLINK_NOFOLLOW) to fix (1), fgetxattrat_nofollow() to
> fix (2).
>=20
> A new local_fopenat() helper is introduced as a replacement to
> local_fopen() to fix (3). No effort is made to factor out code
> because local_fopen() will be dropped when all users have been
> converted to call local_fopenat().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   78 +++++++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 61 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XAEV7zm15O60d1Zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvf3AAoJEJykq7OBq3PIrSYH/1BfK0gcUl54lZRiOGtCd8dl
0ZRXdQQgTVkEOPJDPxXlJ7oQfzyd84JX/Xmrt6YkK1p1FT0SCvL2TclQALGuGArm
+HdTzCnHEDVQH82oPq1g8OxfEbSTWD379v0/pUDM0g1w8jm79uyv55whhX4aUTtZ
q/NiJkI7iDZEGOIqr8wdh+qaZgqDyHVLEJnmWBTwDMOlc9mX/lr0s2JTX/LKYwF9
u9V9icbYTMp7NaBISyZQdjqge42sCxRoz+SWZ5PtD+uRJnCmODw+Gizp2+D5uWdV
LadN/uGjCtmkVAEpj7Sn3hueeI1blFmbRI5JOhQ3d7fIc7g3pEwSrwtV3DJMynw=
=Sykn
-----END PGP SIGNATURE-----

--XAEV7zm15O60d1Zf--
