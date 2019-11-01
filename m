Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7778C2086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa0OeZKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7778C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTmp-0000Ax-9r
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQTjW-00071n-RN
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQTjQ-0004vS-LF
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQTjQ-0004j1-HD
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572602433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZbWS4z5zx9Uj24IYu9jd20MrPNOf8ssfnRGYm5Ywpc=;
 b=fa0OeZKRe2Z+qdAE/8PSeLYZc92uvxeW7XCZuOR8VIRSI5PT3JqXpBJZ55jtmc2/h2QB1X
 usqAT1fof+IGeEHhbWerbTld0+TGwA8TS9M9QqpCUYiJjGSAUKDCdRIc0Gxz9H9H/bj2SI
 DZeZWvOcryW1CNSgBM1wAXN9pmxgdMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-lpwiKjK1OtGHt595ylDJEg-1; Fri, 01 Nov 2019 06:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46F021005500;
 Fri,  1 Nov 2019 10:00:31 +0000 (UTC)
Received: from localhost (ovpn-117-28.ams2.redhat.com [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB45E5DA32;
 Fri,  1 Nov 2019 10:00:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2 1/4] Revert "qcow2: skip writing zero buffers to empty
 COW areas"
Date: Fri,  1 Nov 2019 11:00:16 +0100
Message-Id: <20191101100019.9512-2-mreitz@redhat.com>
In-Reply-To: <20191101100019.9512-1-mreitz@redhat.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lpwiKjK1OtGHt595ylDJEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a.

This commit causes fundamental performance problems on XFS (because
fallocate() stalls the AIO pipeline), and as such it is not clear that
we should unconditionally enable this behavior.

We expect subclusters to alleviate the performance penalty of small
writes to newly allocated clusters, so when we get them, the originally
intended performance gain may actually no longer be significant.

If we want to reintroduce something similar to c8bb23cbdbe, it will
require extensive benchmarking on various systems with subclusters
enabled.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json       |  4 +-
 block/qcow2.h              |  6 ---
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 86 --------------------------------------
 block/trace-events         |  1 -
 tests/qemu-iotests/060     |  7 +---
 tests/qemu-iotests/060.out |  5 +--
 7 files changed, 4 insertions(+), 107 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index aa97ee2641..f053f15431 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3304,8 +3304,6 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
-# @cluster_alloc_space: an allocation of file space for a cluster (since 4=
.1)
-#
 # @none: triggers once at creation of the blkdebug node (since 4.1)
 #
 # Since: 2.9
@@ -3326,7 +3324,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write', 'cluster_alloc_space', 'none'] }
+            'cor_write', 'none'] }
=20
 ##
 # @BlkdebugIOType:
diff --git a/block/qcow2.h b/block/qcow2.h
index 601c2e4c82..8166f6e311 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -418,12 +418,6 @@ typedef struct QCowL2Meta
      */
     Qcow2COWRegion cow_end;
=20
-    /*
-     * Indicates that COW regions are already handled and do not require
-     * any more processing.
-     */
-    bool skip_cow;
-
     /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8982b7b762..fbfea8c817 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -809,7 +809,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta=
 *m)
     assert(start->nb_bytes + end->nb_bytes <=3D UINT_MAX - data_bytes);
     assert(start->offset + start->nb_bytes <=3D end->offset);
=20
-    if ((start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) || m->skip_co=
w) {
+    if (start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) {
         return 0;
     }
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 7c18721741..17555cb0a1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2274,11 +2274,6 @@ static bool merge_cow(uint64_t offset, unsigned byte=
s,
             continue;
         }
=20
-        /* If COW regions are handled already, skip this too */
-        if (m->skip_cow) {
-            continue;
-        }
-
         /* The data (middle) region must be immediately after the
          * start region */
         if (l2meta_cow_start(m) + m->cow_start.nb_bytes !=3D offset) {
@@ -2305,81 +2300,6 @@ static bool merge_cow(uint64_t offset, unsigned byte=
s,
     return false;
 }
=20
-static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t b=
ytes)
-{
-    int64_t nr;
-    return !bytes ||
-        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &&
-         nr =3D=3D bytes);
-}
-
-static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
-{
-    /*
-     * This check is designed for optimization shortcut so it must be
-     * efficient.
-     * Instead of is_zero(), use is_unallocated() as it is faster (but not
-     * as accurate and can result in false negatives).
-     */
-    return is_unallocated(bs, m->offset + m->cow_start.offset,
-                          m->cow_start.nb_bytes) &&
-           is_unallocated(bs, m->offset + m->cow_end.offset,
-                          m->cow_end.nb_bytes);
-}
-
-static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
-{
-    BDRVQcow2State *s =3D bs->opaque;
-    QCowL2Meta *m;
-
-    if (!(s->data_file->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK)) =
{
-        return 0;
-    }
-
-    if (bs->encrypted) {
-        return 0;
-    }
-
-    for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
-        int ret;
-
-        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
-            continue;
-        }
-
-        if (!is_zero_cow(bs, m)) {
-            continue;
-        }
-
-        /*
-         * instead of writing zero COW buffers,
-         * efficiently zero out the whole clusters
-         */
-
-        ret =3D qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
-                                            m->nb_clusters * s->cluster_si=
ze,
-                                            true);
-        if (ret < 0) {
-            return ret;
-        }
-
-        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
-        ret =3D bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
-                                    m->nb_clusters * s->cluster_size,
-                                    BDRV_REQ_NO_FALLBACK);
-        if (ret < 0) {
-            if (ret !=3D -ENOTSUP && ret !=3D -EAGAIN) {
-                return ret;
-            }
-            continue;
-        }
-
-        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clust=
ers);
-        m->skip_cow =3D true;
-    }
-    return 0;
-}
-
 /*
  * qcow2_co_pwritev_task
  * Called with s->lock unlocked
@@ -2421,12 +2341,6 @@ static coroutine_fn int qcow2_co_pwritev_task(BlockD=
riverState *bs,
         qiov_offset =3D 0;
     }
=20
-    /* Try to efficiently initialize the physical space with zeroes */
-    ret =3D handle_alloc_space(bs, l2meta);
-    if (ret < 0) {
-        goto out_unlocked;
-    }
-
     /*
      * If we need to do COW, check if it's possible to merge the
      * writing of the guest data together with that of the COW regions.
diff --git a/block/trace-events b/block/trace-events
index 6ba86decca..c615b26d71 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -72,7 +72,6 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p cu=
r_bytes %d"
 qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p =
offset 0x%" PRIx64 " count %d"
 qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset 0x%=
" PRIx64 " count %d"
-qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset 0=
x%" PRIx64 " nb_clusters %d"
=20
 # qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p o=
ffset 0x%" PRIx64 " bytes %d"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index b91d8321bb..89e911400c 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -150,15 +150,10 @@ $QEMU_IO -c "$OPEN_RO" -c "read -P 1 0 512" | _filter=
_qemu_io
 echo
 echo "=3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D"
 echo
-BACKING_IMG=3D$TEST_IMG.base
-TEST_IMG=3D$BACKING_IMG _make_test_img 1G
-
-$QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
-
 # compat=3D0.10 is required in order to make the following discard actuall=
y
 # unallocate the sector rather than make it a zero sector - we want COW, a=
fter
 # all.
-IMGOPTS=3D'compat=3D0.10' _make_test_img -b "$BACKING_IMG" 1G
+IMGOPTS=3D'compat=3D0.10' _make_test_img 1G
 # Write two clusters, the second one enforces creation of an L2 table afte=
r
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_=
io
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 0f6b0658a1..e42bf8c5a9 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -97,10 +97,7 @@ read 512/512 bytes at offset 0
=20
 =3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1073741824
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
--=20
2.21.0


