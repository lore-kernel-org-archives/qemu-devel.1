Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DF3C742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E223620665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E223620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzTK-0007mA-OS
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlzSu-0006OL-11
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlzSs-0004I2-Qy
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlzSq-0004Ao-4x; Fri, 12 Jul 2019 13:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 792F13079B63;
 Fri, 12 Jul 2019 17:36:07 +0000 (UTC)
Received: from localhost (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10E8819C58;
 Fri, 12 Jul 2019 17:36:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 19:35:55 +0200
Message-Id: <20190712173600.14554-3-mreitz@redhat.com>
In-Reply-To: <20190712173600.14554-1-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 12 Jul 2019 17:36:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/7] block: Add blk_truncate_for_formatting()
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h | 12 ++++++++
 block/block-backend.c          | 54 ++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 733c4957eb..cd9ec8bf52 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -236,6 +236,18 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_t=
 offset, const void *buf,
                           int bytes);
 int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode preallo=
c,
                  Error **errp);
+
+/**
+ * Wrapper of blk_truncate() for format drivers that need to truncate
+ * their protocol node before formatting it.
+ * Invoke blk_truncate() to truncate the file to @offset; if that
+ * fails with -ENOTSUP (and the file is already big enough), try to
+ * overwrite the first sector with zeroes.  If that succeeds, return
+ * success.
+ */
+int blk_truncate_for_formatting(BlockBackend *blk, int64_t offset,
+                                Error **errp);
+
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
diff --git a/block/block-backend.c b/block/block-backend.c
index a8d160fd5d..c0e64b1ee1 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2041,6 +2041,60 @@ int blk_truncate(BlockBackend *blk, int64_t offset=
, PreallocMode prealloc,
     return bdrv_truncate(blk->root, offset, prealloc, errp);
 }
=20
+int blk_truncate_for_formatting(BlockBackend *blk, int64_t offset, Error=
 **errp)
+{
+    Error *local_err =3D NULL;
+    int64_t current_size;
+    int bytes_to_clear;
+    int ret;
+
+    ret =3D blk_truncate(blk, offset, PREALLOC_MODE_OFF, &local_err);
+    if (ret < 0 && ret !=3D -ENOTSUP) {
+        error_propagate(errp, local_err);
+        return ret;
+    } else if (ret >=3D 0) {
+        return ret;
+    }
+
+    current_size =3D blk_getlength(blk);
+    if (current_size < 0) {
+        error_free(local_err);
+        error_setg_errno(errp, -current_size,
+                         "Failed to inquire new image file's current len=
gth");
+        return current_size;
+    }
+
+    if (current_size < offset) {
+        /* Need to grow the image, but we failed to do that */
+        error_propagate(errp, local_err);
+        return -ENOTSUP;
+    }
+
+    error_free(local_err);
+    /*
+     * We can deal with images that are too big.  We just need to
+     * clear the first sector.
+     */
+
+    bytes_to_clear =3D MIN(current_size, BDRV_SECTOR_SIZE) - offset;
+    if (bytes_to_clear) {
+        if (!(blk->root->perm & BLK_PERM_WRITE)) {
+            error_setg(errp, "Cannot clear first sector of new image: "
+                       "Write permission missing");
+            return -EPERM;
+        }
+
+        ret =3D blk_pwrite_zeroes(blk, offset, bytes_to_clear, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to clear the first sect=
or of "
+                             "the new image");
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static void blk_pdiscard_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
--=20
2.21.0


