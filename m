Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B330EC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8751E206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8751E206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylS1-0000lM-3U
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPa-0006Df-24
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPY-0005jd-RV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPW-0005fu-6C; Fri, 16 Aug 2019 19:13:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8009D30A5686;
 Fri, 16 Aug 2019 23:13:29 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9E7719C6A;
 Fri, 16 Aug 2019 23:13:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:12:50 -0400
Message-Id: <20190816231318.8650-9-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 16 Aug 2019 23:13:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/36] hbitmap: enable merging across
 granularities
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

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190709232550.10724-9-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 util/hbitmap.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 83927f3c08a..fd44c897ab0 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -781,7 +781,27 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
=20
 bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
 {
-    return (a->size =3D=3D b->size) && (a->granularity =3D=3D b->granula=
rity);
+    return (a->orig_size =3D=3D b->orig_size);
+}
+
+/**
+ * hbitmap_sparse_merge: performs dst =3D dst | src
+ * works with differing granularities.
+ * best used when src is sparsely populated.
+ */
+static void hbitmap_sparse_merge(HBitmap *dst, const HBitmap *src)
+{
+    uint64_t offset =3D 0;
+    uint64_t count =3D src->orig_size;
+
+    while (hbitmap_next_dirty_area(src, &offset, &count)) {
+        hbitmap_set(dst, offset, count);
+        offset +=3D count;
+        if (offset >=3D src->orig_size) {
+            break;
+        }
+        count =3D src->orig_size - offset;
+    }
 }
=20
 /**
@@ -812,10 +832,24 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap =
*b, HBitmap *result)
         return true;
     }
=20
+    if (a->granularity !=3D b->granularity) {
+        if ((a !=3D result) && (b !=3D result)) {
+            hbitmap_reset_all(result);
+        }
+        if (a !=3D result) {
+            hbitmap_sparse_merge(result, a);
+        }
+        if (b !=3D result) {
+            hbitmap_sparse_merge(result, b);
+        }
+        return true;
+    }
+
     /* This merge is O(size), as BITS_PER_LONG and HBITMAP_LEVELS are co=
nstant.
      * It may be possible to improve running times for sparsely populate=
d maps
      * by using hbitmap_iter_next, but this is suboptimal for dense maps=
.
      */
+    assert(a->size =3D=3D b->size);
     for (i =3D HBITMAP_LEVELS - 1; i >=3D 0; i--) {
         for (j =3D 0; j < a->sizes[i]; j++) {
             result->levels[i][j] =3D a->levels[i][j] | b->levels[i][j];
--=20
2.21.0


