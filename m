Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C647C11D0B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1B720658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjXb+xSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1B720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oQp-0000WX-AO
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oOZ-0005Hc-TA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oOY-00068J-GG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:09:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oOY-000682-Av
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MttArOFtWxbQbyc/L7DWpav82OCvI7dSnQyTC0YOVBQ=;
 b=NjXb+xSFRRjtm309iFF0D/9w67rl+8wlJ4+XtK0HFRDFrCgqWOz4J62SczaSx9ON8oNGY3
 IArupLcamw/l3bLmosny+OZ1zowQYay1UfWgjwDQGVzgV58k+Xw9vMAf3UxeLyu2BxN9nZ
 YJcNVzXqzSMeIYrE/vJfMlLAZbKelX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-yxSDvBd5NqqcQDFqwopwXQ-1; Thu, 20 Feb 2020 11:09:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01067477;
 Thu, 20 Feb 2020 16:09:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35CF9101D489;
 Thu, 20 Feb 2020 16:09:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/18] block/backup-top: fix flags handling
Date: Thu, 20 Feb 2020 17:07:00 +0100
Message-Id: <20200220160710.533297-9-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yxSDvBd5NqqcQDFqwopwXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

backup-top "supports" write-unchanged, by skipping CBW operation in
backup_top_co_pwritev. But it forgets to do the same in
backup_top_co_pwrite_zeroes, as well as declare support for
BDRV_REQ_WRITE_UNCHANGED.

Fix this, and, while being here, declare also support for flags
supported by source child.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200207161231.32707-1-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup-top.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index fa78f3256d..1bfb360bd3 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -48,11 +48,17 @@ static coroutine_fn int backup_top_co_preadv(
 }
=20
 static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offs=
et,
-                                       uint64_t bytes)
+                                       uint64_t bytes, BdrvRequestFlags fl=
ags)
 {
     BDRVBackupTopState *s =3D bs->opaque;
-    uint64_t end =3D QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size);
-    uint64_t off =3D QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
+    uint64_t off, end;
+
+    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
+        return 0;
+    }
+
+    off =3D QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
+    end =3D QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size);
=20
     return block_copy(s->bcs, off, end - off, NULL);
 }
@@ -60,7 +66,7 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *=
bs, uint64_t offset,
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
                                                int64_t offset, int bytes)
 {
-    int ret =3D backup_top_cbw(bs, offset, bytes);
+    int ret =3D backup_top_cbw(bs, offset, bytes, 0);
     if (ret < 0) {
         return ret;
     }
@@ -71,7 +77,7 @@ static int coroutine_fn backup_top_co_pdiscard(BlockDrive=
rState *bs,
 static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
         int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-    int ret =3D backup_top_cbw(bs, offset, bytes);
+    int ret =3D backup_top_cbw(bs, offset, bytes, flags);
     if (ret < 0) {
         return ret;
     }
@@ -84,11 +90,9 @@ static coroutine_fn int backup_top_co_pwritev(BlockDrive=
rState *bs,
                                               uint64_t bytes,
                                               QEMUIOVector *qiov, int flag=
s)
 {
-    if (!(flags & BDRV_REQ_WRITE_UNCHANGED)) {
-        int ret =3D backup_top_cbw(bs, offset, bytes);
-        if (ret < 0) {
-            return ret;
-        }
+    int ret =3D backup_top_cbw(bs, offset, bytes, flags);
+    if (ret < 0) {
+        return ret;
     }
=20
     return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
@@ -196,8 +200,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverSt=
ate *source,
         return NULL;
     }
=20
-    top->total_sectors =3D source->total_sectors;
     state =3D top->opaque;
+    top->total_sectors =3D source->total_sectors;
+    top->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+            (BDRV_REQ_FUA & source->supported_write_flags);
+    top->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
+            ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
+             source->supported_zero_flags);
=20
     bdrv_ref(target);
     state->target =3D bdrv_attach_child(top, target, "target", &child_file=
, errp);
--=20
2.24.1


