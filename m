Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B35C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11857206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11857206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwz9-0002sX-0e
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqW-0001cs-Aq
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqU-0006bn-R4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwqR-0006ZC-Iy; Fri, 11 Oct 2019 11:28:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 538BB7E423;
 Fri, 11 Oct 2019 15:28:41 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B41A14535;
 Fri, 11 Oct 2019 15:28:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/16] qcow2: Separate qcow2_check_read_snapshot_table()
Date: Fri, 11 Oct 2019 17:28:06 +0200
Message-Id: <20191011152814.14791-9-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 11 Oct 2019 15:28:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reading the snapshot table can fail.  That is a problem when we want to
repair the image.

Therefore, stop reading the snapshot table in qcow2_do_open() in check
mode.  Instead, add a new function qcow2_check_read_snapshot_table()
that reads the snapshot table at a later point.  In the future, we want
to handle errors here and fix them.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h          |  4 +++
 block/qcow2-snapshot.c | 58 ++++++++++++++++++++++++++++++++
 block/qcow2.c          | 76 ++++++++++++++++++++++++++++++++----------
 3 files changed, 120 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 02d629a3d8..6c2a38c98d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -716,6 +716,10 @@ void qcow2_free_snapshots(BlockDriverState *bs);
 int qcow2_read_snapshots(BlockDriverState *bs, Error **errp);
 int qcow2_write_snapshots(BlockDriverState *bs);
=20
+int coroutine_fn qcow2_check_read_snapshot_table(BlockDriverState *bs,
+                                                 BdrvCheckResult *result=
,
+                                                 BdrvCheckMode fix);
+
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
                                unsigned table_size);
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index e3bf4c9776..d667bfd935 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -322,6 +322,64 @@ fail:
     return ret;
 }
=20
+int coroutine_fn qcow2_check_read_snapshot_table(BlockDriverState *bs,
+                                                 BdrvCheckResult *result=
,
+                                                 BdrvCheckMode fix)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    Error *local_err =3D NULL;
+    int ret;
+    struct {
+        uint32_t nb_snapshots;
+        uint64_t snapshots_offset;
+    } QEMU_PACKED snapshot_table_pointer;
+
+    /* qcow2_do_open() discards this information in check mode */
+    ret =3D bdrv_pread(bs->file, offsetof(QCowHeader, nb_snapshots),
+                     &snapshot_table_pointer, sizeof(snapshot_table_poin=
ter));
+    if (ret < 0) {
+        result->check_errors++;
+        fprintf(stderr, "ERROR failed to read the snapshot table pointer=
 from "
+                "the image header: %s\n", strerror(-ret));
+        return ret;
+    }
+
+    s->snapshots_offset =3D be64_to_cpu(snapshot_table_pointer.snapshots=
_offset);
+    s->nb_snapshots =3D be32_to_cpu(snapshot_table_pointer.nb_snapshots)=
;
+
+    ret =3D qcow2_validate_table(bs, s->snapshots_offset, s->nb_snapshot=
s,
+                               sizeof(QCowSnapshotHeader),
+                               sizeof(QCowSnapshotHeader) * QCOW_MAX_SNA=
PSHOTS,
+                               "snapshot table", &local_err);
+    if (ret < 0) {
+        result->check_errors++;
+        error_reportf_err(local_err, "ERROR ");
+
+        /* We did not read the snapshot table, so invalidate this inform=
ation */
+        s->snapshots_offset =3D 0;
+        s->nb_snapshots =3D 0;
+
+        return ret;
+    }
+
+    qemu_co_mutex_unlock(&s->lock);
+    ret =3D qcow2_read_snapshots(bs, &local_err);
+    qemu_co_mutex_lock(&s->lock);
+    if (ret < 0) {
+        result->check_errors++;
+        error_reportf_err(local_err,
+                          "ERROR failed to read the snapshot table: ");
+
+        /* We did not read the snapshot table, so invalidate this inform=
ation */
+        s->snapshots_offset =3D 0;
+        s->nb_snapshots =3D 0;
+
+        return ret;
+    }
+
+    return 0;
+}
+
 static void find_new_snapshot_id(BlockDriverState *bs,
                                  char *id_str, int id_str_size)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index a2e46ce589..7f47444ab7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -570,11 +570,40 @@ int qcow2_mark_consistent(BlockDriverState *bs)
     return 0;
 }
=20
+static void qcow2_add_check_result(BdrvCheckResult *out,
+                                   const BdrvCheckResult *src,
+                                   bool set_allocation_info)
+{
+    out->corruptions +=3D src->corruptions;
+    out->leaks +=3D src->leaks;
+    out->check_errors +=3D src->check_errors;
+    out->corruptions_fixed +=3D src->corruptions_fixed;
+    out->leaks_fixed +=3D src->leaks_fixed;
+
+    if (set_allocation_info) {
+        out->image_end_offset =3D src->image_end_offset;
+        out->bfi =3D src->bfi;
+    }
+}
+
 static int coroutine_fn qcow2_co_check_locked(BlockDriverState *bs,
                                               BdrvCheckResult *result,
                                               BdrvCheckMode fix)
 {
-    int ret =3D qcow2_check_refcounts(bs, result, fix);
+    BdrvCheckResult snapshot_res =3D {};
+    BdrvCheckResult refcount_res =3D {};
+    int ret;
+
+    memset(result, 0, sizeof(*result));
+
+    ret =3D qcow2_check_read_snapshot_table(bs, &snapshot_res, fix);
+    qcow2_add_check_result(result, &snapshot_res, false);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D qcow2_check_refcounts(bs, &refcount_res, fix);
+    qcow2_add_check_result(result, &refcount_res, true);
     if (ret < 0) {
         return ret;
     }
@@ -1410,17 +1439,22 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
         goto fail;
     }
=20
-    /* The total size in bytes of the snapshot table is checked in
-     * qcow2_read_snapshots() because the size of each snapshot is
-     * variable and we don't know it yet.
-     * Here we only check the offset and number of snapshots. */
-    ret =3D qcow2_validate_table(bs, header.snapshots_offset,
-                               header.nb_snapshots,
-                               sizeof(QCowSnapshotHeader),
-                               sizeof(QCowSnapshotHeader) * QCOW_MAX_SNA=
PSHOTS,
-                               "Snapshot table", errp);
-    if (ret < 0) {
-        goto fail;
+    if (!(flags & BDRV_O_CHECK)) {
+        /*
+         * The total size in bytes of the snapshot table is checked in
+         * qcow2_read_snapshots() because the size of each snapshot is
+         * variable and we don't know it yet.
+         * Here we only check the offset and number of snapshots.
+         */
+        ret =3D qcow2_validate_table(bs, header.snapshots_offset,
+                                   header.nb_snapshots,
+                                   sizeof(QCowSnapshotHeader),
+                                   sizeof(QCowSnapshotHeader) *
+                                       QCOW_MAX_SNAPSHOTS,
+                                   "Snapshot table", errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
=20
     /* read the level 1 table */
@@ -1580,13 +1614,19 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
         s->image_backing_file =3D g_strdup(bs->auto_backing_file);
     }
=20
-    /* Internal snapshots */
-    s->snapshots_offset =3D header.snapshots_offset;
-    s->nb_snapshots =3D header.nb_snapshots;
+    /*
+     * Internal snapshots; skip reading them in check mode, because
+     * we do not need them then, and we do not want to abort because
+     * of a broken table.
+     */
+    if (!(flags & BDRV_O_CHECK)) {
+        s->snapshots_offset =3D header.snapshots_offset;
+        s->nb_snapshots =3D header.nb_snapshots;
=20
-    ret =3D qcow2_read_snapshots(bs, errp);
-    if (ret < 0) {
-        goto fail;
+        ret =3D qcow2_read_snapshots(bs, errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
=20
     /* Clear unknown autoclear feature bits */
--=20
2.21.0


