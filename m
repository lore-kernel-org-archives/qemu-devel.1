Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89649C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4DB218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4DB218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2Sc-00046Y-Vb
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iJ2QI-00027Y-My
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iJ2QH-0000zA-67
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iJ2QE-0000yB-Ih; Fri, 11 Oct 2019 17:26:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B302D5AFDE;
 Fri, 11 Oct 2019 21:26:01 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 541561EC;
 Fri, 11 Oct 2019 21:26:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 01/19] util/hbitmap: strict hbitmap_reset
Date: Fri, 11 Oct 2019 17:25:32 -0400
Message-Id: <20191011212550.27269-2-jsnow@redhat.com>
In-Reply-To: <20191011212550.27269-1-jsnow@redhat.com>
References: <20191011212550.27269-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 11 Oct 2019 21:26:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

hbitmap_reset has an unobvious property: it rounds requested region up.
It may provoke bugs, like in recently fixed write-blocking mode of
mirror: user calls reset on unaligned region, not keeping in mind that
there are possible unrelated dirty bytes, covered by rounded-up region
and information of this unrelated "dirtiness" will be lost.

Make hbitmap_reset strict: assert that arguments are aligned, allowing
only one exception when @start + @count =3D=3D hb->orig_size. It's needed
to comfort users of hbitmap_next_dirty_area, which cares about
hb->orig_size.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20190806152611.280389-1-vsementsov@virtuozzo.com>
[Maintainer edit: Max's suggestions from on-list. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/hbitmap.h | 5 +++++
 tests/test-hbitmap.c   | 2 +-
 util/hbitmap.c         | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 4afbe6292e3..1bf944ca3d1 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -132,6 +132,11 @@ void hbitmap_set(HBitmap *hb, uint64_t start, uint64=
_t count);
  * @count: Number of bits to reset.
  *
  * Reset a consecutive range of bits in an HBitmap.
+ * @start and @count must be aligned to bitmap granularity. The only exc=
eption
+ * is resetting the tail of the bitmap: @count may be equal to hb->orig_=
size -
+ * @start, in this case @count may be not aligned. The sum of @start + @=
count is
+ * allowed to be greater than hb->orig_size, but only if @start < hb->or=
ig_size
+ * and @start + @count =3D ALIGN_UP(hb->orig_size, granularity).
  */
 void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count);
=20
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index eed5d288cbc..e1f867085f4 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -423,7 +423,7 @@ static void test_hbitmap_granularity(TestHBitmapData =
*data,
     hbitmap_test_check(data, 0);
     hbitmap_test_set(data, 0, 3);
     g_assert_cmpint(hbitmap_count(data->hb), =3D=3D, 4);
-    hbitmap_test_reset(data, 0, 1);
+    hbitmap_test_reset(data, 0, 2);
     g_assert_cmpint(hbitmap_count(data->hb), =3D=3D, 2);
 }
=20
diff --git a/util/hbitmap.c b/util/hbitmap.c
index fd44c897ab0..757d39e360a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -476,6 +476,10 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, uint=
64_t count)
     /* Compute range in the last layer.  */
     uint64_t first;
     uint64_t last =3D start + count - 1;
+    uint64_t gran =3D 1ULL << hb->granularity;
+
+    assert(!(start & (gran - 1)));
+    assert(!(count & (gran - 1)) || (start + count =3D=3D hb->orig_size)=
);
=20
     trace_hbitmap_reset(hb, start, count,
                         start >> hb->granularity, last >> hb->granularit=
y);
--=20
2.21.0


