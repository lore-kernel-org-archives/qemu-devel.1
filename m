Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EEDC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C96214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C96214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzmrP-0004DI-VG
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzmpN-0001qq-NT
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzmpM-00021F-9X
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzmpJ-0001yv-KB; Mon, 19 Aug 2019 14:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9318106E96B;
 Mon, 19 Aug 2019 18:56:20 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8006110013A1;
 Mon, 19 Aug 2019 18:56:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 20:55:52 +0200
Message-Id: <20190819185602.4267-7-mreitz@redhat.com>
In-Reply-To: <20190819185602.4267-1-mreitz@redhat.com>
References: <20190819185602.4267-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 19 Aug 2019 18:56:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/16] qcow2: Put qcow2_upgrade() into its
 own function
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index dbb50bc2f8..190a3874c1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4749,12 +4749,46 @@ static int qcow2_downgrade(BlockDriverState *bs, =
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
@@ -4937,17 +4971,16 @@ static int qcow2_amend_options(BlockDriverState *=
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


