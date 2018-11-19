Received: from eggs.gnu.org ([2001:4830:134:3::10]:46933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZE-0001Tg-5O
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZB-0007AH-2X
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:40 +0100
Message-Id: <20181119142944.29061-6-kwolf@redhat.com>
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] qcow2: Don't allow overflow during cluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Our code was already checking that we did not attempt to
allocate more clusters than what would fit in an INT64 (the
physical maximimum if we can access a full off_t's worth of
data).  But this does not catch smaller limits enforced by
various spots in the qcow2 image description: L1 and normal
clusters of L2 are documented as having bits 63-56 reserved
for other purposes, capping our maximum offset at 64PB (bit
55 is the maximum bit set).  And for compressed images with
2M clusters, the cap drops the maximum offset to bit 48, or
a maximum offset of 512TB.  If we overflow that offset, we
would write compressed data into one place, but try to
decompress from another, which won't work.

It's actually possible to prove that overflow can cause image
corruption without this patch; I'll add the iotests separately
in the next commit.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h          |  6 ++++++
 block/qcow2-refcount.c | 20 +++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 29c98d87a0..8662b68575 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -42,6 +42,12 @@
 #define QCOW_MAX_CRYPT_CLUSTERS 32
 #define QCOW_MAX_SNAPSHOTS 65536
=20
+/* Field widths in qcow2 mean normal cluster offsets cannot reach
+ * 64PB; depending on cluster size, compressed clusters can have a
+ * smaller limit (64PB for up to 16k clusters, then ramps down to
+ * 512TB for 2M clusters).  */
+#define QCOW_MAX_CLUSTER_OFFSET ((1ULL << 56) - 1)
+
 /* 8 MB refcount table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
 #define QCOW_MAX_REFTABLE_SIZE S_8MiB
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 46082aeac1..1c63ac244a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -31,7 +31,8 @@
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"
=20
-static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size)=
;
+static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
+                                    uint64_t max);
 static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
                             int64_t offset, int64_t length, uint64_t add=
end,
                             bool decrease, enum qcow2_discard_type type)=
;
@@ -362,7 +363,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
     }
=20
     /* Allocate the refcount block itself and mark it as used */
-    int64_t new_block =3D alloc_clusters_noref(bs, s->cluster_size);
+    int64_t new_block =3D alloc_clusters_noref(bs, s->cluster_size, INT6=
4_MAX);
     if (new_block < 0) {
         return new_block;
     }
@@ -954,7 +955,8 @@ int qcow2_update_cluster_refcount(BlockDriverState *b=
s,
=20
=20
 /* return < 0 if error */
-static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size)
+static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
+                                    uint64_t max)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t i, nb_clusters, refcount;
@@ -979,9 +981,9 @@ retry:
     }
=20
     /* Make sure that all offsets in the "allocated" range are represent=
able
-     * in an int64_t */
+     * in the requested max */
     if (s->free_cluster_index > 0 &&
-        s->free_cluster_index - 1 > (INT64_MAX >> s->cluster_bits))
+        s->free_cluster_index - 1 > (max >> s->cluster_bits))
     {
         return -EFBIG;
     }
@@ -1001,7 +1003,7 @@ int64_t qcow2_alloc_clusters(BlockDriverState *bs, =
uint64_t size)
=20
     BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
     do {
-        offset =3D alloc_clusters_noref(bs, size);
+        offset =3D alloc_clusters_noref(bs, size, QCOW_MAX_CLUSTER_OFFSE=
T);
         if (offset < 0) {
             return offset;
         }
@@ -1083,7 +1085,11 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, in=
t size)
     free_in_cluster =3D s->cluster_size - offset_into_cluster(s, offset)=
;
     do {
         if (!offset || free_in_cluster < size) {
-            int64_t new_cluster =3D alloc_clusters_noref(bs, s->cluster_=
size);
+            int64_t new_cluster;
+
+            new_cluster =3D alloc_clusters_noref(bs, s->cluster_size,
+                                               MIN(s->cluster_offset_mas=
k,
+                                                   QCOW_MAX_CLUSTER_OFFS=
ET));
             if (new_cluster < 0) {
                 return new_cluster;
             }
--=20
2.19.1
