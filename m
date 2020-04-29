Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F6AC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF8C206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdNzf1OF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF8C206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnXw-0007KZ-Hk
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnRF-0004SY-9y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnRE-0003zx-M5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTnRE-0003vH-5Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588169507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iFJA1sE2IUTsGX+c99KkPhxahWSl8oT3iPtXyqjU3E=;
 b=MdNzf1OFTziZSjDvNIJP+vHrWT64dZfhmLm5FSBUDYmvnM7B+Rbr9mGicKLvAGQnBPnpgP
 Ae6x3nLS2qD0o3Wd2AOIpy8x2EUIr3HMMfol3tYln1Oes2rCawAh0W12SWeZwirrwGqqtk
 qamfT7NxuXavzZQdjB7wyH+z2cdZTYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-3iY82_NmPWiulTm8jaQQxg-1; Wed, 29 Apr 2020 10:11:45 -0400
X-MC-Unique: 3iY82_NmPWiulTm8jaQQxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97182100A8D1;
 Wed, 29 Apr 2020 14:11:36 +0000 (UTC)
Received: from localhost (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 347411002388;
 Wed, 29 Apr 2020 14:11:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/4] block: Use blk_make_empty() after commits
Date: Wed, 29 Apr 2020 16:11:26 +0200
Message-Id: <20200429141126.85159-5-mreitz@redhat.com>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
References: <20200429141126.85159-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

bdrv_commit() already has a BlockBackend pointing to the BDS that we
want to empty, it just has the wrong permissions.

qemu-img commit has no BlockBackend pointing to the old backing file
yet, but introducing one is simple.

After this commit, bdrv_make_empty() is the only remaining caller of
BlockDriver.bdrv_make_empty().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c | 16 +++++++++-------
 qemu-img.c     | 19 ++++++++++++++-----
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 87f6096d90..ba60fb7955 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -414,7 +414,9 @@ int bdrv_commit(BlockDriverState *bs)
     }
=20
     ctx =3D bdrv_get_aio_context(bs);
-    src =3D blk_new(ctx, BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    /* WRITE_UNCHANGED is required for bdrv_make_empty() */
+    src =3D blk_new(ctx, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANG=
ED,
+                  BLK_PERM_ALL);
     backing =3D blk_new(ctx, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_AL=
L);
=20
     ret =3D blk_insert_bs(src, bs, &local_err);
@@ -492,14 +494,14 @@ int bdrv_commit(BlockDriverState *bs)
         }
     }
=20
-    if (drv->bdrv_make_empty) {
-        ret =3D drv->bdrv_make_empty(bs);
-        if (ret < 0) {
-            goto ro_cleanup;
-        }
-        blk_flush(src);
+    ret =3D blk_make_empty(src, NULL);
+    /* Ignore -ENOTSUP */
+    if (ret < 0 && ret !=3D -ENOTSUP) {
+        goto ro_cleanup;
     }
=20
+    blk_flush(src);
+
     /*
      * Make sure all data we wrote to the backing device is actually
      * stable on disk.
diff --git a/qemu-img.c b/qemu-img.c
index 7f52742ef2..77f3575538 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1065,11 +1065,20 @@ static int img_commit(int argc, char **argv)
         goto unref_backing;
     }
=20
-    if (!drop && bs->drv->bdrv_make_empty) {
-        ret =3D bs->drv->bdrv_make_empty(bs);
-        if (ret) {
-            error_setg_errno(&local_err, -ret, "Could not empty %s",
-                             filename);
+    if (!drop) {
+        BlockBackend *old_backing_blk;
+
+        old_backing_blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE, BLK_PERM_A=
LL,
+                                          &local_err);
+        if (!old_backing_blk) {
+            goto unref_backing;
+        }
+        ret =3D blk_make_empty(old_backing_blk, &local_err);
+        blk_unref(old_backing_blk);
+        if (ret =3D=3D -ENOTSUP) {
+            error_free(local_err);
+            local_err =3D NULL;
+        } else if (ret < 0) {
             goto unref_backing;
         }
     }
--=20
2.25.4


