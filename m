Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC775C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64477206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alWU/Y2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64477206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE43D-000655-J9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE40E-0000te-5J
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE40C-00009x-BJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24509)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE40C-00008o-7L
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584419932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJmvqTqXqTMPCSVQr1qy1e1SoPh13NTfRknUTlZehjg=;
 b=alWU/Y2ysMsyDIrbYv/7uKw5LPe0fIU+byovrchXPsrKzKVRXofsuUFtb2VfAjf489V8bZ
 tXDknLYJOGslxPP0YjDpHGAKK+4NqGCY9OTNhljdyZaRJzpHzaewLOLUZvhqg76N+RXkig
 bqSOb5hXZJVHFkULGRuGrL7lprxUnq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-iuR7iVi1PLicUcRObluc-w-1; Tue, 17 Mar 2020 00:38:49 -0400
X-MC-Unique: iuR7iVi1PLicUcRObluc-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8727C1857BE5;
 Tue, 17 Mar 2020 04:38:48 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 911EB10016EB;
 Tue, 17 Mar 2020 04:38:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 jsnow@redhat.com
Subject: [PULL 07/10] block/dirty-bitmap: improve _next_dirty_area API
Date: Tue, 17 Mar 2020 00:38:16 -0400
Message-Id: <20200317043819.20197-8-jsnow@redhat.com>
In-Reply-To: <20200317043819.20197-1-jsnow@redhat.com>
References: <20200317043819.20197-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Firstly, _next_dirty_area is for scenarios when we may contiguously
search for next dirty area inside some limited region, so it is more
comfortable to specify "end" which should not be recalculated on each
iteration.

Secondly, let's add a possibility to limit resulting area size, not
limiting searching area. This will be used in NBD code in further
commit. (Note that now bdrv_dirty_bitmap_next_dirty_area is unused)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200205112041.6003-8-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h |  3 ++-
 include/qemu/hbitmap.h       | 23 ++++++++++--------
 block/dirty-bitmap.c         |  6 +++--
 tests/test-hbitmap.c         | 45 +++++++++++++++++++++++-------------
 util/hbitmap.c               | 44 +++++++++++++++++++++--------------
 5 files changed, 75 insertions(+), 46 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index b1f0de12db..8a10029418 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -110,7 +110,8 @@ int64_t bdrv_dirty_bitmap_next_dirty(BdrvDirtyBitmap *b=
itmap, int64_t offset,
 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, int64_t offse=
t,
                                     int64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
-                                       int64_t *offset, int64_t *bytes);
+        int64_t start, int64_t end, int64_t max_dirty_count,
+        int64_t *dirty_start, int64_t *dirty_count);
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
=20
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 6e9ae51ed3..5e71b6d6f7 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -324,18 +324,21 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t =
start, int64_t count);
=20
 /* hbitmap_next_dirty_area:
  * @hb: The HBitmap to operate on
- * @start: in-out parameter.
- *         in: the offset to start from
- *         out: (if area found) start of found area
- * @count: in-out parameter.
- *         in: length of requested region
- *         out: length of found area
+ * @start: the offset to start from
+ * @end: end of requested area
+ * @max_dirty_count: limit for out parameter dirty_count
+ * @dirty_start: on success: start of found area
+ * @dirty_count: on success: length of found area
  *
- * If dirty area found within [@start, @start + @count), returns true and =
sets
- * @offset and @bytes appropriately. Otherwise returns false and leaves @o=
ffset
- * and @bytes unchanged.
+ * If dirty area found within [@start, @end), returns true and sets
+ * @dirty_start and @dirty_count appropriately. @dirty_count will not exce=
ed
+ * @max_dirty_count.
+ * If dirty area was not found, returns false and leaves @dirty_start and
+ * @dirty_count unchanged.
  */
-bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *c=
ount);
+bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t start, int64_t end=
,
+                             int64_t max_dirty_count,
+                             int64_t *dirty_start, int64_t *dirty_count);
=20
 /**
  * hbitmap_iter_next:
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 1b14c8eb26..063793e316 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -873,9 +873,11 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *b=
itmap, int64_t offset,
 }
=20
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
-                                       int64_t *offset, int64_t *bytes)
+        int64_t start, int64_t end, int64_t max_dirty_count,
+        int64_t *dirty_start, int64_t *dirty_count)
 {
-    return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
+    return hbitmap_next_dirty_area(bitmap->bitmap, start, end, max_dirty_c=
ount,
+                                   dirty_start, dirty_count);
 }
=20
 /**
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 8905b8a351..b6726cf76b 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -920,18 +920,19 @@ static void test_hbitmap_next_x_after_truncate(TestHB=
itmapData *data,
     test_hbitmap_next_x_check(data, 0);
 }
=20
-static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
-                                               int64_t offset,
-                                               int64_t count)
+static void test_hbitmap_next_dirty_area_check_limited(TestHBitmapData *da=
ta,
+                                                       int64_t offset,
+                                                       int64_t count,
+                                                       int64_t max_dirty)
 {
     int64_t off1, off2;
     int64_t len1 =3D 0, len2;
     bool ret1, ret2;
     int64_t end;
=20
-    off1 =3D offset;
-    len1 =3D count;
-    ret1 =3D hbitmap_next_dirty_area(data->hb, &off1, &len1);
+    ret1 =3D hbitmap_next_dirty_area(data->hb,
+            offset, count =3D=3D INT64_MAX ? INT64_MAX : offset + count, m=
ax_dirty,
+            &off1, &len1);
=20
     end =3D offset > data->size || data->size - offset < count ? data->siz=
e :
                                                                offset + co=
unt;
@@ -940,21 +941,25 @@ static void test_hbitmap_next_dirty_area_check(TestHB=
itmapData *data,
         ;
     }
=20
-    for (len2 =3D 1; off2 + len2 < end && hbitmap_get(data->hb, off2 + len=
2);
-         len2++) {
+    for (len2 =3D 1; (off2 + len2 < end && len2 < max_dirty &&
+                    hbitmap_get(data->hb, off2 + len2)); len2++)
+    {
         ;
     }
=20
     ret2 =3D off2 < end;
-    if (!ret2) {
-        /* leave unchanged */
-        off2 =3D offset;
-        len2 =3D count;
-    }
-
     g_assert_cmpint(ret1, =3D=3D, ret2);
-    g_assert_cmpint(off1, =3D=3D, off2);
-    g_assert_cmpint(len1, =3D=3D, len2);
+
+    if (ret2) {
+        g_assert_cmpint(off1, =3D=3D, off2);
+        g_assert_cmpint(len1, =3D=3D, len2);
+    }
+}
+
+static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
+                                               int64_t offset, int64_t cou=
nt)
+{
+    test_hbitmap_next_dirty_area_check_limited(data, offset, count, INT64_=
MAX);
 }
=20
 static void test_hbitmap_next_dirty_area_do(TestHBitmapData *data,
@@ -964,6 +969,7 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmap=
Data *data,
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, 0, 1);
     test_hbitmap_next_dirty_area_check(data, L3 - 1, 1);
+    test_hbitmap_next_dirty_area_check_limited(data, 0, INT64_MAX, 1);
=20
     hbitmap_set(data->hb, L2, 1);
     test_hbitmap_next_dirty_area_check(data, 0, 1);
@@ -976,6 +982,8 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmap=
Data *data,
     test_hbitmap_next_dirty_area_check(data, L2, INT64_MAX);
     test_hbitmap_next_dirty_area_check(data, L2, 1);
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 1);
+    test_hbitmap_next_dirty_area_check_limited(data, 0, INT64_MAX, 1);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 - 1, 2, 1);
=20
     hbitmap_set(data->hb, L2 + 5, L1);
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
@@ -988,6 +996,8 @@ static void test_hbitmap_next_dirty_area_do(TestHBitmap=
Data *data,
     test_hbitmap_next_dirty_area_check(data, L2 + L1, L1);
     test_hbitmap_next_dirty_area_check(data, L2, 0);
     test_hbitmap_next_dirty_area_check(data, L2 + 1, 0);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 + 3, INT64_MAX, 3)=
;
+    test_hbitmap_next_dirty_area_check_limited(data, L2 + 3, 7, 10);
=20
     hbitmap_set(data->hb, L2 * 2, L3 - L2 * 2);
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
@@ -997,6 +1007,9 @@ static void test_hbitmap_next_dirty_area_do(TestHBitma=
pData *data,
     test_hbitmap_next_dirty_area_check(data, L2 + 5 + L1, 5);
     test_hbitmap_next_dirty_area_check(data, L2 * 2 - L1, L1 + 1);
     test_hbitmap_next_dirty_area_check(data, L2 * 2, L2);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 * 2 + 1, INT64_MAX=
, 5);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 * 2 + 1, 10, 5);
+    test_hbitmap_next_dirty_area_check_limited(data, L2 * 2 + 1, 2, 5);
=20
     hbitmap_set(data->hb, 0, L3);
     test_hbitmap_next_dirty_area_check(data, 0, INT64_MAX);
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 883ca48fa6..305b894a63 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -270,22 +270,33 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_t =
start, int64_t count)
     return res;
 }
=20
-bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t *c=
ount)
+bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t start, int64_t end=
,
+                             int64_t max_dirty_count,
+                             int64_t *dirty_start, int64_t *dirty_count)
 {
-    int64_t area_start, area_end;
+    int64_t next_zero;
=20
-    area_start =3D hbitmap_next_dirty(hb, *start, *count);
-    if (area_start < 0) {
+    assert(start >=3D 0 && end >=3D 0 && max_dirty_count > 0);
+
+    end =3D MIN(end, hb->orig_size);
+    if (start >=3D end) {
         return false;
     }
=20
-    area_end =3D hbitmap_next_zero(hb, area_start, *start + *count - area_=
start);
-    if (area_end < 0) {
-        area_end =3D MIN(hb->orig_size, *start + *count);
+    start =3D hbitmap_next_dirty(hb, start, end - start);
+    if (start < 0) {
+        return false;
+    }
+
+    end =3D start + MIN(end - start, max_dirty_count);
+
+    next_zero =3D hbitmap_next_zero(hb, start, end - start);
+    if (next_zero >=3D 0) {
+        end =3D next_zero;
     }
=20
-    *start =3D area_start;
-    *count =3D area_end - area_start;
+    *dirty_start =3D start;
+    *dirty_count =3D end - start;
=20
     return true;
 }
@@ -841,16 +852,15 @@ bool hbitmap_can_merge(const HBitmap *a, const HBitma=
p *b)
  */
 static void hbitmap_sparse_merge(HBitmap *dst, const HBitmap *src)
 {
-    int64_t offset =3D 0;
-    int64_t count =3D src->orig_size;
+    int64_t offset;
+    int64_t count;
=20
-    while (hbitmap_next_dirty_area(src, &offset, &count)) {
+    for (offset =3D 0;
+         hbitmap_next_dirty_area(src, offset, src->orig_size, INT64_MAX,
+                                 &offset, &count);
+         offset +=3D count)
+    {
         hbitmap_set(dst, offset, count);
-        offset +=3D count;
-        if (offset >=3D src->orig_size) {
-            break;
-        }
-        count =3D src->orig_size - offset;
     }
 }
=20
--=20
2.21.1


