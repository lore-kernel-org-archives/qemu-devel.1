Received: from eggs.gnu.org ([2001:4830:134:3::10]:39308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTlFw-0002My-QQ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gTlFu-00055L-Ba
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:15:12 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 3 Dec 2018 10:15:00 +0000
Message-ID: <20181203101429.88735-10-anton.nefedov@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 9/9] iotest 134: test cluster-misaligned
 encrypted write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

COW (even empty/zero) areas require encryption too

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/134     |  9 +++++++++
 tests/qemu-iotests/134.out | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index cacabcd28b..792c8ca12f 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -57,6 +57,15 @@ echo
 echo "=3D=3D reading whole image =3D=3D"
 $QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _filte=
r_qemu_io | _filter_testdir
=20
+echo
+echo "=3D=3D rewriting cluster part =3D=3D"
+$QEMU_IO --object $SECRET -c "write -P 0xb 512 512" --image-opts $IMGSPEC =
| _filter_qemu_io | _filter_testdir
+
+echo
+echo "=3D=3D verify pattern =3D=3D"
+$QEMU_IO --object $SECRET -c "read -P 0 0 512"  --image-opts $IMGSPEC | _f=
ilter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xb 512 512"  --image-opts $IMGSPEC =
| _filter_qemu_io | _filter_testdir
+
 echo
 echo "=3D=3D rewriting whole image =3D=3D"
 $QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPEC =
| _filter_qemu_io | _filter_testdir
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 972be49d91..09d46f6b17 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -5,6 +5,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217=
728 encryption=3Don encrypt.
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
+=3D=3D rewriting cluster part =3D=3D
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D verify pattern =3D=3D
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 =3D=3D rewriting whole image =3D=3D
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
--=20
2.17.1
