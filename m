Received: from eggs.gnu.org ([2001:4830:134:3::10]:45660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv2j-0001Lg-Gm
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgv2i-0004Vl-DA
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:10:53 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgv2i-0004VK-7K
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:10:52 -0500
Received: by mail-wr0-x244.google.com with SMTP id 89so4242857wrr.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:10:52 -0800 (PST)
Date: Thu, 23 Feb 2017 15:10:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223151049.GX30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760174673.31154.11366007991909627456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e9ndEBTQFD7P4kUb"
Content-Disposition: inline
In-Reply-To: <148760174673.31154.11366007991909627456.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 24/29] 9pfs: local: chown: don't follow
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


--e9ndEBTQFD7P4kUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:42:26PM +0100, Greg Kurz wrote:
> The local_chown() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) lchown() which follows symbolic links for all path elements but the
>     rightmost one
> (2) local_set_xattr()->setxattr() which follows symbolic links for all
>     path elements
> (3) local_set_mapped_file_attr() which calls in turn local_fopen() and
>     mkdir(), both functions following symbolic links for all path
>     elements but the rightmost one
>=20
> This patch converts local_chown() to rely on open_nofollow() and
> fchownat() to fix (1), as well as local_set_xattrat() and
> local_set_mapped_file_attrat() to fix (2) and (3) respectively.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--e9ndEBTQFD7P4kUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvt5AAoJEJykq7OBq3PIuSAIAK0yxz15Q9OxkHIJ4vEh4VyZ
ca9TeE6bsvBqXWMJI9JeamkJe3mq6jaqi0k0sNdRPmo6w5syLglgZZ4mlMyac9Zi
YXHVrq+GJkMFx7SJku/zmtQbHRGhMv8utyqmm2yZq1EldPNim5udLj9Vx9QXY2SW
3z71M75oyNkgieZt5oFYA6vcyMxYJUHhxTP2myQ5Uatns5bVCaV7iZ/fTc3dhhGO
eyeMaBFo9cLAf1ikZGH7uXIs9xVWLk0qH2ixYyquOkNSAvNAeAe+QF0r6nDgcJl6
c6iV0ccPnCmVbIfQBHpmx5yPIGV9Shk8Gq2XxLX1qcdq9R0/TH68yl+W6Nui+jU=
=rNVF
-----END PGP SIGNATURE-----

--e9ndEBTQFD7P4kUb--
