Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A1CC31E40
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C333C204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C333C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVz0-0003bQ-R1
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsVsT-0006yV-31
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsVsQ-0002fv-KX
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsVsL-0002aK-Ku; Tue, 30 Jul 2019 13:25:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3303300CA4E;
 Tue, 30 Jul 2019 17:25:24 +0000 (UTC)
Received: from localhost (ovpn-116-164.ams2.redhat.com [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DBEA5D978;
 Tue, 30 Jul 2019 17:25:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 19:25:00 +0200
Message-Id: <20190730172508.19911-6-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-1-mreitz@redhat.com>
References: <20190730172508.19911-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 30 Jul 2019 17:25:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 05/13] qcow2: Write v3-compliant
 snapshot list on upgrade
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

qcow2 v3 requires every snapshot table entry to have two extra data
fields: The 64-bit VM state size, and the virtual disk size.  Both are
optional for v2 images, so they may not be present.

qcow2_upgrade() therefore should update the snapshot table to ensure all
entries have these extra data fields.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1727347
Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 99e9dad798..75d41683a1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4731,7 +4731,9 @@ static int qcow2_upgrade(BlockDriverState *bs, int =
target_version,
                          Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
+    bool need_snapshot_update;
     int current_version =3D s->qcow_version;
+    int i;
     int ret;
=20
     /* This is qcow2_upgrade(), not qcow2_downgrade() */
@@ -4740,7 +4742,30 @@ static int qcow2_upgrade(BlockDriverState *bs, int=
 target_version,
     /* There are no other versions (yet) that you can upgrade to */
     assert(target_version =3D=3D 3);
=20
-    status_cb(bs, 0, 1, cb_opaque);
+    status_cb(bs, 0, 2, cb_opaque);
+
+    /*
+     * In v2, snapshots do not need to have extra data.  v3 requires
+     * the 64-bit VM state size and the virtual disk size to be
+     * present.
+     * qcow2_write_snapshots() will always write the list in the
+     * v3-compliant format.
+     */
+    need_snapshot_update =3D false;
+    for (i =3D 0; i < s->nb_snapshots; i++) {
+        if (s->snapshots[i].extra_data_size < 16) {
+            need_snapshot_update =3D true;
+            break;
+        }
+    }
+    if (need_snapshot_update) {
+        ret =3D qcow2_write_snapshots(bs);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to update the snapshot =
table");
+            return ret;
+        }
+    }
+    status_cb(bs, 1, 2, cb_opaque);
=20
     s->qcow_version =3D target_version;
     ret =3D qcow2_update_header(bs);
@@ -4749,7 +4774,7 @@ static int qcow2_upgrade(BlockDriverState *bs, int =
target_version,
         error_setg_errno(errp, -ret, "Failed to update the image header"=
);
         return ret;
     }
-    status_cb(bs, 1, 1, cb_opaque);
+    status_cb(bs, 2, 2, cb_opaque);
=20
     return 0;
 }
--=20
2.21.0


