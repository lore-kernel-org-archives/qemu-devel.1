Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342DEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E3A214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zoe9M4ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E3A214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaXF-0005U6-4Z
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLs-0003Tk-Oj
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLq-0004ve-TG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLq-0004uw-LG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVVLLfNB4yRmFqSpWcv4l5srCFwjCup1lKXgjD1c2ws=;
 b=Zoe9M4ZKOenDy1ki995rWyUF1EyETzQZvTG021+q2G1JbfYUEaBh7H+nzbNlzwNd1V8nOU
 CqMQKn0ir4UezF6IoNddbthaH3+pzPrOEmRqomACEY1dSlkIIRBTKaO0++GwsdYGO0+fFz
 +saLJqc6wS6GY4NY+rAXJm3k7Gm49Hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-1Rngf_udOfuu1wt8eE04bA-1; Fri, 31 Jan 2020 12:45:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D3B61005510;
 Fri, 31 Jan 2020 17:45:00 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB34863AD;
 Fri, 31 Jan 2020 17:45:00 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/17] qcow2: Let qemu-img check cover all-zero bit
Date: Fri, 31 Jan 2020 11:44:36 -0600
Message-Id: <20200131174436.2961874-18-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1Rngf_udOfuu1wt8eE04bA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Since checking an images refcounts already visits every cluster, it's
basically free to also check that the all-zero bit is correctly set.
Only check for the active L1 table, and only output an error on the
first non-zero cluster found.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-refcount.c     | 60 +++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/060.out |  6 ++--
 tests/qemu-iotests/285     | 17 +++++++++++
 tests/qemu-iotests/285.out | 20 +++++++++++++
 4 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f67ac6b2d893..95c8101df365 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1583,6 +1583,7 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, Bd=
rvCheckResult *res,
 /* Flags for check_refcounts_l1() and check_refcounts_l2() */
 enum {
     CHECK_FRAG_INFO =3D 0x2,      /* update BlockFragInfo counters */
+    CHECK_ALL_ZERO =3D 0x4,       /* check autoclear all_zero bit */
 };

 /*
@@ -1596,12 +1597,14 @@ enum {
 static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                               void **refcount_table,
                               int64_t *refcount_table_size, int64_t l2_off=
set,
-                              int flags, BdrvCheckMode fix, bool active)
+                              int flags, BdrvCheckMode fix, bool active,
+                              bool *all_zero)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t *l2_table, l2_entry;
     uint64_t next_contiguous_offset =3D 0;
     int i, l2_size, nb_csectors, ret;
+    bool check_all_zero;

     /* Read L2 table from disk */
     l2_size =3D s->l2_size * sizeof(uint64_t);
@@ -1615,8 +1618,9 @@ static int check_refcounts_l2(BlockDriverState *bs, B=
drvCheckResult *res,
     }

     /* Do the actual checks */
-    for(i =3D 0; i < s->l2_size; i++) {
+    for (i =3D 0; i < s->l2_size; i++) {
         l2_entry =3D be64_to_cpu(l2_table[i]);
+        check_all_zero =3D *all_zero;

         switch (qcow2_get_cluster_type(bs, l2_entry)) {
         case QCOW2_CLUSTER_COMPRESSED:
@@ -1662,6 +1666,8 @@ static int check_refcounts_l2(BlockDriverState *bs, B=
drvCheckResult *res,
             break;

         case QCOW2_CLUSTER_ZERO_ALLOC:
+            check_all_zero =3D false;
+            /* fall through */
         case QCOW2_CLUSTER_NORMAL:
         {
             uint64_t offset =3D l2_entry & L2E_OFFSET_MASK;
@@ -1740,12 +1746,51 @@ static int check_refcounts_l2(BlockDriverState *bs,=
 BdrvCheckResult *res,
         }

         case QCOW2_CLUSTER_ZERO_PLAIN:
+            check_all_zero =3D false;
+            break;
+
         case QCOW2_CLUSTER_UNALLOCATED:
+            if (!bs->backing) {
+                check_all_zero =3D false;
+            }
             break;

         default:
             abort();
         }
+
+        if (check_all_zero) {
+            fprintf(stderr, "%s: all zero bit set but L2 table at offset "
+                    "0x%" PRIx64" contains non-zero cluster at entry %d\n"=
,
+                    fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR",
+                    l2_offset, i);
+            *all_zero =3D false;
+            if (fix & BDRV_FIX_ERRORS) {
+                uint64_t feat;
+
+                ret =3D bdrv_pread(bs->file,
+                                 offsetof(QCowHeader, autoclear_features),
+                                 &feat, sizeof(feat));
+                if (ret >=3D 0) {
+                    feat &=3D ~cpu_to_be64(QCOW2_AUTOCLEAR_ALL_ZERO);
+                    ret =3D bdrv_pwrite(bs->file,
+                                      offsetof(QCowHeader, autoclear_featu=
res),
+                                      &feat, sizeof(feat));
+                }
+                if (ret < 0) {
+                    fprintf(stderr,
+                            "ERROR: Failed to update all zero bit: %s\n",
+                            strerror(-ret));
+                    res->check_errors++;
+                    /* Continue checking the rest of this L2 table */
+                } else {
+                    res->corruptions_fixed++;
+                }
+                s->autoclear_features &=3D ~QCOW2_AUTOCLEAR_ALL_ZERO;
+            } else {
+                res->corruptions++;
+            }
+        }
     }

     g_free(l2_table);
@@ -1774,6 +1819,12 @@ static int check_refcounts_l1(BlockDriverState *bs,
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t *l1_table =3D NULL, l2_offset, l1_size2;
     int i, ret;
+    bool all_zero =3D false;
+
+    if (flags & CHECK_ALL_ZERO &&
+        s->autoclear_features & QCOW2_AUTOCLEAR_ALL_ZERO) {
+        all_zero =3D true;
+    }

     l1_size2 =3D l1_size * sizeof(uint64_t);

@@ -1825,7 +1876,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
             /* Process and check L2 entries */
             ret =3D check_refcounts_l2(bs, res, refcount_table,
                                      refcount_table_size, l2_offset, flags=
,
-                                     fix, active);
+                                     fix, active, &all_zero);
             if (ret < 0) {
                 goto fail;
             }
@@ -2114,7 +2165,8 @@ static int calculate_refcounts(BlockDriverState *bs, =
BdrvCheckResult *res,

     /* current L1 table */
     ret =3D check_refcounts_l1(bs, res, refcount_table, nb_clusters,
-                             s->l1_table_offset, s->l1_size, CHECK_FRAG_IN=
FO,
+                             s->l1_table_offset, s->l1_size,
+                             CHECK_FRAG_INFO | CHECK_ALL_ZERO,
                              fix, true);
     if (ret < 0) {
         return ret;
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index d27692a33c0d..d82aca458544 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -3,9 +3,10 @@ QA output created by 060
 =3D=3D=3D Testing L2 reference into L1 =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+ERROR: all zero bit set but L2 table at offset 0x30000 contains non-zero c=
luster at entry 0
 ERROR cluster 3 refcount=3D1 reference=3D3

-1 errors were found on the image.
+2 errors were found on the image.
 Data may be corrupted, or further writes to the image may corrupt it.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (ove=
rlaps with active L1 table); further corruption events will be suppressed
@@ -28,10 +29,11 @@ read 512/512 bytes at offset 0
 =3D=3D=3D Testing cluster data reference into refcount block =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+ERROR: all zero bit set but L2 table at offset 0x40000 contains non-zero c=
luster at entry 0
 ERROR refcount block 0 refcount=3D2
 ERROR cluster 2 refcount=3D1 reference=3D2

-2 errors were found on the image.
+3 errors were found on the image.
 Data may be corrupted, or further writes to the image may corrupt it.
 incompatible_features     []
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (ove=
rlaps with refcount block); further corruption events will be suppressed
diff --git a/tests/qemu-iotests/285 b/tests/qemu-iotests/285
index 66037af237a1..c435bb57d749 100755
--- a/tests/qemu-iotests/285
+++ b/tests/qemu-iotests/285
@@ -101,6 +101,23 @@ $QEMU_IMG snapshot -l snap "$TEST_IMG"
 $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific \
     | _filter_date | _filter_vmstate_size

+echo
+echo "=3D=3D=3D qemu-img check =3D=3D=3D"
+echo
+
+_make_test_img 32M
+$QEMU_IO -c 'w -P 1 0 1M' "$TEST_IMG" | _filter_qemu_io
+# Image should be clean
+_check_test_img
+# Manually corrupt the image by setting the bit
+$PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 2
+# check should detect the problem
+_check_test_img
+# repair should fix it
+_check_test_img -r all
+# the image should be clean again
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/285.out b/tests/qemu-iotests/285.out
index e43ff9906b5f..b28c9e266bf6 100644
--- a/tests/qemu-iotests/285.out
+++ b/tests/qemu-iotests/285.out
@@ -254,4 +254,24 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
+
+=3D=3D=3D qemu-img check =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+ERROR: all zero bit set but L2 table at offset 0x40000 contains non-zero c=
luster at entry 0
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+Repairing: all zero bit set but L2 table at offset 0x40000 contains non-ze=
ro cluster at entry 0
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    1 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+No errors were found on the image.
 *** done
--=20
2.24.1


