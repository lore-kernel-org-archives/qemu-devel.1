Received: from eggs.gnu.org ([209.51.188.92]:46034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcv-0002FF-Rp
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcs-00050k-5e
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:27 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:09:02 -0500
Message-Id: <20190401140903.19186-14-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/14] nbd/server: Advertise actual minimum
 block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Both NBD_CMD_BLOCK_STATUS and structured NBD_CMD_READ will split their
reply according to bdrv_block_status() boundaries. If the block device
has a request_alignment smaller than 512, but we advertise a block
alignment of 512 to the client, then this can result in the server
reply violating client expectations by reporting a smaller region of
the export than what the client is permitted to address (although this
is less of an issue for qemu 4.0 clients, given recent client patches
to overlook our non-compliance at EOF).  Since it's always better to
be strict in what we send, it is worth advertising the actual minimum
block limit rather than blindly rounding it up to 512.

Note that this patch is not foolproof - it is still possible to
provoke non-compliant server behavior using:

$ qemu-nbd --image-opts driver=3Dblkdebug,align=3D512,image.driver=3Dfile=
,image.filename=3D/path/to/non-aligned-file

That is arguably a bug in the blkdebug driver (it should never pass
back block status smaller than its alignment, even if it has to make
multiple bdrv_get_status calls and determine the
least-common-denominator status among the group to return). It may
also be possible to observe issues with a backing layer with smaller
alignment than the active layer, although so far I have been unable to
write a reliable iotest for that scenario (but again, an issue like
that could be argued to be a bug in the block layer, or something
where we need a flag to bdrv_block_status() to state whether the
result must be aligned to the current layer's limits or can be
subdivided for accuracy when chasing backing files).

Anyways, as blkdebug is not normally used, and as this patch makes our
server more interoperable with qemu 3.1 clients, it is worth applying
now, even while we still work on a larger patch series for the 4.1
timeframe to have byte-accurate file lengths.

Note that the iotests output changes - for 223 and 233, we can see the
server's better granularity advertisement; and for 241, the three test
cases have the following effects:
- natural alignment: the server's smaller alignment is now advertised,
and the hole reported at EOF is now the right result; we've gotten rid
of the server's non-compliance
- forced server alignment: the server still advertises 512 bytes, but
still sends a mid-sector hole. This is still a server compliance bug,
which needs to be fixed in the block layer in a later patch; output
does not change because the client is already being tolerant of the
non-compliance
- forced client alignment: the server's smaller alignment means that
the client now sees the server's status change mid-sector without any
protocol violations, but the fact that the map shows an unaligned
mid-sector hole is evidence of the block layer problems with aligned
block status, to be fixed in a later patch

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190329042750.14704-7-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: rebase to enhanced iotest 241 coverage]
---
 nbd/server.c               | 13 ++++++++-----
 tests/qemu-iotests/223.out |  4 ++--
 tests/qemu-iotests/233.out |  2 +-
 tests/qemu-iotests/241.out | 10 ++++++----
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index fd013a2817a..218a2aa5e65 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -607,13 +607,16 @@ static int nbd_negotiate_handle_info(NBDClient *cli=
ent, uint16_t myflags,
     /* Send NBD_INFO_BLOCK_SIZE always, but tweak the minimum size
      * according to whether the client requested it, and according to
      * whether this is OPT_INFO or OPT_GO. */
-    /* minimum - 1 for back-compat, or 512 if client is new enough.
-     * TODO: consult blk_bs(blk)->bl.request_alignment? */
-    sizes[0] =3D
-            (client->opt =3D=3D NBD_OPT_INFO || blocksize) ? BDRV_SECTOR=
_SIZE : 1;
+    /* minimum - 1 for back-compat, or actual if client will obey it. */
+    if (client->opt =3D=3D NBD_OPT_INFO || blocksize) {
+        sizes[0] =3D blk_get_request_alignment(exp->blk);
+    } else {
+        sizes[0] =3D 1;
+    }
+    assert(sizes[0] <=3D NBD_MAX_BUFFER_SIZE);
     /* preferred - Hard-code to 4096 for now.
      * TODO: is blk_bs(blk)->bl.opt_transfer appropriate? */
-    sizes[1] =3D 4096;
+    sizes[1] =3D MAX(4096, sizes[0]);
     /* maximum - At most 32M, but smaller as appropriate. */
     sizes[2] =3D MIN(blk_get_max_transfer(exp->blk), NBD_MAX_BUFFER_SIZE=
);
     trace_nbd_negotiate_handle_info_block_size(sizes[0], sizes[1], sizes=
[2]);
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 7828a447392..d5201b2356a 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -41,7 +41,7 @@ exports available: 2
  export: 'n'
   size:  4194304
   flags: 0x4ef ( readonly flush fua trim zeroes df cache )
-  min block: 512
+  min block: 1
   opt block: 4096
   max block: 33554432
   available meta contexts: 2
@@ -50,7 +50,7 @@ exports available: 2
  export: 'n2'
   size:  4194304
   flags: 0x4ed ( flush fua trim zeroes df cache )
-  min block: 512
+  min block: 1
   opt block: 4096
   max block: 33554432
   available meta contexts: 2
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 5acbc13b54a..9511b6ea658 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -38,7 +38,7 @@ exports available: 1
  export: ''
   size:  67108864
   flags: 0x4ed ( flush fua trim zeroes df cache )
-  min block: 512
+  min block: 1
   opt block: 4096
   max block: 33554432
   available meta contexts: 1
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index f22eabbf324..f481074a02e 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -3,8 +3,9 @@ QA output created by 241
 =3D=3D=3D Exporting unaligned raw image, natural alignment =3D=3D=3D

   size:  1024
-  min block: 512
-[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
+  min block: 1
+[{ "start": 0, "length": 1000, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 1000, "length": 24, "depth": 0, "zero": true, "data": true, "=
offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)

 =3D=3D=3D Exporting unaligned raw image, forced server sector alignment =
=3D=3D=3D
@@ -20,7 +21,8 @@ WARNING: Image format was not specified for '/home/ebla=
ke/qemu/tests/qemu-iotest
 =3D=3D=3D Exporting unaligned raw image, forced client sector alignment =
=3D=3D=3D

   size:  1024
-  min block: 512
-[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
+  min block: 1
+[{ "start": 0, "length": 1000, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 1000, "length": 24, "depth": 0, "zero": true, "data": true, "=
offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 *** done
--=20
2.20.1
