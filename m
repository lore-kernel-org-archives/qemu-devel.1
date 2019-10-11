Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF905C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5521206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5521206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwwm-0007Xl-4b
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqf-0001tp-A8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqd-0006gT-LR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwqa-0006eK-FP; Fri, 11 Oct 2019 11:28:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B13BE3097032;
 Fri, 11 Oct 2019 15:28:51 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23B0F600CC;
 Fri, 11 Oct 2019 15:28:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 12/16] qcow2: Fix overly long snapshot tables
Date: Fri, 11 Oct 2019 17:28:10 +0200
Message-Id: <20191011152814.14791-13-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 15:28:51 +0000 (UTC)
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

We currently refuse to open qcow2 images with overly long snapshot
tables.  This patch makes qemu-img check -r all drop all offending
entries past what we deem acceptable.

The user cannot choose which snapshots are removed.  This is fine
because we have chosen the maximum snapshot table size to be so large
(64 MB) that it cannot be reasonably reached.  If the snapshot table
exceeds this size, the image has probably been corrupted in some way; in
this case, it is most important to just make the image usable such that
the user can copy off at least the active layer.
(Also note that the snapshots will be removed only with "-r all", so a
plain "check" or "check -r leaks" will not delete any data.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-snapshot.c | 88 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 582eb3386a..366d9f574c 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -29,15 +29,24 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
=20
+static void qcow2_free_single_snapshot(BlockDriverState *bs, int i)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+
+    assert(i >=3D 0 && i < s->nb_snapshots);
+    g_free(s->snapshots[i].name);
+    g_free(s->snapshots[i].id_str);
+    g_free(s->snapshots[i].unknown_extra_data);
+    memset(&s->snapshots[i], 0, sizeof(s->snapshots[i]));
+}
+
 void qcow2_free_snapshots(BlockDriverState *bs)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int i;
=20
     for(i =3D 0; i < s->nb_snapshots; i++) {
-        g_free(s->snapshots[i].name);
-        g_free(s->snapshots[i].id_str);
-        g_free(s->snapshots[i].unknown_extra_data);
+        qcow2_free_single_snapshot(bs, i);
     }
     g_free(s->snapshots);
     s->snapshots =3D NULL;
@@ -48,6 +57,14 @@ void qcow2_free_snapshots(BlockDriverState *bs)
  * If @repair is true, try to repair a broken snapshot table instead
  * of just returning an error:
  *
+ * - If the snapshot table was too long, set *nb_clusters_reduced to
+ *   the number of snapshots removed off the end.
+ *   The caller will update the on-disk nb_snapshots accordingly;
+ *   this leaks clusters, but is safe.
+ *   (The on-disk information must be updated before
+ *   qcow2_check_refcounts(), because that function relies on
+ *   s->nb_snapshots to reflect the on-disk value.)
+ *
  * - If there were snapshots with too much extra metadata, increment
  *   *extra_data_dropped for each.
  *   This requires the caller to eventually rewrite the whole snapshot
@@ -59,6 +76,7 @@ void qcow2_free_snapshots(BlockDriverState *bs)
  *   extra data.)
  */
 static int qcow2_do_read_snapshots(BlockDriverState *bs, bool repair,
+                                   int *nb_clusters_reduced,
                                    int *extra_data_dropped,
                                    Error **errp)
 {
@@ -67,7 +85,7 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs=
, bool repair,
     QCowSnapshotExtraData extra;
     QCowSnapshot *sn;
     int i, id_str_size, name_size;
-    int64_t offset;
+    int64_t offset, pre_sn_offset;
     uint64_t table_length =3D 0;
     int ret;
=20
@@ -83,6 +101,7 @@ static int qcow2_do_read_snapshots(BlockDriverState *b=
s, bool repair,
     for(i =3D 0; i < s->nb_snapshots; i++) {
         bool truncate_unknown_extra_data =3D false;
=20
+        pre_sn_offset =3D offset;
         table_length =3D ROUND_UP(table_length, 8);
=20
         /* Read statically sized part of the snapshot header */
@@ -197,9 +216,31 @@ static int qcow2_do_read_snapshots(BlockDriverState =
*bs, bool repair,
         if (table_length > QCOW_MAX_SNAPSHOTS_SIZE ||
             offset - s->snapshots_offset > INT_MAX)
         {
-            ret =3D -EFBIG;
-            error_setg(errp, "Snapshot table is too big");
-            goto fail;
+            if (!repair) {
+                ret =3D -EFBIG;
+                error_setg(errp, "Snapshot table is too big");
+                error_append_hint(errp, "You can force-remove all %u "
+                                  "overhanging snapshots with qemu-img c=
heck "
+                                  "-r all\n", s->nb_snapshots - i);
+                goto fail;
+            }
+
+            fprintf(stderr, "Discarding %u overhanging snapshots (snapsh=
ot "
+                    "table is too big)\n", s->nb_snapshots - i);
+
+            *nb_clusters_reduced +=3D (s->nb_snapshots - i);
+
+            /* Discard current snapshot also */
+            qcow2_free_single_snapshot(bs, i);
+
+            /*
+             * This leaks all the rest of the snapshot table and the
+             * snapshots' clusters, but we run in check -r all mode,
+             * so qcow2_check_refcounts() will take care of it.
+             */
+            s->nb_snapshots =3D i;
+            offset =3D pre_sn_offset;
+            break;
         }
     }
=20
@@ -214,7 +255,7 @@ fail:
=20
 int qcow2_read_snapshots(BlockDriverState *bs, Error **errp)
 {
-    return qcow2_do_read_snapshots(bs, false, NULL, errp);
+    return qcow2_do_read_snapshots(bs, false, NULL, NULL, errp);
 }
=20
 /* add at the end of the file a new list of snapshots */
@@ -382,6 +423,7 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
kDriverState *bs,
 {
     BDRVQcow2State *s =3D bs->opaque;
     Error *local_err =3D NULL;
+    int nb_clusters_reduced =3D 0;
     int extra_data_dropped =3D 0;
     int ret;
     struct {
@@ -419,7 +461,8 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
kDriverState *bs,
=20
     qemu_co_mutex_unlock(&s->lock);
     ret =3D qcow2_do_read_snapshots(bs, fix & BDRV_FIX_ERRORS,
-                                  &extra_data_dropped, &local_err);
+                                  &nb_clusters_reduced, &extra_data_drop=
ped,
+                                  &local_err);
     qemu_co_mutex_lock(&s->lock);
     if (ret < 0) {
         result->check_errors++;
@@ -432,7 +475,32 @@ int coroutine_fn qcow2_check_read_snapshot_table(Blo=
ckDriverState *bs,
=20
         return ret;
     }
-    result->corruptions +=3D extra_data_dropped;
+    result->corruptions +=3D nb_clusters_reduced + extra_data_dropped;
+
+    if (nb_clusters_reduced) {
+        /*
+         * Update image header now, because:
+         * (1) qcow2_check_refcounts() relies on s->nb_snapshots to be
+         *     the same as what the image header says,
+         * (2) this leaks clusters, but qcow2_check_refcounts() will
+         *     fix that.
+         */
+        assert(fix & BDRV_FIX_ERRORS);
+
+        snapshot_table_pointer.nb_snapshots =3D cpu_to_be32(s->nb_snapsh=
ots);
+        ret =3D bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, nb_snaps=
hots),
+                               &snapshot_table_pointer.nb_snapshots,
+                               sizeof(snapshot_table_pointer.nb_snapshot=
s));
+        if (ret < 0) {
+            result->check_errors++;
+            fprintf(stderr, "ERROR failed to update the snapshot count i=
n the "
+                    "image header: %s\n", strerror(-ret));
+            return ret;
+        }
+
+        result->corruptions_fixed +=3D nb_clusters_reduced;
+        result->corruptions -=3D nb_clusters_reduced;
+    }
=20
     return 0;
 }
--=20
2.21.0


