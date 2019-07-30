Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09CC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7683D204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7683D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW0P-000756-QO
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsVsb-00077I-H4
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsVsY-0002lM-Li
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsVsU-0002iM-B6; Tue, 30 Jul 2019 13:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9DCE287633;
 Tue, 30 Jul 2019 17:25:33 +0000 (UTC)
Received: from localhost (ovpn-116-164.ams2.redhat.com [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19AFC19C5B;
 Tue, 30 Jul 2019 17:25:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 19:25:03 +0200
Message-Id: <20190730172508.19911-9-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-1-mreitz@redhat.com>
References: <20190730172508.19911-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 30 Jul 2019 17:25:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 08/13] qcow2: Fix broken snapshot table
 entries
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

The only case where we currently reject snapshot table entries is when
they have too much extra data.  Fix them with qemu-img check -r all by
counting it as a corruption, reducing their extra_data_size, and then
letting qcow2_check_fix_snapshot_table() do the rest.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-snapshot.c | 69 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 58609b6ea4..9956c32964 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -44,7 +44,23 @@ void qcow2_free_snapshots(BlockDriverState *bs)
     s->nb_snapshots =3D 0;
 }
=20
-int qcow2_read_snapshots(BlockDriverState *bs, Error **errp)
+/*
+ * If @repair is true, try to repair a broken snapshot table instead
+ * of just returning an error:
+ *
+ * - If there were snapshots with too much extra metadata, increment
+ *   *extra_data_dropped for each.
+ *   This requires the caller to eventually rewrite the whole snapshot
+ *   table, which requires cluster allocation.  Therefore, this should
+ *   be done only after qcow2_check_refcounts() made sure the refcount
+ *   structures are valid.
+ *   (In the meantime, the image is still valid because
+ *   qcow2_check_refcounts() does not do anything with snapshots'
+ *   extra data.)
+ */
+static int qcow2_do_read_snapshots(BlockDriverState *bs, bool repair,
+                                   int *extra_data_dropped,
+                                   Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     QCowSnapshotHeader h;
@@ -64,6 +80,8 @@ int qcow2_read_snapshots(BlockDriverState *bs, Error **=
errp)
     s->snapshots =3D g_new0(QCowSnapshot, s->nb_snapshots);
=20
     for(i =3D 0; i < s->nb_snapshots; i++) {
+        bool discard_unknown_extra_data =3D false;
+
         /* Read statically sized part of the snapshot header */
         offset =3D ROUND_UP(offset, 8);
         ret =3D bdrv_pread(bs->file, offset, &h, sizeof(h));
@@ -86,10 +104,21 @@ int qcow2_read_snapshots(BlockDriverState *bs, Error=
 **errp)
         name_size =3D be16_to_cpu(h.name_size);
=20
         if (sn->extra_data_size > QCOW_MAX_SNAPSHOT_EXTRA_DATA) {
-            ret =3D -EFBIG;
-            error_setg(errp, "Too much extra metadata in snapshot table =
"
-                       "entry %i", i);
-            goto fail;
+            if (!repair) {
+                ret =3D -EFBIG;
+                error_setg(errp, "Too much extra metadata in snapshot ta=
ble "
+                           "entry %i", i);
+                error_append_hint(errp, "You can force-remove this extra=
 "
+                                  "metadata with qemu-img check -r all\n=
");
+                goto fail;
+            }
+
+            fprintf(stderr, "Discarding too much extra metadata in snaps=
hot "
+                    "table entry %i (%" PRIu32 " > %u)\n",
+                    i, sn->extra_data_size, QCOW_MAX_SNAPSHOT_EXTRA_DATA=
);
+
+            (*extra_data_dropped)++;
+            discard_unknown_extra_data =3D true;
         }
=20
         /* Read known extra data */
@@ -112,16 +141,22 @@ int qcow2_read_snapshots(BlockDriverState *bs, Erro=
r **errp)
         }
=20
         if (sn->extra_data_size > sizeof(extra)) {
-            /* Store unknown extra data */
             size_t unknown_extra_data_size =3D
                 sn->extra_data_size - sizeof(extra);
=20
-            sn->unknown_extra_data =3D g_malloc(unknown_extra_data_size)=
;
-            ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_data,
-                             unknown_extra_data_size);
-            if (ret < 0) {
-                error_setg_errno(errp, -ret, "Failed to read snapshot ta=
ble");
-                goto fail;
+            if (discard_unknown_extra_data) {
+                /* Discard unknown extra data */
+                sn->extra_data_size =3D sizeof(extra);
+            } else {
+                /* Store unknown extra data */
+                sn->unknown_extra_data =3D g_malloc(unknown_extra_data_s=
ize);
+                ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_d=
ata,
+                                 unknown_extra_data_size);
+                if (ret < 0) {
+                    error_setg_errno(errp, -ret,
+                                     "Failed to read snapshot table");
+                    goto fail;
+                }
             }
             offset +=3D unknown_extra_data_size;
         }
@@ -162,6 +197,11 @@ fail:
     return ret;
 }
=20
+int qcow2_read_snapshots(BlockDriverState *bs, Error **errp)
+{
+    return qcow2_do_read_snapshots(bs, false, NULL, errp);
+}
+
 /* add at the end of the file a new list of snapshots */
 int qcow2_write_snapshots(BlockDriverState *bs)
 {
@@ -327,6 +367,7 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
kDriverState *bs,
 {
     BDRVQcow2State *s =3D bs->opaque;
     Error *local_err =3D NULL;
+    int extra_data_dropped =3D 0;
     int ret;
     struct {
         uint32_t nb_snapshots;
@@ -362,7 +403,8 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
kDriverState *bs,
     }
=20
     qemu_co_mutex_unlock(&s->lock);
-    ret =3D qcow2_read_snapshots(bs, &local_err);
+    ret =3D qcow2_do_read_snapshots(bs, fix & BDRV_FIX_ERRORS,
+                                  &extra_data_dropped, &local_err);
     qemu_co_mutex_lock(&s->lock);
     if (ret < 0) {
         result->check_errors++;
@@ -375,6 +417,7 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
kDriverState *bs,
=20
         return ret;
     }
+    result->corruptions +=3D extra_data_dropped;
=20
     return 0;
 }
--=20
2.21.0


