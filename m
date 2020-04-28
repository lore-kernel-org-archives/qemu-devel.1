Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F0C83006
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA088206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV1qyGvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA088206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQGy-0005EL-RE
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:27:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTQG4-0003ES-I9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTQG3-0001oo-95
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTQG2-0001oS-S0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588080402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEyOAEDZWInkg5GvbTHqHJ7asx8yW0xK/qDXZe7F7Wo=;
 b=SV1qyGvU/9Pud0HjExukas+U2lPeAMS5c6dNgg0Dq8P63O1d73Tu8E+72IDr3AwFSorKVa
 4scSjbxVnwZRzTCaifHuAPQbiXyJPNa8CQsT6YtTk87ndyUGtlA5h+DFPCzOxWsoNnTAO/
 aOPmWWByml853RLC6EH8CABM0v2g5+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-j8MmwSQtMeeGUzYxEhH6NQ-1; Tue, 28 Apr 2020 09:26:40 -0400
X-MC-Unique: j8MmwSQtMeeGUzYxEhH6NQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 820EABFC0;
 Tue, 28 Apr 2020 13:26:39 +0000 (UTC)
Received: from localhost (ovpn-112-143.ams2.redhat.com [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2159160C81;
 Tue, 28 Apr 2020 13:26:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/4] block: Use blk_make_empty() after commits
Date: Tue, 28 Apr 2020 15:26:29 +0200
Message-Id: <20200428132629.796753-5-mreitz@redhat.com>
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
References: <20200428132629.796753-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 block/commit.c |  8 +++++++-
 qemu-img.c     | 19 ++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 8e672799af..24720ba67d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -493,10 +493,16 @@ int bdrv_commit(BlockDriverState *bs)
     }
=20
     if (drv->bdrv_make_empty) {
-        ret =3D drv->bdrv_make_empty(bs);
+        ret =3D blk_set_perm(src, BLK_PERM_WRITE, BLK_PERM_ALL, NULL);
         if (ret < 0) {
             goto ro_cleanup;
         }
+
+        ret =3D blk_make_empty(src, NULL);
+        if (ret < 0) {
+            goto ro_cleanup;
+        }
+
         blk_flush(src);
     }
=20
diff --git a/qemu-img.c b/qemu-img.c
index 821cbf610e..a5e8659867 100644
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


