Received: from eggs.gnu.org ([2001:4830:134:3::10]:34799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCCNa-0001zS-2B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCCNZ-0007d4-0N
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:29:58 -0500
References: <20171106145345.12038-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35e0527c-06df-cef8-eb50-80b2e2a3e444@redhat.com>
Date: Tue, 7 Nov 2017 16:29:49 -0600
MIME-Version: 1.0
In-Reply-To: <20171106145345.12038-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UFHIVo6kaXaSbsgBcf0tMKhMhJ2kHI48B"
Subject: Re: [Qemu-devel] [PATCH] block: Close a BlockDriverState completely
 even when bs->drv is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UFHIVo6kaXaSbsgBcf0tMKhMhJ2kHI48B
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <35e0527c-06df-cef8-eb50-80b2e2a3e444@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Close a BlockDriverState completely
 even when bs->drv is NULL
References: <20171106145345.12038-1-berto@igalia.com>
In-Reply-To: <20171106145345.12038-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 08:53 AM, Alberto Garcia wrote:
> bdrv_close() skips much of its logic when bs->drv is NULL. This is
> fine when we're closing a BlockDriverState that has just been created
> (because e.g the initialization process failed), but it's not enough
> in other cases.
>=20
> For example, when a valid qcow2 image is found to be corrupted then
> QEMU marks it as such in the file header and then sets bs->drv to
> NULL in order to make the BlockDriverState unusable. When that BDS is
> later closed then many of its data structures are not freed (leaking
> their memory) and none of its children are detached. This results in
> bdrv_close_all() failing to close all BDSs and making this assertion
> fail when QEMU is being shut down:
>=20
>    bdrv_close_all: Assertion `QTAILQ_EMPTY(&all_bdrv_states)' failed.
>=20
> This patch makes bdrv_close() do the full uninitialization process
> in all cases. This fixes the problem with corrupted images and still
> works fine with freshly created BDSs.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c                    | 57 +++++++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/060     | 13 +++++++++++
>  tests/qemu-iotests/060.out | 12 ++++++++++
>  3 files changed, 53 insertions(+), 29 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UFHIVo6kaXaSbsgBcf0tMKhMhJ2kHI48B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloCM90ACgkQp6FrSiUn
Q2qw5Af/WhJG2kZA0ViBPpBEJ0y7EIOVTjDfW4UNOaTbt7zDDRm5P+p9oako1CnW
t8LjkhMQkWWhDlcjFmMHM3HL6a6fFWibZHTsS4fJfu+apRyyp6eT4smaYzDB1aRZ
+jo9isYIZ9wrRt1WWI2sn6j/ftxAU+nQzMMW07xT8veUelJiyXBrU09n8ZxBv0Wc
nDugfU0z8ef787nTJPtSpTDVifhTq/0yJ/0q8W0NRVEfYdaiK8xy2lr3eBjMTb1P
oGvtb07ufU3mTGjpKpjDGizbFjs5qP9k3BRrnoJ23tpaCK9Qq1HKxwA5JJTZamLt
1b+YCXVUHjzrHzP+To720KakE6OA3A==
=XhKN
-----END PGP SIGNATURE-----

--UFHIVo6kaXaSbsgBcf0tMKhMhJ2kHI48B--
