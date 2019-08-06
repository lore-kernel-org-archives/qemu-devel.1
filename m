Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222AEC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A972070D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A972070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1OW-0006s6-6x
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hv1Lx-0002hl-DO
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hv1Lw-0002id-9F
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:26:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:49618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hv1Lr-0002gM-KT; Tue, 06 Aug 2019 11:26:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hv1Ln-0006FV-IN; Tue, 06 Aug 2019 18:26:11 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue,  6 Aug 2019 18:26:11 +0300
Message-Id: <20190806152611.280389-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hbitmap_reset has an unobvious property: it rounds requested region up.
It may provoke bugs, like in recently fixed write-blocking mode of
mirror: user calls reset on unaligned region, not keeping in mind that
there are possible unrelated dirty bytes, covered by rounded-up region
and information of this unrelated "dirtiness" will be lost.

Make hbitmap_reset strict: assert that arguments are aligned, allowing
only one exception when @start + @count == hb->orig_size. It's needed
to comfort users of hbitmap_next_dirty_area, which cares about
hb->orig_size.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2 based on Max's https://github.com/XanClic/qemu.git block
which will be merged soon to 4.1, and this patch goes to 4.2
Based-on: https://github.com/XanClic/qemu.git block

v1 was "[PATCH] util/hbitmap: fix unaligned reset", and as I understand
we all agreed to just assert alignment instead of aligning down
automatically.

 include/qemu/hbitmap.h | 5 +++++
 tests/test-hbitmap.c   | 2 +-
 util/hbitmap.c         | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 4afbe6292e..7865e819ca 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -132,6 +132,11 @@ void hbitmap_set(HBitmap *hb, uint64_t start, uint64_t count);
  * @count: Number of bits to reset.
  *
  * Reset a consecutive range of bits in an HBitmap.
+ * @start and @count must be aligned to bitmap granularity. The only exception
+ * is resetting the tail of the bitmap: @count may be equal to @start +
+ * hb->orig_size, in this case @count may be not aligned. @start + @count
+ * allowed to be greater than hb->orig_size, but only if @start < hb->orig_size
+ * and @start + @count = ALIGN_UP(hb->orig_size, granularity).
  */
 void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count);
 
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 592d8219db..2be56d1597 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -423,7 +423,7 @@ static void test_hbitmap_granularity(TestHBitmapData *data,
     hbitmap_test_check(data, 0);
     hbitmap_test_set(data, 0, 3);
     g_assert_cmpint(hbitmap_count(data->hb), ==, 4);
-    hbitmap_test_reset(data, 0, 1);
+    hbitmap_test_reset(data, 0, 2);
     g_assert_cmpint(hbitmap_count(data->hb), ==, 2);
 }
 
diff --git a/util/hbitmap.c b/util/hbitmap.c
index bcc0acdc6a..586920cb52 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -476,6 +476,10 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count)
     /* Compute range in the last layer.  */
     uint64_t first;
     uint64_t last = start + count - 1;
+    uint64_t gran = 1ULL << hb->granularity;
+
+    assert(!(start & (gran - 1)));
+    assert(!(count & (gran - 1)) || (start + count == hb->orig_size));
 
     trace_hbitmap_reset(hb, start, count,
                         start >> hb->granularity, last >> hb->granularity);
-- 
2.18.0


