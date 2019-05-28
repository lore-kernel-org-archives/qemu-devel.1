Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE87C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49EC208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49EC208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41723 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVi20-0004xV-Pg
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:45:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhpP-0002dh-Dg
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhpN-0002ti-8L
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:32:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhpE-0001IZ-OW; Tue, 28 May 2019 15:31:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45A853082E44;
	Tue, 28 May 2019 19:29:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B0925D9CC;
	Tue, 28 May 2019 19:29:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:45 +0200
Message-Id: <20190528192847.2730-20-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 28 May 2019 19:29:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/21] qcow2: skip writing zero buffers to empty
 COW areas
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

If COW areas of the newly allocated clusters are zeroes on the backing
image, efficient bdrv_write_zeroes(flags=3DBDRV_REQ_NO_FALLBACK) can be
used on the whole cluster instead of writing explicit zero buffers later
in perform_cow().

iotest 060:
write to the discarded cluster does not trigger COW anymore.
Use a backing image instead.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-id: 20190516142749.81019-2-anton.nefedov@virtuozzo.com
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json       |  4 +-
 block/qcow2.h              |  6 +++
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 85 ++++++++++++++++++++++++++++++++++++++
 block/trace-events         |  1 +
 tests/qemu-iotests/060     |  7 +++-
 tests/qemu-iotests/060.out |  5 ++-
 7 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..3e4042be7f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3215,6 +3215,8 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
+# @cluster_alloc_space: an allocation of file space for a cluster (since=
 4.1)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -3233,7 +3235,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'cor_write', 'cluster_alloc_space'] }
=20
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/qcow2.h b/block/qcow2.h
index e873ae5d12..567375e56c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -405,6 +405,12 @@ typedef struct QCowL2Meta
      */
     Qcow2COWRegion cow_end;
=20
+    /*
+     * Indicates that COW regions are already handled and do not require
+     * any more processing.
+     */
+    bool skip_cow;
+
     /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 4a929900cf..cf892f37a8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -831,7 +831,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Me=
ta *m)
     assert(start->offset + start->nb_bytes <=3D end->offset);
     assert(!m->data_qiov || m->data_qiov->size =3D=3D data_bytes);
=20
-    if (start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) {
+    if ((start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) || m->skip_=
cow) {
         return 0;
     }
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index dea765b2f4..f2cb131048 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2103,6 +2103,11 @@ static bool merge_cow(uint64_t offset, unsigned by=
tes,
             continue;
         }
=20
+        /* If COW regions are handled already, skip this too */
+        if (m->skip_cow) {
+            continue;
+        }
+
         /* The data (middle) region must be immediately after the
          * start region */
         if (l2meta_cow_start(m) + m->cow_start.nb_bytes !=3D offset) {
@@ -2128,6 +2133,80 @@ static bool merge_cow(uint64_t offset, unsigned by=
tes,
     return false;
 }
=20
+static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t=
 bytes)
+{
+    int64_t nr;
+    return !bytes ||
+        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr =3D=
=3D bytes);
+}
+
+static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+{
+    /*
+     * This check is designed for optimization shortcut so it must be
+     * efficient.
+     * Instead of is_zero(), use is_unallocated() as it is faster (but n=
ot
+     * as accurate and can result in false negatives).
+     */
+    return is_unallocated(bs, m->offset + m->cow_start.offset,
+                          m->cow_start.nb_bytes) &&
+           is_unallocated(bs, m->offset + m->cow_end.offset,
+                          m->cow_end.nb_bytes);
+}
+
+static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    QCowL2Meta *m;
+
+    if (!(s->data_file->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK)=
) {
+        return 0;
+    }
+
+    if (bs->encrypted) {
+        return 0;
+    }
+
+    for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
+        int ret;
+
+        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
+            continue;
+        }
+
+        if (!is_zero_cow(bs, m)) {
+            continue;
+        }
+
+        /*
+         * instead of writing zero COW buffers,
+         * efficiently zero out the whole clusters
+         */
+
+        ret =3D qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
+                                            m->nb_clusters * s->cluster_=
size,
+                                            true);
+        if (ret < 0) {
+            return ret;
+        }
+
+        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
+        ret =3D bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
+                                    m->nb_clusters * s->cluster_size,
+                                    BDRV_REQ_NO_FALLBACK);
+        if (ret < 0) {
+            if (ret !=3D -ENOTSUP && ret !=3D -EAGAIN) {
+                return ret;
+            }
+            continue;
+        }
+
+        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clu=
sters);
+        m->skip_cow =3D true;
+    }
+    return 0;
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t =
offset,
                                          uint64_t bytes, QEMUIOVector *q=
iov,
                                          int flags)
@@ -2207,6 +2286,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriv=
erState *bs, uint64_t offset,
             qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
         }
=20
+        /* Try to efficiently initialize the physical space with zeroes =
*/
+        ret =3D handle_alloc_space(bs, l2meta);
+        if (ret < 0) {
+            goto out_unlocked;
+        }
+
         /* If we need to do COW, check if it's possible to merge the
          * writing of the guest data together with that of the COW regio=
ns.
          * If it's not possible (or not necessary) then write the
diff --git a/block/trace-events b/block/trace-events
index 79ccd8d824..1e0653ce6d 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -68,6 +68,7 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p =
cur_bytes %d"
 qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %=
p offset 0x%" PRIx64 " count %d"
 qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset 0=
x%" PRIx64 " count %d"
+qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset=
 0x%" PRIx64 " nb_clusters %d"
=20
 # qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p=
 offset 0x%" PRIx64 " bytes %d"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 89e911400c..b91d8321bb 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -150,10 +150,15 @@ $QEMU_IO -c "$OPEN_RO" -c "read -P 1 0 512" | _filt=
er_qemu_io
 echo
 echo "=3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D"
 echo
+BACKING_IMG=3D$TEST_IMG.base
+TEST_IMG=3D$BACKING_IMG _make_test_img 1G
+
+$QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
+
 # compat=3D0.10 is required in order to make the following discard actua=
lly
 # unallocate the sector rather than make it a zero sector - we want COW,=
 after
 # all.
-IMGOPTS=3D'compat=3D0.10' _make_test_img 1G
+IMGOPTS=3D'compat=3D0.10' _make_test_img -b "$BACKING_IMG" 1G
 # Write two clusters, the second one enforces creation of an L2 table af=
ter
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qem=
u_io
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index e42bf8c5a9..0f6b0658a1 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -97,7 +97,10 @@ read 512/512 bytes at offset 0
=20
 =3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1073741824
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
--=20
2.21.0


