Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CAC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9992077A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJfUG1bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9992077A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfI8-0003nQ-LZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jEfFo-00088O-1i
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jEfFk-0004Rb-Fm
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jEfFk-0004QY-9P
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584563123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LncJ/BC9kCGucJRhLcuktA7p5kTX1f+tStirinx1uFo=;
 b=RJfUG1bV+0YyT0r0pZy0Q9IvWC+bEohYeKdSKOruvFd0jVtM52x9APuhXXjp3MIi3W6/ZM
 /G4S4lDqLs/l105yBvaGf+UsVn6uqdtRj2Zm+RArRG3Vswz4Pqub8W5+HQotLyp3LNrCVC
 x9euvC1xhT7QwcSi/KA/ddqq0g0O+8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-2c0dYcEkN6O5HAZbxzHilA-1; Wed, 18 Mar 2020 16:25:19 -0400
X-MC-Unique: 2c0dYcEkN6O5HAZbxzHilA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86EA8100726A;
 Wed, 18 Mar 2020 20:25:07 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C289F60BF1;
 Wed, 18 Mar 2020 20:25:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, jsnow@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 07/11] block/dirty-bitmap: add _next_dirty API
Date: Wed, 18 Mar 2020 16:23:37 -0400
Message-Id: <20200318202341.6961-8-jsnow@redhat.com>
In-Reply-To: <20200318202341.6961-1-jsnow@redhat.com>
References: <20200318202341.6961-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We have bdrv_dirty_bitmap_next_zero, let's add corresponding
bdrv_dirty_bitmap_next_dirty, which is more comfortable to use than
bitmap iterators in some cases.

For test modify test_hbitmap_next_zero_check_range to check both
next_zero and next_dirty and add some new checks.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200205112041.6003-7-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h |   2 +
 include/qemu/hbitmap.h       |  13 ++++
 block/dirty-bitmap.c         |   6 ++
 tests/test-hbitmap.c         | 130 ++++++++++++++++++++---------------
 util/hbitmap.c               |  60 ++++++++--------
 5 files changed, 126 insertions(+), 85 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 27c72cc56a..b1f0de12db 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -105,6 +105,8 @@ for (bitmap =3D bdrv_dirty_bitmap_first(bs); bitmap; \
      bitmap =3D bdrv_dirty_bitmap_next(bitmap))
=20
 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp=
);
+int64_t bdrv_dirty_bitmap_next_dirty(BdrvDirtyBitmap *bitmap, int64_t offs=
et,
+                                     int64_t bytes);
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offse=
t,
                                     int64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index b6e85f3d5d..6e9ae51ed3 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -297,6 +297,19 @@ void hbitmap_free(HBitmap *hb);
  */
 void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first=
);
=20
+/*
+ * hbitmap_next_dirty:
+ *
+ * Find next dirty bit within selected range. If not found, return -1.
+ *
+ * @hb: The HBitmap to operate on
+ * @start: The bit to start from.
+ * @count: Number of bits to proceed. If @start+@count > bitmap size, the =
whole
+ * bitmap is looked through. You can use INT64_MAX as @count to search up =
to
+ * the bitmap end.
+ */
+int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t count=
);
+
 /* hbitmap_next_zero:
  *
  * Find next not dirty bit within selected range. If not found, return -1.
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index af9f5411a6..1b14c8eb26 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -860,6 +860,12 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *=
bitmap, Error **errp)
     return hbitmap_sha256(bitmap->bitmap, errp);
 }
=20
+int64_t bdrv_dirty_bitmap_next_dirty(BdrvDirtyBitmap *bitmap, int64_t offs=
et,
+                                     int64_t bytes)
+{
+    return hbitmap_next_dirty(bitmap->bitmap, offset, bytes);
+}
+
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offse=
t,
                                     int64_t bytes)
 {
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 9d210dc18c..8905b8a351 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -816,92 +816,108 @@ static void test_hbitmap_iter_and_reset(TestHBitmapD=
ata *data,
     hbitmap_iter_next(&hbi);
 }
=20
-static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
-                                               int64_t start,
-                                               int64_t count)
+static void test_hbitmap_next_x_check_range(TestHBitmapData *data,
+                                            int64_t start,
+                                            int64_t count)
 {
-    int64_t ret1 =3D hbitmap_next_zero(data->hb, start, count);
-    int64_t ret2 =3D start;
+    int64_t next_zero =3D hbitmap_next_zero(data->hb, start, count);
+    int64_t next_dirty =3D hbitmap_next_dirty(data->hb, start, count);
+    int64_t next;
     int64_t end =3D start >=3D data->size || data->size - start < count ?
                 data->size : start + count;
+    bool first_bit =3D hbitmap_get(data->hb, start);
=20
-    for ( ; ret2 < end && hbitmap_get(data->hb, ret2); ret2++) {
+    for (next =3D start;
+         next < end && hbitmap_get(data->hb, next) =3D=3D first_bit;
+         next++)
+    {
         ;
     }
-    if (ret2 =3D=3D end) {
-        ret2 =3D -1;
+
+    if (next =3D=3D end) {
+        next =3D -1;
     }
=20
-    g_assert_cmpint(ret1, =3D=3D, ret2);
+    g_assert_cmpint(next_dirty, =3D=3D, first_bit ? start : next);
+    g_assert_cmpint(next_zero, =3D=3D, first_bit ? next : start);
 }
=20
-static void test_hbitmap_next_zero_check(TestHBitmapData *data, int64_t st=
art)
+static void test_hbitmap_next_x_check(TestHBitmapData *data, int64_t start=
)
 {
-    test_hbitmap_next_zero_check_range(data, start, INT64_MAX);
+    test_hbitmap_next_x_check_range(data, start, INT64_MAX);
 }
=20
-static void test_hbitmap_next_zero_do(TestHBitmapData *data, int granulari=
ty)
+static void test_hbitmap_next_x_do(TestHBitmapData *data, int granularity)
 {
     hbitmap_test_init(data, L3, granularity);
-    test_hbitmap_next_zero_check(data, 0);
-    test_hbitmap_next_zero_check(data, L3 - 1);
-    test_hbitmap_next_zero_check_range(data, 0, 1);
-    test_hbitmap_next_zero_check_range(data, L3 - 1, 1);
+    test_hbitmap_next_x_check(data, 0);
+    test_hbitmap_next_x_check(data, L3 - 1);
+    test_hbitmap_next_x_check_range(data, 0, 1);
+    test_hbitmap_next_x_check_range(data, L3 - 1, 1);
=20
     hbitmap_set(data->hb, L2, 1);
-    test_hbitmap_next_zero_check(data, 0);
-    test_hbitmap_next_zero_check(data, L2 - 1);
-    test_hbitmap_next_zero_check(data, L2);
-    test_hbitmap_next_zero_check(data, L2 + 1);
-    test_hbitmap_next_zero_check_range(data, 0, 1);
-    test_hbitmap_next_zero_check_range(data, 0, L2);
-    test_hbitmap_next_zero_check_range(data, L2 - 1, 1);
-    test_hbitmap_next_zero_check_range(data, L2 - 1, 2);
-    test_hbitmap_next_zero_check_range(data, L2, 1);
-    test_hbitmap_next_zero_check_range(data, L2 + 1, 1);
+    test_hbitmap_next_x_check(data, 0);
+    test_hbitmap_next_x_check(data, L2 - 1);
+    test_hbitmap_next_x_check(data, L2);
+    test_hbitmap_next_x_check(data, L2 + 1);
+    test_hbitmap_next_x_check_range(data, 0, 1);
+    test_hbitmap_next_x_check_range(data, 0, L2);
+    test_hbitmap_next_x_check_range(data, L2 - 1, 1);
+    test_hbitmap_next_x_check_range(data, L2 - 1, 2);
+    test_hbitmap_next_x_check_range(data, L2, 1);
+    test_hbitmap_next_x_check_range(data, L2 + 1, 1);
=20
     hbitmap_set(data->hb, L2 + 5, L1);
-    test_hbitmap_next_zero_check(data, 0);
-    test_hbitmap_next_zero_check(data, L2 + 1);
-    test_hbitmap_next_zero_check(data, L2 + 2);
-    test_hbitmap_next_zero_check(data, L2 + 5);
-    test_hbitmap_next_zero_check(data, L2 + L1 - 1);
-    test_hbitmap_next_zero_check(data, L2 + L1);
-    test_hbitmap_next_zero_check_range(data, L2, 6);
-    test_hbitmap_next_zero_check_range(data, L2 + 1, 3);
-    test_hbitmap_next_zero_check_range(data, L2 + 4, L1);
-    test_hbitmap_next_zero_check_range(data, L2 + 5, L1);
+    test_hbitmap_next_x_check(data, 0);
+    test_hbitmap_next_x_check(data, L2 - L1);
+    test_hbitmap_next_x_check(data, L2 + 1);
+    test_hbitmap_next_x_check(data, L2 + 2);
+    test_hbitmap_next_x_check(data, L2 + 5);
+    test_hbitmap_next_x_check(data, L2 + L1 - 1);
+    test_hbitmap_next_x_check(data, L2 + L1);
+    test_hbitmap_next_x_check(data, L2 + L1 + 1);
+    test_hbitmap_next_x_check_range(data, L2 - 2, L1);
+    test_hbitmap_next_x_check_range(data, L2, 4);
+    test_hbitmap_next_x_check_range(data, L2, 6);
+    test_hbitmap_next_x_check_range(data, L2 + 1, 3);
+    test_hbitmap_next_x_check_range(data, L2 + 4, L1);
+    test_hbitmap_next_x_check_range(data, L2 + 5, L1);
+    test_hbitmap_next_x_check_range(data, L2 + 5 + L1 - 1, 1);
+    test_hbitmap_next_x_check_range(data, L2 + 5 + L1, 1);
+    test_hbitmap_next_x_check_range(data, L2 + 5 + L1 + 1, 1);
=20
     hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
-    test_hbitmap_next_zero_check(data, L2 * 2 - L1);
-    test_hbitmap_next_zero_check(data, L2 * 2 - 2);
-    test_hbitmap_next_zero_check(data, L2 * 2 - 1);
-    test_hbitmap_next_zero_check(data, L2 * 2);
-    test_hbitmap_next_zero_check(data, L3 - 1);
-    test_hbitmap_next_zero_check_range(data, L2 * 2 - L1, L1 + 1);
-    test_hbitmap_next_zero_check_range(data, L2 * 2, L2);
+    test_hbitmap_next_x_check(data, L2 * 2 - L1);
+    test_hbitmap_next_x_check(data, L2 * 2 - 2);
+    test_hbitmap_next_x_check(data, L2 * 2 - 1);
+    test_hbitmap_next_x_check(data, L2 * 2);
+    test_hbitmap_next_x_check(data, L2 * 2 + 1);
+    test_hbitmap_next_x_check(data, L2 * 2 + L1);
+    test_hbitmap_next_x_check(data, L3 - 1);
+    test_hbitmap_next_x_check_range(data, L2 * 2 - L1, L1 + 1);
+    test_hbitmap_next_x_check_range(data, L2 * 2, L2);
=20
     hbitmap_set(data->hb, 0, L3);
-    test_hbitmap_next_zero_check(data, 0);
+    test_hbitmap_next_x_check(data, 0);
 }
=20
-static void test_hbitmap_next_zero_0(TestHBitmapData *data, const void *un=
used)
+static void test_hbitmap_next_x_0(TestHBitmapData *data, const void *unuse=
d)
 {
-    test_hbitmap_next_zero_do(data, 0);
+    test_hbitmap_next_x_do(data, 0);
 }
=20
-static void test_hbitmap_next_zero_4(TestHBitmapData *data, const void *un=
used)
+static void test_hbitmap_next_x_4(TestHBitmapData *data, const void *unuse=
d)
 {
-    test_hbitmap_next_zero_do(data, 4);
+    test_hbitmap_next_x_do(data, 4);
 }
=20
-static void test_hbitmap_next_zero_after_truncate(TestHBitmapData *data,
-                                                  const void *unused)
+static void test_hbitmap_next_x_after_truncate(TestHBitmapData *data,
+                                               const void *unused)
 {
     hbitmap_test_init(data, L1, 0);
     hbitmap_test_truncate_impl(data, L1 * 2);
     hbitmap_set(data->hb, 0, L1);
-    test_hbitmap_next_zero_check(data, 0);
+    test_hbitmap_next_x_check(data, 0);
 }
=20
 static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
@@ -1068,12 +1084,12 @@ int main(int argc, char **argv)
     hbitmap_test_add("/hbitmap/iter/iter_and_reset",
                      test_hbitmap_iter_and_reset);
=20
-    hbitmap_test_add("/hbitmap/next_zero/next_zero_0",
-                     test_hbitmap_next_zero_0);
-    hbitmap_test_add("/hbitmap/next_zero/next_zero_4",
-                     test_hbitmap_next_zero_4);
-    hbitmap_test_add("/hbitmap/next_zero/next_zero_after_truncate",
-                     test_hbitmap_next_zero_after_truncate);
+    hbitmap_test_add("/hbitmap/next_zero/next_x_0",
+                     test_hbitmap_next_x_0);
+    hbitmap_test_add("/hbitmap/next_zero/next_x_4",
+                     test_hbitmap_next_x_4);
+    hbitmap_test_add("/hbitmap/next_zero/next_x_after_truncate",
+                     test_hbitmap_next_x_after_truncate);
=20
     hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_0",
                      test_hbitmap_next_dirty_area_0);
diff --git a/util/hbitmap.c b/util/hbitmap.c
index df22f06be6..883ca48fa6 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -193,6 +193,30 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap=
 *hb, uint64_t first)
     }
 }
=20
+int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t count=
)
+{
+    HBitmapIter hbi;
+    int64_t first_dirty_off;
+    uint64_t end;
+
+    assert(start >=3D 0 && count >=3D 0);
+
+    if (start >=3D hb->orig_size || count =3D=3D 0) {
+        return -1;
+    }
+
+    end =3D count > hb->orig_size - start ? hb->orig_size : start + count;
+
+    hbitmap_iter_init(&hbi, hb, start);
+    first_dirty_off =3D hbitmap_iter_next(&hbi);
+
+    if (first_dirty_off < 0 || first_dirty_off >=3D end) {
+        return -1;
+    }
+
+    return MAX(start, first_dirty_off);
+}
+
 int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t count)
 {
     size_t pos =3D (start >> hb->granularity) >> BITS_PER_LEVEL;
@@ -248,40 +272,20 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t =
start, int64_t count)
=20
 bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *c=
ount)
 {
-    HBitmapIter hbi;
-    int64_t firt_dirty_off, area_end;
-    uint32_t granularity =3D 1UL << hb->granularity;
-    uint64_t end;
+    int64_t area_start, area_end;
=20
-    assert(*start >=3D 0 && *count >=3D 0);
-
-    if (*start >=3D hb->orig_size || *count =3D=3D 0) {
+    area_start =3D hbitmap_next_dirty(hb, *start, *count);
+    if (area_start < 0) {
         return false;
     }
=20
-    end =3D *count > hb->orig_size - *start ? hb->orig_size : *start + *co=
unt;
-
-    hbitmap_iter_init(&hbi, hb, *start);
-    firt_dirty_off =3D hbitmap_iter_next(&hbi);
-
-    if (firt_dirty_off < 0 || firt_dirty_off >=3D end) {
-        return false;
+    area_end =3D hbitmap_next_zero(hb, area_start, *start + *count - area_=
start);
+    if (area_end < 0) {
+        area_end =3D MIN(hb->orig_size, *start + *count);
     }
=20
-    if (firt_dirty_off + granularity >=3D end) {
-        area_end =3D end;
-    } else {
-        area_end =3D hbitmap_next_zero(hb, firt_dirty_off + granularity,
-                                     end - firt_dirty_off - granularity);
-        if (area_end < 0) {
-            area_end =3D end;
-        }
-    }
-
-    if (firt_dirty_off > *start) {
-        *start =3D firt_dirty_off;
-    }
-    *count =3D area_end - *start;
+    *start =3D area_start;
+    *count =3D area_end - area_start;
=20
     return true;
 }
--=20
2.21.1


