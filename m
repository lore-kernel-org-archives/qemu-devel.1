Received: from eggs.gnu.org ([209.51.188.92]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn1V0-0000x6-ME
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gn1Ux-00088P-IG
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:26:21 -0500
References: <20190124141731.21509-1-kwolf@redhat.com>
	<bcf01a3b-fea8-d170-416a-f04d78a63822@virtuozzo.com>
	<20190124163614.GM4601@localhost.localdomain>
	<cbbd150b-9514-93ce-3b3a-3f85a963003d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fbe9140-e927-bd72-2b4e-8b1dbd58e010@redhat.com>
Date: Fri, 25 Jan 2019 07:26:10 -0600
MIME-Version: 1.0
In-Reply-To: <cbbd150b-9514-93ce-3b3a-3f85a963003d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kb9wttZZMPm8YwbyDy59lxuapwukVfOe7"
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kb9wttZZMPm8YwbyDy59lxuapwukVfOe7
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <1fbe9140-e927-bd72-2b4e-8b1dbd58e010@redhat.com>
Subject: Re: [PATCH] file-posix: Cache lseek result for data regions
References: <20190124141731.21509-1-kwolf@redhat.com>
 <bcf01a3b-fea8-d170-416a-f04d78a63822@virtuozzo.com>
 <20190124163614.GM4601@localhost.localdomain>
 <cbbd150b-9514-93ce-3b3a-3f85a963003d@virtuozzo.com>
In-Reply-To: <cbbd150b-9514-93ce-3b3a-3f85a963003d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/25/19 3:13 AM, Vladimir Sementsov-Ogievskiy wrote:

>=20
> before your patch:
> ]# ./test
> Formatting 'x', fmt=3Draw size=3D1048576
> qemu-io> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0523 sec (19.093 MiB/sec and 19.0927 ops/sec)
> qemu-io> [{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "=
data": true, "offset": 0}]
> qemu-io> handle_aiocb_write_zeroes
> wrote 102400/102400 bytes at offset 102400
> 100 KiB, 1 ops; 0.0165 sec (5.898 MiB/sec and 60.3974 ops/sec)
> qemu-io> [{ "start": 0, "length": 102400, "depth": 0, "zero": false, "d=
ata": true, "offset": 0},
> { "start": 102400, "length": 102400, "depth": 0, "zero": true, "data": =
false, "offset": 102400},
> { "start": 204800, "length": 843776, "depth": 0, "zero": false, "data":=
 true, "offset": 204800}]
> qemu-io> handle_aiocb_write_zeroes_unmap
> wrote 102400/102400 bytes at offset 512000
> 100 KiB, 1 ops; 0.0001 sec (545.566 MiB/sec and 5586.5922 ops/sec)
> qemu-io> [{ "start": 0, "length": 102400, "depth": 0, "zero": false, "d=
ata": true, "offset": 0},
> { "start": 102400, "length": 102400, "depth": 0, "zero": true, "data": =
false, "offset": 102400},
> { "start": 204800, "length": 307200, "depth": 0, "zero": false, "data":=
 true, "offset": 204800},
> { "start": 512000, "length": 102400, "depth": 0, "zero": true, "data": =
false, "offset": 512000},
> { "start": 614400, "length": 434176, "depth": 0, "zero": false, "data":=
 true, "offset": 614400}]

Your demonstration pre-patch shows that both 'write -z' and 'write -z
-u' produced areas of the qcow2 image that were marked as known zeroes,
and claim 'data':false meaning that those two areas are sparse (that is,
it appears 'write -z' managed to unmap after all?)

>=20
>=20
>=20
> after your patch:
> # ./test
> Formatting 'x', fmt=3Draw size=3D1048576
> qemu-io> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0768 sec (13.019 MiB/sec and 13.0195 ops/sec)
> qemu-io> [{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "=
data": true, "offset": 0}]
> qemu-io> handle_aiocb_write_zeroes
> wrote 102400/102400 bytes at offset 102400
> 100 KiB, 1 ops; 0.0166 sec (5.883 MiB/sec and 60.2410 ops/sec)
> qemu-io> [{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "=
data": true, "offset": 0}]

So here, the cache was not invalidated, so the 'write -z' area was
temporarily reported as data...

> qemu-io> handle_aiocb_write_zeroes_unmap
> wrote 102400/102400 bytes at offset 512000
> 100 KiB, 1 ops; 0.0002 sec (469.501 MiB/sec and 4807.6923 ops/sec)
> qemu-io> [{ "start": 0, "length": 102400, "depth": 0, "zero": false, "d=
ata": true, "offset": 0},
> { "start": 102400, "length": 102400, "depth": 0, "zero": true, "data": =
false, "offset": 102400},
> { "start": 204800, "length": 307200, "depth": 0, "zero": false, "data":=
 true, "offset": 204800},
> { "start": 512000, "length": 102400, "depth": 0, "zero": true, "data": =
false, "offset": 512000},
> { "start": 614400, "length": 434176, "depth": 0, "zero": false, "data":=
 true, "offset": 614400}]

but after the 'write -z -u' invalidated the cache, we once again see
that the 'write -z' worked.

>=20
>=20
> So, you've changed behavior of block_status after write_zeroes without =
UNMAP for the worse.
>=20
> Hmm, should I prepare patch for qemu-io? qemu-img map is definitely bet=
ter.

qemu-io map is NOT asking the same information as qemu-img map (it's
annoying - but BOTH pieces of information are useful, and there are some
iotests that check both outputs to get a full picture of things).
qemu-img asks as much information as possible about all layers, while
qemu-io asks only abut the top layer.

That said, qemu-io is NOT baked in stone; if you want to patch it AND
fix the iotest fallout, I'm not opposed to that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--kb9wttZZMPm8YwbyDy59lxuapwukVfOe7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxLDnIACgkQp6FrSiUn
Q2obtAf9E2rF6AdAbeYuTFY2OJZgiyEbNJyJgJ0ftPioZykEp9tGjtgm6cj0nk4o
Va2vSFhN4pj20aQx/QL4GeZMvWfix+tzUL6FmbgdOscF726SKzN4WUwkKGRgSkJy
fBAXSIrLSL0A/Dy/TZAORdG2BwOqSmDMpYTzRCz/D09z6X3lHBNTpb9jBo22ZG39
W4pZncTTT79TEEjf1JNJcPN7raWP5SvejW5OVKV/IIxlnAlYH/gWofnvep8Gi6r4
bnOtDkjibGYzhOsSEWtx5ckQ4xHVjrkcSS3kEW0xIvyMNlx7UviaBGUUpr69temc
PnIvWrdzsfr1TCjyvevgLuirOT/S6Q==
=Zr9H
-----END PGP SIGNATURE-----

--kb9wttZZMPm8YwbyDy59lxuapwukVfOe7--
