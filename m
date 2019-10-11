Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675F6ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A85F206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A85F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwx0-0007sE-TL
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqJ-0001RS-HF
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqI-0006UM-1r
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwqE-0006RO-CW; Fri, 11 Oct 2019 11:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F7AD300CB26;
 Fri, 11 Oct 2019 15:28:29 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E50E310013D9;
 Fri, 11 Oct 2019 15:28:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 04/16] qcow2: Keep unknown extra snapshot data
Date: Fri, 11 Oct 2019 17:28:02 +0200
Message-Id: <20191011152814.14791-5-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 11 Oct 2019 15:28:29 +0000 (UTC)
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

The qcow2 specification says to ignore unknown extra data fields in
snapshot table entries.  Currently, we discard it whenever we update the
image, which is a bit different from "ignore".

This patch makes the qcow2 driver keep all unknown extra data fields
when updating an image's snapshot table.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h          |  5 ++++
 block/qcow2-snapshot.c | 61 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8da1ad11d9..61e5d4ba94 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -61,6 +61,9 @@
  * space for snapshot names and IDs */
 #define QCOW_MAX_SNAPSHOTS_SIZE (1024 * QCOW_MAX_SNAPSHOTS)
=20
+/* Maximum amount of extra data per snapshot table entry to accept */
+#define QCOW_MAX_SNAPSHOT_EXTRA_DATA 1024
+
 /* Bitmap header extension constraints */
 #define QCOW2_MAX_BITMAPS 65535
 #define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
@@ -181,6 +184,8 @@ typedef struct QCowSnapshot {
     uint32_t date_sec;
     uint32_t date_nsec;
     uint64_t vm_clock_nsec;
+    uint32_t extra_data_size;
+    void *unknown_extra_data; /* Extra data past QCowSnapshotExtraData *=
/
 } QCowSnapshot;
=20
 struct Qcow2Cache;
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 80d32e4504..120cb7fa09 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -37,6 +37,7 @@ void qcow2_free_snapshots(BlockDriverState *bs)
     for(i =3D 0; i < s->nb_snapshots; i++) {
         g_free(s->snapshots[i].name);
         g_free(s->snapshots[i].id_str);
+        g_free(s->snapshots[i].unknown_extra_data);
     }
     g_free(s->snapshots);
     s->snapshots =3D NULL;
@@ -51,7 +52,6 @@ int qcow2_read_snapshots(BlockDriverState *bs, Error **=
errp)
     QCowSnapshot *sn;
     int i, id_str_size, name_size;
     int64_t offset;
-    uint32_t extra_data_size;
     int ret;
=20
     if (!s->nb_snapshots) {
@@ -80,31 +80,53 @@ int qcow2_read_snapshots(BlockDriverState *bs, Error =
**errp)
         sn->date_sec =3D be32_to_cpu(h.date_sec);
         sn->date_nsec =3D be32_to_cpu(h.date_nsec);
         sn->vm_clock_nsec =3D be64_to_cpu(h.vm_clock_nsec);
-        extra_data_size =3D be32_to_cpu(h.extra_data_size);
+        sn->extra_data_size =3D be32_to_cpu(h.extra_data_size);
=20
         id_str_size =3D be16_to_cpu(h.id_str_size);
         name_size =3D be16_to_cpu(h.name_size);
=20
-        /* Read extra data */
+        if (sn->extra_data_size > QCOW_MAX_SNAPSHOT_EXTRA_DATA) {
+            ret =3D -EFBIG;
+            error_setg(errp, "Too much extra metadata in snapshot table =
"
+                       "entry %i", i);
+            goto fail;
+        }
+
+        /* Read known extra data */
         ret =3D bdrv_pread(bs->file, offset, &extra,
-                         MIN(sizeof(extra), extra_data_size));
+                         MIN(sizeof(extra), sn->extra_data_size));
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to read snapshot table"=
);
             goto fail;
         }
-        offset +=3D extra_data_size;
+        offset +=3D MIN(sizeof(extra), sn->extra_data_size);
=20
-        if (extra_data_size >=3D endof(QCowSnapshotExtraData,
-                                     vm_state_size_large)) {
+        if (sn->extra_data_size >=3D endof(QCowSnapshotExtraData,
+                                         vm_state_size_large)) {
             sn->vm_state_size =3D be64_to_cpu(extra.vm_state_size_large)=
;
         }
=20
-        if (extra_data_size >=3D endof(QCowSnapshotExtraData, disk_size)=
) {
+        if (sn->extra_data_size >=3D endof(QCowSnapshotExtraData, disk_s=
ize)) {
             sn->disk_size =3D be64_to_cpu(extra.disk_size);
         } else {
             sn->disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
         }
=20
+        if (sn->extra_data_size > sizeof(extra)) {
+            /* Store unknown extra data */
+            size_t unknown_extra_data_size =3D
+                sn->extra_data_size - sizeof(extra);
+
+            sn->unknown_extra_data =3D g_malloc(unknown_extra_data_size)=
;
+            ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_data,
+                             unknown_extra_data_size);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to read snapshot ta=
ble");
+                goto fail;
+            }
+            offset +=3D unknown_extra_data_size;
+        }
+
         /* Read snapshot ID */
         sn->id_str =3D g_malloc(id_str_size + 1);
         ret =3D bdrv_pread(bs->file, offset, sn->id_str, id_str_size);
@@ -162,7 +184,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs=
)
         sn =3D s->snapshots + i;
         offset =3D ROUND_UP(offset, 8);
         offset +=3D sizeof(h);
-        offset +=3D sizeof(extra);
+        offset +=3D MAX(sizeof(extra), sn->extra_data_size);
         offset +=3D strlen(sn->id_str);
         offset +=3D strlen(sn->name);
=20
@@ -209,7 +231,8 @@ static int qcow2_write_snapshots(BlockDriverState *bs=
)
         h.date_sec =3D cpu_to_be32(sn->date_sec);
         h.date_nsec =3D cpu_to_be32(sn->date_nsec);
         h.vm_clock_nsec =3D cpu_to_be64(sn->vm_clock_nsec);
-        h.extra_data_size =3D cpu_to_be32(sizeof(extra));
+        h.extra_data_size =3D cpu_to_be32(MAX(sizeof(extra),
+                                            sn->extra_data_size));
=20
         memset(&extra, 0, sizeof(extra));
         extra.vm_state_size_large =3D cpu_to_be64(sn->vm_state_size);
@@ -234,6 +257,22 @@ static int qcow2_write_snapshots(BlockDriverState *b=
s)
         }
         offset +=3D sizeof(extra);
=20
+        if (sn->extra_data_size > sizeof(extra)) {
+            size_t unknown_extra_data_size =3D
+                sn->extra_data_size - sizeof(extra);
+
+            /* qcow2_read_snapshots() ensures no unbounded allocation */
+            assert(unknown_extra_data_size <=3D BDRV_REQUEST_MAX_BYTES);
+            assert(sn->unknown_extra_data);
+
+            ret =3D bdrv_pwrite(bs->file, offset, sn->unknown_extra_data=
,
+                              unknown_extra_data_size);
+            if (ret < 0) {
+                goto fail;
+            }
+            offset +=3D unknown_extra_data_size;
+        }
+
         ret =3D bdrv_pwrite(bs->file, offset, sn->id_str, id_str_size);
         if (ret < 0) {
             goto fail;
@@ -376,6 +415,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUS=
napshotInfo *sn_info)
     sn->date_sec =3D sn_info->date_sec;
     sn->date_nsec =3D sn_info->date_nsec;
     sn->vm_clock_nsec =3D sn_info->vm_clock_nsec;
+    sn->extra_data_size =3D sizeof(QCowSnapshotExtraData);
=20
     /* Allocate the L1 table of the snapshot and copy the current one th=
ere. */
     l1_table_offset =3D qcow2_alloc_clusters(bs, s->l1_size * sizeof(uin=
t64_t));
@@ -647,6 +687,7 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
      * The snapshot is now unused, clean up. If we fail after this point=
, we
      * won't recover but just leak clusters.
      */
+    g_free(sn.unknown_extra_data);
     g_free(sn.id_str);
     g_free(sn.name);
=20
--=20
2.21.0


