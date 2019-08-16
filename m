Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B26BC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D138206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D138206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylWP-0005mi-HZ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPc-0006HZ-DW
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPa-0005lq-E8
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPX-0005gY-3a; Fri, 16 Aug 2019 19:13:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 551A53DFCD;
 Fri, 16 Aug 2019 23:13:30 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A173919C6A;
 Fri, 16 Aug 2019 23:13:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:12:51 -0400
Message-Id: <20190816231318.8650-10-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 16 Aug 2019 23:13:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/36] block/dirty-bitmap: add
 bdrv_dirty_bitmap_merge_internal
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm surprised it didn't come up sooner, but sometimes we have a +busy
bitmap as a source. This is dangerous from the QMP API, but if we are
the owner that marked the bitmap busy, it's safe to merge it using it as
a read only source.

It is not safe in the general case to allow users to read from in-use
bitmaps, so create an internal variant that foregoes the safety
checking.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190709232550.10724-10-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c      | 54 +++++++++++++++++++++++++++++++++++----
 include/block/block_int.h |  3 +++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 95a9c2a5d8a..7881fea684b 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -810,6 +810,12 @@ bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitm=
ap *bitmap,
     return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
 }
=20
+/**
+ * bdrv_merge_dirty_bitmap: merge src into dest.
+ * Ensures permissions on bitmaps are reasonable; use for public API.
+ *
+ * @backup: If provided, make a copy of dest here prior to merge.
+ */
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitma=
p *src,
                              HBitmap **backup, Error **errp)
 {
@@ -833,6 +839,42 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, =
const BdrvDirtyBitmap *src,
         goto out;
     }
=20
+    ret =3D bdrv_dirty_bitmap_merge_internal(dest, src, backup, false);
+    assert(ret);
+
+out:
+    qemu_mutex_unlock(dest->mutex);
+    if (src->mutex !=3D dest->mutex) {
+        qemu_mutex_unlock(src->mutex);
+    }
+}
+
+/**
+ * bdrv_dirty_bitmap_merge_internal: merge src into dest.
+ * Does NOT check bitmap permissions; not suitable for use as public API=
.
+ *
+ * @backup: If provided, make a copy of dest here prior to merge.
+ * @lock: If true, lock and unlock bitmaps on the way in/out.
+ * returns true if the merge succeeded; false if unattempted.
+ */
+bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
+                                      const BdrvDirtyBitmap *src,
+                                      HBitmap **backup,
+                                      bool lock)
+{
+    bool ret;
+
+    assert(!bdrv_dirty_bitmap_readonly(dest));
+    assert(!bdrv_dirty_bitmap_inconsistent(dest));
+    assert(!bdrv_dirty_bitmap_inconsistent(src));
+
+    if (lock) {
+        qemu_mutex_lock(dest->mutex);
+        if (src->mutex !=3D dest->mutex) {
+            qemu_mutex_lock(src->mutex);
+        }
+    }
+
     if (backup) {
         *backup =3D dest->bitmap;
         dest->bitmap =3D hbitmap_alloc(dest->size, hbitmap_granularity(*=
backup));
@@ -840,11 +882,13 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest,=
 const BdrvDirtyBitmap *src,
     } else {
         ret =3D hbitmap_merge(dest->bitmap, src->bitmap, dest->bitmap);
     }
-    assert(ret);
=20
-out:
-    qemu_mutex_unlock(dest->mutex);
-    if (src->mutex !=3D dest->mutex) {
-        qemu_mutex_unlock(src->mutex);
+    if (lock) {
+        qemu_mutex_unlock(dest->mutex);
+        if (src->mutex !=3D dest->mutex) {
+            qemu_mutex_unlock(src->mutex);
+        }
     }
+
+    return ret;
 }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 80953ac8aeb..aa697f1f694 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1253,6 +1253,9 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t o=
ffset, int64_t bytes);
=20
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
 void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)=
;
+bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
+                                      const BdrvDirtyBitmap *src,
+                                      HBitmap **backup, bool lock);
=20
 void bdrv_inc_in_flight(BlockDriverState *bs);
 void bdrv_dec_in_flight(BlockDriverState *bs);
--=20
2.21.0


