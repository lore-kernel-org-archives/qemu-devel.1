Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C855C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700BE208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700BE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlfDr-0006iy-Bh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlfDP-0005Zp-CB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlfDC-00010B-Uv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlfCt-0000mk-EJ; Thu, 11 Jul 2019 15:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C5E3308213A;
 Thu, 11 Jul 2019 19:58:18 +0000 (UTC)
Received: from localhost (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 928F360BE2;
 Thu, 11 Jul 2019 19:58:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 11 Jul 2019 21:58:01 +0200
Message-Id: <20190711195804.30703-3-mreitz@redhat.com>
In-Reply-To: <20190711195804.30703-1-mreitz@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 19:58:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 2/5] block: Generic truncation fallback
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a protocol driver does not support truncation, we call fall back to
effectively not doing anything if the new size is less than the actual
file size.  This is what we have been doing for some host device drivers
already.

The only caveat is that we have to zero out everything in the first
sector that lies beyond the new "EOF" so we do not get any surprises
with format probing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 24a18759fd..382728fa9a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3064,6 +3064,57 @@ static void bdrv_parent_cb_resize(BlockDriverState=
 *bs)
     }
 }
=20
+static int coroutine_fn bdrv_co_truncate_fallback(BdrvChild *child,
+                                                  int64_t offset,
+                                                  PreallocMode prealloc,
+                                                  Error **errp)
+{
+    BlockDriverState *bs =3D child->bs;
+    int64_t cur_size =3D bdrv_getlength(bs);
+
+    if (cur_size < 0) {
+        error_setg_errno(errp, -cur_size,
+                         "Failed to inquire current file size");
+        return cur_size;
+    }
+
+    if (prealloc !=3D PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_str(prealloc));
+        return -ENOTSUP;
+    }
+
+    if (offset > cur_size) {
+        error_setg(errp, "Cannot grow this %s node", bs->drv->format_nam=
e);
+        return -ENOTSUP;
+    }
+
+    /*
+     * Overwrite first "post-EOF" parts of the first sector with
+     * zeroes so raw images will not be misprobed
+     */
+    if (offset < BDRV_SECTOR_SIZE && offset < cur_size) {
+        int64_t fill_len =3D MIN(BDRV_SECTOR_SIZE - offset, cur_size - o=
ffset);
+        int ret;
+
+        if (!(child->perm & BLK_PERM_WRITE)) {
+            error_setg(errp, "Cannot write to this node to clear the fil=
e past "
+                       "the truncated EOF");
+            return -EPERM;
+        }
+
+        ret =3D bdrv_co_pwrite_zeroes(child, offset, fill_len, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to clear file past the truncated EO=
F");
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+
 /**
  * Truncate file to 'offset' bytes (needed only for file protocols)
  */
@@ -3074,6 +3125,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child,=
 int64_t offset,
     BlockDriver *drv =3D bs->drv;
     BdrvTrackedRequest req;
     int64_t old_size, new_bytes;
+    Error *local_err =3D NULL;
     int ret;
=20
=20
@@ -3127,15 +3179,24 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *chil=
d, int64_t offset,
             ret =3D bdrv_co_truncate(bs->file, offset, prealloc, errp);
             goto out;
         }
-        error_setg(errp, "Image format driver does not support resize");
+        error_setg(&local_err, "Image format driver does not support res=
ize");
         ret =3D -ENOTSUP;
-        goto out;
+    } else {
+        ret =3D drv->bdrv_co_truncate(bs, offset, prealloc, &local_err);
     }
=20
-    ret =3D drv->bdrv_co_truncate(bs, offset, prealloc, errp);
-    if (ret < 0) {
+    if (ret =3D=3D -ENOTSUP && drv->bdrv_file_open) {
+        error_free(local_err);
+
+        ret =3D bdrv_co_truncate_fallback(child, offset, prealloc, errp)=
;
+        if (ret < 0) {
+            goto out;
+        }
+    } else if (ret < 0) {
+        error_propagate(errp, local_err);
         goto out;
     }
+
     ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector cou=
nt");
--=20
2.21.0


