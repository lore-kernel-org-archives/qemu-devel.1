Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE719FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8485421D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8485421D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDog-00048P-Hn
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iLDjS-0006mW-VN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iLDjR-0002H3-RW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iLDjP-0002EF-LY; Thu, 17 Oct 2019 17:54:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CEB2D51EF6;
 Thu, 17 Oct 2019 21:54:50 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75DBC5D9DC;
 Thu, 17 Oct 2019 21:54:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Subject: [PULL v3 02/19] block: move bdrv_can_store_new_dirty_bitmap to
 block/dirty-bitmap.c
Date: Thu, 17 Oct 2019 17:54:19 -0400
Message-Id: <20191017215436.14252-3-jsnow@redhat.com>
In-Reply-To: <20191017215436.14252-1-jsnow@redhat.com>
References: <20191017215436.14252-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 17 Oct 2019 21:54:50 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

block/dirty-bitmap.c seems to be more appropriate for it and
bdrv_remove_persistent_dirty_bitmap already in it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190920082543.23444-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block.c              | 22 ----------------------
 block/dirty-bitmap.c | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/block.c b/block.c
index 1946fc6f57..d19a4781a3 100644
--- a/block.c
+++ b/block.c
@@ -6582,25 +6582,3 @@ void bdrv_del_child(BlockDriverState *parent_bs, B=
drvChild *child, Error **errp)
=20
     parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
 }
-
-bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *n=
ame,
-                                     uint32_t granularity, Error **errp)
-{
-    BlockDriver *drv =3D bs->drv;
-
-    if (!drv) {
-        error_setg_errno(errp, ENOMEDIUM,
-                         "Can't store persistent bitmaps to %s",
-                         bdrv_get_device_or_node_name(bs));
-        return false;
-    }
-
-    if (!drv->bdrv_can_store_new_dirty_bitmap) {
-        error_setg_errno(errp, ENOTSUP,
-                         "Can't store persistent bitmaps to %s",
-                         bdrv_get_device_or_node_name(bs));
-        return false;
-    }
-
-    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
-}
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 134e0c9a0c..8f42015db9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -464,6 +464,28 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriver=
State *bs,
     }
 }
=20
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *n=
ame,
+                                     uint32_t granularity, Error **errp)
+{
+    BlockDriver *drv =3D bs->drv;
+
+    if (!drv) {
+        error_setg_errno(errp, ENOMEDIUM,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return false;
+    }
+
+    if (!drv->bdrv_can_store_new_dirty_bitmap) {
+        error_setg_errno(errp, ENOTSUP,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return false;
+    }
+
+    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
+}
+
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     bdrv_dirty_bitmap_lock(bitmap);
--=20
2.21.0


