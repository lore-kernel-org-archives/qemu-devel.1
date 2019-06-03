Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2209CC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8A42407D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8A42407D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXofS-0000bi-3V
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:14:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUn-0000Z5-8Z
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUi-0007UJ-65
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoUe-0007Mn-1i; Mon, 03 Jun 2019 11:03:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63804307D942;
	Mon,  3 Jun 2019 15:03:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 785D06726F;
	Mon,  3 Jun 2019 15:03:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:10 +0200
Message-Id: <20190603150233.6614-6-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 03 Jun 2019 15:03:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/28] block: avoid recursive block_status call
 if possible
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

drv_co_block_status digs bs->file for additional, more accurate search
for hole inside region, reported as DATA by bs since 5daa74a6ebc.

This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
knows, where are holes and where is data. But every block_status
request calls lseek additionally. Assume a big disk, full of
data, in any iterative copying block job (or img convert) we'll call
lseek(HOLE) on every iteration, and each of these lseeks will have to
iterate through all metadata up to the end of file. It's obviously
ineffective behavior. And for many scenarios we don't need this lseek
at all.

However, lseek is needed when we have metadata-preallocated image.

So, let's detect metadata-preallocation case and don't dig qcow2's
protocol file in other cases.

The idea is to compare allocation size in POV of filesystem with
allocations size in POV of Qcow2 (by refcounts). If allocation in fs is
significantly lower, consider it as metadata-preallocation case.

102 iotest changed, as our detector can't detect shrinked file as
metadata-preallocation, which don't seem to be wrong, as with metadata
preallocation we always have valid file length.

Two other iotests have a slight change in their QMP output sequence:
Active 'block-commit' returns earlier because the job coroutine yields
earlier on a blocking operation. This operation is loading the refcount
blocks in qcow2_detect_metadata_preallocation().

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h              |  4 ++++
 include/block/block.h      |  8 +++++++-
 block/io.c                 |  9 ++++++++-
 block/qcow2-refcount.c     | 32 ++++++++++++++++++++++++++++++++
 block/qcow2.c              | 11 +++++++++++
 tests/qemu-iotests/102     |  2 +-
 tests/qemu-iotests/102.out |  3 ++-
 tests/qemu-iotests/141.out |  2 +-
 tests/qemu-iotests/144.out |  2 +-
 9 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 567375e56c..fc1b0d3c1e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -356,6 +356,9 @@ typedef struct BDRVQcow2State {
     int nb_threads;
=20
     BdrvChild *data_file;
+
+    bool metadata_preallocation_checked;
+    bool metadata_preallocation;
 } BDRVQcow2State;
=20
 typedef struct Qcow2COWRegion {
@@ -655,6 +658,7 @@ int qcow2_change_refcount_order(BlockDriverState *bs,=
 int refcount_order,
                                 void *cb_opaque, Error **errp);
 int qcow2_shrink_reftable(BlockDriverState *bs);
 int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
+int qcow2_detect_metadata_preallocation(BlockDriverState *bs);
=20
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
diff --git a/include/block/block.h b/include/block/block.h
index 9b083e2bca..531cf595cf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -156,10 +156,15 @@ typedef struct HDGeometry {
  * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
  *                 layer, set by block layer
  *
- * Internal flag:
+ * Internal flags:
  * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to reque=
st
  *                 that the block layer recompute the answer from the re=
turned
  *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VA=
LID.
+ * BDRV_BLOCK_RECURSE: request that the block layer will recursively sea=
rch for
+ *                     zeroes in file child of current block node inside
+ *                     returned region. Only valid together with both
+ *                     BDRV_BLOCK_DATA and BDRV_BLOCK_OFFSET_VALID. Shou=
ld not
+ *                     appear with BDRV_BLOCK_ZERO.
  *
  * If BDRV_BLOCK_OFFSET_VALID is set, the map parameter represents the
  * host offset within the returned BDS that is allocated for the
@@ -184,6 +189,7 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_RAW          0x08
 #define BDRV_BLOCK_ALLOCATED    0x10
 #define BDRV_BLOCK_EOF          0x20
+#define BDRV_BLOCK_RECURSE      0x40
 #define BDRV_BLOCK_OFFSET_MASK  BDRV_SECTOR_MASK
=20
 typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReop=
enQueue;
diff --git a/block/io.c b/block/io.c
index 3134a60a48..150358c3b1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2092,6 +2092,12 @@ static int coroutine_fn bdrv_co_block_status(Block=
DriverState *bs,
      */
     assert(*pnum && QEMU_IS_ALIGNED(*pnum, align) &&
            align > offset - aligned_offset);
+    if (ret & BDRV_BLOCK_RECURSE) {
+        assert(ret & BDRV_BLOCK_DATA);
+        assert(ret & BDRV_BLOCK_OFFSET_VALID);
+        assert(!(ret & BDRV_BLOCK_ZERO));
+    }
+
     *pnum -=3D offset - aligned_offset;
     if (*pnum > bytes) {
         *pnum =3D bytes;
@@ -2122,7 +2128,8 @@ static int coroutine_fn bdrv_co_block_status(BlockD=
riverState *bs,
         }
     }
=20
-    if (want_zero && local_file && local_file !=3D bs &&
+    if (want_zero && ret & BDRV_BLOCK_RECURSE &&
+        local_file && local_file !=3D bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int64_t file_pnum;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 4c1794f9af..3a2c673a5e 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3444,3 +3444,35 @@ int64_t qcow2_get_last_cluster(BlockDriverState *b=
s, int64_t size)
                             "There are no references in the refcount tab=
le.");
     return -EIO;
 }
+
+int qcow2_detect_metadata_preallocation(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int64_t i, end_cluster, cluster_count =3D 0, threshold;
+    int64_t file_length, real_allocation, real_clusters;
+
+    file_length =3D bdrv_getlength(bs->file->bs);
+    if (file_length < 0) {
+        return file_length;
+    }
+
+    real_allocation =3D bdrv_get_allocated_file_size(bs->file->bs);
+    if (real_allocation < 0) {
+        return real_allocation;
+    }
+
+    real_clusters =3D real_allocation / s->cluster_size;
+    threshold =3D MAX(real_clusters * 10 / 9, real_clusters + 2);
+
+    end_cluster =3D size_to_clusters(s, file_length);
+    for (i =3D 0; i < end_cluster && cluster_count < threshold; i++) {
+        uint64_t refcount;
+        int ret =3D qcow2_get_refcount(bs, i, &refcount);
+        if (ret < 0) {
+            return ret;
+        }
+        cluster_count +=3D !!refcount;
+    }
+
+    return cluster_count >=3D threshold;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index f2cb131048..14f914117f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1895,6 +1895,12 @@ static int coroutine_fn qcow2_co_block_status(Bloc=
kDriverState *bs,
     unsigned int bytes;
     int status =3D 0;
=20
+    if (!s->metadata_preallocation_checked) {
+        ret =3D qcow2_detect_metadata_preallocation(bs);
+        s->metadata_preallocation =3D (ret =3D=3D 1);
+        s->metadata_preallocation_checked =3D true;
+    }
+
     bytes =3D MIN(INT_MAX, count);
     qemu_co_mutex_lock(&s->lock);
     ret =3D qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset=
);
@@ -1917,6 +1923,11 @@ static int coroutine_fn qcow2_co_block_status(Bloc=
kDriverState *bs,
     } else if (ret !=3D QCOW2_CLUSTER_UNALLOCATED) {
         status |=3D BDRV_BLOCK_DATA;
     }
+    if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
+        (status & BDRV_BLOCK_OFFSET_VALID))
+    {
+        status |=3D BDRV_BLOCK_RECURSE;
+    }
     return status;
 }
=20
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 749ff66b8a..b898df436f 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -55,7 +55,7 @@ $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
=20
 $QEMU_IO -c map "$TEST_IMG"
-$QEMU_IMG map "$TEST_IMG"
+$QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map
=20
 echo
 echo '=3D=3D=3D Testing map on an image file truncated outside of qemu =3D=
=3D=3D'
diff --git a/tests/qemu-iotests/102.out b/tests/qemu-iotests/102.out
index 4401b08fee..cd2fdc7f96 100644
--- a/tests/qemu-iotests/102.out
+++ b/tests/qemu-iotests/102.out
@@ -7,7 +7,8 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image resized.
 64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
-Offset          Length          Mapped to       File
+Offset          Length          File
+0               0x10000         TEST_DIR/t.IMGFMT
=20
 =3D=3D=3D Testing map on an image file truncated outside of qemu =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 41c7291258..4d71d9dcae 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -42,9 +42,9 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "commit"}}
-{"return": {}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block =
device is in use by block job: commit"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index 55299201e4..a9a8216bea 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -14,10 +14,10 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D5=
36870912 backing_file=3DTEST_DIR/
=20
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "virtio0"}}
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_READY", "data": {"device": "virtio0", "len": 0, "offset": =
0, "speed": 0, "type": "commit"}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_COMPLETED", "data": {"device": "virtio0", "len": 0, "offse=
t": 0, "speed": 0, "type": "commit"}}
--=20
2.20.1


