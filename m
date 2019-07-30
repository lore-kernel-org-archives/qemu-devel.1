Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED64C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BAE204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BAE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVz2-0003fb-80
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsVsb-000765-6O
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsVsY-0002lO-Lo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsVsS-0002g3-Fu; Tue, 30 Jul 2019 13:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A56F3C0669D5;
 Tue, 30 Jul 2019 17:25:30 +0000 (UTC)
Received: from localhost (ovpn-116-164.ams2.redhat.com [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D4D05D9C5;
 Tue, 30 Jul 2019 17:25:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 19:25:02 +0200
Message-Id: <20190730172508.19911-8-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-1-mreitz@redhat.com>
References: <20190730172508.19911-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 30 Jul 2019 17:25:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 07/13] qcow2: Add
 qcow2_check_fix_snapshot_table()
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

qcow2_check_read_snapshot_table() can perform consistency checks, but it
cannot fix everything.  Specifically, it cannot allocate new clusters,
because that should wait until the refcount structures are known to be
consistent (i.e., after qcow2_check_refcounts()).  Thus, it cannot call
qcow2_write_snapshots().

Do that in qcow2_check_fix_snapshot_table(), which is called after
qcow2_check_refcounts().

Currently, there is nothing that would set result->corruptions, so this
is a no-op.  A follow-up patch will change that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          |  3 +++
 block/qcow2-snapshot.c | 25 +++++++++++++++++++++++++
 block/qcow2.c          |  9 ++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 50c7eefb5b..6823c37e82 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -715,6 +715,9 @@ int qcow2_write_snapshots(BlockDriverState *bs);
 int coroutine_fn qcow2_check_read_snapshot_table(BlockDriverState *bs,
                                                  BdrvCheckResult *result=
,
                                                  BdrvCheckMode fix);
+int coroutine_fn qcow2_check_fix_snapshot_table(BlockDriverState *bs,
+                                                BdrvCheckResult *result,
+                                                BdrvCheckMode fix);
=20
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index cbc6d699b6..58609b6ea4 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -379,6 +379,31 @@ int coroutine_fn qcow2_check_read_snapshot_table(Blo=
ckDriverState *bs,
     return 0;
 }
=20
+int coroutine_fn qcow2_check_fix_snapshot_table(BlockDriverState *bs,
+                                                BdrvCheckResult *result,
+                                                BdrvCheckMode fix)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int ret;
+
+    if (result->corruptions && (fix & BDRV_FIX_ERRORS)) {
+        qemu_co_mutex_unlock(&s->lock);
+        ret =3D qcow2_write_snapshots(bs);
+        qemu_co_mutex_lock(&s->lock);
+        if (ret < 0) {
+            result->check_errors++;
+            fprintf(stderr, "ERROR failed to update snapshot table: %s\n=
",
+                    strerror(-ret));
+            return ret;
+        }
+
+        result->corruptions_fixed +=3D result->corruptions;
+        result->corruptions =3D 0;
+    }
+
+    return 0;
+}
+
 static void find_new_snapshot_id(BlockDriverState *bs,
                                  char *id_str, int id_str_size)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 2983a7795a..ac94cc7807 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -594,13 +594,20 @@ static int coroutine_fn qcow2_co_check_locked(Block=
DriverState *bs,
     memset(result, 0, sizeof(*result));
=20
     ret =3D qcow2_check_read_snapshot_table(bs, &snapshot_res, fix);
-    qcow2_add_check_result(result, &snapshot_res, false);
     if (ret < 0) {
+        qcow2_add_check_result(result, &snapshot_res, false);
         return ret;
     }
=20
     ret =3D qcow2_check_refcounts(bs, &refcount_res, fix);
     qcow2_add_check_result(result, &refcount_res, true);
+    if (ret < 0) {
+        qcow2_add_check_result(result, &snapshot_res, false);
+        return ret;
+    }
+
+    ret =3D qcow2_check_fix_snapshot_table(bs, &snapshot_res, fix);
+    qcow2_add_check_result(result, &snapshot_res, false);
     if (ret < 0) {
         return ret;
     }
--=20
2.21.0


