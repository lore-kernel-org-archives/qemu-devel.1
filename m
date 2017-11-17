Received: from eggs.gnu.org ([2001:4830:134:3::10]:50066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFkBM-0006xw-2H
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFkBK-0003tX-PE
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:12:00 -0500
References: <20171117164747.11525-1-eblake@redhat.com>
	<600d87a3-93a9-5d5d-7a9f-a31ba213348b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e42602d2-3b4a-279d-4714-2d281f879d41@redhat.com>
Date: Fri, 17 Nov 2017 11:11:51 -0600
MIME-Version: 1.0
In-Reply-To: <600d87a3-93a9-5d5d-7a9f-a31ba213348b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LMvTlf6ChGM4a9RdoLrPGn1VpfaAnoEn4"
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: fix image corruption on
 commit with persistent snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LMvTlf6ChGM4a9RdoLrPGn1VpfaAnoEn4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>
Message-ID: <e42602d2-3b4a-279d-4714-2d281f879d41@redhat.com>
Subject: Re: [PATCH for-2.11] qcow2: fix image corruption on commit with
 persistent snapshot
References: <20171117164747.11525-1-eblake@redhat.com>
 <600d87a3-93a9-5d5d-7a9f-a31ba213348b@virtuozzo.com>
In-Reply-To: <600d87a3-93a9-5d5d-7a9f-a31ba213348b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 17.11.2017 19:47, Eric Blake wrote:
>> If an image contains persistent snapshots, we cannot use the
>=20
> bitmaps

Oh, right. Maintainer can fix that, if I don't need to respin.

>=20
>> fast path of bdrv_make_empty() to clear the image during
>> qemu-img commit, because that will lose the clusters related
>> to the bitmaps.
>>
>> Also leave a comment in qcow2_read_extensions to remind future
>> feature additions to think about fast-path removal, since we
>> just barely fixed the same bug for LUKS encryption.
>>
>> It's a pain that qemu-img has not yet been taught to manipulate,
>> or even at a very minimum display, information about persistent
>> bitmaps; instead, we have to use QMP commands.=C2=A0 It's also a
>> pain that only qeury-block and x-debug-block-dirty-bitmap-sha256
>> will allow bitmap introspection; but the former requires the
>> node to be hooked to a block device, and the latter is experimental.
>=20
> sorry for that pain =3D(.
>=20
> Honestly, I don't understand why such a simple and obvious fix needs an=

> additional test.

Because the test was cool!  Here's how it fails without the qcow2 fix:

--- /home/eblake/qemu/tests/qemu-iotests/176.out	2017-11-17
10:41:56.287187401 -0600
+++ /home/eblake/qemu/tests/qemu-iotests/176.out.bad	2017-11-17
10:42:07.621220260 -0600
@@ -179,6 +179,8 @@
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 2202009600
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Bitmap '' doesn't satisfy the constraints
+qemu-img: Persistent bitmaps are lost for node '#block148'
 Image committed.
 read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -198,14 +200,11 @@
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
-0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
+qemu-img: Could not open
'/home/eblake/qemu/tests/qemu-iotests/scratch/t.qcow2': Bitmap ''
doesn't satisfy the constraints
 QMP_VERSION
 {"return": {}}
-{"return": {}}
-{"return": {"sha256":
"e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"error": {"class": "GenericError", "desc": "Bitmap '' doesn't satisfy
the constraints"}}
+{"error": {"class": "GenericError", "desc": "Node 'drive0' not found"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "SHUTDOWN", "data": {"guest": false}}


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LMvTlf6ChGM4a9RdoLrPGn1VpfaAnoEn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPGFcACgkQp6FrSiUn
Q2oa5wgAp0NOFOHzcjTqz+FKkfFQ3esvoQ/1CMrSLvysKqB6lpoExRsSwRsgi5ZR
uPm54Yz+Hb7hm+9qpukvZ7rauEdHCVoAF88HCxfeULXMNy7P3rXjFtAXaPlkLMe/
IsoFn5p9LA0JzoiGQ1ISJY4jTS59UUTJX1RBwTPVo+6KBJBFaNG6giH1pBqIvLlS
WdtBz1AcLw0hhEo/R9aBF/ptBE9sHYvQ/975LSG5RM+5a96It9w29itNF0+0rDfe
lIGW7kwDEVJuZGz3l21SWg+SKo9ujQzk0V1LCXgCO1/Y5ZtqQ1l8kehzVhdQ37C7
VSP7PvDqPKina+SuFfiDLXUXVZzi3Q==
=rn+s
-----END PGP SIGNATURE-----

--LMvTlf6ChGM4a9RdoLrPGn1VpfaAnoEn4--
