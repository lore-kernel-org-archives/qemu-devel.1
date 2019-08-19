Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F45FC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747432087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747432087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzn1W-0000wv-FU
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzmpf-0002Hg-7b
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzmpd-0002B0-Po
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzmpa-00028V-8m; Mon, 19 Aug 2019 14:56:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9635630860C6;
 Mon, 19 Aug 2019 18:56:37 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B5FC88B1A;
 Mon, 19 Aug 2019 18:56:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 20:55:56 +0200
Message-Id: <20190819185602.4267-11-mreitz@redhat.com>
In-Reply-To: <20190819185602.4267-1-mreitz@redhat.com>
References: <20190819185602.4267-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 19 Aug 2019 18:56:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/16] qcow2: Fix broken snapshot table
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
 block/qcow2-snapshot.c | 67 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index b526a8f819..53dc1635ec 100644
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
+        bool truncate_unknown_extra_data =3D false;
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
+            truncate_unknown_extra_data =3D true;
         }
=20
         /* Read known extra data */
@@ -113,18 +142,26 @@ int qcow2_read_snapshots(BlockDriverState *bs, Erro=
r **errp)
         }
=20
         if (sn->extra_data_size > sizeof(extra)) {
-            /* Store unknown extra data */
-            size_t unknown_extra_data_size =3D
-                sn->extra_data_size - sizeof(extra);
+            uint64_t extra_data_end;
+            size_t unknown_extra_data_size;
+
+            extra_data_end =3D offset + sn->extra_data_size - sizeof(ext=
ra);
=20
+            if (truncate_unknown_extra_data) {
+                sn->extra_data_size =3D QCOW_MAX_SNAPSHOT_EXTRA_DATA;
+            }
+
+            /* Store unknown extra data */
+            unknown_extra_data_size =3D sn->extra_data_size - sizeof(ext=
ra);
             sn->unknown_extra_data =3D g_malloc(unknown_extra_data_size)=
;
             ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_data,
                              unknown_extra_data_size);
             if (ret < 0) {
-                error_setg_errno(errp, -ret, "Failed to read snapshot ta=
ble");
+                error_setg_errno(errp, -ret,
+                                 "Failed to read snapshot table");
                 goto fail;
             }
-            offset +=3D unknown_extra_data_size;
+            offset =3D extra_data_end;
         }
=20
         /* Read snapshot ID */
@@ -163,6 +200,11 @@ fail:
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
@@ -328,6 +370,7 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
kDriverState *bs,
 {
     BDRVQcow2State *s =3D bs->opaque;
     Error *local_err =3D NULL;
+    int extra_data_dropped =3D 0;
     int ret;
     struct {
         uint32_t nb_snapshots;
@@ -363,7 +406,8 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
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
@@ -376,6 +420,7 @@ int coroutine_fn qcow2_check_read_snapshot_table(Bloc=
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


