Received: from eggs.gnu.org ([2001:4830:134:3::10]:56055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFjHX-0006o9-F4
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFjHW-0008RV-JD
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:14:19 -0500
References: <20171106145345.12038-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e30a779a-df6d-b929-f39b-ee4b3a580443@redhat.com>
Date: Fri, 17 Nov 2017 17:14:08 +0100
MIME-Version: 1.0
In-Reply-To: <20171106145345.12038-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I7NSQOK4hKCldak3sgJrIXnmCxsf146nS"
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I7NSQOK4hKCldak3sgJrIXnmCxsf146nS
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <e30a779a-df6d-b929-f39b-ee4b3a580443@redhat.com>
Subject: Re: [PATCH] block: Close a BlockDriverState completely even when
 bs->drv is NULL
References: <20171106145345.12038-1-berto@igalia.com>
In-Reply-To: <20171106145345.12038-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-06 15:53, Alberto Garcia wrote:
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

Sooo...  What's the exact status of this patch? :-)

Max


--I7NSQOK4hKCldak3sgJrIXnmCxsf146nS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloPCtESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADV4H/3ukUP1b3RqpD2mEFkGt4SXhCWfvVa7N
qTunT5JSbdfy+7rP5Ixn4fMEt//NCdN4m6cmuodlA4CEBI82rIHV2A+N68vgyYOa
wQ0NNXieBTQpml7H8BNnEFBjuyxVquzJhW7CPDUuJoW/rhhzLNuD7EYsw9ZYsjuR
QE2oZzUeJVJYzMDHkGmZ2fv18NH1eL3R+KjzlnwBgjoucFbIXUOPuqq3/s7AHG6P
eGdn09yWhroiUvdEFRv0d9cfz4EEPhi5PF75k0s4X8Y7meEIJaQ7PFskF4DFxMth
WasQSBXrXYSdaWkpfqwrZM1Y6m9nI56qQJFV+g2oS2cv4hFUVLA5CCE=
=iUoK
-----END PGP SIGNATURE-----

--I7NSQOK4hKCldak3sgJrIXnmCxsf146nS--
