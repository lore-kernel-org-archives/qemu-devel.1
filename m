Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88668ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DF0206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DF0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwwF-0007Cu-Uv
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqT-0001Wz-0m
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqR-0006Zz-Ka
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwqN-0006Xm-JB; Fri, 11 Oct 2019 11:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CA3C302C080;
 Fri, 11 Oct 2019 15:28:38 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 029DA60872;
 Fri, 11 Oct 2019 15:28:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 07/16] qcow2: Write v3-compliant snapshot list on upgrade
Date: Fri, 11 Oct 2019 17:28:05 +0200
Message-Id: <20191011152814.14791-8-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 11 Oct 2019 15:28:38 +0000 (UTC)
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

qcow2 v3 requires every snapshot table entry to have two extra data
fields: The 64-bit VM state size, and the virtual disk size.  Both are
optional for v2 images, so they may not be present.

qcow2_upgrade() therefore should update the snapshot table to ensure all
entries have these extra data fields.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1727347
Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d43064dca2..a2e46ce589 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4907,7 +4907,9 @@ static int qcow2_upgrade(BlockDriverState *bs, int =
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
@@ -4916,7 +4918,33 @@ static int qcow2_upgrade(BlockDriverState *bs, int=
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
+        if (s->snapshots[i].extra_data_size <
+            sizeof_field(QCowSnapshotExtraData, vm_state_size_large) +
+            sizeof_field(QCowSnapshotExtraData, disk_size))
+        {
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
@@ -4925,7 +4953,7 @@ static int qcow2_upgrade(BlockDriverState *bs, int =
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


