Received: from eggs.gnu.org ([2001:4830:134:3::10]:43304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYv0B-0007DN-VU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYv0A-0001BJ-OJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:31:11 -0500
Date: Wed, 1 Feb 2017 13:31:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170201133100.GA11677@stefanha-x1.localdomain>
References: <20170131112308.54189-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20170131112308.54189-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block: bdrv_invalidate_cache: invalidate
 children first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 02:23:08PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Current implementation invalidates firstly parent bds and then its
> children. This leads to the following bug:
>=20
> after incoming migration, in bdrv_invalidate_cache_all:
> 1. invalidate parent bds - reopen it with BDRV_O_INACTIVE cleared
> 2. child is not yet invalidated
> 3. parent check that its BDRV_O_INACTIVE is cleared
> 4. parent writes to child
> 5. assert in bdrv_co_pwritev, as BDRV_O_INACTIVE is set for child
>=20
> This patch fixes it by just changing invalidate sequence: invalidate
> children first.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v2: I've missed that bdrv_invalidate_cache is already recursive, so we
> can change sequence here. Also v1 doesn't cover the case when
> bdrv_invalidate_cache is called not from bdrv_invalidate_cache_all.
>=20
>  block.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkeMUAAoJEJykq7OBq3PISm4H/AxHGMItHqfWU2SG1TpoSt6D
n/2x4w2flveCY5ZEpZ8iM2AcFvCDhY9shpN89e/9Cs5t7mGPV+bv6prOTKF0HbRO
MJ1eQPJg09kItntQRlRCWaZHSrBxCFltN4al1vLEbckWIn4grTe5ughuFK+mZ/3n
8IeWEQAKEVL37sex4BefPeq3OkCkCnnjxc8Bw+Nr9hQTlnf6WXMTCvVzpGRoa7+q
jriHSS5VLNry0fWf7ev4YWKCADpSS1u+0KjqOnXKhJinqAnUVnWWR6e/ed8S5JqI
sfw6+ERy0ZtMmcwho1ICupvZ4V79wa4iEkyJCfNGoIRDIuUzmgdyYReO7NmS0eo=
=oDQl
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
