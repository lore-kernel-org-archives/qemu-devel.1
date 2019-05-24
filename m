Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C58C282E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A9921848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A9921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUE3y-0000mJ-Ur
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUE25-0007DD-Lv
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUDzb-0004Q5-Gn
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hUDza-0004P8-6B; Fri, 24 May 2019 13:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DF463004413;
	Fri, 24 May 2019 17:28:21 +0000 (UTC)
Received: from localhost (ovpn-204-150.brq.redhat.com [10.40.204.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AB2F760C62;
	Fri, 24 May 2019 17:28:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 24 May 2019 19:28:10 +0200
Message-Id: <20190524172812.27308-2-mreitz@redhat.com>
In-Reply-To: <20190524172812.27308-1-mreitz@redhat.com>
References: <20190524172812.27308-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 24 May 2019 17:28:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 1/3] block: Add ImageRotationalInfo
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This enum indicates whether a file is stored on a rotating disk or a
solid-state drive.  Drivers report it via the .bdrv_get_info() callback,
and if they do not, the global bdrv_get_info() implementation
automatically takes it from bs->file or bs->backing, if available.

On the QAPI side, we report the value as part of the ImageInfo
structure.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json  | 19 ++++++++++++++++++-
 include/block/block.h |  7 +++++++
 block.c               | 20 +++++++++++++++++++-
 block/qapi.c          |  3 +++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3e4042be7f..80b9f2a69c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -130,6 +130,20 @@
       'luks': 'QCryptoBlockInfoLUKS'
   } }
=20
+##
+# @ImageRotationalInfo:
+#
+# Indicates whether an image is stored on a rotating disk or not.
+#
+# @solid-state: Image is stored on a solid-state drive
+#
+# @rotating:    Image is stored on a rotating disk
+#
+# Since: 4.1
+##
+{ 'enum': 'ImageRotationalInfo',
+  'data': [ 'solid-state', 'rotating' ] }
+
 ##
 # @ImageInfo:
 #
@@ -161,6 +175,9 @@
 #
 # @backing-image: info of the backing image (since 1.6)
 #
+# @rotational: indicates whether the image is stored on a rotating
+#              disk or not (since 4.1)
+#
 # @format-specific: structure supplying additional format-specific
 # information (since 1.7)
 #
@@ -173,7 +190,7 @@
            '*cluster-size': 'int', '*encrypted': 'bool', '*compressed': =
'bool',
            '*backing-filename': 'str', '*full-backing-filename': 'str',
            '*backing-filename-format': 'str', '*snapshots': ['SnapshotIn=
fo'],
-           '*backing-image': 'ImageInfo',
+           '*backing-image': 'ImageInfo', '*rotational': 'ImageRotationa=
lInfo',
            '*format-specific': 'ImageInfoSpecific' } }
=20
 ##
diff --git a/include/block/block.h b/include/block/block.h
index 531cf595cf..dc0f8a4671 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -31,6 +31,13 @@ typedef struct BlockDriverInfo {
      * True if this block driver only supports compressed writes
      */
     bool needs_compressed_writes;
+
+    /*
+     * Indicates whether this image file is stored on a rotating disk
+     * or a solid-state drive.
+     */
+    bool has_rotational_info;
+    ImageRotationalInfo rotational_info;
 } BlockDriverInfo;
=20
 typedef struct BlockFragInfo {
diff --git a/block.c b/block.c
index 4c3902508d..e6b2d6d23b 100644
--- a/block.c
+++ b/block.c
@@ -4950,6 +4950,8 @@ void bdrv_get_backing_filename(BlockDriverState *bs=
,
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BlockDriver *drv =3D bs->drv;
+    int ret;
+
     /* if bs->drv =3D=3D NULL, bs is closed, so there's nothing to do he=
re */
     if (!drv) {
         return -ENOMEDIUM;
@@ -4960,8 +4962,24 @@ int bdrv_get_info(BlockDriverState *bs, BlockDrive=
rInfo *bdi)
         }
         return -ENOTSUP;
     }
+
     memset(bdi, 0, sizeof(*bdi));
-    return drv->bdrv_get_info(bs, bdi);
+    ret =3D drv->bdrv_get_info(bs, bdi);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (!bdi->has_rotational_info && (bs->file || bs->backing)) {
+        BlockDriverState *child =3D bs->file ? bs->file->bs : bs->backin=
g->bs;
+        BlockDriverInfo child_bdi;
+
+        if (bdrv_get_info(child, &child_bdi) >=3D 0) {
+            bdi->rotational_info =3D child_bdi.rotational_info;
+            bdi->has_rotational_info =3D child_bdi.has_rotational_info;
+        }
+    }
+
+    return 0;
 }
=20
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
diff --git a/block/qapi.c b/block/qapi.c
index 0c13c86f4e..48ebfbdcc1 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -286,6 +286,9 @@ void bdrv_query_image_info(BlockDriverState *bs,
         }
         info->dirty_flag =3D bdi.is_dirty;
         info->has_dirty_flag =3D true;
+
+        info->rotational =3D bdi.rotational_info;
+        info->has_rotational =3D bdi.has_rotational_info;
     }
     info->format_specific =3D bdrv_get_specific_info(bs, &err);
     if (err) {
--=20
2.21.0


