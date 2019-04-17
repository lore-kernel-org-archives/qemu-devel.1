Received: from eggs.gnu.org ([209.51.188.92]:47026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGjl7-0007g4-3L
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGjl6-00065T-60
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:33:49 -0400
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d03ef112-4ff4-c5af-5894-5b2c5f8075de@redhat.com>
Date: Wed, 17 Apr 2019 07:33:35 -0500
MIME-Version: 1.0
In-Reply-To: <20190417100929.39943-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9"
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/2] Fix overflow bug in qcow2
 discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com,
 stefanha@redhat.com
Message-ID: <d03ef112-4ff4-c5af-5894-5b2c5f8075de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/2] Fix overflow bug in qcow2
 discard
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190417100929.39943-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 5:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. We faced an interesting bug, which may be simply reproduced:
>=20
> prepare image:
> ./qemu-img create -f qcow2 -o cluster_size=3D1M /ssd/test 2300M
> ./qemu-io -c 'write 100M 2000M' -c 'write 2100M 200M' -c 'write 0 100M'=
 /ssd/test
>=20
> shrink:
> ./qemu-img resize --shrink /ssd/test 50M
>=20
> bug:
> ./qemu-img info /ssd/test
> image: /ssd/test
> file format: qcow2
> virtual size: 50M (52428800 bytes)
> disk size: 2.2G
> cluster_size: 1048576
> Format specific information:
>     compat: 1.1
>     lazy refcounts: false
>     refcount bits: 16
>     corrupt: false
>=20
> Virtual size is shrunk, but file - not. It is due to the fact,
> that merged qcow2 discard may exceed 2G, and then converting from
> uint64_t to int in qcow2_process_discards when we call bdrv_pdiscard
> make wrong thing.

Too late for 4.0, but also not a regression new to this release, since
the problem appears to have been present since its introduction in
commit 0b919fae (1.6.0) (that is, even back then, Qcow2DiscardRegion was
introduced with a 64-bit discard length, but qcow2_process_discards
blindly passed that through bdrv_discard() at the time, which took 'int
nb_sectors').

>=20
> So, here are proposal of fix and new iotest for it.
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   block/io: bdrv_pdiscard: support int64_t bytes parameter
>   iotests: test big qcow2 shrink
>=20
>  include/block/block.h      |  4 +--
>  block/io.c                 | 19 ++++++-----
>  tests/qemu-iotests/249     | 69 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/249.out | 30 +++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  5 files changed, 112 insertions(+), 11 deletions(-)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3HR8ACgkQp6FrSiUn
Q2rkZwf8D1J0c9aGOSLV4ybDsfzcTr58jHbkRo9mSo9QYJAbxPVPnHjgIXzsB45G
wYQNs+/hv10COPTeuYSkLEXJI7l1NE4wpL+gISSmBQrL4pKg0AlE38G+k2bV10I6
oO88fCb3AES7c432tVC1Kzruk+UuOxPBpu4ta5vcf4dmZP+/7ZPlE/Wl9GwPQsCK
5I+iusvRcElvzJ+YbvSyak4MmtxZpKeukq6rb3lr++LlyNJiETYf5/I9+zEoyNyN
71PvpsPtW1DwkhasUylhxliwMZGfS4BiUeq2dVy0a4pagIDTMgF1R9JqA21QxrJZ
v1lTTKob2gmLIuNRPXWxCbm+687Zcw==
=ij5Q
-----END PGP SIGNATURE-----

--iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9--
