Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A75DC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FABF2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FABF2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdlnj-0002f8-G1
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 21:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hdle7-0002G1-0k
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hdlUr-0004rq-1T
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:04:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hdlUp-0004po-KV; Wed, 19 Jun 2019 21:04:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF99D81F1B;
 Thu, 20 Jun 2019 01:04:10 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B26161001E67;
 Thu, 20 Jun 2019 01:04:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 21:03:50 -0400
Message-Id: <20190620010356.19164-7-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-1-jsnow@redhat.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 01:04:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 06/12] block/dirty-bitmap: add
 bdrv_dirty_bitmap_claim
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
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function can claim an hbitmap to replace its own current hbitmap.
In the case that the granularities do not match, it will use
hbitmap_merge to copy the bit data instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/block_int.h |  1 +
 include/qemu/hbitmap.h    |  8 ++++++++
 block/dirty-bitmap.c      | 14 ++++++++++++++
 util/hbitmap.c            |  5 +++++
 4 files changed, 28 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 89370c1b9b..7348ea8e78 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1240,6 +1240,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t o=
ffset, int64_t bytes);
=20
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
 void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)=
;
+void bdrv_dirty_bitmap_claim(BdrvDirtyBitmap *bitmap, HBitmap **hbitmap)=
;
=20
 void bdrv_inc_in_flight(BlockDriverState *bs);
 void bdrv_dec_in_flight(BlockDriverState *bs);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 4afbe6292e..c74519042a 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -82,6 +82,14 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size);
  */
 bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result);
=20
+/**
+ * hbitmap_same_conf:
+ *
+ * Compares the configuration for HBitmaps A and B.
+ * Return true if they are identical, false otherwise.
+ */
+bool hbitmap_same_conf(const HBitmap *a, const HBitmap *b);
+
 /**
  * hbitmap_can_merge:
  *
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 95a9c2a5d8..15c857e445 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -632,6 +632,20 @@ void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitm=
ap, HBitmap *backup)
     hbitmap_free(tmp);
 }
=20
+/* claim ownership of an hbitmap */
+void bdrv_dirty_bitmap_claim(BdrvDirtyBitmap *bitmap, HBitmap **hbitmap)
+{
+    if (hbitmap_same_conf(bitmap->bitmap, *hbitmap)) {
+        bdrv_restore_dirty_bitmap(bitmap, *hbitmap);
+    } else {
+        assert(hbitmap_can_merge(bitmap->bitmap, *hbitmap));
+        bdrv_clear_dirty_bitmap(bitmap, NULL);
+        hbitmap_merge(bitmap->bitmap, *hbitmap, bitmap->bitmap);
+        hbitmap_free(*hbitmap);
+    }
+    *hbitmap =3D NULL;
+}
+
 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bit=
map,
                                               uint64_t offset, uint64_t =
bytes)
 {
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 0d6724b7bc..a2abd425b5 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -775,6 +775,11 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
     }
 }
=20
+bool hbitmap_same_conf(const HBitmap *a, const HBitmap *b)
+{
+    return (a->size =3D=3D b->size) && (a->granularity =3D=3D b->granula=
rity);
+}
+
 bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
 {
     return (a->size =3D=3D b->size);
--=20
2.21.0


