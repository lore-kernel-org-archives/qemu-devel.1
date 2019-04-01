Received: from eggs.gnu.org ([209.51.188.92]:45984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcq-00027u-7Y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxco-0004vU-BP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:58 -0500
Message-Id: <20190401140903.19186-10-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/14] nbd/client: Report offsets in
 bdrv_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

It is desirable for 'qemu-img map' to have the same output for a file
whether it is served over file or nbd protocols. However, ever since
we implemented block status for NBD (2.12), the NBD protocol forgot to
inform the block layer that as the final layer in the chain, the
offset is valid; without an offset, the human-readable form of
qemu-img map gives up with the unhelpful:

$ nbdkit -U - data data=3D"1" size=3D512 --run 'qemu-img map $nbd'
Offset          Length          Mapped to       File
qemu-img: File contains external, encrypted or compressed clusters.

The --output=3Djson form always works, because it is reporting the
lower-level bdrv_block_status results directly rather than trying to
filter out sparse ranges for human consumption - but now it also
shows the offset member.

With this patch, the human output changes to:

Offset          Length          Mapped to       File
0               0x200           0               nbd+unix://?socket=3D/tmp=
/nbdkitOxeoLa/socket

This change is observable to several iotests.

Fixes: 78a33ab5
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190329042750.14704-4-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c         |  9 +++++++--
 tests/qemu-iotests/209.out |  4 ++--
 tests/qemu-iotests/223.out | 18 +++++++++---------
 tests/qemu-iotests/241.out |  6 +++---
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 150af9cc46f..3edb508f668 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -972,7 +972,9 @@ int coroutine_fn nbd_client_co_block_status(BlockDriv=
erState *bs,

     if (!client->info.base_allocation) {
         *pnum =3D bytes;
-        return BDRV_BLOCK_DATA;
+        *map =3D offset;
+        *file =3D bs;
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }

     ret =3D nbd_co_send_request(bs, &request, NULL);
@@ -995,8 +997,11 @@ int coroutine_fn nbd_client_co_block_status(BlockDri=
verState *bs,

     assert(extent.length);
     *pnum =3D extent.length;
+    *map =3D offset;
+    *file =3D bs;
     return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
-           (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
+        (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0) |
+        BDRV_BLOCK_OFFSET_VALID;
 }

 void nbd_client_detach_aio_context(BlockDriverState *bs)
diff --git a/tests/qemu-iotests/209.out b/tests/qemu-iotests/209.out
index 0d29724e84a..214e27bfcec 100644
--- a/tests/qemu-iotests/209.out
+++ b/tests/qemu-iotests/209.out
@@ -1,2 +1,2 @@
-[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data": true=
},
-{ "start": 524288, "length": 524288, "depth": 0, "zero": true, "data": f=
alse}]
+[{ "start": 0, "length": 524288, "depth": 0, "zero": false, "data": true=
, "offset": 0},
+{ "start": 524288, "length": 524288, "depth": 0, "zero": true, "data": f=
alse, "offset": 524288}]
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 95c40a17ad7..7828a447392 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -67,18 +67,18 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true},
-{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": fa=
lse},
-{ "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data"=
: true}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET},
+{ "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET}]
 [{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false=
},
-{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true},
+{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]

 =3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D

-[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true},
+[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true, "=
offset": OFFSET},
 { "start": 512, "length": 512, "depth": 0, "zero": false, "data": false}=
,
-{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue},
+{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]

 =3D=3D=3D End qemu NBD server =3D=3D=3D
@@ -94,10 +94,10 @@ read 2097152/2097152 bytes at offset 2097152
 =3D=3D=3D Use qemu-nbd as server =3D=3D=3D

 [{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false=
},
-{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true},
+{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
-[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true},
+[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true, "=
offset": OFFSET},
 { "start": 512, "length": 512, "depth": 0, "zero": false, "data": false}=
,
-{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue},
+{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue, "offset": OFFSET},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
 *** done
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index b76a6234d72..f22eabbf324 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -4,7 +4,7 @@ QA output created by 241

   size:  1024
   min block: 512
-[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true}]
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)

 =3D=3D=3D Exporting unaligned raw image, forced server sector alignment =
=3D=3D=3D
@@ -14,13 +14,13 @@ WARNING: Image format was not specified for '/home/eb=
lake/qemu/tests/qemu-iotest
          Specify the 'raw' format explicitly to remove the restrictions.
   size:  1024
   min block: 512
-[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true}]
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)

 =3D=3D=3D Exporting unaligned raw image, forced client sector alignment =
=3D=3D=3D

   size:  1024
   min block: 512
-[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true}]
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 *** done
--=20
2.20.1
