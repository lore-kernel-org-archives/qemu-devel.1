Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFFC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7244C2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7244C2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdlqW-0004wr-NK
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 21:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40681)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hdle7-0002Dv-8O
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hdlUp-0004qK-M3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hdlUo-0004oJ-Av; Wed, 19 Jun 2019 21:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FB5930C31B4;
 Thu, 20 Jun 2019 01:04:09 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CD21001E67;
 Thu, 20 Jun 2019 01:04:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 21:03:49 -0400
Message-Id: <20190620010356.19164-6-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-1-jsnow@redhat.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 20 Jun 2019 01:04:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 05/12] hbitmap: enable merging across
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 util/hbitmap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 45d1725daf..0d6724b7bc 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -777,7 +777,17 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
=20
 bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
 {
-    return (a->size =3D=3D b->size) && (a->granularity =3D=3D b->granula=
rity);
+    return (a->size =3D=3D b->size);
+}
+
+static void hbitmap_sparse_merge(HBitmap *dst, const HBitmap *src)
+{
+    uint64_t offset =3D 0;
+    uint64_t count =3D src->orig_size;
+
+    while (hbitmap_next_dirty_area(src, &offset, &count)) {
+        hbitmap_set(dst, offset, count);
+    }
 }
=20
 /**
@@ -804,6 +814,16 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *=
b, HBitmap *result)
         return true;
     }
=20
+    if (a->size !=3D b->size) {
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
--=20
2.21.0


