Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E9C34034
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE22207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE22207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zwB-0004gw-RX
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1j3zvB-00035f-So
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1j3zv9-0007uc-8m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:16:05 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:58770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1j3zv3-0007qI-Jm; Tue, 18 Feb 2020 05:15:57 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B7E91436DF;
 Tue, 18 Feb 2020 11:08:12 +0100 (CET)
From: =?UTF-8?q?Fabian=20Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
To: qemu-devel@nongnu.org
Subject: [RFC qemu 6/6] mirror: move some checks to QMP
Date: Tue, 18 Feb 2020 11:07:40 +0100
Message-Id: <20200218100740.2228521-7-f.gruenbichler@proxmox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

and assert the passing conditions in block/mirror.c. while incremental
mode was never available for drive-mirror, it makes the interface more
uniform w.r.t. backup block jobs.

Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
---
 block/mirror.c             | 28 +++------------
 blockdev.c                 | 29 +++++++++++++++
 tests/qemu-iotests/284.out | 72 +++++++++++++++++++-------------------
 3 files changed, 70 insertions(+), 59 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index d6aca2874e..7a3373fca7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1562,31 +1562,13 @@ static BlockJob *mirror_start_job(
     Error *local_err =3D NULL;
     int ret;
=20
-    if (sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
-        error_setg(errp, "Sync mode '%s' not supported",
-                   MirrorSyncMode_str(sync_mode));
-        return NULL;
-    } else if (sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
-        if (!bitmap) {
-            error_setg(errp, "Must provide a valid bitmap name for '%s'"
-                       " sync mode",
-                       MirrorSyncMode_str(sync_mode));
-            return NULL;
-        }
-    } else if (bitmap) {
-        error_setg(errp,
-                   "sync mode '%s' is not compatible with bitmaps",
-                   MirrorSyncMode_str(sync_mode));
-        return NULL;
-    }
+    /* QMP interface protects us from these cases */
+    assert(sync_mode !=3D MIRROR_SYNC_MODE_INCREMENTAL);
+    assert((bitmap && sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) ||
+           (!bitmap && sync_mode !=3D MIRROR_SYNC_MODE_BITMAP));
+    assert(!(bitmap && granularity));
=20
     if (bitmap) {
-        if (granularity) {
-            error_setg(errp, "granularity (%d)"
-                       "cannot be specified when a bitmap is provided",
-                       granularity);
-            return NULL;
-        }
         granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
=20
         if (bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER) {
diff --git a/blockdev.c b/blockdev.c
index 23df9f76ba..87bde0a4f4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3847,7 +3847,36 @@ static void blockdev_mirror_common(const char *job=
_id, BlockDriverState *bs,
         sync =3D MIRROR_SYNC_MODE_FULL;
     }
=20
+    if ((sync =3D=3D MIRROR_SYNC_MODE_BITMAP) ||
+        (sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL)) {
+        /* done before desugaring 'incremental' to print the right messa=
ge */
+        if (!has_bitmap) {
+            error_setg(errp, "Must provide a valid bitmap name for "
+                       "'%s' sync mode", MirrorSyncMode_str(sync));
+            return;
+        }
+    }
+
+    if (sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
+        if (has_bitmap_mode &&
+            bitmap_mode !=3D BITMAP_SYNC_MODE_ON_SUCCESS) {
+            error_setg(errp, "Bitmap sync mode must be '%s' "
+                       "when using sync mode '%s'",
+                       BitmapSyncMode_str(BITMAP_SYNC_MODE_ON_SUCCESS),
+                       MirrorSyncMode_str(sync));
+            return;
+        }
+        has_bitmap_mode =3D true;
+        sync =3D MIRROR_SYNC_MODE_BITMAP;
+        bitmap_mode =3D BITMAP_SYNC_MODE_ON_SUCCESS;
+    }
+
     if (has_bitmap) {
+        if (sync !=3D MIRROR_SYNC_MODE_BITMAP) {
+            error_setg(errp, "Sync mode '%s' not supported with bitmap."=
,
+                       MirrorSyncMode_str(sync));
+            return;
+        }
         if (granularity) {
             error_setg(errp, "Granularity and bitmap cannot both be set"=
);
             return;
diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
index 9b7408b6d6..06a2e29058 100644
--- a/tests/qemu-iotests/284.out
+++ b/tests/qemu-iotests/284.out
@@ -2681,45 +2681,45 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID=
-fmirror3" =3D=3D> Identical, OK!
 -- Sync mode incremental tests --
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_jo=
b", "sync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", =
"sync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "=
sync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "api_job", "sync": "incremental", "t=
arget": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Sync mode 'incremental' not=
 supported"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'incremental' sync mode"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "incremental", "target": "mirror_targe=
t"}}
 {"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Sync mode 'incremental' not=
 supported"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Sync mode 'incremental' not=
 supported"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be 'o=
n-success' when using sync mode 'incremental'"}}
=20
 -- Sync mode bitmap tests --
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_jo=
b", "sync": "bitmap", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", =
"sync": "bitmap", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "=
sync": "bitmap", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "api_job", "sync": "bitmap", "target=
": "mirror_target"}}
 {"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
@@ -2751,28 +2751,28 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID=
-fmirror3" =3D=3D> Identical, OK!
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-to=
p", "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "syn=
c": "full", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 -- Sync mode top tests --
=20
@@ -2786,28 +2786,28 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID=
-fmirror3" =3D=3D> Identical, OK!
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-to=
p", "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "syn=
c": "top", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'full' not suppor=
ted with bitmap."}}
=20
 -- Sync mode none tests --
=20
@@ -2821,26 +2821,26 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID=
-fmirror3" =3D=3D> Identical, OK!
 {"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-to=
p", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'none' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'none' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "sync mode 'none' is not com=
patible with bitmaps"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "syn=
c": "none", "target": "mirror_target"}}
-{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not suppor=
ted with bitmap."}}
=20
--=20
2.20.1



