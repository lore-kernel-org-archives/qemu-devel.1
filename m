Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA363ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39E9206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39E9206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwt6-0003pO-Bo
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqG-0001P4-O9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqF-0006Rx-JE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwqB-0006QE-Ka; Fri, 11 Oct 2019 11:28:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C64627575F;
 Fri, 11 Oct 2019 15:28:26 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38EE660872;
 Fri, 11 Oct 2019 15:28:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 03/16] qcow2: Add Error ** to qcow2_read_snapshots()
Date: Fri, 11 Oct 2019 17:28:01 +0200
Message-Id: <20191011152814.14791-4-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 11 Oct 2019 15:28:26 +0000 (UTC)
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h          | 2 +-
 block/qcow2-snapshot.c | 7 ++++++-
 block/qcow2.c          | 3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index f51f478e34..8da1ad11d9 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -708,7 +708,7 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
                             Error **errp);
=20
 void qcow2_free_snapshots(BlockDriverState *bs);
-int qcow2_read_snapshots(BlockDriverState *bs);
+int qcow2_read_snapshots(BlockDriverState *bs, Error **errp);
=20
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 752883e5c3..80d32e4504 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -43,7 +43,7 @@ void qcow2_free_snapshots(BlockDriverState *bs)
     s->nb_snapshots =3D 0;
 }
=20
-int qcow2_read_snapshots(BlockDriverState *bs)
+int qcow2_read_snapshots(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     QCowSnapshotHeader h;
@@ -68,6 +68,7 @@ int qcow2_read_snapshots(BlockDriverState *bs)
         offset =3D ROUND_UP(offset, 8);
         ret =3D bdrv_pread(bs->file, offset, &h, sizeof(h));
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to read snapshot table"=
);
             goto fail;
         }
=20
@@ -88,6 +89,7 @@ int qcow2_read_snapshots(BlockDriverState *bs)
         ret =3D bdrv_pread(bs->file, offset, &extra,
                          MIN(sizeof(extra), extra_data_size));
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to read snapshot table"=
);
             goto fail;
         }
         offset +=3D extra_data_size;
@@ -107,6 +109,7 @@ int qcow2_read_snapshots(BlockDriverState *bs)
         sn->id_str =3D g_malloc(id_str_size + 1);
         ret =3D bdrv_pread(bs->file, offset, sn->id_str, id_str_size);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to read snapshot table"=
);
             goto fail;
         }
         offset +=3D id_str_size;
@@ -116,6 +119,7 @@ int qcow2_read_snapshots(BlockDriverState *bs)
         sn->name =3D g_malloc(name_size + 1);
         ret =3D bdrv_pread(bs->file, offset, sn->name, name_size);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to read snapshot table"=
);
             goto fail;
         }
         offset +=3D name_size;
@@ -123,6 +127,7 @@ int qcow2_read_snapshots(BlockDriverState *bs)
=20
         if (offset - s->snapshots_offset > QCOW_MAX_SNAPSHOTS_SIZE) {
             ret =3D -EFBIG;
+            error_setg(errp, "Snapshot table is too big");
             goto fail;
         }
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 7961c05783..d0135912d0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1584,9 +1584,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
     s->snapshots_offset =3D header.snapshots_offset;
     s->nb_snapshots =3D header.nb_snapshots;
=20
-    ret =3D qcow2_read_snapshots(bs);
+    ret =3D qcow2_read_snapshots(bs, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not read snapshots");
         goto fail;
     }
=20
--=20
2.21.0


