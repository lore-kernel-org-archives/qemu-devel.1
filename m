Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E26C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59352082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaxGas0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59352082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaTI-0007Nk-8p
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLp-0003NX-Uf
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLm-0004nj-Mq
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLm-0004m9-Fr
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSXT9TeN+7rkm9Q6hKCJz30xc5WswAgdcGlCz6C8fUM=;
 b=KaxGas0yE6Wm4KGovhgFlpv7rcVikqWkLLJ/RWM9sHMIK8ZnS3BzqtgH23PUJcuVlwOhSt
 puZTo4BmxVgUqlzS1XwpvTYTbHHoHGtusbjYJ1kuZpTw5YXGPKyNaxmHTk94wOKa86nn6k
 xBKX280u05GThJ1+yv4L9d1ZWleQvlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-u4T0iZxpMtCLKRls8FVvpg-1; Fri, 31 Jan 2020 12:44:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E358D107ACC4;
 Fri, 31 Jan 2020 17:44:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 656D47FB60;
 Fri, 31 Jan 2020 17:44:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/17] qcow2: Implement all-zero autoclear bit
Date: Fri, 31 Jan 2020 11:44:34 -0600
Message-Id: <20200131174436.2961874-16-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: u4T0iZxpMtCLKRls8FVvpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire up the autoclear bit just defined in the previous patch. When we
create an image or clear it with .bdrv_make_empty, we know that it
reads as all zeroes.  Reading an image does not change the previous
status, nor does writing zeroes, trimming (because we specifically set
trimmed clusters to read as zero), or resize (because the new length
reads as zero).  This leaves normal writes, data copies, snapshot
reverts, and altering the backing file that can change the status.
Furthermore, it is not safe to claim that an encrypted image or an
image with a backing file reads as all zeroes.

Implementation-wise, we clear the bit from the file on the first
modification, and then rewrite it when marking the image clean; some
callers want to rewrite it (to either set or clear), while others want
to preserve the current value; the modifications to qemu_mark_clean
make it easier to consolidate the logic for when setting the bit is
safe.

A number of iotests have altered output, in situations where we have a
provably zero image at that point in the test.

Later, we may want to wire in further checks to qemu-img check that
validates if the bit is set correctly, and/or to set the bit in images
where it would be valid, but I did not do that here.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-snapshot.c     | 11 +++++
 block/qcow2.c              | 97 ++++++++++++++++++++++++++++++++++----
 block/qcow2.h              |  5 +-
 tests/qemu-iotests/031.out |  6 +--
 tests/qemu-iotests/036.out |  6 +--
 tests/qemu-iotests/061.out | 12 +++--
 tests/qemu-iotests/065     | 12 ++---
 tests/qemu-iotests/082.out |  7 +++
 tests/qemu-iotests/206.out |  4 ++
 tests/qemu-iotests/242.out |  1 +
 10 files changed, 134 insertions(+), 27 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 5ab64da1ec36..e19f1b3ef5fa 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -781,6 +781,16 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const ch=
ar *snapshot_id)
         goto fail;
     }

+    /*
+     * With modification to the qcow2 spec, snapshots could store
+     * whether they are in an all zero state. But for now, we assume
+     * all snapshots are nonzero.
+     */
+    ret =3D qcow2_mark_nonzero(bs);
+    if (ret < 0) {
+        goto fail;
+    }
+
     /*
      * Make sure that the current L1 table is big enough to contain the wh=
ole
      * L1 table of the snapshot. If the snapshot L1 table is smaller, the
@@ -1044,6 +1054,7 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
     s->l1_size =3D sn->l1_size;
     s->l1_table_offset =3D sn->l1_table_offset;
     s->l1_table =3D new_l1_table;
+    s->autoclear_features &=3D ~QCOW2_AUTOCLEAR_ALL_ZERO;

     for(i =3D 0;i < s->l1_size; i++) {
         be64_to_cpus(&s->l1_table[i]);
diff --git a/block/qcow2.c b/block/qcow2.c
index 3f61d806a14b..6b1969e4d90a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -480,6 +480,40 @@ static void report_unsupported_feature(Error **errp, Q=
cow2Feature *table,
     g_free(features);
 }

+/*
+ * Clear the all zero bit and flushes afterwards if necessary.
+ *
+ * If updating the header fails, it is not safe to proceed with
+ * modifying the image.
+ */
+int qcow2_mark_nonzero(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    uint64_t val;
+    int ret;
+
+    if (!(s->autoclear_features & QCOW2_AUTOCLEAR_ALL_ZERO)) {
+        return 0; /* already marked non-zero, including version 2 */
+    }
+
+    assert(s->qcow_version >=3D 3);
+
+    val =3D cpu_to_be64(s->autoclear_features & ~QCOW2_AUTOCLEAR_ALL_ZERO)=
;
+    ret =3D bdrv_pwrite(bs->file, offsetof(QCowHeader, autoclear_features)=
,
+                      &val, sizeof(val));
+    if (ret < 0) {
+        return ret;
+    }
+    ret =3D bdrv_flush(bs->file->bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* Only clear the in-memory flag if the header was updated successfull=
y */
+    s->autoclear_features &=3D ~QCOW2_AUTOCLEAR_ALL_ZERO;
+    return 0;
+}
+
 /*
  * Sets the dirty bit and flushes afterwards if necessary.
  *
@@ -518,16 +552,27 @@ int qcow2_mark_dirty(BlockDriverState *bs)
 /*
  * Clears the dirty bit and flushes before if necessary.  Only call this
  * function when there are no pending requests, it does not guard against
- * concurrent requests dirtying the image.
+ * concurrent requests dirtying the image. If all_zero is 0 or 1, adjust
+ * the value of s->autoclear; if -1, preserve the cached value.
  */
-static int qcow2_mark_clean(BlockDriverState *bs)
+static int qcow2_mark_clean(BlockDriverState *bs, int all_zero)
 {
     BDRVQcow2State *s =3D bs->opaque;

-    if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY) {
+    if (all_zero =3D=3D -1) {
+        all_zero =3D !!(s->autoclear_features & QCOW2_AUTOCLEAR_ALL_ZERO);
+    }
+    if (bs->backing || bs->encrypted || s->qcow_version < 3) {
+        all_zero =3D 0;
+    }
+    if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY ||
+        (all_zero && !(s->autoclear_features & QCOW2_AUTOCLEAR_ALL_ZERO)))=
 {
         int ret;

         s->incompatible_features &=3D ~QCOW2_INCOMPAT_DIRTY;
+        if (all_zero) {
+            s->autoclear_features |=3D QCOW2_AUTOCLEAR_ALL_ZERO;
+        }

         ret =3D qcow2_flush_caches(bs);
         if (ret < 0) {
@@ -616,7 +661,13 @@ static int coroutine_fn qcow2_co_check_locked(BlockDri=
verState *bs,
     }

     if (fix && result->check_errors =3D=3D 0 && result->corruptions =3D=3D=
 0) {
-        ret =3D qcow2_mark_clean(bs);
+        /*
+         * In the case of fixing an image, we've actually spent the
+         * time of traversing every cluster, and could thus turn the
+         * all_zero bit on if the check proves it is correct; but for
+         * now, it is easier to just always drop the all_zero bit.
+         */
+        ret =3D qcow2_mark_clean(bs, 0);
         if (ret < 0) {
             return ret;
         }
@@ -1069,7 +1120,7 @@ static int qcow2_update_options_prepare(BlockDriverSt=
ate *bs,
     }

     if (s->use_lazy_refcounts && !r->use_lazy_refcounts) {
-        ret =3D qcow2_mark_clean(bs);
+        ret =3D qcow2_mark_clean(bs, -1);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to disable lazy refcounts=
");
             goto fail;
@@ -1865,7 +1916,7 @@ static int qcow2_reopen_prepare(BDRVReopenState *stat=
e,
             goto fail;
         }

-        ret =3D qcow2_mark_clean(state->bs);
+        ret =3D qcow2_mark_clean(state->bs, -1);
         if (ret < 0) {
             goto fail;
         }
@@ -2486,6 +2537,11 @@ static coroutine_fn int qcow2_co_pwritev_part(

     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);

+    ret =3D qcow2_mark_nonzero(bs);
+    if (ret < 0) {
+        goto fail_nometa;
+    }
+
     while (bytes !=3D 0 && aio_task_pool_status(aio) =3D=3D 0) {

         l2meta =3D NULL;
@@ -2586,7 +2642,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
     }

     if (result =3D=3D 0) {
-        qcow2_mark_clean(bs);
+        qcow2_mark_clean(bs, -1);
     }

     return result;
@@ -3443,6 +3499,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
         header->autoclear_features |=3D
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
     }
+    if (version >=3D 3 && !qcow2_opts->has_backing_file) {
+        header->autoclear_features |=3D cpu_to_be64(QCOW2_AUTOCLEAR_ALL_ZE=
RO);
+    }

     ret =3D blk_pwrite(blk, 0, header, cluster_size, 0);
     g_free(header);
@@ -3793,6 +3852,11 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDrive=
rState *bs,
     }

     qemu_co_mutex_lock(&s->lock);
+    /*
+     * No need to call qcow2_mark_nonzero: v2 images lack autoclear
+     * bits and so are already nonzero; v3 images pass full_discard=3Dfals=
e
+     * so that discarded clusters still read as zero.
+     */
     ret =3D qcow2_cluster_discard(bs, offset, bytes, QCOW2_DISCARD_REQUEST=
,
                                 false);
     qemu_co_mutex_unlock(&s->lock);
@@ -3902,6 +3966,11 @@ qcow2_co_copy_range_to(BlockDriverState *bs,

     qemu_co_mutex_lock(&s->lock);

+    ret =3D qcow2_mark_nonzero(bs);
+    if (ret < 0) {
+        goto fail;
+    }
+
     while (bytes !=3D 0) {

         l2meta =3D NULL;
@@ -4334,6 +4403,11 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *b=
s,
         return -ENOTSUP;
     }

+    ret =3D qcow2_mark_nonzero(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
     if (bytes =3D=3D 0) {
         /*
          * align end of file to a sector boundary to ease reading with
@@ -4547,7 +4621,7 @@ static int make_completely_empty(BlockDriverState *bs=
)

     /* Now finally the in-memory information corresponds to the on-disk
      * structures and is correct */
-    ret =3D qcow2_mark_clean(bs);
+    ret =3D qcow2_mark_clean(bs, 1);
     if (ret < 0) {
         goto fail;
     }
@@ -4615,6 +4689,9 @@ static int qcow2_make_empty(BlockDriverState *bs)
             break;
         }
     }
+    if (!bs->backing && !bs->encrypted && s->qcow_version >=3D 3) {
+        s->autoclear_features |=3D QCOW2_AUTOCLEAR_ALL_ZERO;
+    }

     return ret;
 }
@@ -5002,7 +5079,7 @@ static int qcow2_downgrade(BlockDriverState *bs, int =
target_version,

     /* clear incompatible features */
     if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY) {
-        ret =3D qcow2_mark_clean(bs);
+        ret =3D qcow2_mark_clean(bs, 0);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to make the image clean")=
;
             return ret;
@@ -5372,7 +5449,7 @@ static int qcow2_amend_options(BlockDriverState *bs, =
QemuOpts *opts,
             s->use_lazy_refcounts =3D true;
         } else {
             /* make image clean first */
-            ret =3D qcow2_mark_clean(bs);
+            ret =3D qcow2_mark_clean(bs, -1);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "Failed to make the image cle=
an");
                 return ret;
diff --git a/block/qcow2.h b/block/qcow2.h
index 6fc2d323d753..7b971ed825ed 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -243,8 +243,8 @@ enum {
     QCOW2_AUTOCLEAR_ALL_ZERO            =3D 1 << QCOW2_AUTOCLEAR_ALL_ZERO_=
BITNR,

     QCOW2_AUTOCLEAR_MASK                =3D QCOW2_AUTOCLEAR_BITMAPS
-                                        | QCOW2_AUTOCLEAR_DATA_FILE_RAW,
-    /* TODO: Add _ALL_ZERO to _MASK once it is handled correctly */
+                                        | QCOW2_AUTOCLEAR_DATA_FILE_RAW
+                                        | QCOW2_AUTOCLEAR_ALL_ZERO,
 };

 enum qcow2_discard_type {
@@ -610,6 +610,7 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, =
size_t cluster_size,

 int qcow2_mark_dirty(BlockDriverState *bs);
 int qcow2_mark_corrupt(BlockDriverState *bs);
+int qcow2_mark_nonzero(BlockDriverState *bs);
 int qcow2_mark_consistent(BlockDriverState *bs);
 int qcow2_update_header(BlockDriverState *bs);

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index bb1afa7b87f6..293f67e96bb6 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -111,7 +111,7 @@ nb_snapshots              0
 snapshot_offset           0x0
 incompatible_features     []
 compatible_features       []
-autoclear_features        []
+autoclear_features        [2]
 refcount_order            4
 header_length             104

@@ -144,7 +144,7 @@ nb_snapshots              0
 snapshot_offset           0x0
 incompatible_features     []
 compatible_features       []
-autoclear_features        []
+autoclear_features        [2]
 refcount_order            4
 header_length             104

@@ -177,7 +177,7 @@ nb_snapshots              0
 snapshot_offset           0x0
 incompatible_features     []
 compatible_features       []
-autoclear_features        []
+autoclear_features        [2]
 refcount_order            4
 header_length             104

diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index e409acf60e2b..5eea8b2bb547 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -5,7 +5,7 @@ QA output created by 036
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 incompatible_features     [63]
 compatible_features       []
-autoclear_features        []
+autoclear_features        [2]
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Unknown incompatible feature: 8000000000000000
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Test feature

@@ -23,7 +23,7 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported=
 IMGFMT feature(s): tes
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 incompatible_features     []
 compatible_features       []
-autoclear_features        [63]
+autoclear_features        [2, 63]
 Header extension:
 magic                     0x6803f857
 length                    336
@@ -35,7 +35,7 @@ data                      <binary>
 No errors were found on the image.
 incompatible_features     []
 compatible_features       []
-autoclear_features        []
+autoclear_features        [2]
 Header extension:
 magic                     0x6803f857
 length                    336
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index d873f79bb606..3d471c2bde14 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -20,7 +20,7 @@ nb_snapshots              0
 snapshot_offset           0x0
 incompatible_features     []
 compatible_features       [0]
-autoclear_features        []
+autoclear_features        [2]
 refcount_order            4
 header_length             104

@@ -78,7 +78,7 @@ nb_snapshots              0
 snapshot_offset           0x0
 incompatible_features     []
 compatible_features       [0]
-autoclear_features        []
+autoclear_features        [2]
 refcount_order            4
 header_length             104

@@ -189,7 +189,7 @@ nb_snapshots              0
 snapshot_offset           0x0
 incompatible_features     []
 compatible_features       [42]
-autoclear_features        [42]
+autoclear_features        [2, 42]
 refcount_order            4
 header_length             104

@@ -491,6 +491,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -511,6 +512,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     data file: foo
@@ -524,6 +526,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     data file raw: false
@@ -538,6 +541,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -550,6 +554,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
@@ -563,6 +568,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 5b21eb96bd09..d47b3d30d0de 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -94,17 +94,17 @@ class TestQCow2(TestQemuImgInfo):
 class TestQCow3NotLazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
     img_options =3D 'compat=3D1.1,lazy_refcounts=3Doff'
-    json_compare =3D { 'compat': '1.1', 'lazy-refcounts': False,
+    json_compare =3D { 'compat': '1.1', 'all-zero': True, 'lazy-refcounts'=
: False,
                      'refcount-bits': 16, 'corrupt': False }
-    human_compare =3D [ 'compat: 1.1', 'lazy refcounts: false',
+    human_compare =3D [ 'compat: 1.1', 'all zero: true', 'lazy refcounts: =
false',
                       'refcount bits: 16', 'corrupt: false' ]

 class TestQCow3Lazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
     img_options =3D 'compat=3D1.1,lazy_refcounts=3Don'
-    json_compare =3D { 'compat': '1.1', 'lazy-refcounts': True,
+    json_compare =3D { 'compat': '1.1', 'all-zero': True, 'lazy-refcounts'=
: True,
                      'refcount-bits': 16, 'corrupt': False }
-    human_compare =3D [ 'compat: 1.1', 'lazy refcounts: true',
+    human_compare =3D [ 'compat: 1.1', 'all zero: true', 'lazy refcounts: =
true',
                       'refcount bits: 16', 'corrupt: false' ]

 class TestQCow3NotLazyQMP(TestQMP):
@@ -112,7 +112,7 @@ class TestQCow3NotLazyQMP(TestQMP):
        with lazy refcounts enabled'''
     img_options =3D 'compat=3D1.1,lazy_refcounts=3Doff'
     qemu_options =3D 'lazy-refcounts=3Don'
-    compare =3D { 'compat': '1.1', 'lazy-refcounts': False,
+    compare =3D { 'compat': '1.1', 'all-zero': True, 'lazy-refcounts': Fal=
se,
                 'refcount-bits': 16, 'corrupt': False }


@@ -121,7 +121,7 @@ class TestQCow3LazyQMP(TestQMP):
        with lazy refcounts disabled'''
     img_options =3D 'compat=3D1.1,lazy_refcounts=3Don'
     qemu_options =3D 'lazy-refcounts=3Doff'
-    compare =3D { 'compat': '1.1', 'lazy-refcounts': True,
+    compare =3D { 'compat': '1.1', 'all-zero': True, 'lazy-refcounts': Tru=
e,
                 'refcount-bits': 16, 'corrupt': False }

 TestImageInfoSpecific =3D None
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9d4ed4dc9d61..6729a43712f2 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -17,6 +17,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -29,6 +30,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -299,6 +301,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -310,6 +313,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -579,6 +583,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
@@ -590,6 +595,7 @@ virtual size: 130 MiB (136314880 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -601,6 +607,7 @@ virtual size: 132 MiB (138412032 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: true
     refcount bits: 16
     corrupt: false
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 61e7241e0bf3..aa27d75d12b1 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -18,6 +18,7 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -40,6 +41,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
@@ -62,6 +64,7 @@ virtual size: 32 MiB (33554432 bytes)
 cluster_size: 2097152
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: true
     refcount bits: 1
     corrupt: false
@@ -102,6 +105,7 @@ encrypted: yes
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     refcount bits: 16
     encrypt:
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index 7ac8404d11c8..807f24549e89 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -153,6 +153,7 @@ virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
+    all zero: true
     lazy refcounts: false
     bitmaps:
         [0]:
--=20
2.24.1


