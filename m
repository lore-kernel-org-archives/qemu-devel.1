Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5098C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE522077A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THFhk/ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE522077A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfJ1-00053s-Nu
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jEfFj-000829-FV
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jEfFh-0004IJ-Ep
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jEfFh-0004H6-9c
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584563121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKtPjnOC+qmsf/rsTqO8bPpSqljWlxweNtsd9zZRPu4=;
 b=THFhk/ZKmwReXnMbnc6H/LzjuWmsjvaKEjBKoz007NzF2tR9Ye7lNJM9Ish5ePPCoiuKMW
 +boJuGIJRsdz947eE37FwkudjOL+uQLYvfxOoN62E9PWOuGrij+ea6V4tTmz5o+T0dix/I
 Dfc0x/NPABKsyU11TtXYqzNxVae5UzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-w0aq-q96PJGMIPQjWbo_Iw-1; Wed, 18 Mar 2020 16:25:19 -0400
X-MC-Unique: w0aq-q96PJGMIPQjWbo_Iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 353DF1016E7D;
 Wed, 18 Mar 2020 20:24:56 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EE7060BF1;
 Wed, 18 Mar 2020 20:24:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, jsnow@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 05/11] hbitmap: drop meta bitmaps as they are unused
Date: Wed, 18 Mar 2020 16:23:35 -0400
Message-Id: <20200318202341.6961-6-jsnow@redhat.com>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200205112041.6003-5-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/hbitmap.h |  21 --------
 tests/test-hbitmap.c   | 115 -----------------------------------------
 util/hbitmap.c         |  16 ------
 3 files changed, 152 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 15837a0e2d..df922d8517 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -325,27 +325,6 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t =
start, uint64_t count);
 bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *start,
                              uint64_t *count);
=20
-/* hbitmap_create_meta:
- * Create a "meta" hbitmap to track dirtiness of the bits in this HBitmap.
- * The caller owns the created bitmap and must call hbitmap_free_meta(hb) =
to
- * free it.
- *
- * Currently, we only guarantee that if a bit in the hbitmap is changed it
- * will be reflected in the meta bitmap, but we do not yet guarantee the
- * opposite.
- *
- * @hb: The HBitmap to operate on.
- * @chunk_size: How many bits in @hb does one bit in the meta track.
- */
-HBitmap *hbitmap_create_meta(HBitmap *hb, int chunk_size);
-
-/* hbitmap_free_meta:
- * Free the meta bitmap of @hb.
- *
- * @hb: The HBitmap whose meta bitmap should be freed.
- */
-void hbitmap_free_meta(HBitmap *hb);
-
 /**
  * hbitmap_iter_next:
  * @hbi: HBitmapIter to operate on.
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index e1f867085f..aeaa0b3f22 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -22,7 +22,6 @@
=20
 typedef struct TestHBitmapData {
     HBitmap       *hb;
-    HBitmap       *meta;
     unsigned long *bits;
     size_t         size;
     size_t         old_size;
@@ -94,14 +93,6 @@ static void hbitmap_test_init(TestHBitmapData *data,
     }
 }
=20
-static void hbitmap_test_init_meta(TestHBitmapData *data,
-                                   uint64_t size, int granularity,
-                                   int meta_chunk)
-{
-    hbitmap_test_init(data, size, granularity);
-    data->meta =3D hbitmap_create_meta(data->hb, meta_chunk);
-}
-
 static inline size_t hbitmap_test_array_size(size_t bits)
 {
     size_t n =3D DIV_ROUND_UP(bits, BITS_PER_LONG);
@@ -144,9 +135,6 @@ static void hbitmap_test_teardown(TestHBitmapData *data=
,
                                   const void *unused)
 {
     if (data->hb) {
-        if (data->meta) {
-            hbitmap_free_meta(data->hb);
-        }
         hbitmap_free(data->hb);
         data->hb =3D NULL;
     }
@@ -648,96 +636,6 @@ static void test_hbitmap_truncate_shrink_large(TestHBi=
tmapData *data,
     hbitmap_test_truncate(data, size, -diff, 0);
 }
=20
-static void hbitmap_check_meta(TestHBitmapData *data,
-                               int64_t start, int count)
-{
-    int64_t i;
-
-    for (i =3D 0; i < data->size; i++) {
-        if (i >=3D start && i < start + count) {
-            g_assert(hbitmap_get(data->meta, i));
-        } else {
-            g_assert(!hbitmap_get(data->meta, i));
-        }
-    }
-}
-
-static void hbitmap_test_meta(TestHBitmapData *data,
-                              int64_t start, int count,
-                              int64_t check_start, int check_count)
-{
-    hbitmap_reset_all(data->hb);
-    hbitmap_reset_all(data->meta);
-
-    /* Test "unset" -> "unset" will not update meta. */
-    hbitmap_reset(data->hb, start, count);
-    hbitmap_check_meta(data, 0, 0);
-
-    /* Test "unset" -> "set" will update meta */
-    hbitmap_set(data->hb, start, count);
-    hbitmap_check_meta(data, check_start, check_count);
-
-    /* Test "set" -> "set" will not update meta */
-    hbitmap_reset_all(data->meta);
-    hbitmap_set(data->hb, start, count);
-    hbitmap_check_meta(data, 0, 0);
-
-    /* Test "set" -> "unset" will update meta */
-    hbitmap_reset_all(data->meta);
-    hbitmap_reset(data->hb, start, count);
-    hbitmap_check_meta(data, check_start, check_count);
-}
-
-static void hbitmap_test_meta_do(TestHBitmapData *data, int chunk_size)
-{
-    uint64_t size =3D chunk_size * 100;
-    hbitmap_test_init_meta(data, size, 0, chunk_size);
-
-    hbitmap_test_meta(data, 0, 1, 0, chunk_size);
-    hbitmap_test_meta(data, 0, chunk_size, 0, chunk_size);
-    hbitmap_test_meta(data, chunk_size - 1, 1, 0, chunk_size);
-    hbitmap_test_meta(data, chunk_size - 1, 2, 0, chunk_size * 2);
-    hbitmap_test_meta(data, chunk_size - 1, chunk_size + 1, 0, chunk_size =
* 2);
-    hbitmap_test_meta(data, chunk_size - 1, chunk_size + 2, 0, chunk_size =
* 3);
-    hbitmap_test_meta(data, 7 * chunk_size - 1, chunk_size + 2,
-                      6 * chunk_size, chunk_size * 3);
-    hbitmap_test_meta(data, size - 1, 1, size - chunk_size, chunk_size);
-    hbitmap_test_meta(data, 0, size, 0, size);
-}
-
-static void test_hbitmap_meta_byte(TestHBitmapData *data, const void *unus=
ed)
-{
-    hbitmap_test_meta_do(data, BITS_PER_BYTE);
-}
-
-static void test_hbitmap_meta_word(TestHBitmapData *data, const void *unus=
ed)
-{
-    hbitmap_test_meta_do(data, BITS_PER_LONG);
-}
-
-static void test_hbitmap_meta_sector(TestHBitmapData *data, const void *un=
used)
-{
-    hbitmap_test_meta_do(data, BDRV_SECTOR_SIZE * BITS_PER_BYTE);
-}
-
-/**
- * Create an HBitmap and test set/unset.
- */
-static void test_hbitmap_meta_one(TestHBitmapData *data, const void *unuse=
d)
-{
-    int i;
-    int64_t offsets[] =3D {
-        0, 1, L1 - 1, L1, L1 + 1, L2 - 1, L2, L2 + 1, L3 - 1, L3, L3 + 1
-    };
-
-    hbitmap_test_init_meta(data, L3 * 2, 0, 1);
-    for (i =3D 0; i < ARRAY_SIZE(offsets); i++) {
-        hbitmap_test_meta(data, offsets[i], 1, offsets[i], 1);
-        hbitmap_test_meta(data, offsets[i], L1, offsets[i], L1);
-        hbitmap_test_meta(data, offsets[i], L2, offsets[i], L2);
-    }
-}
-
 static void test_hbitmap_serialize_align(TestHBitmapData *data,
                                          const void *unused)
 {
@@ -750,13 +648,6 @@ static void test_hbitmap_serialize_align(TestHBitmapDa=
ta *data,
     g_assert_cmpint(r, =3D=3D, 64 << 3);
 }
=20
-static void test_hbitmap_meta_zero(TestHBitmapData *data, const void *unus=
ed)
-{
-    hbitmap_test_init_meta(data, 0, 0, 1);
-
-    hbitmap_check_meta(data, 0, 0);
-}
-
 static void hbitmap_test_serialize_range(TestHBitmapData *data,
                                          uint8_t *buf, size_t buf_size,
                                          uint64_t pos, uint64_t count)
@@ -1165,12 +1056,6 @@ int main(int argc, char **argv)
     hbitmap_test_add("/hbitmap/truncate/shrink/large",
                      test_hbitmap_truncate_shrink_large);
=20
-    hbitmap_test_add("/hbitmap/meta/zero", test_hbitmap_meta_zero);
-    hbitmap_test_add("/hbitmap/meta/one", test_hbitmap_meta_one);
-    hbitmap_test_add("/hbitmap/meta/byte", test_hbitmap_meta_byte);
-    hbitmap_test_add("/hbitmap/meta/word", test_hbitmap_meta_word);
-    hbitmap_test_add("/hbitmap/meta/sector", test_hbitmap_meta_sector);
-
     hbitmap_test_add("/hbitmap/serialize/align",
                      test_hbitmap_serialize_align);
     hbitmap_test_add("/hbitmap/serialize/basic",
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 26145d4b9e..b6d4b99a06 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -905,22 +905,6 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b,=
 HBitmap *result)
     return true;
 }
=20
-HBitmap *hbitmap_create_meta(HBitmap *hb, int chunk_size)
-{
-    assert(!(chunk_size & (chunk_size - 1)));
-    assert(!hb->meta);
-    hb->meta =3D hbitmap_alloc(hb->size << hb->granularity,
-                             hb->granularity + ctz32(chunk_size));
-    return hb->meta;
-}
-
-void hbitmap_free_meta(HBitmap *hb)
-{
-    assert(hb->meta);
-    hbitmap_free(hb->meta);
-    hb->meta =3D NULL;
-}
-
 char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
 {
     size_t size =3D bitmap->sizes[HBITMAP_LEVELS - 1] * sizeof(unsigned lo=
ng);
--=20
2.21.1


