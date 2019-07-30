Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC4C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED182089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED182089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVxI-0008MQ-3Q
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsVsM-0006qs-Hg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsVsL-0002aS-FF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:25:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39457)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsVsI-0002X8-LY; Tue, 30 Jul 2019 13:25:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEF07796ED;
 Tue, 30 Jul 2019 17:25:21 +0000 (UTC)
Received: from localhost (ovpn-116-164.ams2.redhat.com [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5568C5C1A1;
 Tue, 30 Jul 2019 17:25:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 19:24:59 +0200
Message-Id: <20190730172508.19911-5-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-1-mreitz@redhat.com>
References: <20190730172508.19911-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 30 Jul 2019 17:25:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 04/13] qcow2: Put qcow2_upgrade() into
 an own function
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

This does not make sense right now, but it will make sense once we need
to do more than to just update s->qcow_version.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0336deaf2c..99e9dad798 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4721,12 +4721,46 @@ static int qcow2_downgrade(BlockDriverState *bs, =
int target_version,
     return 0;
 }
=20
+/*
+ * Upgrades an image's version.  While newer versions encompass all
+ * features of older versions, some things may have to be presented
+ * differently.
+ */
+static int qcow2_upgrade(BlockDriverState *bs, int target_version,
+                         BlockDriverAmendStatusCB *status_cb, void *cb_o=
paque,
+                         Error **errp)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int current_version =3D s->qcow_version;
+    int ret;
+
+    /* This is qcow2_upgrade(), not qcow2_downgrade() */
+    assert(target_version > current_version);
+
+    /* There are no other versions (yet) that you can upgrade to */
+    assert(target_version =3D=3D 3);
+
+    status_cb(bs, 0, 1, cb_opaque);
+
+    s->qcow_version =3D target_version;
+    ret =3D qcow2_update_header(bs);
+    if (ret < 0) {
+        s->qcow_version =3D current_version;
+        error_setg_errno(errp, -ret, "Failed to update the image header"=
);
+        return ret;
+    }
+    status_cb(bs, 1, 1, cb_opaque);
+
+    return 0;
+}
+
 typedef enum Qcow2AmendOperation {
     /* This is the value Qcow2AmendHelperCBInfo::last_operation will be
      * statically initialized to so that the helper CB can discern the f=
irst
      * invocation from an operation change */
     QCOW2_NO_OPERATION =3D 0,
=20
+    QCOW2_UPGRADING,
     QCOW2_CHANGING_REFCOUNT_ORDER,
     QCOW2_DOWNGRADING,
 } Qcow2AmendOperation;
@@ -4909,17 +4943,16 @@ static int qcow2_amend_options(BlockDriverState *=
bs, QemuOpts *opts,
     helper_cb_info =3D (Qcow2AmendHelperCBInfo){
         .original_status_cb =3D status_cb,
         .original_cb_opaque =3D cb_opaque,
-        .total_operations =3D (new_version < old_version)
+        .total_operations =3D (new_version !=3D old_version)
                           + (s->refcount_bits !=3D refcount_bits)
     };
=20
     /* Upgrade first (some features may require compat=3D1.1) */
     if (new_version > old_version) {
-        s->qcow_version =3D new_version;
-        ret =3D qcow2_update_header(bs);
+        helper_cb_info.current_operation =3D QCOW2_UPGRADING;
+        ret =3D qcow2_upgrade(bs, new_version, &qcow2_amend_helper_cb,
+                            &helper_cb_info, errp);
         if (ret < 0) {
-            s->qcow_version =3D old_version;
-            error_setg_errno(errp, -ret, "Failed to update the image hea=
der");
             return ret;
         }
     }
--=20
2.21.0


